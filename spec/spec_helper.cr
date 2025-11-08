require "spec"

# Load only the core library for unit tests (not the generated code)
require "http"
require "json"
require "yaml"
require "uri"
require "db/pool"
require "log"

require "../src/serialization"
require "../src/config"
require "../src/client"
require "../src/watch"
require "../src/generic"

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
