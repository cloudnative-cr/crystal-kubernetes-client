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
  # EndpointPort is a tuple that describes a single port. Deprecated: This API is deprecated in v1.33+.
  struct EndpointPort
    include Kubernetes::Serializable

    # The application protocol for this port. This is used as a hint for implementations to offer richer behavior for protocols that they understand. This field follows standard Kubernetes label syntax. Valid values are either:
    # * Un-prefixed protocol names - reserved for IANA standard service names (as per RFC-6335 and https://www.iana.org/assignments/service-names).
    # * Kubernetes-defined prefixed names:
    # * 'kubernetes.io/h2c' - HTTP/2 prior knowledge over cleartext as described in https://www.rfc-editor.org/rfc/rfc9113.html#name-starting-http-2-with-prior-
    # * 'kubernetes.io/ws'  - WebSocket over cleartext as described in https://www.rfc-editor.org/rfc/rfc6455
    # * 'kubernetes.io/wss' - WebSocket over TLS as described in https://www.rfc-editor.org/rfc/rfc6455
    # * Other protocols should use implementation-defined prefixed names such as mycompany.com/my-custom-protocol.
    @[JSON::Field(key: "appProtocol")]
    @[YAML::Field(key: "appProtocol")]
    property app_protocol : String?
    # The name of this port.  This must match the 'name' field in the corresponding ServicePort. Must be a DNS_LABEL. Optional only if one port is defined.
    property name : String?
    # The port number of the endpoint.
    property port : Int32?
    # The IP protocol for this port. Must be UDP, TCP, or SCTP. Default is TCP.
    property protocol : String?
  end

  # Event is a report of an event somewhere in the cluster.  Events have a limited retention time and triggers and messages may evolve with time.  Event consumers should not rely on the timing of an event with a given Reason reflecting a consistent underlying trigger, or the continued existence of events with that Reason.  Events should be treated as informative, best-effort, supplemental data.
  struct Event
    include Kubernetes::Serializable

    # What action was taken/failed regarding to the Regarding object.
    property action : String?
    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # The number of times this event has occurred.
    property count : Int32?
    # Time when this Event was first observed.
    @[JSON::Field(key: "eventTime")]
    @[YAML::Field(key: "eventTime")]
    property event_time : Time?
    # The time at which the event was first recorded. (Time of server receipt is in TypeMeta.)
    @[JSON::Field(key: "firstTimestamp")]
    @[YAML::Field(key: "firstTimestamp")]
    property first_timestamp : Time?
    # The object that this event is about.
    @[JSON::Field(key: "involvedObject")]
    @[YAML::Field(key: "involvedObject")]
    property involved_object : ObjectReference?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # The time at which the most recent occurrence of this event was recorded.
    @[JSON::Field(key: "lastTimestamp")]
    @[YAML::Field(key: "lastTimestamp")]
    property last_timestamp : Time?
    # A human-readable description of the status of this operation.
    property message : String?
    # Standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ObjectMeta?
    # This should be a short, machine understandable string that gives the reason for the transition into the object's current status.
    property reason : String?
    # Optional secondary object for more complex actions.
    property related : ObjectReference?
    # Name of the controller that emitted this Event, e.g. `kubernetes.io/kubelet`.
    @[JSON::Field(key: "reportingComponent")]
    @[YAML::Field(key: "reportingComponent")]
    property reporting_component : String?
    # ID of the controller instance, e.g. `kubelet-xyzf`.
    @[JSON::Field(key: "reportingInstance")]
    @[YAML::Field(key: "reportingInstance")]
    property reporting_instance : String?
    # Data about the Event series this event represents or nil if it's a singleton Event.
    property series : EventSeries?
    # The component reporting this event. Should be a short machine understandable string.
    property source : EventSource?
    # Type of this event (Normal, Warning), new types could be added in the future
    property type : String?
  end

  # EventList is a list of events.
  struct EventList
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # List of events
    property items : Array(Event)?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard list metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property metadata : ListMeta?
  end

  # EventSeries contain information on series of events, i.e. thing that was/is happening continuously for some time.
  struct EventSeries
    include Kubernetes::Serializable

    # Number of occurrences in this series up to the last heartbeat time
    property count : Int32?
    # Time of the last occurrence observed
    @[JSON::Field(key: "lastObservedTime")]
    @[YAML::Field(key: "lastObservedTime")]
    property last_observed_time : Time?
  end

  # ResourceClaim references one entry in PodSpec.ResourceClaims.
  struct ResourceClaim
    include Kubernetes::Serializable

    # Name must match the name of one entry in pod.spec.resourceClaims of the Pod where this field is used. It makes that resource available inside a container.
    property name : String?
    # Request is the name chosen for a request in the referenced claim. If empty, everything from the claim is made available, otherwise only the result of this request.
    property request : String?
  end
end
