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
  # Lease defines a lease concept.
  struct Lease
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ObjectMeta?
    # spec contains the specification of the Lease. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status
    property spec : LeaseSpec?
  end

  # LeaseList is a list of Lease objects.
  struct LeaseList
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
    property api_version : String?
    # items is a list of schema objects.
    property items : Array(Lease)?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard list metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ListMeta?
  end

  # LeaseSpec is a specification of a Lease.
  struct LeaseSpec
    include Kubernetes::Serializable

    # acquireTime is a time when the current lease was acquired.
    @[::JSON::Field(key: "acquireTime")]
    @[::YAML::Field(key: "acquireTime")]
    property acquire_time : MicroTime?
    # holderIdentity contains the identity of the holder of a current lease. If Coordinated Leader Election is used, the holder identity must be equal to the elected LeaseCandidate.metadata.name field.
    @[::JSON::Field(key: "holderIdentity")]
    @[::YAML::Field(key: "holderIdentity")]
    property holder_identity : String?
    # leaseDurationSeconds is a duration that candidates for a lease need to wait to force acquire it. This is measured against the time of last observed renewTime.
    @[::JSON::Field(key: "leaseDurationSeconds")]
    @[::YAML::Field(key: "leaseDurationSeconds")]
    property lease_duration_seconds : Int32?
    # leaseTransitions is the number of transitions of a lease between holders.
    @[::JSON::Field(key: "leaseTransitions")]
    @[::YAML::Field(key: "leaseTransitions")]
    property lease_transitions : Int32?
    # PreferredHolder signals to a lease holder that the lease has a more optimal holder and should be given up. This field can only be set if Strategy is also set.
    @[::JSON::Field(key: "preferredHolder")]
    @[::YAML::Field(key: "preferredHolder")]
    property preferred_holder : String?
    # renewTime is a time when the current holder of a lease has last updated the lease.
    @[::JSON::Field(key: "renewTime")]
    @[::YAML::Field(key: "renewTime")]
    property renew_time : MicroTime?
    # Strategy indicates the strategy for picking the leader for coordinated leader election. If the field is not specified, there is no active coordination for this lease. (Alpha) Using this field requires the CoordinatedLeaderElection feature gate to be enabled.
    property strategy : String?
  end
end
