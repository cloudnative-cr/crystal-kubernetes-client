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
  # The device this taint is attached to has the "effect" on any claim which does not tolerate the taint and, through the claim, to pods using the claim.
  struct DeviceTaint
    include Kubernetes::Serializable

    # The effect of the taint on claims that do not tolerate the taint and through such claims on the pods using them.
    # Valid effects are None, NoSchedule and NoExecute. PreferNoSchedule as used for nodes is not valid here. More effects may get added in the future. Consumers must treat unknown effects like None.
    property effect : String?
    # The taint key to be applied to a device. Must be a label name.
    property key : String?
    # TimeAdded represents the time at which the taint was added or (only in a DeviceTaintRule) the effect was modified. Added automatically during create or update if not set.
    # In addition, in a DeviceTaintRule a value provided during an update gets replaced with the current time if the provided value is the same as the old one and the new effect is different. Changing the key and/or value while keeping the effect unchanged is possible and does not update the time stamp because the eviction which uses it is either already started (NoExecute) or not started yet (NoEffect, NoSchedule).
    @[::JSON::Field(key: "timeAdded")]
    @[::YAML::Field(key: "timeAdded")]
    property time_added : Time?
    # The taint value corresponding to the taint key. Must be a label value.
    property value : String?
  end

  # DeviceTaintRule adds one taint to all devices which match the selector. This has the same effect as if the taint was specified directly in the ResourceSlice by the DRA driver.
  struct DeviceTaintRule
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
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
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
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
    @[::JSON::Field(key: "deviceSelector")]
    @[::YAML::Field(key: "deviceSelector")]
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

  # PoolStatus contains status information for a single resource pool.
  struct PoolStatus
    include Kubernetes::Serializable

    # AllocatedDevices is the number of devices currently allocated to claims. A value of 0 means no devices are allocated. May be unset when validationError is set.
    @[::JSON::Field(key: "allocatedDevices")]
    @[::YAML::Field(key: "allocatedDevices")]
    property allocated_devices : Int32?
    # AvailableDevices is the number of devices available for allocation. This equals TotalDevices - AllocatedDevices - UnavailableDevices. A value of 0 means no devices are currently available. May be unset when validationError is set.
    @[::JSON::Field(key: "availableDevices")]
    @[::YAML::Field(key: "availableDevices")]
    property available_devices : Int32?
    # Driver is the DRA driver name for this pool. Must be a DNS subdomain (e.g., "gpu.example.com").
    property driver : String?
    # Generation is the pool generation observed across all ResourceSlices in this pool. Only the latest generation is reported. During a generation rollout, if not all slices at the latest generation have been published, the pool is included with a validationError and device counts unset.
    property generation : Int64?
    # NodeName is the node this pool is associated with. When omitted, the pool is not associated with a specific node. Must be a valid DNS subdomain name (RFC1123).
    @[::JSON::Field(key: "nodeName")]
    @[::YAML::Field(key: "nodeName")]
    property node_name : String?
    # PoolName is the name of the pool. Must be a valid resource pool name (DNS subdomains separated by "/").
    @[::JSON::Field(key: "poolName")]
    @[::YAML::Field(key: "poolName")]
    property pool_name : String?
    # ResourceSliceCount is the number of ResourceSlices that make up this pool. May be unset when validationError is set.
    @[::JSON::Field(key: "resourceSliceCount")]
    @[::YAML::Field(key: "resourceSliceCount")]
    property resource_slice_count : Int32?
    # TotalDevices is the total number of devices in the pool across all slices. A value of 0 means the pool has no devices. May be unset when validationError is set.
    @[::JSON::Field(key: "totalDevices")]
    @[::YAML::Field(key: "totalDevices")]
    property total_devices : Int32?
    # UnavailableDevices is the number of devices that are not available due to taints or other conditions, but are not allocated. A value of 0 means all unallocated devices are available. May be unset when validationError is set.
    @[::JSON::Field(key: "unavailableDevices")]
    @[::YAML::Field(key: "unavailableDevices")]
    property unavailable_devices : Int32?
    # ValidationError is set when the pool's data could not be fully validated (e.g., incomplete slice publication). When set, device count fields and ResourceSliceCount may be unset.
    @[::JSON::Field(key: "validationError")]
    @[::YAML::Field(key: "validationError")]
    property validation_error : String?
  end

  # ResourcePoolStatusRequest triggers a one-time calculation of resource pool status based on the provided filters. Once status is set, the request is considered complete and will not be reprocessed. Users should delete and recreate requests to get updated information.
  struct ResourcePoolStatusRequest
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard object metadata
    property metadata : ObjectMeta?
    # Spec defines the filters for which pools to include in the status. The spec is immutable once created.
    property spec : ResourcePoolStatusRequestSpec?
    # Status is populated by the controller with the calculated pool status. When status is non-nil, the request is considered complete and the entire object becomes immutable.
    property status : ResourcePoolStatusRequestStatus?
  end

  # ResourcePoolStatusRequestList is a collection of ResourcePoolStatusRequests.
  struct ResourcePoolStatusRequestList
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Items is the list of ResourcePoolStatusRequests.
    property items : Array(ResourcePoolStatusRequest)?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard list metadata
    property metadata : ListMeta?
  end

  # ResourcePoolStatusRequestSpec defines the filters for the pool status request.
  struct ResourcePoolStatusRequestSpec
    include Kubernetes::Serializable

    # Driver specifies the DRA driver name to filter pools. Only pools from ResourceSlices with this driver will be included. Must be a DNS subdomain (e.g., "gpu.example.com").
    property driver : String?
    # Limit optionally specifies the maximum number of pools to return in the status. If more pools match the filter criteria, the response will be truncated (i.e., len(status.pools) < status.poolCount).
    # Default: 100 Minimum: 1 Maximum: 1000
    property limit : Int32?
    # PoolName optionally filters to a specific pool name. If not specified, all pools from the specified driver are included. When specified, must be a non-empty valid resource pool name (DNS subdomains separated by "/").
    @[::JSON::Field(key: "poolName")]
    @[::YAML::Field(key: "poolName")]
    property pool_name : String?
  end

  # ResourcePoolStatusRequestStatus contains the calculated pool status information.
  struct ResourcePoolStatusRequestStatus
    include Kubernetes::Serializable

    # Conditions provide information about the state of the request. A condition with type=Complete or type=Failed will always be set when the status is populated.
    # Known condition types: - "Complete": True when the request has been processed successfully - "Failed": True when the request could not be processed
    property conditions : Array(Condition)?
    # PoolCount is the total number of pools that matched the filter criteria, regardless of truncation. This helps users understand how many pools exist even when the response is truncated. A value of 0 means no pools matched the filter criteria.
    @[::JSON::Field(key: "poolCount")]
    @[::YAML::Field(key: "poolCount")]
    property pool_count : Int32?
    # Pools contains the first `spec.limit` matching pools, sorted by driver then pool name. If `len(pools) < poolCount`, the list was truncated. When omitted, no pools matched the request filters.
    property pools : Array(PoolStatus)?
  end
end
