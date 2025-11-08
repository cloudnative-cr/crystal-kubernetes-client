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
  # CELDeviceSelector contains a CEL expression for selecting a device.
  struct CELDeviceSelector
    include Kubernetes::Serializable

    # Expression is a CEL expression which evaluates a single device. It must evaluate to true when the device under consideration satisfies the desired criteria, and false when it does not. Any other result is an error and causes allocation of devices to abort.
    # The expression's input is an object named "device", which carries the following properties:
    # - driver (string): the name of the driver which defines this device.
    # - attributes (map[string]object): the device's attributes, grouped by prefix
    # (e.g. device.attributes["dra.example.com"] evaluates to an object with all
    # of the attributes which were prefixed by "dra.example.com".
    # - capacity (map[string]object): the device's capacities, grouped by prefix.
    # Example: Consider a device with driver="dra.example.com", which exposes two attributes named "model" and "ext.example.com/family" and which exposes one capacity named "modules". This input to this expression would have the following fields:
    # device.driver
    # device.attributes["dra.example.com"].model
    # device.attributes["ext.example.com"].family
    # device.capacity["dra.example.com"].modules
    # The device.driver field can be used to check for a specific driver, either as a high-level precondition (i.e. you only want to consider devices from this driver) or as part of a multi-clause expression that is meant to consider devices from different drivers.
    # The value type of each attribute is defined by the device definition, and users who write these expressions must consult the documentation for their specific drivers. The value type of each capacity is Quantity.
    # If an unknown prefix is used as a lookup in either device.attributes or device.capacity, an empty map will be returned. Any reference to an unknown field will cause an evaluation error and allocation to abort.
    # A robust expression should check for the existence of attributes before referencing them.
    # For ease of use, the cel.bind() function is enabled, and can be used to simplify expressions that access multiple attributes with the same domain. For example:
    # cel.bind(dra, device.attributes["dra.example.com"], dra.someBool && dra.anotherBool)
    # The length of the expression must be smaller or equal to 10 Ki. The cost of evaluating it is also limited based on the estimated number of logical steps.
    property expression : String?
  end

  # DeviceSelector must have exactly one field set.
  struct DeviceSelector
    include Kubernetes::Serializable

    # CEL contains a CEL expression for selecting a device.
    property cel : CELDeviceSelector?
  end

  # The device this taint is attached to has the "effect" on any claim which does not tolerate the taint and, through the claim, to pods using the claim.
  struct DeviceTaint
    include Kubernetes::Serializable

    # The effect of the taint on claims that do not tolerate the taint and through such claims on the pods using them. Valid effects are NoSchedule and NoExecute. PreferNoSchedule as used for nodes is not valid here.
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

    # DeviceSelector defines which device(s) the taint is applied to. All selector criteria must be satified for a device to match. The empty selector matches all devices. Without a selector, no devices are matches.
    @[JSON::Field(key: "deviceSelector")]
    @[YAML::Field(key: "deviceSelector")]
    property device_selector : DeviceTaintSelector?
    # The taint that gets applied to matching devices.
    property taint : DeviceTaint?
  end

  # DeviceTaintSelector defines which device(s) a DeviceTaintRule applies to. The empty selector matches all devices. Without a selector, no devices are matched.
  struct DeviceTaintSelector
    include Kubernetes::Serializable

    # If device is set, only devices with that name are selected. This field corresponds to slice.spec.devices[].name.
    # Setting also driver and pool may be required to avoid ambiguity, but is not required.
    property device : String?
    # If DeviceClassName is set, the selectors defined there must be satisfied by a device to be selected. This field corresponds to class.metadata.name.
    @[JSON::Field(key: "deviceClassName")]
    @[YAML::Field(key: "deviceClassName")]
    property device_class_name : String?
    # If driver is set, only devices from that driver are selected. This fields corresponds to slice.spec.driver.
    property driver : String?
    # If pool is set, only devices in that pool are selected.
    # Also setting the driver name may be useful to avoid ambiguity when different drivers use the same pool name, but this is not required because selecting pools from different drivers may also be useful, for example when drivers with node-local devices use the node name as their pool name.
    property pool : String?
    # Selectors contains the same selection criteria as a ResourceClaim. Currently, CEL expressions are supported. All of these selectors must be satisfied.
    property selectors : Array(DeviceSelector)?
  end
end
