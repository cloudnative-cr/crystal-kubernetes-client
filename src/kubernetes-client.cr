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
require "json"
require "yaml"
require "uri"
require "db/pool"
require "log"

require "./serialization"
require "./config"
require "./auth"
require "./client"
require "./watch"
require "./generic"
require "./resources"

# Generated models and API methods
require "./generated/models/*"
require "./generated/api/*"

module Kubernetes
  VERSION = "0.1.0"

  class Error < ::Exception
  end

  class ClientError < Error
  end

  class UnexpectedResponse < Error
  end

  class AuthenticationError < Error
  end

  class ConfigError < Error
  end
end
