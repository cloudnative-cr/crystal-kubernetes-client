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
require "yaml"

module Kubernetes
  module Serializable
    macro included
      include JSON::Serializable
      include YAML::Serializable

      # Helper macro for defining fields with automatic camelCase conversion
      macro field(name, type = nil, **options, &block)
        \{% if options[:key] %}
          @[JSON::Field(key: \{{options[:key]}})]
          @[YAML::Field(key: \{{options[:key]}})]
        \{% else %}
          @[JSON::Field(key: \{{name.id.stringify.camelcase(lower: true)}})]
          @[YAML::Field(key: \{{name.id.stringify.camelcase(lower: true)}})]
        \{% end %}

        \{% if options[:ignore_serialize] %}
          @[JSON::Field(ignore_serialize: true)]
          @[YAML::Field(ignore_serialize: true)]
        \{% end %}

        \{% if type %}
          getter \{{name.id}} : \{{type}} \{% if block %} = \{{yield}} \{% end %}
        \{% else %}
          getter \{{name.id}} \{% if block %} = \{{yield}} \{% end %}
        \{% end %}
      end
    end
  end

  # Kubernetes resource wrapper with metadata, spec, and status
  struct Resource(T)
    include Serializable

    field api_version : String { "" }
    field kind : String { "" }
    field metadata : Metadata
    field spec : T
    field status : JSON::Any = JSON::Any.new(nil)

    def initialize(*, @api_version, @kind, @metadata, @spec, @status = JSON::Any.new(nil))
    end
  end

  # Resource metadata
  struct Metadata
    include Serializable

    DEFAULT_TIME = Time.new(seconds: 0, nanoseconds: 0, location: Time::Location::UTC)

    field name : String = ""
    field namespace : String { "" }
    field labels : Hash(String, String) { {} of String => String }
    field annotations : Hash(String, String) { {} of String => String }
    field resource_version : String, ignore_serialize: true { "" }
    field uid : String, ignore_serialize: true { "" }

    def initialize(@name, @namespace = nil, @labels = {} of String => String)
    end
  end

  struct OwnerReference
    include Serializable
    field api_version : String?
    field kind : String?
    field name : String?
    field uid : String?
  end

  # Metadata for list responses
  struct ListMetadata
    include JSON::Serializable
    include YAML::Serializable

    @[JSON::Field(key: "resourceVersion")]
    @[YAML::Field(key: "resourceVersion")]
    property resource_version : String?

    property continue : String?

    @[JSON::Field(key: "remainingItemCount")]
    @[YAML::Field(key: "remainingItemCount")]
    property remaining_item_count : Int64?
  end

  struct List(T)
    include JSON::Serializable
    include YAML::Serializable
    include Enumerable(T)

    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?

    property kind : String?
    property metadata : ListMetadata?
    property items : Array(T)

    delegate each, to: items
  end

  struct Status
    include Serializable
    field kind : String
    field api_version : String
    field status : String
    field message : String
    field code : Int32
  end
end
