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

require "http"
require "openssl"
require "db/pool"
require "base64"
require "inotify"
require "./config"
require "./auth"
require "./credential_cache"

module Kubernetes
  class Client
    IN_CLUSTER_TOKEN_PATH     = "/var/run/secrets/kubernetes.io/serviceaccount/token"
    IN_CLUSTER_CA_CERT_PATH   = "/var/run/secrets/kubernetes.io/serviceaccount/ca.crt"
    IN_CLUSTER_NAMESPACE_PATH = "/var/run/secrets/kubernetes.io/serviceaccount/namespace"

    getter server : URI
    getter log : Log

    # Token caching for in-cluster ServiceAccount tokens
    @cached_token : String?
    @token_file_path : String?
    @token_watcher : Inotify::Watcher?
    @token_mutex : Mutex = Mutex.new
    @http_pool : DB::Pool(HTTP::Client)
    @credential_cache : CredentialCache?

    # Connection pool configuration
    @pool_size : Int32
    @pool_timeout : Time::Span
    @request_timeout : Time::Span

    def self.new
      if host = ENV["KUBERNETES_SERVICE_HOST"]?
        # In-cluster configuration
        host += ":#{ENV["KUBERNETES_SERVICE_PORT"]?}" if ENV["KUBERNETES_SERVICE_PORT"]?
        server = URI.parse("https://#{host}")

        # Load service account token
        token = if File.exists?(IN_CLUSTER_TOKEN_PATH)
                  File.read(IN_CLUSTER_TOKEN_PATH).strip
                else
                  ""
                end

        # Configure TLS with CA certificate
        tls = if File.exists?(IN_CLUSTER_CA_CERT_PATH)
                ctx = OpenSSL::SSL::Context::Client.new
                ctx.ca_certificates = IN_CLUSTER_CA_CERT_PATH
                ctx
              else
                nil
              end

        new(server: server, token: token, tls: tls)
      elsif File.exists?(File.expand_path("~/.kube/config"))
        from_config
      else
        raise ConfigError.new("Cannot detect Kubernetes config: not in-cluster and ~/.kube/config not found")
      end
    end

    def self.from_config(*, file : String = File.expand_path("~/.kube/config"), context : String? = nil, log : Log = Log.for("k8s"), cache_credentials : Bool = true)
      config = File.open(file) { |f| Config.from_yaml f }
      context ||= config.current_context

      # Find context with proper error handling
      ctx = config.contexts.find { |c| c.name == context }
      raise ConfigError.new("Context '#{context}' not found in kubeconfig") unless ctx

      # Find cluster with proper error handling
      cluster = config.clusters.find { |c| c.name == ctx.context.cluster }
      raise ConfigError.new("Cluster '#{ctx.context.cluster}' not found in kubeconfig") unless cluster

      # Find user with proper error handling
      user = config.users.find { |u| u.name == ctx.context.user }
      raise ConfigError.new("User '#{ctx.context.user}' not found in kubeconfig") unless user

      # Initialize credential cache if enabled
      credential_cache = cache_credentials ? CredentialCache.new(log) : nil

      # Build authentication from user config
      auth = Auth.from_user(user.user, log, credential_cache)

      # Build TLS context from cluster config
      tls = build_tls_context(cluster.cluster, auth, log)

      new(server: cluster.cluster.server, auth: auth, tls: tls, log: log, credential_cache: credential_cache)
    end

    # Build TLS context from cluster and auth config
    private def self.build_tls_context(
      cluster : Config::ClusterEntry::Cluster,
      auth : Auth,
      log : Log = Log.for("k8s"),
    ) : OpenSSL::SSL::Context::Client?
      ctx = OpenSSL::SSL::Context::Client.new

      # Configure CA certificate
      if ca_data = cluster.certificate_authority_data
        # Write CA cert to temporary file with secure permissions
        ca_pem = Base64.decode_string(ca_data)
        tmp_ca = File.tempfile("k8s-ca", ".pem")
        File.chmod(tmp_ca.path, 0o600)  # Secure before writing
        File.write(tmp_ca.path, ca_pem)
        auth.track_temp_file(tmp_ca.path)  # Track for cleanup
        ctx.ca_certificates = tmp_ca.path
      elsif ca_file = cluster.certificate_authority
        ctx.ca_certificates = File.expand_path(ca_file)
      end

      # Configure client certificate/key if present
      if cert_file = auth.client_cert_file
        ctx.certificate_chain = cert_file
        if key_file = auth.client_key_file
          ctx.private_key = key_file
        end
      end

      # Handle insecure skip TLS verify
      if cluster.insecure_skip_tls_verify
        log.warn { "SECURITY WARNING: TLS certificate verification is disabled (insecure-skip-tls-verify=true). This is insecure and should only be used for development/testing." }
        ctx.verify_mode = OpenSSL::SSL::VerifyMode::NONE
      end

      ctx
    end

    def initialize(
      *,
      @server : URI,
      token : String = "",
      auth : Auth? = nil,
      @tls : OpenSSL::SSL::Context::Client? = nil,
      @log = Log.for("k8s"),
      credential_cache : CredentialCache? = nil,
      pool_size : Int32 = 25,
      pool_timeout : Time::Span = 30.seconds,
      request_timeout : Time::Span = 30.seconds,
    )
      # Validate pool parameters
      raise ArgumentError.new("pool_size must be positive (got #{pool_size})") if pool_size <= 0
      raise ArgumentError.new("pool_timeout must be positive") if pool_timeout <= Time::Span.zero
      raise ArgumentError.new("request_timeout must be positive") if request_timeout <= Time::Span.zero
      # Build auth from token if auth not provided (backwards compatibility)
      @auth = auth || (token.presence ? Auth.new(token: token) : Auth.new)
      @credential_cache = credential_cache

      # Store pool configuration
      @pool_size = pool_size
      @pool_timeout = pool_timeout
      @request_timeout = request_timeout

      # Auto-configure TLS for HTTPS if not provided
      if @server.scheme == "https" && @tls.nil?
        @tls = OpenSSL::SSL::Context::Client.new
        @log.debug { "Auto-configured TLS context for HTTPS connection" }
      end

      # Detect and cache ServiceAccount token if in-cluster
      @token_file_path = detect_token_file_path
      @cached_token = load_initial_token

      # Create HTTP pool with auth
      @http_pool = create_http_pool

      # Start watching for token rotation
      @token_watcher = start_token_watcher
    end

    def get(path : String, params : String? = nil, headers = HTTP::Headers.new, *, check_status : Bool = true, &)
      full_path = params && !params.empty? ? "#{path}?#{params}" : path

      # Retry once on SSL error (likely token rotation)
      2.times do |attempt|
        begin
          @http_pool.checkout do |http|
            http.get(full_path, headers: headers) do |res|
              raise_for_status(res, path) if check_status && !res.success?
              yield res
            end
          end
          return
        rescue ex : OpenSSL::SSL::Error
          if attempt == 0
            @log.warn { "SSL error (likely token rotation): #{ex.message}, recreating HTTP pool and retrying" }
            reload_token_and_pool("SSL error recovery")
          else
            raise ex
          end
        end
      end
    end

    # Helper to build common list query parameters
    def build_list_params(
      label_selector : String? = nil,
      field_selector : String? = nil,
      limit : Int32? = nil,
      continue : String? = nil,
      resource_version : String? = nil,
      timeout_seconds : Int32? = nil,
      watch : Bool? = nil,
    ) : String
      params = {} of String => String
      params["labelSelector"] = label_selector if label_selector
      params["fieldSelector"] = field_selector if field_selector
      params["limit"] = limit.to_s if limit
      params["continue"] = continue if continue
      params["resourceVersion"] = resource_version if resource_version
      params["timeoutSeconds"] = timeout_seconds.to_s if timeout_seconds
      params["watch"] = "true" if watch
      URI::Params.encode(params)
    end

    def post(path, body, headers = HTTP::Headers.new, *, check_status : Bool = true)
      @http_pool.checkout do |http|
        headers["Content-Type"] = "application/json"
        res = http.post(path, headers: headers, body: body.to_json)
        raise_for_status(res, path) if check_status && !res.success?
        res
      end
    end

    def patch(path, body, headers = HTTP::Headers.new, *, content_type = "application/apply-patch+yaml", check_status : Bool = true)
      @http_pool.checkout do |http|
        headers["Content-Type"] = content_type
        res = http.patch(path, headers: headers, body: content_type.includes?("yaml") ? body.to_yaml : body.to_json)
        raise_for_status(res, path) if check_status && !res.success?
        res
      end
    end

    def put(path, body, headers = HTTP::Headers.new, *, check_status : Bool = true)
      @http_pool.checkout do |http|
        headers["Content-Type"] = "application/json"
        res = http.put(path, headers: headers, body: body.to_json)
        raise_for_status(res, path) if check_status && !res.success?
        res
      end
    end

    def delete(path, headers = HTTP::Headers.new, *, check_status : Bool = true)
      @http_pool.checkout do |http|
        res = http.delete(path, headers: headers)
        raise_for_status(res, path) if check_status && !res.success?
        res
      end
    end

    # High-level type-safe API for v1 resources.
    #
    # This provides convenient access to common Kubernetes resources
    # without needing to use blocks or parse JSON manually.
    #
    # Example:
    # ```
    # k8s = Kubernetes::Client.new
    #
    # # Type-safe, no blocks
    # pods = k8s.v1.pods.list_namespaced("default")
    # pods.items.each { |pod| puts pod.metadata.name }
    #
    # # Helper methods
    # k8s.v1.deployments.scale("default", "nginx", replicas: 10)
    # k8s.v1.pods.wait_until_ready("default", "nginx")
    # logs = k8s.v1.pods.logs("default", "nginx")
    # ```
    def v1 : Resources::V1
      @v1 ||= Resources::V1.new(self)
    end

    def close
      @token_watcher.try(&.close)
      @http_pool.close
      @auth.cleanup_temp_files
    end

    # Create HTTP pool with authentication
    private def create_http_pool : DB::Pool(HTTP::Client)
      options = DB::Pool::Options.new(
        max_pool_size: @pool_size,
        checkout_timeout: @pool_timeout.total_seconds
      )
      DB::Pool(HTTP::Client).new(options) do
        http = HTTP::Client.new(@server, tls: @tls)

        # Set connection timeouts
        http.read_timeout = @request_timeout
        http.connect_timeout = 5.seconds

        http.before_request do |req|
          # Apply authentication headers with mutex protection
          @token_mutex.synchronize do
            # Use cached token if available (in-cluster)
            if cached = @cached_token
              req.headers["Authorization"] = "Bearer #{cached}" if cached.presence
            else
              # Fall back to auth struct
              @auth.apply_headers(req.headers)
            end
          end
        end
        http
      end
    end

    # Detect ServiceAccount token file path
    private def detect_token_file_path : String?
      return nil unless File.exists?(IN_CLUSTER_TOKEN_PATH)
      IN_CLUSTER_TOKEN_PATH
    rescue File::Error
      nil
    end

    # Load initial token (in-cluster or from auth)
    private def load_initial_token : String?
      return nil unless path = @token_file_path

      begin
        File.read(path).strip
      rescue ex : File::NotFoundError | File::Error
        @log.warn { "Failed to read token: #{ex.message}" }
        nil
      end
    end

    # Start inotify watcher for token rotation
    private def start_token_watcher : Inotify::Watcher?
      return nil unless path = @token_file_path
      return nil unless File.exists?(path)

      begin
        parent_dir = File.dirname(path)
        watcher = Inotify.watch(parent_dir) do |event|
          # Kubernetes rotates secrets via ..data symlink
          if event.type.moved_to? && event.name == "..data"
            reload_token_and_pool("Token rotated (#{event.type} #{event.name})")
          elsif event.name == File.basename(path) && (event.type.modify? || event.type.close_write?)
            reload_token_and_pool("Token file changed (#{event.type})")
          end
        end

        @log.info { "Started inotify watcher for token directory: #{parent_dir}" }
        watcher
      rescue ex
        @log.warn { "Failed to start token file watcher: #{ex.message}" }
        nil
      end
    end

    # Reload token and recreate HTTP pool
    private def reload_token_and_pool(reason : String)
      @token_mutex.synchronize do
        @log.info { "#{reason}, reloading token and recreating HTTP pool" }
        @cached_token = load_initial_token
        old_pool = @http_pool
        @http_pool = create_http_pool
        old_pool.close
      end
    end

    private def raise_for_status(response, path)
      body = response.body? || ""
      case response.status_code
      when 401
        raise AuthenticationError.new("Unauthorized (#{path}): #{body}")
      when 403
        raise AuthenticationError.new("Forbidden (#{path}): #{body}")
      when 404
        raise ClientError.new("Not found (#{path})")
      when 409
        raise ClientError.new("Conflict (#{path}): #{body}")
      when 410
        # Gone - resource version too old (special case for watches)
        raise ClientError.new("Gone - resource version expired (#{path})")
      when 400..499
        raise ClientError.new("Client error #{response.status_code} (#{path}): #{body}")
      when 500..599
        raise Error.new("Server error #{response.status_code} (#{path}): #{body}")
      else
        raise Error.new("Unexpected response #{response.status_code} (#{path}): #{body}")
      end
    end
  end
end
