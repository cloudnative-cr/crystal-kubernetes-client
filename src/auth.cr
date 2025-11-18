# Copyright 2025 Josephine Pfeiffer
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require "json"
require "process"
require "base64"

module Kubernetes
  # Authentication credentials for Kubernetes API
  class Auth
    include ::JSON::Serializable

    property token : String?
    property username : String?
    property password : String?
    property client_cert_file : String?
    property client_key_file : String?

    # Track temporary files created for embedded certificates
    # These should be cleaned up when no longer needed
    @[::JSON::Field(ignore: true)]
    @temp_files : Array(String) = [] of String

    @[::JSON::Field(ignore: true)]
    @temp_files_mutex : Mutex = Mutex.new

    def initialize(
      @token : String? = nil,
      @username : String? = nil,
      @password : String? = nil,
      @client_cert_file : String? = nil,
      @client_key_file : String? = nil,
    )
    end

    # Clean up temporary certificate files
    def cleanup_temp_files
      @temp_files_mutex.synchronize do
        @temp_files.each do |file|
          begin
            File.delete(file)
          rescue File::Error
            # File may have already been deleted, ignore
          end
        end
        @temp_files.clear
      end
    end

    protected def track_temp_file(path : String)
      @temp_files_mutex.synchronize do
        @temp_files << path
      end
    end

    # ameba:disable Metrics/CyclomaticComplexity
    def self.from_user(user : Config::UserEntry::User, log : Log = Log.for("k8s.auth"), cache : CredentialCache? = nil) : Auth
      # Priority order: exec > token/tokenFile > client-cert > basic auth

      if exec = user.exec
        return from_exec(exec, log, cache)
      end

      if token = user.token
        return Auth.new(token: token)
      elsif token_file = user.token_file
        token = File.read(File.expand_path(token_file)).strip
        return Auth.new(token: token)
      end

      if user.client_certificate || user.client_certificate_data
        auth = Auth.new

        cert_file = if cert_data = user.client_certificate_data
                      # Write embedded cert to temporary file with secure permissions
                      cert_pem = Base64.decode_string(cert_data)
                      tmp_cert = File.tempfile("k8s-client-cert", ".pem")
                      File.chmod(tmp_cert.path, 0o600) # Secure before writing
                      File.write(tmp_cert.path, cert_pem)
                      auth.track_temp_file(tmp_cert.path)
                      tmp_cert.path
                    elsif cert_path = user.client_certificate
                      File.expand_path(cert_path)
                    end

        key_file = if key_data = user.client_key_data
                     # Write embedded key to temporary file with secure permissions
                     key_pem = Base64.decode_string(key_data)
                     tmp_key = File.tempfile("k8s-client-key", ".pem")
                     File.chmod(tmp_key.path, 0o600) # Secure before writing sensitive data
                     File.write(tmp_key.path, key_pem)
                     auth.track_temp_file(tmp_key.path)
                     tmp_key.path
                   elsif key_path = user.client_key
                     File.expand_path(key_path)
                   end

        auth.client_cert_file = cert_file
        auth.client_key_file = key_file
        return auth
      end

      # 4. Basic authentication (lowest priority, deprecated)
      if username = user.username
        return Auth.new(username: username, password: user.password)
      end

      # No authentication
      Auth.new
    end

    # Execute external credential provider with caching
    # ameba:disable Metrics/CyclomaticComplexity
    private def self.from_exec(exec : Config::UserEntry::ExecConfig, log : Log, cache : CredentialCache? = nil) : Auth
      # Try cache first if available
      if cache
        cache_key = CredentialCache.key_for_exec(exec)
        if cached_auth = cache.get(cache_key)
          log.debug { "Using cached exec provider credential" }
          return cached_auth
        end
      end

      log.debug { "Executing credential provider: #{exec.command} #{exec.args.try(&.join(" "))}" }

      # Build environment
      env = {} of String => String
      if exec_env = exec.env
        exec_env.each do |env_var|
          env[env_var.name] = env_var.value
        end
      end

      # Execute command
      output = IO::Memory.new
      error = IO::Memory.new

      args = exec.args || [] of String
      process = Process.new(
        exec.command,
        args,
        env: env,
        output: output,
        error: error
      )

      status = process.wait
      unless status.success?
        error_msg = error.to_s
        log.error { "Exec provider failed: #{error_msg}" }
        raise AuthError.new("Exec provider failed: #{error_msg}")
      end

      # Parse ExecCredential response
      begin
        credential = ExecCredential.from_json(output.to_s)
        log.debug { "Exec provider returned credential (expires: #{credential.status.expiration_timestamp})" }

        # Parse expiration
        expires_at = if exp_str = credential.status.expiration_timestamp
                       Time.parse_rfc3339(exp_str)
                     end

        # Extract token from credential
        auth = if token = credential.status.token
                 Auth.new(token: token)
               elsif cert_data = credential.status.client_certificate_data
                 # Client cert authentication from exec - write to temp files with secure permissions
                 auth_obj = Auth.new
                 cert_pem = Base64.decode_string(cert_data)
                 tmp_cert = File.tempfile("k8s-exec-cert", ".pem")
                 File.chmod(tmp_cert.path, 0o600) # Secure before writing
                 File.write(tmp_cert.path, cert_pem)
                 auth_obj.track_temp_file(tmp_cert.path)

                 tmp_key = if key_data = credential.status.client_key_data
                             key_pem = Base64.decode_string(key_data)
                             tmp = File.tempfile("k8s-exec-key", ".pem")
                             File.chmod(tmp.path, 0o600) # Secure before writing sensitive data
                             File.write(tmp.path, key_pem)
                             auth_obj.track_temp_file(tmp.path)
                             tmp.path
                           end

                 auth_obj.client_cert_file = tmp_cert.path
                 auth_obj.client_key_file = tmp_key
                 auth_obj
               else
                 raise AuthError.new("Exec provider returned credential without token or certificate")
               end

        # Cache the credential if cache is available
        # NOTE: Only cache token-based credentials, not cert-based ones
        # Cert-based credentials use temporary files that won't be valid after deserialization
        if cache && auth.token
          cache_key = CredentialCache.key_for_exec(exec)
          cache.set(cache_key, auth, expires_at)
          log.debug { "Cached exec provider token credential" }
        elsif cache && (auth.client_cert_file || auth.client_key_file)
          log.debug { "Skipping cache for cert-based exec credential (temp files not cacheable)" }
        end

        auth
      rescue ex : ::JSON::ParseException
        log.error { "Failed to parse exec provider output: #{ex.message}" }
        raise AuthError.new("Failed to parse exec provider output: #{ex.message}")
      end
    end

    def apply_headers(headers : HTTP::Headers)
      if token = @token
        headers["Authorization"] = "Bearer #{token}"
      elsif username = @username
        credentials = Base64.strict_encode("#{username}:#{@password}")
        headers["Authorization"] = "Basic #{credentials}"
      end
      # Note: Client cert/key are applied to TLS context, not headers
    end

    # ExecCredential Status - must be public to avoid serialization errors
    struct ExecCredentialStatus
      include ::JSON::Serializable

      @[::JSON::Field(key: "expirationTimestamp")]
      property expiration_timestamp : String?

      property token : String?

      @[::JSON::Field(key: "clientCertificateData")]
      property client_certificate_data : String?

      @[::JSON::Field(key: "clientKeyData")]
      property client_key_data : String?
    end

    # ExecCredential response format (client.authentication.k8s.io/v1)
    private struct ExecCredential
      include ::JSON::Serializable

      @[::JSON::Field(key: "apiVersion")]
      property api_version : String

      property kind : String
      property status : ExecCredentialStatus
    end
  end

  class AuthError < Exception
  end
end
