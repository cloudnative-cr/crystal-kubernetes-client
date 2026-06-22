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
require "../../serialization"

module Kubernetes
  # An API server instance reports the version it can decode and the version it encodes objects to when persisting objects in the backend.
  struct ServerStorageVersion
    include Kubernetes::Serializable

    # apiServerID is the ID of the reporting API server.
    @[::JSON::Field(key: "apiServerID")]
    @[::YAML::Field(key: "apiServerID")]
    property api_server_id : String?
    # decodableVersions are the encoding versions the API server can handle to decode. The API server can decode objects encoded in these versions. The encodingVersion must be included in the decodableVersions.
    @[::JSON::Field(key: "decodableVersions")]
    @[::YAML::Field(key: "decodableVersions")]
    property decodable_versions : Array(String)?
    # encodingVersion the API server encodes the object to when persisting it in the backend (e.g., etcd).
    @[::JSON::Field(key: "encodingVersion")]
    @[::YAML::Field(key: "encodingVersion")]
    property encoding_version : String?
    # servedVersions lists all versions the API server can serve. DecodableVersions must include all ServedVersions.
    @[::JSON::Field(key: "servedVersions")]
    @[::YAML::Field(key: "servedVersions")]
    property served_versions : Array(String)?
  end

  # Storage version of a specific resource.
  struct StorageVersion
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # metadata is the standard object metadata. The name is <group>.<resource>.
    property metadata : ObjectMeta?
    # spec is an empty spec. It is here to comply with Kubernetes API style.
    property spec : StorageVersionSpec?
    # status on the version the API server instance can decode from and encode objects to when persisting objects in the backend.
    property status : StorageVersionStatus?
  end

  # Describes the state of the storageVersion at a certain point.
  struct StorageVersionCondition
    include Kubernetes::Serializable

    # lastTransitionTime is the last time the condition transitioned from one status to another.
    @[::JSON::Field(key: "lastTransitionTime")]
    @[::YAML::Field(key: "lastTransitionTime")]
    property last_transition_time : Time?
    # message is a human readable string indicating details about the transition.
    property message : String?
    # observedGeneration represents the .metadata.generation that the condition was set based upon, if field is set.
    @[::JSON::Field(key: "observedGeneration")]
    @[::YAML::Field(key: "observedGeneration")]
    property observed_generation : Int64?
    # reason for the condition's last transition.
    property reason : String?
    # status of the condition, one of True, False, Unknown.
    property status : String?
    # type of the condition.
    property type : String?
  end

  # A list of StorageVersions.
  struct StorageVersionList
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Items holds a list of StorageVersion
    property items : Array(StorageVersion)?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard list metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ListMeta?
  end

  # StorageVersionSpec is an empty spec.
  struct StorageVersionSpec
    include Kubernetes::Serializable
  end

  # API server instances report the versions they can decode and the version they encode objects to when persisting objects in the backend.
  struct StorageVersionStatus
    include Kubernetes::Serializable

    # commonEncodingVersion is set to an encoding storage version if all API server instances share that same version. If they don't share one storage version, this field is left empty. API servers should finish updating its storageVersionStatus entry before serving write operations, so that this field will be in sync with the reality.
    @[::JSON::Field(key: "commonEncodingVersion")]
    @[::YAML::Field(key: "commonEncodingVersion")]
    property common_encoding_version : String?
    # conditions lists the latest available observations of the storageVersion's state.
    property conditions : Array(StorageVersionCondition)?
    # storageVersions lists the reported versions per API server instance.
    @[::JSON::Field(key: "storageVersions")]
    @[::YAML::Field(key: "storageVersions")]
    property storage_versions : Array(ServerStorageVersion)?
  end
end
