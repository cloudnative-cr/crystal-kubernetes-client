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
  # BasicSchedulingPolicy indicates that standard Kubernetes scheduling behavior should be used.
  struct BasicSchedulingPolicy
    include Kubernetes::Serializable
  end

  # GangSchedulingPolicy defines the parameters for gang scheduling.
  struct GangSchedulingPolicy
    include Kubernetes::Serializable

    # MinCount is the minimum number of pods that must be schedulable or scheduled at the same time for the scheduler to admit the entire group. It must be a positive integer.
    @[::JSON::Field(key: "minCount")]
    @[::YAML::Field(key: "minCount")]
    property min_count : Int32?
  end

  # PodGroup represents a set of pods with a common scheduling policy.
  struct PodGroup
    include Kubernetes::Serializable

    # Name is a unique identifier for the PodGroup within the Workload. It must be a DNS label. This field is immutable.
    property name : String?
    # Policy defines the scheduling policy for this PodGroup.
    property policy : PodGroupPolicy?
  end

  # PodGroupPolicy defines the scheduling configuration for a PodGroup.
  struct PodGroupPolicy
    include Kubernetes::Serializable

    # Basic specifies that the pods in this group should be scheduled using standard Kubernetes scheduling behavior.
    property basic : BasicSchedulingPolicy?
    # Gang specifies that the pods in this group should be scheduled using all-or-nothing semantics.
    property gang : GangSchedulingPolicy?
  end

  # TypedLocalObjectReference allows to reference typed object inside the same namespace.
  struct TypedLocalObjectReference
    include Kubernetes::Serializable

    # APIGroup is the group for the resource being referenced. If APIGroup is empty, the specified Kind must be in the core API group. For any other third-party types, setting APIGroup is required. It must be a DNS subdomain.
    @[::JSON::Field(key: "apiGroup")]
    @[::YAML::Field(key: "apiGroup")]
    property api_group : String?
    # Kind is the type of resource being referenced. It must be a path segment name.
    property kind : String?
    # Name is the name of resource being referenced. It must be a path segment name.
    property name : String?
  end

  # Workload allows for expressing scheduling constraints that should be used when managing lifecycle of workloads from scheduling perspective, including scheduling, preemption, eviction and other phases.
  struct Workload
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard object's metadata. Name must be a DNS subdomain.
    property metadata : ObjectMeta?
    # Spec defines the desired behavior of a Workload.
    property spec : WorkloadSpec?
  end

  # WorkloadList contains a list of Workload resources.
  struct WorkloadList
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Items is the list of Workloads.
    property items : Array(Workload)?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard list metadata.
    property metadata : ListMeta?
  end

  # WorkloadSpec defines the desired state of a Workload.
  struct WorkloadSpec
    include Kubernetes::Serializable

    # ControllerRef is an optional reference to the controlling object, such as a Deployment or Job. This field is intended for use by tools like CLIs to provide a link back to the original workload definition. When set, it cannot be changed.
    @[::JSON::Field(key: "controllerRef")]
    @[::YAML::Field(key: "controllerRef")]
    property controller_ref : TypedLocalObjectReference?
    # PodGroups is the list of pod groups that make up the Workload. The maximum number of pod groups is 8. This field is immutable.
    @[::JSON::Field(key: "podGroups")]
    @[::YAML::Field(key: "podGroups")]
    property pod_groups : Array(PodGroup)?
  end
end
