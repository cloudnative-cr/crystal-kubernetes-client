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

require "../../serialization"

module Kubernetes
  # Eviction evicts a pod from its node subject to certain policies and safety constraints. This is a subresource of Pod.  A request to cause such an eviction is created by POSTing to .../pods/<pod name>/evictions.
  struct Eviction
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # DeleteOptions may be provided
    @[JSON::Field(key: "deleteOptions")]
    @[YAML::Field(key: "deleteOptions")]
    property delete_options : DeleteOptions?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # ObjectMeta describes the pod that is being evicted.
    property metadata : ObjectMeta?
  end

  # PodDisruptionBudget is an object to define the max disruption that can be caused to a collection of pods
  struct PodDisruptionBudget
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ObjectMeta?
    # Specification of the desired behavior of the PodDisruptionBudget.
    property spec : PodDisruptionBudgetSpec?
    # Most recently observed status of the PodDisruptionBudget.
    property status : PodDisruptionBudgetStatus?
  end

  # PodDisruptionBudgetList is a collection of PodDisruptionBudgets.
  struct PodDisruptionBudgetList
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Items is a list of PodDisruptionBudgets
    property items : Array(PodDisruptionBudget)?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ListMeta?
  end

  # PodDisruptionBudgetSpec is a description of a PodDisruptionBudget.
  struct PodDisruptionBudgetSpec
    include Kubernetes::Serializable

    # An eviction is allowed if at most "maxUnavailable" pods selected by "selector" are unavailable after the eviction, i.e. even in absence of the evicted pod. For example, one can prevent all voluntary evictions by specifying 0. This is a mutually exclusive setting with "minAvailable".
    @[JSON::Field(key: "maxUnavailable")]
    @[YAML::Field(key: "maxUnavailable")]
    property max_unavailable : IntOrString?
    # An eviction is allowed if at least "minAvailable" pods selected by "selector" will still be available after the eviction, i.e. even in the absence of the evicted pod.  So for example you can prevent all voluntary evictions by specifying "100%".
    @[JSON::Field(key: "minAvailable")]
    @[YAML::Field(key: "minAvailable")]
    property min_available : IntOrString?
    # Label query over pods whose evictions are managed by the disruption budget. A null selector will match no pods, while an empty ({}) selector will select all pods within the namespace.
    property selector : LabelSelector?
    # UnhealthyPodEvictionPolicy defines the criteria for when unhealthy pods should be considered for eviction. Current implementation considers healthy pods, as pods that have status.conditions item with type="Ready",status="True".
    # Valid policies are IfHealthyBudget and AlwaysAllow. If no policy is specified, the default behavior will be used, which corresponds to the IfHealthyBudget policy.
    # IfHealthyBudget policy means that running pods (status.phase="Running"), but not yet healthy can be evicted only if the guarded application is not disrupted (status.currentHealthy is at least equal to status.desiredHealthy). Healthy pods will be subject to the PDB for eviction.
    # AlwaysAllow policy means that all running pods (status.phase="Running"), but not yet healthy are considered disrupted and can be evicted regardless of whether the criteria in a PDB is met. This means perspective running pods of a disrupted application might not get a chance to become healthy. Healthy pods will be subject to the PDB for eviction.
    # Additional policies may be added in the future. Clients making eviction decisions should disallow eviction of unhealthy pods if they encounter an unrecognized policy in this field.
    @[JSON::Field(key: "unhealthyPodEvictionPolicy")]
    @[YAML::Field(key: "unhealthyPodEvictionPolicy")]
    property unhealthy_pod_eviction_policy : String?
  end

  # PodDisruptionBudgetStatus represents information about the status of a PodDisruptionBudget. Status may trail the actual state of a system.
  struct PodDisruptionBudgetStatus
    include Kubernetes::Serializable

    # Conditions contain conditions for PDB. The disruption controller sets the DisruptionAllowed condition. The following are known values for the reason field (additional reasons could be added in the future): - SyncFailed: The controller encountered an error and wasn't able to compute
    # the number of allowed disruptions. Therefore no disruptions are
    # allowed and the status of the condition will be False.
    # - InsufficientPods: The number of pods are either at or below the number
    # required by the PodDisruptionBudget. No disruptions are
    # allowed and the status of the condition will be False.
    # - SufficientPods: There are more pods than required by the PodDisruptionBudget.
    # The condition will be True, and the number of allowed
    # disruptions are provided by the disruptionsAllowed property.
    property conditions : Array(Condition)?
    # current number of healthy pods
    @[JSON::Field(key: "currentHealthy")]
    @[YAML::Field(key: "currentHealthy")]
    property current_healthy : Int32?
    # minimum desired number of healthy pods
    @[JSON::Field(key: "desiredHealthy")]
    @[YAML::Field(key: "desiredHealthy")]
    property desired_healthy : Int32?
    # DisruptedPods contains information about pods whose eviction was processed by the API server eviction subresource handler but has not yet been observed by the PodDisruptionBudget controller. A pod will be in this map from the time when the API server processed the eviction request to the time when the pod is seen by PDB controller as having been marked for deletion (or after a timeout). The key in the map is the name of the pod and the value is the time when the API server processed the eviction request. If the deletion didn't occur and a pod is still there it will be removed from the list automatically by PodDisruptionBudget controller after some time. If everything goes smooth this map should be empty for the most of the time. Large number of entries in the map may indicate problems with pod deletions.
    @[JSON::Field(key: "disruptedPods")]
    @[YAML::Field(key: "disruptedPods")]
    property disrupted_pods : Hash(String, Time)?
    # Number of pod disruptions that are currently allowed.
    @[JSON::Field(key: "disruptionsAllowed")]
    @[YAML::Field(key: "disruptionsAllowed")]
    property disruptions_allowed : Int32?
    # total number of pods counted by this disruption budget
    @[JSON::Field(key: "expectedPods")]
    @[YAML::Field(key: "expectedPods")]
    property expected_pods : Int32?
    # Most recent generation observed when updating this PDB status. DisruptionsAllowed and other status information is valid only if observedGeneration equals to PDB's object generation.
    @[JSON::Field(key: "observedGeneration")]
    @[YAML::Field(key: "observedGeneration")]
    property observed_generation : Int64?
  end
end
