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

module Kubernetes
  struct Watch(T)
    include ::JSON::Serializable
    property type : Type
    property object : T
    delegate added?, modified?, deleted?, to: type

    enum Type
      ADDED; MODIFIED; DELETED; ERROR
    end
  end

  class Client
    private def handle_watch_http_error(path, status_code, body, params)
      case status_code
      when 410
        # Gone - resource version too old, restart from beginning
        params["resourceVersion"] = "0"
        @log.warn { "Watch resource version expired for #{path}, restarting from beginning" }
      when 401, 403
        # Authentication errors should not retry
        raise AuthenticationError.new("Watch authentication failed (#{status_code}) for #{path}")
      else
        # Other errors trigger retry with backoff
        raise ClientError.new("Watch failed (#{status_code}) for #{path}: #{body}")
      end
    end

    private def process_watch_events(path, res, params, &) forall T
      loop do
        watch = Watch(T | Status).from_json(IO::Delimited.new(res.body_io, "\n"))

        if watch.object.is_a?(Status)
          # Error event from Kubernetes
          @log.error { "Watch error for #{path}: #{watch.object.as(Status).message}" }
          break
        end

        # Update resource version for resume capability
        if watch.object.is_a?(T)
          if watch.object.responds_to?(:metadata) && watch.object.metadata.responds_to?(:resource_version)
            params["resourceVersion"] = watch.object.metadata.resource_version
          end
          yield watch.as(Watch(T))
        end
      end
    end

    def watch(path, resource_version = "0", timeout = 10.minutes, max_retries = -1, &) forall T
      params = URI::Params{"watch" => "1", "resourceVersion" => resource_version}
      params["timeoutSeconds"] = timeout.total_seconds.to_i.to_s if timeout > 0.seconds

      retry_count = 0
      backoff = 1.second
      max_backoff = 30.seconds

      loop do
        break if max_retries >= 0 && retry_count >= max_retries

        begin
          # Disable automatic error raising for watch (we handle errors manually)
          get("#{path}?#{params}", check_status: false) do |res|
            # Handle HTTP errors specific to watch
            unless res.success?
              handle_watch_http_error(path, res.status_code, res.body?, params)
              next
            end

            # Successfully connected, reset retry counters
            retry_count = 0
            backoff = 1.second

            # Process watch events
            process_watch_events(path, res, params) { |watch| yield watch }
          end
        rescue ex : IO::Error
          # Network/IO errors trigger exponential backoff retry
          retry_count += 1
          @log.warn { "Watch connection failed for #{path} (attempt #{retry_count}): #{ex.message}" }

          if max_retries >= 0 && retry_count >= max_retries
            raise Error.new("Watch max retries (#{max_retries}) exceeded for #{path}")
          end

          sleep backoff
          backoff = [backoff * 2, max_backoff].min
        rescue ex : AuthenticationError
          # Don't retry auth errors
          raise ex
        end
      end
    end
  end
end
