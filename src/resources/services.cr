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

module Kubernetes::Resources
  class Services
    struct Service
      include ::JSON::Serializable

      @[::JSON::Field(key: "apiVersion")]
      property api_version : String?

      property kind : String?
      property metadata : Kubernetes::Metadata
      property spec : ServiceSpec?
    end

    struct ServiceSpec
      include ::JSON::Serializable

      property ports : Array(ServicePort)?
      property selector : Hash(String, String)?
      property type : String?

      @[::JSON::Field(key: "clusterIP")]
      property cluster_ip : String?
    end

    struct ServicePort
      include ::JSON::Serializable

      property name : String?
      property port : Int32
      property protocol : String?

      @[::JSON::Field(key: "targetPort")]
      property target_port : Int32 | String | Nil
    end

    def initialize(@client : Client)
      @generic = Generic(Service).new(@client, "", "v1", "services")
    end

    def list_namespaced(namespace : String,
                        label_selector : String? = nil,
                        field_selector : String? = nil,
                        limit : Int32? = nil) : List(Service)
      @generic.list_namespaced(namespace, label_selector, field_selector, limit)
    end

    def read_namespaced(namespace : String, name : String) : Service
      @generic.read_namespaced(namespace, name)
    end

    def delete_namespaced(namespace : String, name : String) : Status
      @generic.delete_namespaced(namespace, name)
    end
  end
end
