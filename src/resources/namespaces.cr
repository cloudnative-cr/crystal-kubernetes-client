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
  class Namespaces
    struct Namespace
      include ::JSON::Serializable

      @[::JSON::Field(key: "apiVersion")]
      property api_version : String?

      property kind : String?
      property metadata : Kubernetes::Metadata
      property status : NamespaceStatus?
    end

    struct NamespaceStatus
      include ::JSON::Serializable

      property phase : String?
    end

    def initialize(@client : Client)
      @generic = Generic(Namespace).new(@client, "", "v1", "namespaces")
    end

    def list(label_selector : String? = nil,
             field_selector : String? = nil,
             limit : Int32? = nil) : List(Namespace)
      @generic.list(label_selector, field_selector, limit)
    end

    def read(name : String) : Namespace
      @generic.read(name)
    end

    def delete(name : String) : Status
      @generic.delete(name)
    end
  end
end
