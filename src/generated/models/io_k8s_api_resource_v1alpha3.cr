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
  # The device this taint is attached to has the "effect" on any claim which does not tolerate the taint and, through the claim, to pods using the claim.
  struct DeviceTaint
    include Kubernetes::Serializable

    # The effect of the taint on claims that do not tolerate the taint and through such claims on the pods using them.
    # Valid effects are None, NoSchedule and NoExecute. PreferNoSchedule as used for nodes is not valid here. More effects may get added in the future. Consumers must treat unknown effects like None.
    property effect : String?
    # The taint key to be applied to a device. Must be a label name.
    property key : String?
    # TimeAdded represents the time at which the taint was added. Added automatically during create or update if not set.
    @[JSON::Field(key: "timeAdded")]
    @[YAML::Field(key: "timeAdded")]
    property time_added : Time?
    # The taint value corresponding to the taint key. Must be a label value.
    property value : String?
  end

  # DeviceTaintRule adds one taint to all devices which match the selector. This has the same effect as if the taint was specified directly in the ResourceSlice by the DRA driver.
  struct DeviceTaintRule
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard object metadata
    property metadata : ObjectMeta?
    # Spec specifies the selector and one taint.
    # Changing the spec automatically increments the metadata.generation number.
    property spec : DeviceTaintRuleSpec?
    # Status provides information about what was requested in the spec.
    property status : DeviceTaintRuleStatus?
  end

  # DeviceTaintRuleList is a collection of DeviceTaintRules.
  struct DeviceTaintRuleList
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Items is the list of DeviceTaintRules.
    property items : Array(DeviceTaintRule)?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard list metadata
    property metadata : ListMeta?
  end

  # DeviceTaintRuleSpec specifies the selector and one taint.
  struct DeviceTaintRuleSpec
    include Kubernetes::Serializable

    # DeviceSelector defines which device(s) the taint is applied to. All selector criteria must be satisfied for a device to match. The empty selector matches all devices. Without a selector, no devices are matches.
    @[JSON::Field(key: "deviceSelector")]
    @[YAML::Field(key: "deviceSelector")]
    property device_selector : DeviceTaintSelector?
    # The taint that gets applied to matching devices.
    property taint : DeviceTaint?
  end

  # DeviceTaintRuleStatus provides information about an on-going pod eviction.
  struct DeviceTaintRuleStatus
    include Kubernetes::Serializable

    # Conditions provide information about the state of the DeviceTaintRule and the cluster at some point in time, in a machine-readable and human-readable format.
    # The following condition is currently defined as part of this API, more may get added: - Type: EvictionInProgress - Status: True if there are currently pods which need to be evicted, False otherwise
    # (includes the effects which don't cause eviction).
    # - Reason: not specified, may change - Message: includes information about number of pending pods and already evicted pods
    # in a human-readable format, updated periodically, may change
    # For `effect: None`, the condition above gets set once for each change to the spec, with the message containing information about what would happen if the effect was `NoExecute`. This feedback can be used to decide whether changing the effect to `NoExecute` will work as intended. It only gets set once to avoid having to constantly update the status.
    # Must have 8 or fewer entries.
    property conditions : Array(Condition)?
  end

  # DeviceTaintSelector defines which device(s) a DeviceTaintRule applies to. The empty selector matches all devices. Without a selector, no devices are matched.
  struct DeviceTaintSelector
    include Kubernetes::Serializable

    # If device is set, only devices with that name are selected. This field corresponds to slice.spec.devices[].name.
    # Setting also driver and pool may be required to avoid ambiguity, but is not required.
    property device : String?
    # If driver is set, only devices from that driver are selected. This fields corresponds to slice.spec.driver.
    property driver : String?
    # If pool is set, only devices in that pool are selected.
    # Also setting the driver name may be useful to avoid ambiguity when different drivers use the same pool name, but this is not required because selecting pools from different drivers may also be useful, for example when drivers with node-local devices use the node name as their pool name.
    property pool : String?
  end
end
