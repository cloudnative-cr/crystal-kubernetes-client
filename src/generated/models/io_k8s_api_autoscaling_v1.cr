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
  # CrossVersionObjectReference contains enough information to let you identify the referred resource.
  struct CrossVersionObjectReference
    include Kubernetes::Serializable

    # apiVersion is the API version of the referent
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # kind is the kind of the referent; More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # name is the name of the referent; More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
    property name : String?
  end

  # configuration of a horizontal pod autoscaler.
  struct HorizontalPodAutoscaler
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard object metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ObjectMeta?
    # spec defines the behaviour of autoscaler. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status.
    property spec : HorizontalPodAutoscalerSpec?
    # status is the current information about the autoscaler.
    property status : HorizontalPodAutoscalerStatus?
  end

  # list of horizontal pod autoscaler objects.
  struct HorizontalPodAutoscalerList
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # items is the list of horizontal pod autoscaler objects.
    property items : Array(HorizontalPodAutoscaler)?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard list metadata.
    property metadata : ListMeta?
  end

  # specification of a horizontal pod autoscaler.
  struct HorizontalPodAutoscalerSpec
    include Kubernetes::Serializable

    # maxReplicas is the upper limit for the number of pods that can be set by the autoscaler; cannot be smaller than MinReplicas.
    @[JSON::Field(key: "maxReplicas")]
    @[YAML::Field(key: "maxReplicas")]
    property max_replicas : Int32?
    # minReplicas is the lower limit for the number of replicas to which the autoscaler can scale down.  It defaults to 1 pod.  minReplicas is allowed to be 0 if the alpha feature gate HPAScaleToZero is enabled and at least one Object or External metric is configured.  Scaling is active as long as at least one metric value is available.
    @[JSON::Field(key: "minReplicas")]
    @[YAML::Field(key: "minReplicas")]
    property min_replicas : Int32?
    # reference to scaled resource; horizontal pod autoscaler will learn the current resource consumption and will set the desired number of pods by using its Scale subresource.
    @[JSON::Field(key: "scaleTargetRef")]
    @[YAML::Field(key: "scaleTargetRef")]
    property scale_target_ref : CrossVersionObjectReference?
    # targetCPUUtilizationPercentage is the target average CPU utilization (represented as a percentage of requested CPU) over all the pods; if not specified the default autoscaling policy will be used.
    @[JSON::Field(key: "targetCPUUtilizationPercentage")]
    @[YAML::Field(key: "targetCPUUtilizationPercentage")]
    property target_cpu_utilization_percentage : Int32?
  end

  # current status of a horizontal pod autoscaler
  struct HorizontalPodAutoscalerStatus
    include Kubernetes::Serializable

    # currentCPUUtilizationPercentage is the current average CPU utilization over all pods, represented as a percentage of requested CPU, e.g. 70 means that an average pod is using now 70% of its requested CPU.
    @[JSON::Field(key: "currentCPUUtilizationPercentage")]
    @[YAML::Field(key: "currentCPUUtilizationPercentage")]
    property current_cpu_utilization_percentage : Int32?
    # currentReplicas is the current number of replicas of pods managed by this autoscaler.
    @[JSON::Field(key: "currentReplicas")]
    @[YAML::Field(key: "currentReplicas")]
    property current_replicas : Int32?
    # desiredReplicas is the  desired number of replicas of pods managed by this autoscaler.
    @[JSON::Field(key: "desiredReplicas")]
    @[YAML::Field(key: "desiredReplicas")]
    property desired_replicas : Int32?
    # lastScaleTime is the last time the HorizontalPodAutoscaler scaled the number of pods; used by the autoscaler to control how often the number of pods is changed.
    @[JSON::Field(key: "lastScaleTime")]
    @[YAML::Field(key: "lastScaleTime")]
    property last_scale_time : Time?
    # observedGeneration is the most recent generation observed by this autoscaler.
    @[JSON::Field(key: "observedGeneration")]
    @[YAML::Field(key: "observedGeneration")]
    property observed_generation : Int64?
  end

  # Scale represents a scaling request for a resource.
  struct Scale
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard object metadata; More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata.
    property metadata : ObjectMeta?
    # spec defines the behavior of the scale. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status.
    property spec : ScaleSpec?
    # status is the current status of the scale. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status. Read-only.
    property status : ScaleStatus?
  end

  # ScaleSpec describes the attributes of a scale subresource.
  struct ScaleSpec
    include Kubernetes::Serializable

    # replicas is the desired number of instances for the scaled object.
    property replicas : Int32?
  end

  # ScaleStatus represents the current status of a scale subresource.
  struct ScaleStatus
    include Kubernetes::Serializable

    # replicas is the actual number of observed instances of the scaled object.
    property replicas : Int32?
    # selector is the label query over pods that should match the replicas count. This is same as the label selector but in the string format to avoid introspection by clients. The string will be in the same format as the query-param syntax. More info about label selectors: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/
    property selector : String?
  end
end
