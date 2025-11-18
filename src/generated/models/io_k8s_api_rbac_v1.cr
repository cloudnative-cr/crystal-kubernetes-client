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
  # AggregationRule describes how to locate ClusterRoles to aggregate into the ClusterRole
  struct AggregationRule
    include Kubernetes::Serializable

    # ClusterRoleSelectors holds a list of selectors which will be used to find ClusterRoles and create the rules. If any of the selectors match, then the ClusterRole's permissions will be added
    @[::JSON::Field(key: "clusterRoleSelectors")]
    @[::YAML::Field(key: "clusterRoleSelectors")]
    property cluster_role_selectors : Array(LabelSelector)?
  end

  # ClusterRole is a cluster level, logical grouping of PolicyRules that can be referenced as a unit by a RoleBinding or ClusterRoleBinding.
  struct ClusterRole
    include Kubernetes::Serializable

    # AggregationRule is an optional field that describes how to build the Rules for this ClusterRole. If AggregationRule is set, then the Rules are controller managed and direct changes to Rules will be stomped by the controller.
    @[::JSON::Field(key: "aggregationRule")]
    @[::YAML::Field(key: "aggregationRule")]
    property aggregation_rule : AggregationRule?
    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard object's metadata.
    property metadata : ObjectMeta?
    # Rules holds all the PolicyRules for this ClusterRole
    property rules : Array(PolicyRule)?
  end

  # ClusterRoleBinding references a ClusterRole, but not contain it.  It can reference a ClusterRole in the global namespace, and adds who information via Subject.
  struct ClusterRoleBinding
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard object's metadata.
    property metadata : ObjectMeta?
    # RoleRef can only reference a ClusterRole in the global namespace. If the RoleRef cannot be resolved, the Authorizer must return an error. This field is immutable.
    @[::JSON::Field(key: "roleRef")]
    @[::YAML::Field(key: "roleRef")]
    property role_ref : RoleRef?
    # Subjects holds references to the objects the role applies to.
    property subjects : Array(Subject)?
  end

  # ClusterRoleBindingList is a collection of ClusterRoleBindings
  struct ClusterRoleBindingList
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Items is a list of ClusterRoleBindings
    property items : Array(ClusterRoleBinding)?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard object's metadata.
    property metadata : ListMeta?
  end

  # ClusterRoleList is a collection of ClusterRoles
  struct ClusterRoleList
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Items is a list of ClusterRoles
    property items : Array(ClusterRole)?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard object's metadata.
    property metadata : ListMeta?
  end

  # PolicyRule holds information that describes a policy rule, but does not contain information about who the rule applies to or which namespace the rule applies to.
  struct PolicyRule
    include Kubernetes::Serializable

    # APIGroups is the name of the APIGroup that contains the resources.  If multiple API groups are specified, any action requested against one of the enumerated resources in any API group will be allowed. "" represents the core API group and "*" represents all API groups.
    @[::JSON::Field(key: "apiGroups")]
    @[::YAML::Field(key: "apiGroups")]
    property api_groups : Array(String)?
    # NonResourceURLs is a set of partial urls that a user should have access to.  *s are allowed, but only as the full, final step in the path Since non-resource URLs are not namespaced, this field is only applicable for ClusterRoles referenced from a ClusterRoleBinding. Rules can either apply to API resources (such as "pods" or "secrets") or non-resource URL paths (such as "/api"),  but not both.
    @[::JSON::Field(key: "nonResourceURLs")]
    @[::YAML::Field(key: "nonResourceURLs")]
    property non_resource_ur_ls : Array(String)?
    # ResourceNames is an optional white list of names that the rule applies to.  An empty set means that everything is allowed.
    @[::JSON::Field(key: "resourceNames")]
    @[::YAML::Field(key: "resourceNames")]
    property resource_names : Array(String)?
    # Resources is a list of resources this rule applies to. '*' represents all resources.
    property resources : Array(String)?
    # Verbs is a list of Verbs that apply to ALL the ResourceKinds contained in this rule. '*' represents all verbs.
    property verbs : Array(String)?
  end

  # Role is a namespaced, logical grouping of PolicyRules that can be referenced as a unit by a RoleBinding.
  struct Role
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard object's metadata.
    property metadata : ObjectMeta?
    # Rules holds all the PolicyRules for this Role
    property rules : Array(PolicyRule)?
  end

  # RoleBinding references a role, but does not contain it.  It can reference a Role in the same namespace or a ClusterRole in the global namespace. It adds who information via Subjects and namespace information by which namespace it exists in.  RoleBindings in a given namespace only have effect in that namespace.
  struct RoleBinding
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard object's metadata.
    property metadata : ObjectMeta?
    # RoleRef can reference a Role in the current namespace or a ClusterRole in the global namespace. If the RoleRef cannot be resolved, the Authorizer must return an error. This field is immutable.
    @[::JSON::Field(key: "roleRef")]
    @[::YAML::Field(key: "roleRef")]
    property role_ref : RoleRef?
    # Subjects holds references to the objects the role applies to.
    property subjects : Array(Subject)?
  end

  # RoleBindingList is a collection of RoleBindings
  struct RoleBindingList
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Items is a list of RoleBindings
    property items : Array(RoleBinding)?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard object's metadata.
    property metadata : ListMeta?
  end

  # RoleList is a collection of Roles
  struct RoleList
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Items is a list of Roles
    property items : Array(Role)?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard object's metadata.
    property metadata : ListMeta?
  end

  # RoleRef contains information that points to the role being used
  struct RoleRef
    include Kubernetes::Serializable

    # APIGroup is the group for the resource being referenced
    @[::JSON::Field(key: "apiGroup")]
    @[::YAML::Field(key: "apiGroup")]
    property api_group : String?
    # Kind is the type of resource being referenced
    property kind : String?
    # Name is the name of resource being referenced
    property name : String?
  end

  # Subject contains a reference to the object or user identities a role binding applies to.  This can either hold a direct API object reference, or a value for non-objects such as user and group names.
  struct Subject
    include Kubernetes::Serializable

    # APIGroup holds the API group of the referenced subject. Defaults to "" for ServiceAccount subjects. Defaults to "rbac.authorization.k8s.io" for User and Group subjects.
    @[::JSON::Field(key: "apiGroup")]
    @[::YAML::Field(key: "apiGroup")]
    property api_group : String?
    # Kind of object being referenced. Values defined by this API group are "User", "Group", and "ServiceAccount". If the Authorizer does not recognized the kind value, the Authorizer should report an error.
    property kind : String?
    # Name of the object being referenced.
    property name : String?
    # Namespace of the referenced object.  If the object kind is non-namespace, such as "User" or "Group", and this value is not empty the Authorizer should report an error.
    property namespace : String?
  end
end
