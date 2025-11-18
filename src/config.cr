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

require "yaml"

# YAML converter for URI
class URI
  def self.new(ctx : ::YAML::ParseContext, node : ::YAML::Nodes::Node)
    URI.parse(String.new(ctx, node))
  end
end

module Kubernetes
  struct Config
    include ::YAML::Serializable
    @[::YAML::Field(key: "current-context")]
    property current_context : String
    property clusters : Array(ClusterEntry)
    property contexts : Array(ContextEntry)
    property users : Array(UserEntry)

    struct ClusterEntry
      include ::YAML::Serializable
      property name : String
      property cluster : Cluster

      struct Cluster
        include ::YAML::Serializable
        property server : URI

        @[::YAML::Field(key: "certificate-authority")]
        property certificate_authority : String?

        @[::YAML::Field(key: "certificate-authority-data")]
        property certificate_authority_data : String?

        @[::YAML::Field(key: "insecure-skip-tls-verify")]
        property insecure_skip_tls_verify : Bool?
      end
    end

    struct ContextEntry
      include ::YAML::Serializable
      property name : String
      property context : Context

      struct Context
        include ::YAML::Serializable
        property cluster : String
        property user : String
      end
    end

    struct UserEntry
      include ::YAML::Serializable
      property name : String
      property user : User

      struct User
        include ::YAML::Serializable

        # Bearer token authentication
        property token : String?

        @[::YAML::Field(key: "tokenFile")]
        property token_file : String?

        # Client certificate authentication
        @[::YAML::Field(key: "client-certificate")]
        property client_certificate : String?

        @[::YAML::Field(key: "client-certificate-data")]
        property client_certificate_data : String?

        @[::YAML::Field(key: "client-key")]
        property client_key : String?

        @[::YAML::Field(key: "client-key-data")]
        property client_key_data : String?

        # Basic authentication
        property username : String?
        property password : String?

        # Exec provider
        property exec : ExecConfig?

        # Auth provider (deprecated but still supported)
        @[::YAML::Field(key: "auth-provider")]
        property auth_provider : AuthProviderConfig?
      end

      struct ExecConfig
        include ::YAML::Serializable

        @[::YAML::Field(key: "apiVersion")]
        property api_version : String

        property command : String
        property args : Array(String)?
        property env : Array(ExecEnvVar)?

        @[::YAML::Field(key: "installHint")]
        property install_hint : String?

        @[::YAML::Field(key: "provideClusterInfo")]
        property provide_cluster_info : Bool?

        @[::YAML::Field(key: "interactiveMode")]
        property interactive_mode : String?

        struct ExecEnvVar
          include ::YAML::Serializable
          property name : String
          property value : String
        end
      end

      struct AuthProviderConfig
        include ::YAML::Serializable
        property name : String
        property config : Hash(String, String)?
      end
    end
  end
end
