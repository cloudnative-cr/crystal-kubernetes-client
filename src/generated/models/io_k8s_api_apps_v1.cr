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
  # ControllerRevision implements an immutable snapshot of state data. Clients are responsible for serializing and deserializing the objects that contain their internal state. Once a ControllerRevision has been successfully created, it can not be updated. The API Server will fail validation of all requests that attempt to mutate the Data field. ControllerRevisions may, however, be deleted. Note that, due to its use by both the DaemonSet and StatefulSet controllers for update and rollback, this object is beta. However, it may be subject to name and representation changes in future releases, and clients should not depend on its stability. It is primarily for internal use by controllers.
  struct ControllerRevision
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Data is the serialized representation of the state.
    property data : RawExtension?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ObjectMeta?
    # Revision indicates the revision of the state represented by Data.
    property revision : Int64?
  end

  # ControllerRevisionList is a resource containing a list of ControllerRevision objects.
  struct ControllerRevisionList
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Items is the list of ControllerRevisions
    property items : Array(ControllerRevision)?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ListMeta?
  end

  # DaemonSet represents the configuration of a daemon set.
  struct DaemonSet
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ObjectMeta?
    # The desired behavior of this daemon set. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status
    property spec : DaemonSetSpec?
    # The current status of this daemon set. This data may be out of date by some window of time. Populated by the system. Read-only. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status
    property status : DaemonSetStatus?
  end

  # DaemonSetCondition describes the state of a DaemonSet at a certain point.
  struct DaemonSetCondition
    include Kubernetes::Serializable

    # Last time the condition transitioned from one status to another.
    @[::JSON::Field(key: "lastTransitionTime")]
    @[::YAML::Field(key: "lastTransitionTime")]
    property last_transition_time : Time?
    # A human readable message indicating details about the transition.
    property message : String?
    # The reason for the condition's last transition.
    property reason : String?
    # Status of the condition, one of True, False, Unknown.
    property status : String?
    # Type of DaemonSet condition.
    property type : String?
  end

  # DaemonSetList is a collection of daemon sets.
  struct DaemonSetList
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
    property api_version : String?
    # A list of daemon sets.
    property items : Array(DaemonSet)?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard list metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ListMeta?
  end

  # DaemonSetSpec is the specification of a daemon set.
  struct DaemonSetSpec
    include Kubernetes::Serializable

    # The minimum number of seconds for which a newly created DaemonSet pod should be ready without any of its container crashing, for it to be considered available. Defaults to 0 (pod will be considered available as soon as it is ready).
    @[::JSON::Field(key: "minReadySeconds")]
    @[::YAML::Field(key: "minReadySeconds")]
    property min_ready_seconds : Int32?
    # The number of old history to retain to allow rollback. This is a pointer to distinguish between explicit zero and not specified. Defaults to 10.
    @[::JSON::Field(key: "revisionHistoryLimit")]
    @[::YAML::Field(key: "revisionHistoryLimit")]
    property revision_history_limit : Int32?
    # A label query over pods that are managed by the daemon set. Must match in order to be controlled. It must match the pod template's labels. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/#label-selectors
    property selector : LabelSelector?
    # An object that describes the pod that will be created. The DaemonSet will create exactly one copy of this pod on every node that matches the template's node selector (or on every node if no node selector is specified). The only allowed template.spec.restartPolicy value is "Always". More info: https://kubernetes.io/docs/concepts/workloads/controllers/replicationcontroller#pod-template
    property template : PodTemplateSpec?
    # An update strategy to replace existing DaemonSet pods with new pods.
    @[::JSON::Field(key: "updateStrategy")]
    @[::YAML::Field(key: "updateStrategy")]
    property update_strategy : DaemonSetUpdateStrategy?
  end

  # DaemonSetStatus represents the current status of a daemon set.
  struct DaemonSetStatus
    include Kubernetes::Serializable

    # Count of hash collisions for the DaemonSet. The DaemonSet controller uses this field as a collision avoidance mechanism when it needs to create the name for the newest ControllerRevision.
    @[::JSON::Field(key: "collisionCount")]
    @[::YAML::Field(key: "collisionCount")]
    property collision_count : Int32?
    # Represents the latest available observations of a DaemonSet's current state.
    property conditions : Array(DaemonSetCondition)?
    # The number of nodes that are running at least 1 daemon pod and are supposed to run the daemon pod. More info: https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/
    @[::JSON::Field(key: "currentNumberScheduled")]
    @[::YAML::Field(key: "currentNumberScheduled")]
    property current_number_scheduled : Int32?
    # The total number of nodes that should be running the daemon pod (including nodes correctly running the daemon pod). More info: https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/
    @[::JSON::Field(key: "desiredNumberScheduled")]
    @[::YAML::Field(key: "desiredNumberScheduled")]
    property desired_number_scheduled : Int32?
    # The number of nodes that should be running the daemon pod and have one or more of the daemon pod running and available (ready for at least spec.minReadySeconds)
    @[::JSON::Field(key: "numberAvailable")]
    @[::YAML::Field(key: "numberAvailable")]
    property number_available : Int32?
    # The number of nodes that are running the daemon pod, but are not supposed to run the daemon pod. More info: https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/
    @[::JSON::Field(key: "numberMisscheduled")]
    @[::YAML::Field(key: "numberMisscheduled")]
    property number_misscheduled : Int32?
    # numberReady is the number of nodes that should be running the daemon pod and have one or more of the daemon pod running with a Ready Condition.
    @[::JSON::Field(key: "numberReady")]
    @[::YAML::Field(key: "numberReady")]
    property number_ready : Int32?
    # The number of nodes that should be running the daemon pod and have none of the daemon pod running and available (ready for at least spec.minReadySeconds)
    @[::JSON::Field(key: "numberUnavailable")]
    @[::YAML::Field(key: "numberUnavailable")]
    property number_unavailable : Int32?
    # The most recent generation observed by the daemon set controller.
    @[::JSON::Field(key: "observedGeneration")]
    @[::YAML::Field(key: "observedGeneration")]
    property observed_generation : Int64?
    # The total number of nodes that are running updated daemon pod
    @[::JSON::Field(key: "updatedNumberScheduled")]
    @[::YAML::Field(key: "updatedNumberScheduled")]
    property updated_number_scheduled : Int32?
  end

  # DaemonSetUpdateStrategy is a struct used to control the update strategy for a DaemonSet.
  struct DaemonSetUpdateStrategy
    include Kubernetes::Serializable

    # Rolling update config params. Present only if type = "RollingUpdate".
    @[::JSON::Field(key: "rollingUpdate")]
    @[::YAML::Field(key: "rollingUpdate")]
    property rolling_update : RollingUpdateDaemonSet?
    # Type of daemon set update. Can be "RollingUpdate" or "OnDelete". Default is RollingUpdate.
    property type : String?
  end

  # Deployment enables declarative updates for Pods and ReplicaSets.
  struct Deployment
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ObjectMeta?
    # Specification of the desired behavior of the Deployment.
    property spec : DeploymentSpec?
    # Most recently observed status of the Deployment.
    property status : DeploymentStatus?
  end

  # DeploymentCondition describes the state of a deployment at a certain point.
  struct DeploymentCondition
    include Kubernetes::Serializable

    # Last time the condition transitioned from one status to another.
    @[::JSON::Field(key: "lastTransitionTime")]
    @[::YAML::Field(key: "lastTransitionTime")]
    property last_transition_time : Time?
    # The last time this condition was updated.
    @[::JSON::Field(key: "lastUpdateTime")]
    @[::YAML::Field(key: "lastUpdateTime")]
    property last_update_time : Time?
    # A human readable message indicating details about the transition.
    property message : String?
    # The reason for the condition's last transition.
    property reason : String?
    # Status of the condition, one of True, False, Unknown.
    property status : String?
    # Type of deployment condition.
    property type : String?
  end

  # DeploymentList is a list of Deployments.
  struct DeploymentList
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Items is the list of Deployments.
    property items : Array(Deployment)?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard list metadata.
    property metadata : ListMeta?
  end

  # DeploymentSpec is the specification of the desired behavior of the Deployment.
  struct DeploymentSpec
    include Kubernetes::Serializable

    # Minimum number of seconds for which a newly created pod should be ready without any of its container crashing, for it to be considered available. Defaults to 0 (pod will be considered available as soon as it is ready)
    @[::JSON::Field(key: "minReadySeconds")]
    @[::YAML::Field(key: "minReadySeconds")]
    property min_ready_seconds : Int32?
    # Indicates that the deployment is paused.
    property paused : Bool?
    # The maximum time in seconds for a deployment to make progress before it is considered to be failed. The deployment controller will continue to process failed deployments and a condition with a ProgressDeadlineExceeded reason will be surfaced in the deployment status. Note that progress will not be estimated during the time a deployment is paused. Defaults to 600s.
    @[::JSON::Field(key: "progressDeadlineSeconds")]
    @[::YAML::Field(key: "progressDeadlineSeconds")]
    property progress_deadline_seconds : Int32?
    # Number of desired pods. This is a pointer to distinguish between explicit zero and not specified. Defaults to 1.
    property replicas : Int32?
    # The number of old ReplicaSets to retain to allow rollback. This is a pointer to distinguish between explicit zero and not specified. Defaults to 10.
    @[::JSON::Field(key: "revisionHistoryLimit")]
    @[::YAML::Field(key: "revisionHistoryLimit")]
    property revision_history_limit : Int32?
    # Label selector for pods. Existing ReplicaSets whose pods are selected by this will be the ones affected by this deployment. It must match the pod template's labels.
    property selector : LabelSelector?
    # The deployment strategy to use to replace existing pods with new ones.
    property strategy : DeploymentStrategy?
    # Template describes the pods that will be created. The only allowed template.spec.restartPolicy value is "Always".
    property template : PodTemplateSpec?
  end

  # DeploymentStatus is the most recently observed status of the Deployment.
  struct DeploymentStatus
    include Kubernetes::Serializable

    # Total number of available non-terminating pods (ready for at least minReadySeconds) targeted by this deployment.
    @[::JSON::Field(key: "availableReplicas")]
    @[::YAML::Field(key: "availableReplicas")]
    property available_replicas : Int32?
    # Count of hash collisions for the Deployment. The Deployment controller uses this field as a collision avoidance mechanism when it needs to create the name for the newest ReplicaSet.
    @[::JSON::Field(key: "collisionCount")]
    @[::YAML::Field(key: "collisionCount")]
    property collision_count : Int32?
    # Represents the latest available observations of a deployment's current state.
    property conditions : Array(DeploymentCondition)?
    # The generation observed by the deployment controller.
    @[::JSON::Field(key: "observedGeneration")]
    @[::YAML::Field(key: "observedGeneration")]
    property observed_generation : Int64?
    # Total number of non-terminating pods targeted by this Deployment with a Ready Condition.
    @[::JSON::Field(key: "readyReplicas")]
    @[::YAML::Field(key: "readyReplicas")]
    property ready_replicas : Int32?
    # Total number of non-terminating pods targeted by this deployment (their labels match the selector).
    property replicas : Int32?
    # Total number of terminating pods targeted by this deployment. Terminating pods have a non-null .metadata.deletionTimestamp and have not yet reached the Failed or Succeeded .status.phase.
    # This is a beta field and requires enabling DeploymentReplicaSetTerminatingReplicas feature (enabled by default).
    @[::JSON::Field(key: "terminatingReplicas")]
    @[::YAML::Field(key: "terminatingReplicas")]
    property terminating_replicas : Int32?
    # Total number of unavailable pods targeted by this deployment. This is the total number of pods that are still required for the deployment to have 100% available capacity. They may either be pods that are running but not yet available or pods that still have not been created.
    @[::JSON::Field(key: "unavailableReplicas")]
    @[::YAML::Field(key: "unavailableReplicas")]
    property unavailable_replicas : Int32?
    # Total number of non-terminating pods targeted by this deployment that have the desired template spec.
    @[::JSON::Field(key: "updatedReplicas")]
    @[::YAML::Field(key: "updatedReplicas")]
    property updated_replicas : Int32?
  end

  # DeploymentStrategy describes how to replace existing pods with new ones.
  struct DeploymentStrategy
    include Kubernetes::Serializable

    # Rolling update config params. Present only if DeploymentStrategyType = RollingUpdate.
    @[::JSON::Field(key: "rollingUpdate")]
    @[::YAML::Field(key: "rollingUpdate")]
    property rolling_update : RollingUpdateDeployment?
    # Type of deployment. Can be "Recreate" or "RollingUpdate". Default is RollingUpdate.
    property type : String?
  end

  # ReplicaSet ensures that a specified number of pod replicas are running at any given time.
  struct ReplicaSet
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # If the Labels of a ReplicaSet are empty, they are defaulted to be the same as the Pod(s) that the ReplicaSet manages. Standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ObjectMeta?
    # Spec defines the specification of the desired behavior of the ReplicaSet. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status
    property spec : ReplicaSetSpec?
    # Status is the most recently observed status of the ReplicaSet. This data may be out of date by some window of time. Populated by the system. Read-only. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status
    property status : ReplicaSetStatus?
  end

  # ReplicaSetCondition describes the state of a replica set at a certain point.
  struct ReplicaSetCondition
    include Kubernetes::Serializable

    # The last time the condition transitioned from one status to another.
    @[::JSON::Field(key: "lastTransitionTime")]
    @[::YAML::Field(key: "lastTransitionTime")]
    property last_transition_time : Time?
    # A human readable message indicating details about the transition.
    property message : String?
    # The reason for the condition's last transition.
    property reason : String?
    # Status of the condition, one of True, False, Unknown.
    property status : String?
    # Type of replica set condition.
    property type : String?
  end

  # ReplicaSetList is a collection of ReplicaSets.
  struct ReplicaSetList
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
    property api_version : String?
    # List of ReplicaSets. More info: https://kubernetes.io/docs/concepts/workloads/controllers/replicaset
    property items : Array(ReplicaSet)?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard list metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property metadata : ListMeta?
  end

  # ReplicaSetSpec is the specification of a ReplicaSet.
  struct ReplicaSetSpec
    include Kubernetes::Serializable

    # Minimum number of seconds for which a newly created pod should be ready without any of its container crashing, for it to be considered available. Defaults to 0 (pod will be considered available as soon as it is ready)
    @[::JSON::Field(key: "minReadySeconds")]
    @[::YAML::Field(key: "minReadySeconds")]
    property min_ready_seconds : Int32?
    # Replicas is the number of desired pods. This is a pointer to distinguish between explicit zero and unspecified. Defaults to 1. More info: https://kubernetes.io/docs/concepts/workloads/controllers/replicaset
    property replicas : Int32?
    # Selector is a label query over pods that should match the replica count. Label keys and values that must match in order to be controlled by this replica set. It must match the pod template's labels. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/#label-selectors
    property selector : LabelSelector?
    # Template is the object that describes the pod that will be created if insufficient replicas are detected. More info: https://kubernetes.io/docs/concepts/workloads/controllers/replicaset/#pod-template
    property template : PodTemplateSpec?
  end

  # ReplicaSetStatus represents the current status of a ReplicaSet.
  struct ReplicaSetStatus
    include Kubernetes::Serializable

    # The number of available non-terminating pods (ready for at least minReadySeconds) for this replica set.
    @[::JSON::Field(key: "availableReplicas")]
    @[::YAML::Field(key: "availableReplicas")]
    property available_replicas : Int32?
    # Represents the latest available observations of a replica set's current state.
    property conditions : Array(ReplicaSetCondition)?
    # The number of non-terminating pods that have labels matching the labels of the pod template of the replicaset.
    @[::JSON::Field(key: "fullyLabeledReplicas")]
    @[::YAML::Field(key: "fullyLabeledReplicas")]
    property fully_labeled_replicas : Int32?
    # ObservedGeneration reflects the generation of the most recently observed ReplicaSet.
    @[::JSON::Field(key: "observedGeneration")]
    @[::YAML::Field(key: "observedGeneration")]
    property observed_generation : Int64?
    # The number of non-terminating pods targeted by this ReplicaSet with a Ready Condition.
    @[::JSON::Field(key: "readyReplicas")]
    @[::YAML::Field(key: "readyReplicas")]
    property ready_replicas : Int32?
    # Replicas is the most recently observed number of non-terminating pods. More info: https://kubernetes.io/docs/concepts/workloads/controllers/replicaset
    property replicas : Int32?
    # The number of terminating pods for this replica set. Terminating pods have a non-null .metadata.deletionTimestamp and have not yet reached the Failed or Succeeded .status.phase.
    # This is a beta field and requires enabling DeploymentReplicaSetTerminatingReplicas feature (enabled by default).
    @[::JSON::Field(key: "terminatingReplicas")]
    @[::YAML::Field(key: "terminatingReplicas")]
    property terminating_replicas : Int32?
  end

  # Spec to control the desired behavior of daemon set rolling update.
  struct RollingUpdateDaemonSet
    include Kubernetes::Serializable

    # The maximum number of nodes with an existing available DaemonSet pod that can have an updated DaemonSet pod during during an update. Value can be an absolute number (ex: 5) or a percentage of desired pods (ex: 10%). This can not be 0 if MaxUnavailable is 0. Absolute number is calculated from percentage by rounding up to a minimum of 1. Default value is 0. Example: when this is set to 30%, at most 30% of the total number of nodes that should be running the daemon pod (i.e. status.desiredNumberScheduled) can have their a new pod created before the old pod is marked as deleted. The update starts by launching new pods on 30% of nodes. Once an updated pod is available (Ready for at least minReadySeconds) the old DaemonSet pod on that node is marked deleted. If the old pod becomes unavailable for any reason (Ready transitions to false, is evicted, or is drained) an updated pod is immediately created on that node without considering surge limits. Allowing surge implies the possibility that the resources consumed by the daemonset on any given node can double if the readiness check fails, and so resource intensive daemonsets should take into account that they may cause evictions during disruption.
    @[::JSON::Field(key: "maxSurge")]
    @[::YAML::Field(key: "maxSurge")]
    property max_surge : IntOrString?
    # The maximum number of DaemonSet pods that can be unavailable during the update. Value can be an absolute number (ex: 5) or a percentage of total number of DaemonSet pods at the start of the update (ex: 10%). Absolute number is calculated from percentage by rounding up. This cannot be 0 if MaxSurge is 0 Default value is 1. Example: when this is set to 30%, at most 30% of the total number of nodes that should be running the daemon pod (i.e. status.desiredNumberScheduled) can have their pods stopped for an update at any given time. The update starts by stopping at most 30% of those DaemonSet pods and then brings up new DaemonSet pods in their place. Once the new pods are available, it then proceeds onto other DaemonSet pods, thus ensuring that at least 70% of original number of DaemonSet pods are available at all times during the update.
    @[::JSON::Field(key: "maxUnavailable")]
    @[::YAML::Field(key: "maxUnavailable")]
    property max_unavailable : IntOrString?
  end

  # Spec to control the desired behavior of rolling update.
  struct RollingUpdateDeployment
    include Kubernetes::Serializable

    # The maximum number of pods that can be scheduled above the desired number of pods. Value can be an absolute number (ex: 5) or a percentage of desired pods (ex: 10%). This can not be 0 if MaxUnavailable is 0. Absolute number is calculated from percentage by rounding up. Defaults to 25%. Example: when this is set to 30%, the new ReplicaSet can be scaled up immediately when the rolling update starts, such that the total number of old and new pods do not exceed 130% of desired pods. Once old pods have been killed, new ReplicaSet can be scaled up further, ensuring that total number of pods running at any time during the update is at most 130% of desired pods.
    @[::JSON::Field(key: "maxSurge")]
    @[::YAML::Field(key: "maxSurge")]
    property max_surge : IntOrString?
    # The maximum number of pods that can be unavailable during the update. Value can be an absolute number (ex: 5) or a percentage of desired pods (ex: 10%). Absolute number is calculated from percentage by rounding down. This can not be 0 if MaxSurge is 0. Defaults to 25%. Example: when this is set to 30%, the old ReplicaSet can be scaled down to 70% of desired pods immediately when the rolling update starts. Once new pods are ready, old ReplicaSet can be scaled down further, followed by scaling up the new ReplicaSet, ensuring that the total number of pods available at all times during the update is at least 70% of desired pods.
    @[::JSON::Field(key: "maxUnavailable")]
    @[::YAML::Field(key: "maxUnavailable")]
    property max_unavailable : IntOrString?
  end

  # RollingUpdateStatefulSetStrategy is used to communicate parameter for RollingUpdateStatefulSetStrategyType.
  struct RollingUpdateStatefulSetStrategy
    include Kubernetes::Serializable

    # The maximum number of pods that can be unavailable during the update. Value can be an absolute number (ex: 5) or a percentage of desired pods (ex: 10%). Absolute number is calculated from percentage by rounding up. This can not be 0. Defaults to 1. This field is beta-level and is enabled by default. The field applies to all pods in the range 0 to Replicas-1. That means if there is any unavailable pod in the range 0 to Replicas-1, it will be counted towards MaxUnavailable. This setting might not be effective for the OrderedReady podManagementPolicy. That policy ensures pods are created and become ready one at a time.
    @[::JSON::Field(key: "maxUnavailable")]
    @[::YAML::Field(key: "maxUnavailable")]
    property max_unavailable : IntOrString?
    # Partition indicates the ordinal at which the StatefulSet should be partitioned for updates. During a rolling update, all pods from ordinal Replicas-1 to Partition are updated. All pods from ordinal Partition-1 to 0 remain untouched. This is helpful in being able to do a canary based deployment. The default value is 0.
    property partition : Int32?
  end

  # StatefulSet represents a set of pods with consistent identities. Identities are defined as:
  # - Network: A single stable DNS and hostname.
  # - Storage: As many VolumeClaims as requested.
  # The StatefulSet guarantees that a given network identity will always map to the same storage identity.
  struct StatefulSet
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ObjectMeta?
    # Spec defines the desired identities of pods in this set.
    property spec : StatefulSetSpec?
    # Status is the current status of Pods in this StatefulSet. This data may be out of date by some window of time.
    property status : StatefulSetStatus?
  end

  # StatefulSetCondition describes the state of a statefulset at a certain point.
  struct StatefulSetCondition
    include Kubernetes::Serializable

    # Last time the condition transitioned from one status to another.
    @[::JSON::Field(key: "lastTransitionTime")]
    @[::YAML::Field(key: "lastTransitionTime")]
    property last_transition_time : Time?
    # A human readable message indicating details about the transition.
    property message : String?
    # The reason for the condition's last transition.
    property reason : String?
    # Status of the condition, one of True, False, Unknown.
    property status : String?
    # Type of statefulset condition.
    property type : String?
  end

  # StatefulSetList is a collection of StatefulSets.
  struct StatefulSetList
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Items is the list of stateful sets.
    property items : Array(StatefulSet)?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard list's metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ListMeta?
  end

  # StatefulSetOrdinals describes the policy used for replica ordinal assignment in this StatefulSet.
  struct StatefulSetOrdinals
    include Kubernetes::Serializable

    # start is the number representing the first replica's index. It may be used to number replicas from an alternate index (eg: 1-indexed) over the default 0-indexed names, or to orchestrate progressive movement of replicas from one StatefulSet to another. If set, replica indices will be in the range:
    # [.spec.ordinals.start, .spec.ordinals.start + .spec.replicas).
    # If unset, defaults to 0. Replica indices will be in the range:
    # [0, .spec.replicas).
    property start : Int32?
  end

  # StatefulSetPersistentVolumeClaimRetentionPolicy describes the policy used for PVCs created from the StatefulSet VolumeClaimTemplates.
  struct StatefulSetPersistentVolumeClaimRetentionPolicy
    include Kubernetes::Serializable

    # WhenDeleted specifies what happens to PVCs created from StatefulSet VolumeClaimTemplates when the StatefulSet is deleted. The default policy of `Retain` causes PVCs to not be affected by StatefulSet deletion. The `Delete` policy causes those PVCs to be deleted.
    @[::JSON::Field(key: "whenDeleted")]
    @[::YAML::Field(key: "whenDeleted")]
    property when_deleted : String?
    # WhenScaled specifies what happens to PVCs created from StatefulSet VolumeClaimTemplates when the StatefulSet is scaled down. The default policy of `Retain` causes PVCs to not be affected by a scaledown. The `Delete` policy causes the associated PVCs for any excess pods above the replica count to be deleted.
    @[::JSON::Field(key: "whenScaled")]
    @[::YAML::Field(key: "whenScaled")]
    property when_scaled : String?
  end

  # A StatefulSetSpec is the specification of a StatefulSet.
  struct StatefulSetSpec
    include Kubernetes::Serializable

    # Minimum number of seconds for which a newly created pod should be ready without any of its container crashing for it to be considered available. Defaults to 0 (pod will be considered available as soon as it is ready)
    @[::JSON::Field(key: "minReadySeconds")]
    @[::YAML::Field(key: "minReadySeconds")]
    property min_ready_seconds : Int32?
    # ordinals controls the numbering of replica indices in a StatefulSet. The default ordinals behavior assigns a "0" index to the first replica and increments the index by one for each additional replica requested.
    property ordinals : StatefulSetOrdinals?
    # persistentVolumeClaimRetentionPolicy describes the lifecycle of persistent volume claims created from volumeClaimTemplates. By default, all persistent volume claims are created as needed and retained until manually deleted. This policy allows the lifecycle to be altered, for example by deleting persistent volume claims when their stateful set is deleted, or when their pod is scaled down.
    @[::JSON::Field(key: "persistentVolumeClaimRetentionPolicy")]
    @[::YAML::Field(key: "persistentVolumeClaimRetentionPolicy")]
    property persistent_volume_claim_retention_policy : StatefulSetPersistentVolumeClaimRetentionPolicy?
    # podManagementPolicy controls how pods are created during initial scale up, when replacing pods on nodes, or when scaling down. The default policy is `OrderedReady`, where pods are created in increasing order (pod-0, then pod-1, etc) and the controller will wait until each pod is ready before continuing. When scaling down, the pods are removed in the opposite order. The alternative policy is `Parallel` which will create pods in parallel to match the desired scale without waiting, and on scale down will delete all pods at once.
    @[::JSON::Field(key: "podManagementPolicy")]
    @[::YAML::Field(key: "podManagementPolicy")]
    property pod_management_policy : String?
    # replicas is the desired number of replicas of the given Template. These are replicas in the sense that they are instantiations of the same Template, but individual replicas also have a consistent identity. If unspecified, defaults to 1.
    property replicas : Int32?
    # revisionHistoryLimit is the maximum number of revisions that will be maintained in the StatefulSet's revision history. The revision history consists of all revisions not represented by a currently applied StatefulSetSpec version. The default value is 10.
    @[::JSON::Field(key: "revisionHistoryLimit")]
    @[::YAML::Field(key: "revisionHistoryLimit")]
    property revision_history_limit : Int32?
    # selector is a label query over pods that should match the replica count. It must match the pod template's labels. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/#label-selectors
    property selector : LabelSelector?
    # serviceName is the name of the service that governs this StatefulSet. This service must exist before the StatefulSet, and is responsible for the network identity of the set. Pods get DNS/hostnames that follow the pattern: pod-specific-string.serviceName.default.svc.cluster.local where "pod-specific-string" is managed by the StatefulSet controller.
    @[::JSON::Field(key: "serviceName")]
    @[::YAML::Field(key: "serviceName")]
    property service_name : String?
    # template is the object that describes the pod that will be created if insufficient replicas are detected. Each pod stamped out by the StatefulSet will fulfill this Template, but have a unique identity from the rest of the StatefulSet. Each pod will be named with the format <statefulsetname>-<podindex>. For example, a pod in a StatefulSet named "web" with index number "3" would be named "web-3". The only allowed template.spec.restartPolicy value is "Always".
    property template : PodTemplateSpec?
    # updateStrategy indicates the StatefulSetUpdateStrategy that will be employed to update Pods in the StatefulSet when a revision is made to Template.
    @[::JSON::Field(key: "updateStrategy")]
    @[::YAML::Field(key: "updateStrategy")]
    property update_strategy : StatefulSetUpdateStrategy?
    # volumeClaimTemplates is a list of claims that pods are allowed to reference. The StatefulSet controller is responsible for mapping network identities to claims in a way that maintains the identity of a pod. Every claim in this list must have at least one matching (by name) volumeMount in one container in the template. A claim in this list takes precedence over any volumes in the template, with the same name.
    @[::JSON::Field(key: "volumeClaimTemplates")]
    @[::YAML::Field(key: "volumeClaimTemplates")]
    property volume_claim_templates : Array(PersistentVolumeClaim)?
  end

  # StatefulSetStatus represents the current state of a StatefulSet.
  struct StatefulSetStatus
    include Kubernetes::Serializable

    # Total number of available pods (ready for at least minReadySeconds) targeted by this statefulset.
    @[::JSON::Field(key: "availableReplicas")]
    @[::YAML::Field(key: "availableReplicas")]
    property available_replicas : Int32?
    # collisionCount is the count of hash collisions for the StatefulSet. The StatefulSet controller uses this field as a collision avoidance mechanism when it needs to create the name for the newest ControllerRevision.
    @[::JSON::Field(key: "collisionCount")]
    @[::YAML::Field(key: "collisionCount")]
    property collision_count : Int32?
    # Represents the latest available observations of a statefulset's current state.
    property conditions : Array(StatefulSetCondition)?
    # currentReplicas is the number of Pods created by the StatefulSet controller from the StatefulSet version indicated by currentRevision.
    @[::JSON::Field(key: "currentReplicas")]
    @[::YAML::Field(key: "currentReplicas")]
    property current_replicas : Int32?
    # currentRevision, if not empty, indicates the version of the StatefulSet used to generate Pods in the sequence [0,currentReplicas).
    @[::JSON::Field(key: "currentRevision")]
    @[::YAML::Field(key: "currentRevision")]
    property current_revision : String?
    # observedGeneration is the most recent generation observed for this StatefulSet. It corresponds to the StatefulSet's generation, which is updated on mutation by the API Server.
    @[::JSON::Field(key: "observedGeneration")]
    @[::YAML::Field(key: "observedGeneration")]
    property observed_generation : Int64?
    # readyReplicas is the number of pods created for this StatefulSet with a Ready Condition.
    @[::JSON::Field(key: "readyReplicas")]
    @[::YAML::Field(key: "readyReplicas")]
    property ready_replicas : Int32?
    # replicas is the number of Pods created by the StatefulSet controller.
    property replicas : Int32?
    # updateRevision, if not empty, indicates the version of the StatefulSet used to generate Pods in the sequence [replicas-updatedReplicas,replicas)
    @[::JSON::Field(key: "updateRevision")]
    @[::YAML::Field(key: "updateRevision")]
    property update_revision : String?
    # updatedReplicas is the number of Pods created by the StatefulSet controller from the StatefulSet version indicated by updateRevision.
    @[::JSON::Field(key: "updatedReplicas")]
    @[::YAML::Field(key: "updatedReplicas")]
    property updated_replicas : Int32?
  end

  # StatefulSetUpdateStrategy indicates the strategy that the StatefulSet controller will use to perform updates. It includes any additional parameters necessary to perform the update for the indicated strategy.
  struct StatefulSetUpdateStrategy
    include Kubernetes::Serializable

    # RollingUpdate is used to communicate parameters when Type is RollingUpdateStatefulSetStrategyType.
    @[::JSON::Field(key: "rollingUpdate")]
    @[::YAML::Field(key: "rollingUpdate")]
    property rolling_update : RollingUpdateStatefulSetStrategy?
    # Type indicates the type of the StatefulSetUpdateStrategy. Default is RollingUpdate.
    property type : String?
  end
end
