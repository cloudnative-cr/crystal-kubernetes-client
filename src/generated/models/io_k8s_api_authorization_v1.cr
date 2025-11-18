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
  # FieldSelectorAttributes indicates a field limited access. Webhook authors are encouraged to * ensure rawSelector and requirements are not both set * consider the requirements field if set * not try to parse or consider the rawSelector field if set. This is to avoid another CVE-2022-2880 (i.e. getting different systems to agree on how exactly to parse a query is not something we want), see https://www.oxeye.io/resources/golang-parameter-smuggling-attack for more details. For the *SubjectAccessReview endpoints of the kube-apiserver: * If rawSelector is empty and requirements are empty, the request is not limited. * If rawSelector is present and requirements are empty, the rawSelector will be parsed and limited if the parsing succeeds. * If rawSelector is empty and requirements are present, the requirements should be honored * If rawSelector is present and requirements are present, the request is invalid.
  struct FieldSelectorAttributes
    include Kubernetes::Serializable

    # rawSelector is the serialization of a field selector that would be included in a query parameter. Webhook implementations are encouraged to ignore rawSelector. The kube-apiserver's *SubjectAccessReview will parse the rawSelector as long as the requirements are not present.
    @[JSON::Field(key: "rawSelector")]
    @[YAML::Field(key: "rawSelector")]
    property raw_selector : String?
    # requirements is the parsed interpretation of a field selector. All requirements must be met for a resource instance to match the selector. Webhook implementations should handle requirements, but how to handle them is up to the webhook. Since requirements can only limit the request, it is safe to authorize as unlimited request if the requirements are not understood.
    property requirements : Array(FieldSelectorRequirement)?
  end

  # LabelSelectorAttributes indicates a label limited access. Webhook authors are encouraged to * ensure rawSelector and requirements are not both set * consider the requirements field if set * not try to parse or consider the rawSelector field if set. This is to avoid another CVE-2022-2880 (i.e. getting different systems to agree on how exactly to parse a query is not something we want), see https://www.oxeye.io/resources/golang-parameter-smuggling-attack for more details. For the *SubjectAccessReview endpoints of the kube-apiserver: * If rawSelector is empty and requirements are empty, the request is not limited. * If rawSelector is present and requirements are empty, the rawSelector will be parsed and limited if the parsing succeeds. * If rawSelector is empty and requirements are present, the requirements should be honored * If rawSelector is present and requirements are present, the request is invalid.
  struct LabelSelectorAttributes
    include Kubernetes::Serializable

    # rawSelector is the serialization of a field selector that would be included in a query parameter. Webhook implementations are encouraged to ignore rawSelector. The kube-apiserver's *SubjectAccessReview will parse the rawSelector as long as the requirements are not present.
    @[JSON::Field(key: "rawSelector")]
    @[YAML::Field(key: "rawSelector")]
    property raw_selector : String?
    # requirements is the parsed interpretation of a label selector. All requirements must be met for a resource instance to match the selector. Webhook implementations should handle requirements, but how to handle them is up to the webhook. Since requirements can only limit the request, it is safe to authorize as unlimited request if the requirements are not understood.
    property requirements : Array(LabelSelectorRequirement)?
  end

  # LocalSubjectAccessReview checks whether or not a user or group can perform an action in a given namespace. Having a namespace scoped resource makes it much easier to grant namespace scoped policy that includes permissions checking.
  struct LocalSubjectAccessReview
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard list metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ObjectMeta?
    # Spec holds information about the request being evaluated.  spec.namespace must be equal to the namespace you made the request against.  If empty, it is defaulted.
    property spec : SubjectAccessReviewSpec?
    # Status is filled in by the server and indicates whether the request is allowed or not
    property status : SubjectAccessReviewStatus?
  end

  # NonResourceAttributes includes the authorization attributes available for non-resource requests to the Authorizer interface
  struct NonResourceAttributes
    include Kubernetes::Serializable

    # Path is the URL path of the request
    property path : String?
    # Verb is the standard HTTP verb
    property verb : String?
  end

  # NonResourceRule holds information that describes a rule for the non-resource
  struct NonResourceRule
    include Kubernetes::Serializable

    # NonResourceURLs is a set of partial urls that a user should have access to.  *s are allowed, but only as the full, final step in the path.  "*" means all.
    @[JSON::Field(key: "nonResourceURLs")]
    @[YAML::Field(key: "nonResourceURLs")]
    property non_resource_ur_ls : Array(String)?
    # Verb is a list of kubernetes non-resource API verbs, like: get, post, put, delete, patch, head, options.  "*" means all.
    property verbs : Array(String)?
  end

  # ResourceAttributes includes the authorization attributes available for resource requests to the Authorizer interface
  struct ResourceAttributes
    include Kubernetes::Serializable

    # fieldSelector describes the limitation on access based on field.  It can only limit access, not broaden it.
    @[JSON::Field(key: "fieldSelector")]
    @[YAML::Field(key: "fieldSelector")]
    property field_selector : FieldSelectorAttributes?
    # Group is the API Group of the Resource.  "*" means all.
    property group : String?
    # labelSelector describes the limitation on access based on labels.  It can only limit access, not broaden it.
    @[JSON::Field(key: "labelSelector")]
    @[YAML::Field(key: "labelSelector")]
    property label_selector : LabelSelectorAttributes?
    # Name is the name of the resource being requested for a "get" or deleted for a "delete". "" (empty) means all.
    property name : String?
    # Namespace is the namespace of the action being requested.  Currently, there is no distinction between no namespace and all namespaces "" (empty) is defaulted for LocalSubjectAccessReviews "" (empty) is empty for cluster-scoped resources "" (empty) means "all" for namespace scoped resources from a SubjectAccessReview or SelfSubjectAccessReview
    property namespace : String?
    # Resource is one of the existing resource types.  "*" means all.
    property resource : String?
    # Subresource is one of the existing resource types.  "" means none.
    property subresource : String?
    # Verb is a kubernetes resource API verb, like: get, list, watch, create, update, delete, proxy.  "*" means all.
    property verb : String?
    # Version is the API Version of the Resource.  "*" means all.
    property version : String?
  end

  # ResourceRule is the list of actions the subject is allowed to perform on resources. The list ordering isn't significant, may contain duplicates, and possibly be incomplete.
  struct ResourceRule
    include Kubernetes::Serializable

    # APIGroups is the name of the APIGroup that contains the resources.  If multiple API groups are specified, any action requested against one of the enumerated resources in any API group will be allowed.  "*" means all.
    @[JSON::Field(key: "apiGroups")]
    @[YAML::Field(key: "apiGroups")]
    property api_groups : Array(String)?
    # ResourceNames is an optional white list of names that the rule applies to.  An empty set means that everything is allowed.  "*" means all.
    @[JSON::Field(key: "resourceNames")]
    @[YAML::Field(key: "resourceNames")]
    property resource_names : Array(String)?
    # Resources is a list of resources this rule applies to.  "*" means all in the specified apiGroups.
    # "*/foo" represents the subresource 'foo' for all resources in the specified apiGroups.
    property resources : Array(String)?
    # Verb is a list of kubernetes resource API verbs, like: get, list, watch, create, update, delete, proxy.  "*" means all.
    property verbs : Array(String)?
  end

  # SelfSubjectAccessReview checks whether or the current user can perform an action.  Not filling in a spec.namespace means "in all namespaces".  Self is a special case, because users should always be able to check whether they can perform an action
  struct SelfSubjectAccessReview
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard list metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ObjectMeta?
    # Spec holds information about the request being evaluated.  user and groups must be empty
    property spec : SelfSubjectAccessReviewSpec?
    # Status is filled in by the server and indicates whether the request is allowed or not
    property status : SubjectAccessReviewStatus?
  end

  # SelfSubjectAccessReviewSpec is a description of the access request.  Exactly one of ResourceAuthorizationAttributes and NonResourceAuthorizationAttributes must be set
  struct SelfSubjectAccessReviewSpec
    include Kubernetes::Serializable

    # NonResourceAttributes describes information for a non-resource access request
    @[JSON::Field(key: "nonResourceAttributes")]
    @[YAML::Field(key: "nonResourceAttributes")]
    property non_resource_attributes : NonResourceAttributes?
    # ResourceAuthorizationAttributes describes information for a resource access request
    @[JSON::Field(key: "resourceAttributes")]
    @[YAML::Field(key: "resourceAttributes")]
    property resource_attributes : ResourceAttributes?
  end

  # SelfSubjectRulesReview enumerates the set of actions the current user can perform within a namespace. The returned list of actions may be incomplete depending on the server's authorization mode, and any errors experienced during the evaluation. SelfSubjectRulesReview should be used by UIs to show/hide actions, or to quickly let an end user reason about their permissions. It should NOT Be used by external systems to drive authorization decisions as this raises confused deputy, cache lifetime/revocation, and correctness concerns. SubjectAccessReview, and LocalAccessReview are the correct way to defer authorization decisions to the API server.
  struct SelfSubjectRulesReview
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard list metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ObjectMeta?
    # Spec holds information about the request being evaluated.
    property spec : SelfSubjectRulesReviewSpec?
    # Status is filled in by the server and indicates the set of actions a user can perform.
    property status : SubjectRulesReviewStatus?
  end

  # SelfSubjectRulesReviewSpec defines the specification for SelfSubjectRulesReview.
  struct SelfSubjectRulesReviewSpec
    include Kubernetes::Serializable

    # Namespace to evaluate rules for. Required.
    property namespace : String?
  end

  # SubjectAccessReview checks whether or not a user or group can perform an action.
  struct SubjectAccessReview
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard list metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ObjectMeta?
    # Spec holds information about the request being evaluated
    property spec : SubjectAccessReviewSpec?
    # Status is filled in by the server and indicates whether the request is allowed or not
    property status : SubjectAccessReviewStatus?
  end

  # SubjectAccessReviewSpec is a description of the access request.  Exactly one of ResourceAuthorizationAttributes and NonResourceAuthorizationAttributes must be set
  struct SubjectAccessReviewSpec
    include Kubernetes::Serializable

    # Extra corresponds to the user.Info.GetExtra() method from the authenticator.  Since that is input to the authorizer it needs a reflection here.
    property extra : Hash(String, Array(String))?
    # Groups is the groups you're testing for.
    property groups : Array(String)?
    # NonResourceAttributes describes information for a non-resource access request
    @[JSON::Field(key: "nonResourceAttributes")]
    @[YAML::Field(key: "nonResourceAttributes")]
    property non_resource_attributes : NonResourceAttributes?
    # ResourceAuthorizationAttributes describes information for a resource access request
    @[JSON::Field(key: "resourceAttributes")]
    @[YAML::Field(key: "resourceAttributes")]
    property resource_attributes : ResourceAttributes?
    # UID information about the requesting user.
    property uid : String?
    # User is the user you're testing for. If you specify "User" but not "Groups", then is it interpreted as "What if User were not a member of any groups
    property user : String?
  end

  # SubjectAccessReviewStatus
  struct SubjectAccessReviewStatus
    include Kubernetes::Serializable

    # Allowed is required. True if the action would be allowed, false otherwise.
    property allowed : Bool?
    # Denied is optional. True if the action would be denied, otherwise false. If both allowed is false and denied is false, then the authorizer has no opinion on whether to authorize the action. Denied may not be true if Allowed is true.
    property denied : Bool?
    # EvaluationError is an indication that some error occurred during the authorization check. It is entirely possible to get an error and be able to continue determine authorization status in spite of it. For instance, RBAC can be missing a role, but enough roles are still present and bound to reason about the request.
    @[JSON::Field(key: "evaluationError")]
    @[YAML::Field(key: "evaluationError")]
    property evaluation_error : String?
    # Reason is optional.  It indicates why a request was allowed or denied.
    property reason : String?
  end

  # SubjectRulesReviewStatus contains the result of a rules check. This check can be incomplete depending on the set of authorizers the server is configured with and any errors experienced during evaluation. Because authorization rules are additive, if a rule appears in a list it's safe to assume the subject has that permission, even if that list is incomplete.
  struct SubjectRulesReviewStatus
    include Kubernetes::Serializable

    # EvaluationError can appear in combination with Rules. It indicates an error occurred during rule evaluation, such as an authorizer that doesn't support rule evaluation, and that ResourceRules and/or NonResourceRules may be incomplete.
    @[JSON::Field(key: "evaluationError")]
    @[YAML::Field(key: "evaluationError")]
    property evaluation_error : String?
    # Incomplete is true when the rules returned by this call are incomplete. This is most commonly encountered when an authorizer, such as an external authorizer, doesn't support rules evaluation.
    property incomplete : Bool?
    # NonResourceRules is the list of actions the subject is allowed to perform on non-resources. The list ordering isn't significant, may contain duplicates, and possibly be incomplete.
    @[JSON::Field(key: "nonResourceRules")]
    @[YAML::Field(key: "nonResourceRules")]
    property non_resource_rules : Array(NonResourceRule)?
    # ResourceRules is the list of actions the subject is allowed to perform on resources. The list ordering isn't significant, may contain duplicates, and possibly be incomplete.
    @[JSON::Field(key: "resourceRules")]
    @[YAML::Field(key: "resourceRules")]
    property resource_rules : Array(ResourceRule)?
  end
end
