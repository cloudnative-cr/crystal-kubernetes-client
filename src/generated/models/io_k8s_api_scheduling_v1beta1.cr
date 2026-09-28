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
  # AllCompositeDisruptionMode means that children of a CompositePodGroup can only be disrupted or preempted together.
  struct AllCompositeDisruptionMode
    include Kubernetes::Serializable
  end

  # AllDisruptionMode specifies that children can only be disrupted together.
  struct AllDisruptionMode
    include Kubernetes::Serializable
  end

  # BasicSchedulingPolicy indicates that standard Kubernetes scheduling behavior should be used.
  struct BasicSchedulingPolicy
    include Kubernetes::Serializable
  end

  # CompositeBasicSchedulingPolicy indicates that the groups belonging to the composite group should be scheduled independently.
  struct CompositeBasicSchedulingPolicy
    include Kubernetes::Serializable
  end

  # CompositeDisruptionMode defines how individual entities within a composite pod group can be disrupted. Exactly one mode must be set.
  struct CompositeDisruptionMode
    include Kubernetes::Serializable

    # all specifies that all children groups can only be disrupted together.
    property all : AllCompositeDisruptionMode?
    # single specifies that children groups can be disrupted independently from each other.
    property single : SingleCompositeDisruptionMode?
  end

  # CompositeGangSchedulingPolicy indicates that the groups belonging to the composite group should be scheduled using all-or-nothing semantics.
  struct CompositeGangSchedulingPolicy
    include Kubernetes::Serializable

    # minGroupCount is the minimum number of child groups that must be schedulable or scheduled at the same time for the scheduler to admit the entire group. It must be a positive integer. This field is mutable to support workload scaling.
    # Note that the scheduler operates on an eventually consistent model. Updates to minGroupCount may not be immediately reflected in scheduling decisions due to propagation delays. If minGroupCount is updated while a scheduling cycle is in progress for that group, the new value may not take effect until the next cycle. Moreover, minGroupCount is only enforced during scheduling, meaning that modifications to this field do not affect already-scheduled pods, applying only to those evaluated in future cycles.
    @[::JSON::Field(key: "minGroupCount")]
    @[::YAML::Field(key: "minGroupCount")]
    property min_group_count : Int32?
  end

  # CompositePodGroupSchedulingConstraints defines scheduling constraints (e.g. topology) for a CompositePodGroup.
  struct CompositePodGroupSchedulingConstraints
    include Kubernetes::Serializable

    # topology defines the topology constraints for the composite pod group. Currently only a single topology constraint can be specified. This may change in the future.
    property topology : Array(TopologyConstraint)?
  end

  # CompositePodGroupSchedulingPolicy defines the scheduling configuration for a CompositePodGroup. Exactly one policy must be set. The policy is chosen at creation time by setting either the Basic or Gang field. The CompositePodGroup may not change policy after creation. Fields within chosen policy may be updated after creation when their individual fields allow it.
  struct CompositePodGroupSchedulingPolicy
    include Kubernetes::Serializable

    # basic specifies that the groups of this composite group should be scheduled independently. Setting this field at group creation time opts this group to basic scheduling; this field cannot be changed afterward.
    property basic : CompositeBasicSchedulingPolicy?
    # gang specifies that the groups of this composite group should be scheduled using all-or-nothing semantics. Setting this field at group creation time opts this group to gang scheduling; this field cannot be set or unset afterward. The minGroupCount field within Gang scheduling policy remains mutable after group creation.
    property gang : CompositeGangSchedulingPolicy?
  end

  # CompositePodGroupTemplate represents a template for a CompositePodGroup with a scheduling policy.
  class CompositePodGroupTemplate
    include Kubernetes::Serializable

    # compositePodGroupTemplates is the list of templates for children CompositePodGroups. The maximum number of templates is 8. At least one entry in CompositePodGroupTemplates or PodGroupTemplates must be set.
    @[::JSON::Field(key: "compositePodGroupTemplates")]
    @[::YAML::Field(key: "compositePodGroupTemplates")]
    property composite_pod_group_templates : Array(CompositePodGroupTemplate)?
    # disruptionMode defines the mode in which a given CompositePodGroup can be disrupted. One of Single, All. This field is immutable.
    @[::JSON::Field(key: "disruptionMode")]
    @[::YAML::Field(key: "disruptionMode")]
    property disruption_mode : CompositeDisruptionMode?
    # name is a unique identifier for the CompositePodGroupTemplate within the Workload. It must be a DNS label. This field is required.
    property name : String?
    # podGroupTemplates is the list of templates for children PodGroups. The maximum number of templates is 8. At least one entry in CompositePodGroupTemplates or PodGroupTemplates must be set.
    @[::JSON::Field(key: "podGroupTemplates")]
    @[::YAML::Field(key: "podGroupTemplates")]
    property pod_group_templates : Array(PodGroupTemplate)?
    # preemptionPolicy is the Policy for preempting pods/podgroups with lower priority. One of Never, PreemptLowerPriority. This field is immutable. This field is available only when the PodGroupPreemptionPolicy feature gate is enabled.
    @[::JSON::Field(key: "preemptionPolicy")]
    @[::YAML::Field(key: "preemptionPolicy")]
    property preemption_policy : String?
    # priority is the value of priority of composite pod groups created from this template. Various system components use this field to find the priority of the composite pod group. When Priority Admission Controller is enabled, it prevents users from setting this field. The admission controller populates this field from PriorityClassName. The higher the value, the higher the priority. This field is immutable.
    property priority : Int32?
    # priorityClassName indicates the priority that should be considered when scheduling a composite pod group created from this template. If no priority class is specified, admission control can set this to the global default priority class if it exists. Otherwise, composite pod groups created from this template will have the priority set to zero. This field is immutable.
    @[::JSON::Field(key: "priorityClassName")]
    @[::YAML::Field(key: "priorityClassName")]
    property priority_class_name : String?
    # schedulingConstraints defines optional scheduling constraints (e.g. topology) for this CompositePodGroupTemplate. This field is immutable.
    @[::JSON::Field(key: "schedulingConstraints")]
    @[::YAML::Field(key: "schedulingConstraints")]
    property scheduling_constraints : CompositePodGroupSchedulingConstraints?
    # schedulingPolicy defines the scheduling policy for this template.
    @[::JSON::Field(key: "schedulingPolicy")]
    @[::YAML::Field(key: "schedulingPolicy")]
    property scheduling_policy : CompositePodGroupSchedulingPolicy?
  end

  # DisruptionMode defines how individual entities within a group can be disrupted. Exactly one mode can be set.
  struct DisruptionMode
    include Kubernetes::Serializable

    # all specifies that all children can only be disrupted together.
    property all : AllDisruptionMode?
    # single specifies that children can be disrupted independently from each other.
    property single : SingleDisruptionMode?
  end

  # GangSchedulingPolicy defines the parameters for gang scheduling.
  struct GangSchedulingPolicy
    include Kubernetes::Serializable

    # minCount is the minimum number of pods that must be schedulable or scheduled at the same time for the scheduler to admit the entire group. It must be a positive integer. This field is mutable to support workload scaling.
    # Note that the scheduler operates on an eventually consistent model. Updates to minCount may not be immediately reflected in scheduling decisions due to propagation delays. If minCount is updated while a scheduling cycle is in progress for that group, the new value may not take effect until the next cycle. Moreover, minCount is only enforced during scheduling, meaning that modifications to this field do not affect already-scheduled pods, applying only to those evaluated in future cycles.
    @[::JSON::Field(key: "minCount")]
    @[::YAML::Field(key: "minCount")]
    property min_count : Int32?
  end

  # PodGroup represents a runtime instance of pods grouped together. PodGroups are created by workload controllers (Job, LWS, JobSet, etc...) from Workload.podGroupTemplates. PodGroup API enablement is toggled by the GenericWorkload feature gate.
  struct PodGroup
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # metadata is the standard object metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ObjectMeta?
    # spec defines the desired state of the PodGroup.
    property spec : PodGroupSpec?
    # status represents the current observed state of the PodGroup.
    property status : PodGroupStatus?
  end

  # PodGroupList contains a list of PodGroup resources.
  struct PodGroupList
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Items is the list of PodGroups.
    property items : Array(PodGroup)?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard list metadata.
    property metadata : ListMeta?
  end

  # PodGroupResourceClaim references exactly one ResourceClaim, either directly or by naming a ResourceClaimTemplate which is then turned into a ResourceClaim for the PodGroup.
  # It adds a name to it that uniquely identifies the ResourceClaim inside the PodGroup. Pods that need access to the ResourceClaim define a matching reference in its own Spec.ResourceClaims. The Pod's claim must match all fields of the PodGroup's claim exactly.
  struct PodGroupResourceClaim
    include Kubernetes::Serializable

    # name uniquely identifies this resource claim inside the PodGroup. This must be a DNS_LABEL.
    property name : String?
    # resourceClaimName is the name of a ResourceClaim object in the same namespace as this PodGroup. The ResourceClaim will be reserved for the PodGroup instead of its individual pods.
    # Exactly one of ResourceClaimName and ResourceClaimTemplateName must be set.
    @[::JSON::Field(key: "resourceClaimName")]
    @[::YAML::Field(key: "resourceClaimName")]
    property resource_claim_name : String?
    # resourceClaimTemplateName is the name of a ResourceClaimTemplate object in the same namespace as this PodGroup.
    # The template will be used to create a new ResourceClaim, which will be bound to this PodGroup. When this PodGroup is deleted, the ResourceClaim will also be deleted. The PodGroup name and resource name, along with a generated component, will be used to form a unique name for the ResourceClaim, which will be recorded in podgroup.status.resourceClaimStatuses.
    # This field is immutable and no changes will be made to the corresponding ResourceClaim by the control plane after creating the ResourceClaim.
    # Exactly one of ResourceClaimName and ResourceClaimTemplateName must be set.
    @[::JSON::Field(key: "resourceClaimTemplateName")]
    @[::YAML::Field(key: "resourceClaimTemplateName")]
    property resource_claim_template_name : String?
  end

  # PodGroupResourceClaimStatus is stored in the PodGroupStatus for each PodGroupResourceClaim which references a ResourceClaimTemplate. It stores the generated name for the corresponding ResourceClaim.
  struct PodGroupResourceClaimStatus
    include Kubernetes::Serializable

    # name uniquely identifies this resource claim inside the PodGroup. This must match the name of an entry in podgroup.spec.resourceClaims, which implies that the string must be a DNS_LABEL.
    property name : String?
    # resourceClaimName is the name of the ResourceClaim that was generated for the PodGroup in the namespace of the PodGroup. If this is unset, then generating a ResourceClaim was not necessary. The podgroup.spec.resourceClaims entry can be ignored in this case.
    @[::JSON::Field(key: "resourceClaimName")]
    @[::YAML::Field(key: "resourceClaimName")]
    property resource_claim_name : String?
  end

  # PodGroupSchedulingConstraints defines scheduling constraints (e.g. topology) for a PodGroup.
  struct PodGroupSchedulingConstraints
    include Kubernetes::Serializable

    # topology defines the topology constraints for the pod group. Currently only a single topology constraint can be specified. This may change in the future.
    property topology : Array(TopologyConstraint)?
  end

  # PodGroupSchedulingPolicy defines the scheduling configuration for a PodGroup. Exactly one policy must be set. The policy is chosen at creation time by setting either the Basic or Gang field. The PodGroup may not change policy after creation. Fields within chosen policy may be updated after creation when their individual fields allow it.
  struct PodGroupSchedulingPolicy
    include Kubernetes::Serializable

    # basic specifies that the pods in this group should be scheduled using standard Kubernetes scheduling behavior. Setting this field at group creation time opts this group to basic scheduling; this field cannot be changed afterward.
    property basic : BasicSchedulingPolicy?
    # gang specifies that the pods in this group should be scheduled using all-or-nothing semantics. Setting this field at group creation time opts this group to gang scheduling; this field cannot be set or unset afterward. The minCount field within Gang scheduling policy remains mutable after group creation.
    property gang : GangSchedulingPolicy?
  end

  # PodGroupSpec defines the desired state of a PodGroup.
  struct PodGroupSpec
    include Kubernetes::Serializable

    # disruptionMode defines the mode in which a given PodGroup can be disrupted. Controllers are expected to fill this field by copying it from a PodGroupTemplate. One of Single, All. Defaults to Single if unset. This field is immutable.
    @[::JSON::Field(key: "disruptionMode")]
    @[::YAML::Field(key: "disruptionMode")]
    property disruption_mode : DisruptionMode?
    # parentCompositePodGroupName contains the name of the parent composite pod group within the same namespace as this pod group. If it's nil, then this pod group is a root of a workload's hierarchy. This field is used only when the CompositePodGroup feature gate is enabled. This field is immutable.
    @[::JSON::Field(key: "parentCompositePodGroupName")]
    @[::YAML::Field(key: "parentCompositePodGroupName")]
    property parent_composite_pod_group_name : String?
    # preemptionPolicy is the Policy for preempting pods/podgroups with lower priority. One of Never, PreemptLowerPriority. Defaults to PreemptLowerPriority if unset. When Priority Admission Controller is enabled, it populates this field from PriorityClassName, and defaults to PreemptLowerPriority if value is unset in PriorityClass. This field is immutable. This field is available only when the PodGroupPreemptionPolicy feature gate is enabled.
    @[::JSON::Field(key: "preemptionPolicy")]
    @[::YAML::Field(key: "preemptionPolicy")]
    property preemption_policy : String?
    # priority is the value of priority of this pod group. Various system components use this field to find the priority of the pod group. When Priority Admission Controller is enabled, it prevents users from setting this field. The admission controller populates this field from PriorityClassName. The higher the value, the higher the priority. This field is immutable.
    property priority : Int32?
    # priorityClassName defines the priority that should be considered when scheduling this pod group. Controllers are expected to fill this field by copying it from a PodGroupTemplate. Otherwise, it is validated and resolved similarly to the PriorityClassName on PodGroupTemplate (i.e. if no priority class is specified, admission control can set this to the global default priority class if it exists. Otherwise, the pod group's priority will be zero). This field is immutable.
    @[::JSON::Field(key: "priorityClassName")]
    @[::YAML::Field(key: "priorityClassName")]
    property priority_class_name : String?
    # resourceClaims defines which ResourceClaims may be shared among Pods in the group. Pods consume the devices allocated to a PodGroup's claim by defining a claim in its own Spec.ResourceClaims that matches the PodGroup's claim exactly. The claim must have the same name and refer to the same ResourceClaim or ResourceClaimTemplate.
    # This is a beta-level field and requires that the DRAWorkloadResourceClaims feature gate is enabled.
    # This field is immutable.
    @[::JSON::Field(key: "resourceClaims")]
    @[::YAML::Field(key: "resourceClaims")]
    property resource_claims : Array(PodGroupResourceClaim)?
    # schedulingConstraints defines optional scheduling constraints (e.g. topology) for this PodGroup. Controllers are expected to fill this field by copying it from a PodGroupTemplate. This field is immutable. This field is only available when the TopologyAwareWorkloadScheduling feature gate is enabled.
    @[::JSON::Field(key: "schedulingConstraints")]
    @[::YAML::Field(key: "schedulingConstraints")]
    property scheduling_constraints : PodGroupSchedulingConstraints?
    # schedulingPolicy defines the scheduling policy for this instance of the PodGroup. Controllers are expected to fill this field by copying it from a PodGroupTemplate.
    @[::JSON::Field(key: "schedulingPolicy")]
    @[::YAML::Field(key: "schedulingPolicy")]
    property scheduling_policy : PodGroupSchedulingPolicy?
    # workloadRef references an optional PodGroup template within the Workload object that was used to create the PodGroup. This field is immutable.
    @[::JSON::Field(key: "workloadRef")]
    @[::YAML::Field(key: "workloadRef")]
    property workload_ref : WorkloadReference?
  end

  # PodGroupStatus represents information about the status of a pod group.
  struct PodGroupStatus
    include Kubernetes::Serializable

    # conditions represent the latest observations of the PodGroup's state.
    # Known condition types: - "PodGroupInitiallyScheduled": Indicates whether the scheduling requirement has been satisfied. Once this condition transitions to True, it serves as a terminal state and will never revert to False, even if pods are subsequently evicted and group constraints are no longer met. - "DisruptionTarget": Indicates whether the PodGroup is about to be terminated
    # due to disruption such as preemption.
    # Known reasons for the PodGroupInitiallyScheduled condition: - "Unschedulable": The PodGroup cannot be scheduled due to resource constraints,
    # affinity/anti-affinity rules, or insufficient capacity for the gang.
    # - "SchedulerError": The PodGroup cannot be scheduled due to some internal error
    # that happened during scheduling, for example due to nodeAffinity parsing errors.
    # Known reasons for the DisruptionTarget condition: - "PreemptionByScheduler": The PodGroup was preempted by the scheduler to make room for
    # higher-priority PodGroups or Pods.
    property conditions : Array(Condition)?
    # resourceClaimStatuses is status of resource claims.
    @[::JSON::Field(key: "resourceClaimStatuses")]
    @[::YAML::Field(key: "resourceClaimStatuses")]
    property resource_claim_statuses : Array(PodGroupResourceClaimStatus)?
  end

  # PodGroupTemplate represents a template for a set of pods with a scheduling policy.
  struct PodGroupTemplate
    include Kubernetes::Serializable

    # disruptionMode defines the mode in which a given PodGroup can be disrupted. One of Single, All. This field is immutable.
    @[::JSON::Field(key: "disruptionMode")]
    @[::YAML::Field(key: "disruptionMode")]
    property disruption_mode : DisruptionMode?
    # name is a unique identifier for the PodGroupTemplate within the Workload. It must be a DNS label. This field is immutable.
    property name : String?
    # preemptionPolicy is the Policy for preempting pods/podgroups with lower priority. One of Never, PreemptLowerPriority. This field is immutable. This field is available only when the PodGroupPreemptionPolicy feature gate is enabled.
    @[::JSON::Field(key: "preemptionPolicy")]
    @[::YAML::Field(key: "preemptionPolicy")]
    property preemption_policy : String?
    # priority is the value of priority of pod groups created from this template. Various system components use this field to find the priority of the pod group. The higher the value, the higher the priority. This field is immutable.
    property priority : Int32?
    # priorityClassName indicates the priority that should be considered when scheduling a pod group created from this template. This field is immutable.
    @[::JSON::Field(key: "priorityClassName")]
    @[::YAML::Field(key: "priorityClassName")]
    property priority_class_name : String?
    # resourceClaims defines which ResourceClaims may be shared among Pods in the group. Pods consume the devices allocated to a PodGroup's claim by defining a claim in its own Spec.ResourceClaims that matches the PodGroup's claim exactly. The claim must have the same name and refer to the same ResourceClaim or ResourceClaimTemplate.
    # This is a beta-level field and requires that the DRAWorkloadResourceClaims feature gate is enabled.
    # This field is immutable.
    @[::JSON::Field(key: "resourceClaims")]
    @[::YAML::Field(key: "resourceClaims")]
    property resource_claims : Array(PodGroupResourceClaim)?
    # schedulingConstraints defines optional scheduling constraints (e.g. topology) for this PodGroupTemplate. This field is only available when the TopologyAwareWorkloadScheduling feature gate is enabled. This field is immutable.
    @[::JSON::Field(key: "schedulingConstraints")]
    @[::YAML::Field(key: "schedulingConstraints")]
    property scheduling_constraints : PodGroupSchedulingConstraints?
    # schedulingPolicy defines the scheduling policy for this PodGroupTemplate.
    @[::JSON::Field(key: "schedulingPolicy")]
    @[::YAML::Field(key: "schedulingPolicy")]
    property scheduling_policy : PodGroupSchedulingPolicy?
  end

  # SingleCompositeDisruptionMode means that individual children of a CompositePodGroup can be disrupted or preempted independently.
  struct SingleCompositeDisruptionMode
    include Kubernetes::Serializable
  end

  # SingleDisruptionMode specifies that children can be disrupted independently.
  struct SingleDisruptionMode
    include Kubernetes::Serializable
  end

  # TopologyConstraint defines a topology constraint for a PodGroup.
  struct TopologyConstraint
    include Kubernetes::Serializable

    # key specifies the key of the node label representing the topology domain. All pods within the PodGroup must be colocated within the same domain instance. Different PodGroups can land on different domain instances even if they derive from the same PodGroupTemplate. Examples: "topology.kubernetes.io/rack"
    property key : String?
  end

  # TypedLocalObjectReference allows to reference typed object inside the same namespace.
  struct TypedLocalObjectReference
    include Kubernetes::Serializable

    # apiGroup is the group for the resource being referenced. If apiGroup is empty, the specified Kind must be in the core API group. For any other third-party types, setting apiGroup is required. It must be a DNS subdomain.
    @[::JSON::Field(key: "apiGroup")]
    @[::YAML::Field(key: "apiGroup")]
    property api_group : String?
    # kind is the type of resource being referenced. It must be a path segment name.
    property kind : String?
    # name is the name of resource being referenced. It must be a path segment name.
    property name : String?
  end

  # Workload allows for expressing scheduling constraints that should be used when managing the lifecycle of workloads from the scheduling perspective, including scheduling, preemption, eviction and other phases. Workload API enablement is toggled by the GenericWorkload feature gate.
  struct Workload
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # metadata is the standard object metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ObjectMeta?
    # spec defines the desired behavior of a Workload.
    property spec : WorkloadSpec?
  end

  # WorkloadList contains a list of Workload resources.
  struct WorkloadList
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
    property api_version : String?
    # items is the list of Workloads.
    property items : Array(Workload)?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # metadata is the standard list metadata.
    property metadata : ListMeta?
  end

  # WorkloadReference references the Workload object together with the template that was used to create a particular PodGroup.
  struct WorkloadReference
    include Kubernetes::Serializable

    # templateName is the name of a template within the Workload object that was used to create a pod group. It must be a DNS label. This field is required.
    @[::JSON::Field(key: "templateName")]
    @[::YAML::Field(key: "templateName")]
    property template_name : String?
    # workloadName is the name of the Workload object that contains a template that was used when creating a pod group. It must be a DNS name. This field is required.
    @[::JSON::Field(key: "workloadName")]
    @[::YAML::Field(key: "workloadName")]
    property workload_name : String?
  end

  # WorkloadSpec defines the desired state of a Workload.
  struct WorkloadSpec
    include Kubernetes::Serializable

    # compositePodGroupTemplates is the list of CompositePodGroup templates that make up the Workload. The maximum number of templates is 8. Templates cannot be added or removed after the workload is created. Existing templates may still be updated where their individual fields allow it. Exactly one of CompositePodGroupTemplates and PodGroupTemplates must be set.
    # This field is used only when the CompositePodGroup feature gate is enabled.
    @[::JSON::Field(key: "compositePodGroupTemplates")]
    @[::YAML::Field(key: "compositePodGroupTemplates")]
    property composite_pod_group_templates : Array(CompositePodGroupTemplate)?
    # controllerRef is an optional reference to the controlling object, such as a Deployment or Job. This field is intended for use by tools like CLIs to provide a link back to the original workload definition. This field is immutable.
    @[::JSON::Field(key: "controllerRef")]
    @[::YAML::Field(key: "controllerRef")]
    property controller_ref : TypedLocalObjectReference?
    # podGroupTemplates is the list of templates that make up the Workload. The maximum number of templates is 8. Templates cannot be added or removed after the workload is created. Existing templates may still be updated where their individual fields allow it. Exactly one of CompositePodGroupTemplates and PodGroupTemplates must be set.
    @[::JSON::Field(key: "podGroupTemplates")]
    @[::YAML::Field(key: "podGroupTemplates")]
    property pod_group_templates : Array(PodGroupTemplate)?
  end
end
