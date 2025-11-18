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
  # APIService represents a server for a particular GroupVersion. Name must be "version.group".
  struct APIService
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ObjectMeta?
    # Spec contains information for locating and communicating with a server
    property spec : APIServiceSpec?
    # Status contains derived information about an API server
    property status : APIServiceStatus?
  end

  # APIServiceCondition describes the state of an APIService at a particular point
  struct APIServiceCondition
    include Kubernetes::Serializable

    # Last time the condition transitioned from one status to another.
    @[::JSON::Field(key: "lastTransitionTime")]
    @[::YAML::Field(key: "lastTransitionTime")]
    property last_transition_time : Time?
    # Human-readable message indicating details about last transition.
    property message : String?
    # Unique, one-word, CamelCase reason for the condition's last transition.
    property reason : String?
    # Status is the status of the condition. Can be True, False, Unknown.
    property status : String?
    # Type is the type of the condition.
    property type : String?
  end

  # APIServiceList is a list of APIService objects.
  struct APIServiceList
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Items is the list of APIService
    property items : Array(APIService)?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard list metadata More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ListMeta?
  end

  # APIServiceSpec contains information for locating and communicating with a server. Only https is supported, though you are able to disable certificate verification.
  struct APIServiceSpec
    include Kubernetes::Serializable

    # CABundle is a PEM encoded CA bundle which will be used to validate an API server's serving certificate. If unspecified, system trust roots on the apiserver are used.
    @[::JSON::Field(key: "caBundle")]
    @[::YAML::Field(key: "caBundle")]
    property ca_bundle : String?
    # Group is the API group name this server hosts
    property group : String?
    # GroupPriorityMinimum is the priority this group should have at least. Higher priority means that the group is preferred by clients over lower priority ones. Note that other versions of this group might specify even higher GroupPriorityMinimum values such that the whole group gets a higher priority. The primary sort is based on GroupPriorityMinimum, ordered highest number to lowest (20 before 10). The secondary sort is based on the alphabetical comparison of the name of the object.  (v1.bar before v1.foo) We'd recommend something like: *.k8s.io (except extensions) at 18000 and PaaSes (OpenShift, Deis) are recommended to be in the 2000s
    @[::JSON::Field(key: "groupPriorityMinimum")]
    @[::YAML::Field(key: "groupPriorityMinimum")]
    property group_priority_minimum : Int32?
    # InsecureSkipTLSVerify disables TLS certificate verification when communicating with this server. This is strongly discouraged.  You should use the CABundle instead.
    @[::JSON::Field(key: "insecureSkipTLSVerify")]
    @[::YAML::Field(key: "insecureSkipTLSVerify")]
    property insecure_skip_tls_verify : Bool?
    # Service is a reference to the service for this API server.  It must communicate on port 443. If the Service is nil, that means the handling for the API groupversion is handled locally on this server. The call will simply delegate to the normal handler chain to be fulfilled.
    property service : ServiceReference?
    # Version is the API version this server hosts.  For example, "v1"
    property version : String?
    # VersionPriority controls the ordering of this API version inside of its group.  Must be greater than zero. The primary sort is based on VersionPriority, ordered highest to lowest (20 before 10). Since it's inside of a group, the number can be small, probably in the 10s. In case of equal version priorities, the version string will be used to compute the order inside a group. If the version string is "kube-like", it will sort above non "kube-like" version strings, which are ordered lexicographically. "Kube-like" versions start with a "v", then are followed by a number (the major version), then optionally the string "alpha" or "beta" and another number (the minor version). These are sorted first by GA > beta > alpha (where GA is a version with no suffix such as beta or alpha), and then by comparing major version, then minor version. An example sorted list of versions: v10, v2, v1, v11beta2, v10beta3, v3beta1, v12alpha1, v11alpha2, foo1, foo10.
    @[::JSON::Field(key: "versionPriority")]
    @[::YAML::Field(key: "versionPriority")]
    property version_priority : Int32?
  end

  # APIServiceStatus contains derived information about an API server
  struct APIServiceStatus
    include Kubernetes::Serializable

    # Current service state of apiService.
    property conditions : Array(APIServiceCondition)?
  end

  # ServiceReference holds a reference to Service.legacy.k8s.io
  struct ServiceReference
    include Kubernetes::Serializable

    # Name is the name of the service
    property name : String?
    # Namespace is the namespace of the service
    property namespace : String?
    # If specified, the port on the service that hosting webhook. Default to 443 for backward compatibility. `port` should be a valid port number (1-65535, inclusive).
    property port : Int32?
  end
end
