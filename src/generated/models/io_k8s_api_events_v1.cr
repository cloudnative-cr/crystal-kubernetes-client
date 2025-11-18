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
  # Event is a report of an event somewhere in the cluster. It generally denotes some state change in the system. Events have a limited retention time and triggers and messages may evolve with time.  Event consumers should not rely on the timing of an event with a given Reason reflecting a consistent underlying trigger, or the continued existence of events with that Reason.  Events should be treated as informative, best-effort, supplemental data.
  struct Event
    include Kubernetes::Serializable

    # action is what action was taken/failed regarding to the regarding object. It is machine-readable. This field cannot be empty for new Events and it can have at most 128 characters.
    property action : String?
    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
    property api_version : String?
    # deprecatedCount is the deprecated field assuring backward compatibility with core.v1 Event type.
    @[::JSON::Field(key: "deprecatedCount")]
    @[::YAML::Field(key: "deprecatedCount")]
    property deprecated_count : Int32?
    # deprecatedFirstTimestamp is the deprecated field assuring backward compatibility with core.v1 Event type.
    @[::JSON::Field(key: "deprecatedFirstTimestamp")]
    @[::YAML::Field(key: "deprecatedFirstTimestamp")]
    property deprecated_first_timestamp : Time?
    # deprecatedLastTimestamp is the deprecated field assuring backward compatibility with core.v1 Event type.
    @[::JSON::Field(key: "deprecatedLastTimestamp")]
    @[::YAML::Field(key: "deprecatedLastTimestamp")]
    property deprecated_last_timestamp : Time?
    # deprecatedSource is the deprecated field assuring backward compatibility with core.v1 Event type.
    @[::JSON::Field(key: "deprecatedSource")]
    @[::YAML::Field(key: "deprecatedSource")]
    property deprecated_source : EventSource?
    # eventTime is the time when this Event was first observed. It is required.
    @[::JSON::Field(key: "eventTime")]
    @[::YAML::Field(key: "eventTime")]
    property event_time : MicroTime?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ObjectMeta?
    # note is a human-readable description of the status of this operation. Maximal length of the note is 1kB, but libraries should be prepared to handle values up to 64kB.
    property note : String?
    # reason is why the action was taken. It is human-readable. This field cannot be empty for new Events and it can have at most 128 characters.
    property reason : String?
    # regarding contains the object this Event is about. In most cases it's an Object reporting controller implements, e.g. ReplicaSetController implements ReplicaSets and this event is emitted because it acts on some changes in a ReplicaSet object.
    property regarding : ObjectReference?
    # related is the optional secondary object for more complex actions. E.g. when regarding object triggers a creation or deletion of related object.
    property related : ObjectReference?
    # reportingController is the name of the controller that emitted this Event, e.g. `kubernetes.io/kubelet`. This field cannot be empty for new Events.
    @[::JSON::Field(key: "reportingController")]
    @[::YAML::Field(key: "reportingController")]
    property reporting_controller : String?
    # reportingInstance is the ID of the controller instance, e.g. `kubelet-xyzf`. This field cannot be empty for new Events and it can have at most 128 characters.
    @[::JSON::Field(key: "reportingInstance")]
    @[::YAML::Field(key: "reportingInstance")]
    property reporting_instance : String?
    # series is data about the Event series this event represents or nil if it's a singleton Event.
    property series : EventSeries?
    # type is the type of this event (Normal, Warning), new types could be added in the future. It is machine-readable. This field cannot be empty for new Events.
    property type : String?
  end

  # EventList is a list of Event objects.
  struct EventList
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
    property api_version : String?
    # items is a list of schema objects.
    property items : Array(Event)?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard list metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ListMeta?
  end

  # EventSeries contain information on series of events, i.e. thing that was/is happening continuously for some time. How often to update the EventSeries is up to the event reporters. The default event reporter in "k8s.io/client-go/tools/events/event_broadcaster.go" shows how this struct is updated on heartbeats and can guide customized reporter implementations.
  struct EventSeries
    include Kubernetes::Serializable

    # count is the number of occurrences in this series up to the last heartbeat time.
    property count : Int32?
    # lastObservedTime is the time when last Event from the series was seen before last heartbeat.
    @[::JSON::Field(key: "lastObservedTime")]
    @[::YAML::Field(key: "lastObservedTime")]
    property last_observed_time : MicroTime?
  end
end
