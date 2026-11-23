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
  # PriorityClass defines mapping from a priority class name to the priority integer value. The value can be any valid integer.
  struct PriorityClass
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
    property api_version : String?
    # description is an arbitrary string that usually provides guidelines on when this priority class should be used.
    property description : String?
    # globalDefault specifies whether this PriorityClass should be considered as the default priority for pods that do not have any priority class. Only one PriorityClass can be marked as `globalDefault`. However, if more than one PriorityClasses exists with their `globalDefault` field set to true, the smallest value of such global default PriorityClasses will be used as the default priority.
    @[::JSON::Field(key: "globalDefault")]
    @[::YAML::Field(key: "globalDefault")]
    property global_default : Bool?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # metadata is the standard object metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ObjectMeta?
    # preemptionPolicy is the Policy for preempting pods with lower priority. One of Never, PreemptLowerPriority. Defaults to PreemptLowerPriority if unset.
    @[::JSON::Field(key: "preemptionPolicy")]
    @[::YAML::Field(key: "preemptionPolicy")]
    property preemption_policy : String?
    # value represents the integer value of this priority class. This is the actual priority that pods receive when they have the name of this class in their pod spec.
    property value : Int32?
  end

  # PriorityClassList is a collection of priority classes.
  struct PriorityClassList
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
    property api_version : String?
    # items is the list of PriorityClasses
    property items : Array(PriorityClass)?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard list metadata More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ListMeta?
  end

  # WorkloadPodGroupAllDisruptionMode indicates that all pods in the group must be disrupted together.
  struct WorkloadPodGroupAllDisruptionMode
    include Kubernetes::Serializable
  end

  # WorkloadPodGroupBasicSchedulingPolicy indicates standard Kubernetes scheduling behavior.
  struct WorkloadPodGroupBasicSchedulingPolicy
    include Kubernetes::Serializable
  end

  # WorkloadPodGroupDisruptionMode defines how individual pods within a group can be disrupted. Exactly one mode must be set.
  struct WorkloadPodGroupDisruptionMode
    include Kubernetes::Serializable

    # all specifies that all pods in the group must be disrupted together.
    property all : WorkloadPodGroupAllDisruptionMode?
    # single specifies that pods can be disrupted independently from each other.
    property single : WorkloadPodGroupSingleDisruptionMode?
  end

  # WorkloadPodGroupGangSchedulingPolicy defines the parameters for gang (all-or-nothing) scheduling.
  struct WorkloadPodGroupGangSchedulingPolicy
    include Kubernetes::Serializable

    # minCount is the minimum number of pods that must be scheduled at the same time for the scheduler to admit the entire group. This field is optional. If it is not specified, the controller should inject a context-specific sane default (e.g., parallelism for a Job). If set, it must be a positive integer.
    @[::JSON::Field(key: "minCount")]
    @[::YAML::Field(key: "minCount")]
    property min_count : Int32?
  end

  # WorkloadPodGroupResourceClaim references a dynamic resource claim that is shared across pods in the group.
  struct WorkloadPodGroupResourceClaim
    include Kubernetes::Serializable

    # name uniquely identifies this resource claim inside the group. This field is required. It must be a DNS_LABEL.
    property name : String?
    # resourceClaimName is the name of a ResourceClaim object in the same namespace. This field is optional. If it is not specified, no resource claim is used. If set, it must be a DNS subdomain.
    @[::JSON::Field(key: "resourceClaimName")]
    @[::YAML::Field(key: "resourceClaimName")]
    property resource_claim_name : String?
    # resourceClaimTemplateName is the name of a ResourceClaimTemplate object in the same namespace. This field is optional. If it is not specified, no resource claim template is used. If set, it must be a DNS subdomain.
    @[::JSON::Field(key: "resourceClaimTemplateName")]
    @[::YAML::Field(key: "resourceClaimTemplateName")]
    property resource_claim_template_name : String?
  end

  # WorkloadPodGroupSchedulingConstraints defines leaf-level scheduling constraints, such as topology.
  struct WorkloadPodGroupSchedulingConstraints
    include Kubernetes::Serializable

    # topology specifies desired topological placements for all pods within the pod group. If unset, no topology placement is requested.
    property topology : Array(WorkloadTopologyConstraint)?
  end

  # WorkloadPodGroupSchedulingPolicy defines the scheduling policy for a group of pods managed by a workload controller. Exactly one policy must be set.
  struct WorkloadPodGroupSchedulingPolicy
    include Kubernetes::Serializable

    # basic specifies that standard, pod-by-pod Kubernetes scheduling behavior should be used.
    property basic : WorkloadPodGroupBasicSchedulingPolicy?
    # gang specifies all-or-nothing scheduling semantics.
    property gang : WorkloadPodGroupGangSchedulingPolicy?
  end

  # WorkloadPodGroupSingleDisruptionMode indicates that individual pods can be disrupted independently.
  struct WorkloadPodGroupSingleDisruptionMode
    include Kubernetes::Serializable
  end

  # WorkloadTopologyConstraint defines a topology constraint for a group of pods managed by a workload controller.
  struct WorkloadTopologyConstraint
    include Kubernetes::Serializable

    # key specifies the key of the node label representing the topology domain. All pods within the PodGroup (or CompositePodGroup) must be colocated within the same domain instance. Different groups can land on different domain instances even if they derive from the same template. Nodes where this label is missing or has an empty value do not belong to any domain instance, so pods within the PodGroup/CompositePodGroup cannot be scheduled onto them. Examples: "topology.kubernetes.io/rack"
    property key : String?
  end
end
