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
require "digest/sha256"
require "file_utils"

module Kubernetes
  # Manages credential caching for exec providers
  # Follows kubectl's caching strategy: ~/.kube/cache/
  class CredentialCache
    CACHE_DIR = File.expand_path("~/.kube/cache")

    # Cached exec credential with expiration
    struct CachedCredential
      include ::JSON::Serializable

      property auth : Auth
      property expires_at : ::Time?

      def initialize(@auth : Auth, @expires_at : ::Time? = nil)
      end

      def expired? : Bool
        if exp = @expires_at
          ::Time.utc.to_unix >= exp.to_unix
        else
          false # No expiration = never expires
        end
      end
    end

    def initialize(@log : Log = Log.for("k8s.cache"))
      ensure_cache_dir
    end

    # Get cached credential if valid
    def get(key : String) : Auth?
      cache_file = cache_path(key)
      return nil unless File.exists?(cache_file)

      begin
        cached = CachedCredential.from_json(File.read(cache_file))

        if cached.expired?
          @log.debug { "Cached credential expired for key: #{key}" }
          File.delete(cache_file) rescue nil
          return nil
        end

        @log.debug { "Using cached credential for key: #{key} (expires: #{cached.expires_at})" }
        cached.auth
      rescue ex : Exception
        @log.warn { "Failed to load cached credential: #{ex.message}" }
        File.delete(cache_file) rescue nil
        nil
      end
    end

    # Store credential in cache
    def set(key : String, auth : Auth, expires_at : ::Time? = nil)
      cache_file = cache_path(key)
      cached = CachedCredential.new(auth: auth, expires_at: expires_at)

      begin
        File.write(cache_file, cached.to_json)
        File.chmod(cache_file, 0o600) # Secure permissions
        @log.debug { "Cached credential for key: #{key} (expires: #{expires_at})" }
      rescue ex
        @log.warn { "Failed to cache credential: #{ex.message}" }
      end
    end

    # Generate cache key from exec config
    def self.key_for_exec(exec : Config::UserEntry::ExecConfig) : String
      # Create stable hash of command + args
      content = "#{exec.command}|#{exec.args.try(&.join("|")) || ""}"
      Digest::SHA256.hexdigest(content)[0..15]
    end

    # Clear all cached credentials
    def clear_all
      return unless Dir.exists?(CACHE_DIR)

      Dir.glob(File.join(CACHE_DIR, "exec-*.json")).each do |file|
        File.delete(file)
        @log.debug { "Deleted cache file: #{file}" }
      end
    end

    private def ensure_cache_dir
      return if Dir.exists?(CACHE_DIR)

      begin
        FileUtils.mkdir_p(CACHE_DIR)
        File.chmod(CACHE_DIR, 0o700) # Secure directory
        @log.debug { "Created cache directory: #{CACHE_DIR}" }
      rescue ex
        @log.warn { "Failed to create cache directory: #{ex.message}" }
      end
    end

    private def cache_path(key : String) : String
      File.join(CACHE_DIR, "exec-#{key}.json")
    end
  end
end
