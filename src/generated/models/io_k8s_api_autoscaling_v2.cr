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
  # ContainerResourceMetricSource indicates how to scale on a resource metric known to Kubernetes, as specified in requests and limits, describing each pod in the current scale target (e.g. CPU or memory).  The values will be averaged together before being compared to the target.  Such metrics are built in to Kubernetes, and have special scaling options on top of those available to normal per-pod metrics using the "pods" source.  Only one "target" type should be set.
  struct ContainerResourceMetricSource
    include Kubernetes::Serializable

    # container is the name of the container in the pods of the scaling target
    property container : String?
    # name is the name of the resource in question.
    property name : String?
    # target specifies the target value for the given metric
    property target : MetricTarget?
  end

  # ContainerResourceMetricStatus indicates the current value of a resource metric known to Kubernetes, as specified in requests and limits, describing a single container in each pod in the current scale target (e.g. CPU or memory).  Such metrics are built in to Kubernetes, and have special scaling options on top of those available to normal per-pod metrics using the "pods" source.
  struct ContainerResourceMetricStatus
    include Kubernetes::Serializable

    # container is the name of the container in the pods of the scaling target
    property container : String?
    # current contains the current value for the given metric
    property current : MetricValueStatus?
    # name is the name of the resource in question.
    property name : String?
  end

  # CrossVersionObjectReference contains enough information to let you identify the referred resource.
  struct CrossVersionObjectReference
    include Kubernetes::Serializable

    # apiVersion is the API version of the referent
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
    property api_version : String?
    # kind is the kind of the referent; More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # name is the name of the referent; More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
    property name : String?
  end

  # ExternalMetricSource indicates how to scale on a metric not associated with any Kubernetes object (for example length of queue in cloud messaging service, or QPS from loadbalancer running outside of cluster).
  struct ExternalMetricSource
    include Kubernetes::Serializable

    # metric identifies the target metric by name and selector
    property metric : MetricIdentifier?
    # target specifies the target value for the given metric
    property target : MetricTarget?
  end

  # ExternalMetricStatus indicates the current value of a global metric not associated with any Kubernetes object.
  struct ExternalMetricStatus
    include Kubernetes::Serializable

    # current contains the current value for the given metric
    property current : MetricValueStatus?
    # metric identifies the target metric by name and selector
    property metric : MetricIdentifier?
  end

  # HPAScalingPolicy is a single policy which must hold true for a specified past interval.
  struct HPAScalingPolicy
    include Kubernetes::Serializable

    # periodSeconds specifies the window of time for which the policy should hold true. PeriodSeconds must be greater than zero and less than or equal to 1800 (30 min).
    @[::JSON::Field(key: "periodSeconds")]
    @[::YAML::Field(key: "periodSeconds")]
    property period_seconds : Int32?
    # type is used to specify the scaling policy.
    property type : String?
    # value contains the amount of change which is permitted by the policy. It must be greater than zero
    property value : Int32?
  end

  # HPAScalingRules configures the scaling behavior for one direction via scaling Policy Rules and a configurable metric tolerance.
  # Scaling Policy Rules are applied after calculating DesiredReplicas from metrics for the HPA. They can limit the scaling velocity by specifying scaling policies. They can prevent flapping by specifying the stabilization window, so that the number of replicas is not set instantly, instead, the safest value from the stabilization window is chosen.
  # The tolerance is applied to the metric values and prevents scaling too eagerly for small metric variations. (Note that setting a tolerance requires the beta HPAConfigurableTolerance feature gate to be enabled.)
  struct HPAScalingRules
    include Kubernetes::Serializable

    # policies is a list of potential scaling polices which can be used during scaling. If not set, use the default values: - For scale up: allow doubling the number of pods, or an absolute change of 4 pods in a 15s window. - For scale down: allow all pods to be removed in a 15s window.
    property policies : Array(HPAScalingPolicy)?
    # selectPolicy is used to specify which policy should be used. If not set, the default value Max is used.
    @[::JSON::Field(key: "selectPolicy")]
    @[::YAML::Field(key: "selectPolicy")]
    property select_policy : String?
    # stabilizationWindowSeconds is the number of seconds for which past recommendations should be considered while scaling up or scaling down. StabilizationWindowSeconds must be greater than or equal to zero and less than or equal to 3600 (one hour). If not set, use the default values: - For scale up: 0 (i.e. no stabilization is done). - For scale down: 300 (i.e. the stabilization window is 300 seconds long).
    @[::JSON::Field(key: "stabilizationWindowSeconds")]
    @[::YAML::Field(key: "stabilizationWindowSeconds")]
    property stabilization_window_seconds : Int32?
    # tolerance is the tolerance on the ratio between the current and desired metric value under which no updates are made to the desired number of replicas (e.g. 0.01 for 1%). Must be greater than or equal to zero. If not set, the default cluster-wide tolerance is applied (by default 10%).
    # For example, if autoscaling is configured with a memory consumption target of 100Mi, and scale-down and scale-up tolerances of 5% and 1% respectively, scaling will be triggered when the actual consumption falls below 95Mi or exceeds 101Mi.
    # This is an beta field and requires the HPAConfigurableTolerance feature gate to be enabled.
    property tolerance : Quantity?
  end

  # HorizontalPodAutoscaler is the configuration for a horizontal pod autoscaler, which automatically manages the replica count of any resource implementing the scale subresource based on the metrics specified.
  struct HorizontalPodAutoscaler
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # metadata is the standard object metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ObjectMeta?
    # spec is the specification for the behaviour of the autoscaler. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status.
    property spec : HorizontalPodAutoscalerSpec?
    # status is the current information about the autoscaler.
    property status : HorizontalPodAutoscalerStatus?
  end

  # HorizontalPodAutoscalerBehavior configures the scaling behavior of the target in both Up and Down directions (scaleUp and scaleDown fields respectively).
  struct HorizontalPodAutoscalerBehavior
    include Kubernetes::Serializable

    # scaleDown is scaling policy for scaling Down. If not set, the default value is to allow to scale down to minReplicas pods, with a 300 second stabilization window (i.e., the highest recommendation for the last 300sec is used).
    @[::JSON::Field(key: "scaleDown")]
    @[::YAML::Field(key: "scaleDown")]
    property scale_down : HPAScalingRules?
    # scaleUp is scaling policy for scaling Up. If not set, the default value is the higher of:
    # * increase no more than 4 pods per 60 seconds
    # * double the number of pods per 60 seconds
    # No stabilization is used.
    @[::JSON::Field(key: "scaleUp")]
    @[::YAML::Field(key: "scaleUp")]
    property scale_up : HPAScalingRules?
  end

  # HorizontalPodAutoscalerCondition describes the state of a HorizontalPodAutoscaler at a certain point.
  struct HorizontalPodAutoscalerCondition
    include Kubernetes::Serializable

    # lastTransitionTime is the last time the condition transitioned from one status to another
    @[::JSON::Field(key: "lastTransitionTime")]
    @[::YAML::Field(key: "lastTransitionTime")]
    property last_transition_time : Time?
    # message is a human-readable explanation containing details about the transition
    property message : String?
    # reason is the reason for the condition's last transition.
    property reason : String?
    # status is the status of the condition (True, False, Unknown)
    property status : String?
    # type describes the current condition
    property type : String?
  end

  # HorizontalPodAutoscalerList is a list of horizontal pod autoscaler objects.
  struct HorizontalPodAutoscalerList
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
    property api_version : String?
    # items is the list of horizontal pod autoscaler objects.
    property items : Array(HorizontalPodAutoscaler)?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # metadata is the standard list metadata.
    property metadata : ListMeta?
  end

  # HorizontalPodAutoscalerSpec describes the desired functionality of the HorizontalPodAutoscaler.
  struct HorizontalPodAutoscalerSpec
    include Kubernetes::Serializable

    # behavior configures the scaling behavior of the target in both Up and Down directions (scaleUp and scaleDown fields respectively). If not set, the default HPAScalingRules for scale up and scale down are used.
    property behavior : HorizontalPodAutoscalerBehavior?
    # maxReplicas is the upper limit for the number of replicas to which the autoscaler can scale up. It cannot be less that minReplicas.
    @[::JSON::Field(key: "maxReplicas")]
    @[::YAML::Field(key: "maxReplicas")]
    property max_replicas : Int32?
    # metrics contains the specifications for which to use to calculate the desired replica count (the maximum replica count across all metrics will be used).  The desired replica count is calculated multiplying the ratio between the target value and the current value by the current number of pods.  Ergo, metrics used must decrease as the pod count is increased, and vice-versa.  See the individual metric source types for more information about how each type of metric must respond. If not set, the default metric will be set to 80% average CPU utilization.
    property metrics : Array(MetricSpec)?
    # minReplicas is the lower limit for the number of replicas to which the autoscaler can scale down.  It defaults to 1 pod.  minReplicas is allowed to be 0 if the alpha feature gate HPAScaleToZero is enabled and at least one Object or External metric is configured.  Scaling is active as long as at least one metric value is available.
    @[::JSON::Field(key: "minReplicas")]
    @[::YAML::Field(key: "minReplicas")]
    property min_replicas : Int32?
    # scaleTargetRef points to the target resource to scale, and is used to the pods for which metrics should be collected, as well as to actually change the replica count.
    @[::JSON::Field(key: "scaleTargetRef")]
    @[::YAML::Field(key: "scaleTargetRef")]
    property scale_target_ref : CrossVersionObjectReference?
  end

  # HorizontalPodAutoscalerStatus describes the current status of a horizontal pod autoscaler.
  struct HorizontalPodAutoscalerStatus
    include Kubernetes::Serializable

    # conditions is the set of conditions required for this autoscaler to scale its target, and indicates whether or not those conditions are met.
    property conditions : Array(HorizontalPodAutoscalerCondition)?
    # currentMetrics is the last read state of the metrics used by this autoscaler.
    @[::JSON::Field(key: "currentMetrics")]
    @[::YAML::Field(key: "currentMetrics")]
    property current_metrics : Array(MetricStatus)?
    # currentReplicas is current number of replicas of pods managed by this autoscaler, as last seen by the autoscaler.
    @[::JSON::Field(key: "currentReplicas")]
    @[::YAML::Field(key: "currentReplicas")]
    property current_replicas : Int32?
    # desiredReplicas is the desired number of replicas of pods managed by this autoscaler, as last calculated by the autoscaler.
    @[::JSON::Field(key: "desiredReplicas")]
    @[::YAML::Field(key: "desiredReplicas")]
    property desired_replicas : Int32?
    # lastScaleTime is the last time the HorizontalPodAutoscaler scaled the number of pods, used by the autoscaler to control how often the number of pods is changed.
    @[::JSON::Field(key: "lastScaleTime")]
    @[::YAML::Field(key: "lastScaleTime")]
    property last_scale_time : Time?
    # observedGeneration is the most recent generation observed by this autoscaler.
    @[::JSON::Field(key: "observedGeneration")]
    @[::YAML::Field(key: "observedGeneration")]
    property observed_generation : Int64?
  end

  # MetricIdentifier defines the name and optionally selector for a metric
  struct MetricIdentifier
    include Kubernetes::Serializable

    # name is the name of the given metric
    property name : String?
    # selector is the string-encoded form of a standard kubernetes label selector for the given metric When set, it is passed as an additional parameter to the metrics server for more specific metrics scoping. When unset, just the metricName will be used to gather metrics.
    property selector : LabelSelector?
  end

  # MetricSpec specifies how to scale based on a single metric (only `type` and one other matching field should be set at once).
  struct MetricSpec
    include Kubernetes::Serializable

    # containerResource refers to a resource metric (such as those specified in requests and limits) known to Kubernetes describing a single container in each pod of the current scale target (e.g. CPU or memory). Such metrics are built in to Kubernetes, and have special scaling options on top of those available to normal per-pod metrics using the "pods" source.
    @[::JSON::Field(key: "containerResource")]
    @[::YAML::Field(key: "containerResource")]
    property container_resource : ContainerResourceMetricSource?
    # external refers to a global metric that is not associated with any Kubernetes object. It allows autoscaling based on information coming from components running outside of cluster (for example length of queue in cloud messaging service, or QPS from loadbalancer running outside of cluster).
    property external : ExternalMetricSource?
    # object refers to a metric describing a single kubernetes object (for example, hits-per-second on an Ingress object).
    property object : ObjectMetricSource?
    # pods refers to a metric describing each pod in the current scale target (for example, transactions-processed-per-second).  The values will be averaged together before being compared to the target value.
    property pods : PodsMetricSource?
    # resource refers to a resource metric (such as those specified in requests and limits) known to Kubernetes describing each pod in the current scale target (e.g. CPU or memory). Such metrics are built in to Kubernetes, and have special scaling options on top of those available to normal per-pod metrics using the "pods" source.
    property resource : ResourceMetricSource?
    # type is the type of metric source.  It should be one of "ContainerResource", "External", "Object", "Pods" or "Resource", each mapping to a matching field in the object.
    property type : String?
  end

  # MetricStatus describes the last-read state of a single metric.
  struct MetricStatus
    include Kubernetes::Serializable

    # container resource refers to a resource metric (such as those specified in requests and limits) known to Kubernetes describing a single container in each pod in the current scale target (e.g. CPU or memory). Such metrics are built in to Kubernetes, and have special scaling options on top of those available to normal per-pod metrics using the "pods" source.
    @[::JSON::Field(key: "containerResource")]
    @[::YAML::Field(key: "containerResource")]
    property container_resource : ContainerResourceMetricStatus?
    # external refers to a global metric that is not associated with any Kubernetes object. It allows autoscaling based on information coming from components running outside of cluster (for example length of queue in cloud messaging service, or QPS from loadbalancer running outside of cluster).
    property external : ExternalMetricStatus?
    # object refers to a metric describing a single kubernetes object (for example, hits-per-second on an Ingress object).
    property object : ObjectMetricStatus?
    # pods refers to a metric describing each pod in the current scale target (for example, transactions-processed-per-second).  The values will be averaged together before being compared to the target value.
    property pods : PodsMetricStatus?
    # resource refers to a resource metric (such as those specified in requests and limits) known to Kubernetes describing each pod in the current scale target (e.g. CPU or memory). Such metrics are built in to Kubernetes, and have special scaling options on top of those available to normal per-pod metrics using the "pods" source.
    property resource : ResourceMetricStatus?
    # type is the type of metric source.  It will be one of "ContainerResource", "External", "Object", "Pods" or "Resource", each corresponds to a matching field in the object.
    property type : String?
  end

  # MetricTarget defines the target value, average value, or average utilization of a specific metric
  struct MetricTarget
    include Kubernetes::Serializable

    # averageUtilization is the target value of the average of the resource metric across all relevant pods, represented as a percentage of the requested value of the resource for the pods. Currently only valid for Resource metric source type
    @[::JSON::Field(key: "averageUtilization")]
    @[::YAML::Field(key: "averageUtilization")]
    property average_utilization : Int32?
    # averageValue is the target value of the average of the metric across all relevant pods (as a quantity)
    @[::JSON::Field(key: "averageValue")]
    @[::YAML::Field(key: "averageValue")]
    property average_value : Quantity?
    # type represents whether the metric type is Utilization, Value, or AverageValue
    property type : String?
    # value is the target value of the metric (as a quantity).
    property value : Quantity?
  end

  # MetricValueStatus holds the current value for a metric
  struct MetricValueStatus
    include Kubernetes::Serializable

    # currentAverageUtilization is the current value of the average of the resource metric across all relevant pods, represented as a percentage of the requested value of the resource for the pods.
    @[::JSON::Field(key: "averageUtilization")]
    @[::YAML::Field(key: "averageUtilization")]
    property average_utilization : Int32?
    # averageValue is the current value of the average of the metric across all relevant pods (as a quantity)
    @[::JSON::Field(key: "averageValue")]
    @[::YAML::Field(key: "averageValue")]
    property average_value : Quantity?
    # value is the current value of the metric (as a quantity).
    property value : Quantity?
  end

  # ObjectMetricSource indicates how to scale on a metric describing a kubernetes object (for example, hits-per-second on an Ingress object).
  struct ObjectMetricSource
    include Kubernetes::Serializable

    # describedObject specifies the descriptions of a object,such as kind,name apiVersion
    @[::JSON::Field(key: "describedObject")]
    @[::YAML::Field(key: "describedObject")]
    property described_object : CrossVersionObjectReference?
    # metric identifies the target metric by name and selector
    property metric : MetricIdentifier?
    # target specifies the target value for the given metric
    property target : MetricTarget?
  end

  # ObjectMetricStatus indicates the current value of a metric describing a kubernetes object (for example, hits-per-second on an Ingress object).
  struct ObjectMetricStatus
    include Kubernetes::Serializable

    # current contains the current value for the given metric
    property current : MetricValueStatus?
    # DescribedObject specifies the descriptions of a object,such as kind,name apiVersion
    @[::JSON::Field(key: "describedObject")]
    @[::YAML::Field(key: "describedObject")]
    property described_object : CrossVersionObjectReference?
    # metric identifies the target metric by name and selector
    property metric : MetricIdentifier?
  end

  # PodsMetricSource indicates how to scale on a metric describing each pod in the current scale target (for example, transactions-processed-per-second). The values will be averaged together before being compared to the target value.
  struct PodsMetricSource
    include Kubernetes::Serializable

    # metric identifies the target metric by name and selector
    property metric : MetricIdentifier?
    # target specifies the target value for the given metric
    property target : MetricTarget?
  end

  # PodsMetricStatus indicates the current value of a metric describing each pod in the current scale target (for example, transactions-processed-per-second).
  struct PodsMetricStatus
    include Kubernetes::Serializable

    # current contains the current value for the given metric
    property current : MetricValueStatus?
    # metric identifies the target metric by name and selector
    property metric : MetricIdentifier?
  end

  # ResourceMetricSource indicates how to scale on a resource metric known to Kubernetes, as specified in requests and limits, describing each pod in the current scale target (e.g. CPU or memory).  The values will be averaged together before being compared to the target.  Such metrics are built in to Kubernetes, and have special scaling options on top of those available to normal per-pod metrics using the "pods" source.  Only one "target" type should be set.
  struct ResourceMetricSource
    include Kubernetes::Serializable

    # name is the name of the resource in question.
    property name : String?
    # target specifies the target value for the given metric
    property target : MetricTarget?
  end

  # ResourceMetricStatus indicates the current value of a resource metric known to Kubernetes, as specified in requests and limits, describing each pod in the current scale target (e.g. CPU or memory).  Such metrics are built in to Kubernetes, and have special scaling options on top of those available to normal per-pod metrics using the "pods" source.
  struct ResourceMetricStatus
    include Kubernetes::Serializable

    # current contains the current value for the given metric
    property current : MetricValueStatus?
    # name is the name of the resource in question.
    property name : String?
  end
end
