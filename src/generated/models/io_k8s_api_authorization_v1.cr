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
  # AuthorizationOptions contains options for specifying the client's authorization abilities.
  struct AuthorizationOptions
    include Kubernetes::Serializable

    # handledDecisionTypes specifies what decision types the client can handle in the context it is in. Currently valid values are: - [Allow, Deny, NoOpinion] (for conditions-unaware clients) or - [Allow, Deny, NoOpinion, ConditionsMap, Union, ...] (for conditions-aware clients) If the authorizer would like to return conditions, but the client does not opt in to handle those here,
    # the authorizer must fail closed to a safe unconditional decision
    # (Deny if any Deny conditions were present, otherwise NoOpinion).
    # Order does not matter in this slice; set semantics should be used. The server does not reject unrecognized decision types, but focuses on whether the client supports a mode that the server does. All clients must support "classic", conditions-unaware authorization.
    @[::JSON::Field(key: "handledDecisionTypes")]
    @[::YAML::Field(key: "handledDecisionTypes")]
    property handled_decision_types : Array(String)?
  end

  # Condition represents a single authorization condition to be evaluated against data available later in the request chain, e.g. objects available in admission.
  struct Condition
    include Kubernetes::Serializable

    # condition returns a string encoding of the condition to be evaluated. It is a pure, deterministic function from ConditionsData to a boolean (or error). Might or might not be human-readable. Optional, if the ID alone is enough for the authorizer to know how to evaluate the condition.
    property condition : String?
    # description is an optional human-friendly description that can be shown as an error message or for debugging. Optional.
    property description : String?
    # id uniquely identifies this condition within the scope of the authorizer that authored it and ConditionsMap it is part of. Validated as a Kubernetes label key. Any domain of form *.k8s.io or *.kubernetes.io is reserved for Kubernetes use.
    property id : String?
    # type describes the type of the condition, if there are multiple possibilities. Should be formatted as a Kubernetes label key. Any domain of form *.k8s.io or *.kubernetes.io is reserved for Kubernetes use. authorizer.kubernetes.io/cel is a conditions type for CEL, handled by kube-apiserver. Optional. Can be omitted if the authorizer already knows how to evaluate the condition.
    property type : String?
  end

  # ConditionsAwareDecision represents one authorizer's decision. It is an enum type, with variants described in ConditionsAwareDecisionType, plus a reason and error.
  struct ConditionsAwareDecision
    include Kubernetes::Serializable

    # allow represents an unconditional Allow decision. Must be non-null when type == "Allow", otherwise this field must be unset.
    property allow : UnconditionalDecision?
    # conditionsMap represents a conditional decision, modelled as a map of conditions. Must be non-null when type == "ConditionsMap", otherwise this field must be unset.
    @[::JSON::Field(key: "conditionsMap")]
    @[::YAML::Field(key: "conditionsMap")]
    property conditions_map : ConditionsMap?
    # deny represents an unconditional Deny decision. Must be non-null when type == "Deny", otherwise this field must be unset.
    property deny : UnconditionalDecision?
    # noOpinion represents an unconditional NoOpinion decision. Must be non-null when type == "NoOpinion", otherwise this field must be unset.
    @[::JSON::Field(key: "noOpinion")]
    @[::YAML::Field(key: "noOpinion")]
    property no_opinion : UnconditionalDecision?
    # type describes the type of the decision, and acts as an enum discriminator.
    property type : String?
    # union forms an ordered tree of decisions, where the union decision is represented by an internal node, and all other decision types are leaf nodes. During evaluation, the leaf decisions are evaluated in depth-first order, until an Allow or Deny decision is found. The order of the decisions should match the order of the authorizers in the union authorizer for interpretability, but the authorizerName is the map key. At least one of the leaves must be of type ConditionsMap, as otherwise the union could be trivially reduced to just a single Allow/Deny/NoOpinion.
    # Must have at least one element when type == "Union", otherwise this field must be unset.
    property union : Array(NamedConditionsAwareDecision)?
  end

  # ConditionsMap represents a map of conditions, keyed by ID across all conditions, across all effects. The ConditionsMap must have at least one Allow condition or at least one Deny condition. It cannot contain more than 128 conditions in total. The conditions are evaluated against data available later, to determine whether the authorizer that authored the conditions allows or denies the request. If all conditions in the map evaluate to false, the final decision must be NoOpinion.
  struct ConditionsMap
    include Kubernetes::Serializable

    # allowConditions contains the conditions with Allow effect. If any such condition evaluates to true, the ConditionsMap as a whole must evaluate to Allow.
    @[::JSON::Field(key: "allowConditions")]
    @[::YAML::Field(key: "allowConditions")]
    property allow_conditions : Array(Condition)?
    # denyConditions contains the conditions with Deny effect. If any such condition evaluates to true or error, the ConditionsMap as a whole must evaluate to Deny.
    @[::JSON::Field(key: "denyConditions")]
    @[::YAML::Field(key: "denyConditions")]
    property deny_conditions : Array(Condition)?
    # noOpinionConditions contains the conditions with NoOpinion effect. If any such condition evaluates to true or error, the ConditionsMap as a whole must evaluate to NoOpinion.
    @[::JSON::Field(key: "noOpinionConditions")]
    @[::YAML::Field(key: "noOpinionConditions")]
    property no_opinion_conditions : Array(Condition)?
  end

  # FieldSelectorAttributes indicates a field limited access. Webhook authors are encouraged to * ensure rawSelector and requirements are not both set * consider the requirements field if set * not try to parse or consider the rawSelector field if set. This is to avoid another CVE-2022-2880 (i.e. getting different systems to agree on how exactly to parse a query is not something we want), see https://www.oxeye.io/resources/golang-parameter-smuggling-attack for more details. For the *SubjectAccessReview endpoints of the kube-apiserver: * If rawSelector is empty and requirements are empty, the request is not limited. * If rawSelector is present and requirements are empty, the rawSelector will be parsed and limited if the parsing succeeds. * If rawSelector is empty and requirements are present, the requirements should be honored * If rawSelector is present and requirements are present, the request is invalid.
  struct FieldSelectorAttributes
    include Kubernetes::Serializable

    # rawSelector is the serialization of a field selector that would be included in a query parameter. Webhook implementations are encouraged to ignore rawSelector. The kube-apiserver's *SubjectAccessReview will parse the rawSelector as long as the requirements are not present.
    @[::JSON::Field(key: "rawSelector")]
    @[::YAML::Field(key: "rawSelector")]
    property raw_selector : String?
    # requirements is the parsed interpretation of a field selector. All requirements must be met for a resource instance to match the selector. Webhook implementations should handle requirements, but how to handle them is up to the webhook. Since requirements can only limit the request, it is safe to authorize as unlimited request if the requirements are not understood.
    property requirements : Array(FieldSelectorRequirement)?
  end

  # LabelSelectorAttributes indicates a label limited access. Webhook authors are encouraged to * ensure rawSelector and requirements are not both set * consider the requirements field if set * not try to parse or consider the rawSelector field if set. This is to avoid another CVE-2022-2880 (i.e. getting different systems to agree on how exactly to parse a query is not something we want), see https://www.oxeye.io/resources/golang-parameter-smuggling-attack for more details. For the *SubjectAccessReview endpoints of the kube-apiserver: * If rawSelector is empty and requirements are empty, the request is not limited. * If rawSelector is present and requirements are empty, the rawSelector will be parsed and limited if the parsing succeeds. * If rawSelector is empty and requirements are present, the requirements should be honored * If rawSelector is present and requirements are present, the request is invalid.
  struct LabelSelectorAttributes
    include Kubernetes::Serializable

    # rawSelector is the serialization of a field selector that would be included in a query parameter. Webhook implementations are encouraged to ignore rawSelector. The kube-apiserver's *SubjectAccessReview will parse the rawSelector as long as the requirements are not present.
    @[::JSON::Field(key: "rawSelector")]
    @[::YAML::Field(key: "rawSelector")]
    property raw_selector : String?
    # requirements is the parsed interpretation of a label selector. All requirements must be met for a resource instance to match the selector. Webhook implementations should handle requirements, but how to handle them is up to the webhook. Since requirements can only limit the request, it is safe to authorize as unlimited request if the requirements are not understood.
    property requirements : Array(LabelSelectorRequirement)?
  end

  # LocalSubjectAccessReview checks whether or not a user or group can perform an action in a given namespace. Having a namespace scoped resource makes it much easier to grant namespace scoped policy that includes permissions checking.
  struct LocalSubjectAccessReview
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # metadata is the standard list metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ObjectMeta?
    # spec holds information about the request being evaluated.  spec.namespace must be equal to the namespace you made the request against.  If empty, it is defaulted.
    property spec : SubjectAccessReviewSpec?
    # status is filled in by the server and indicates whether the request is allowed or not
    property status : SubjectAccessReviewStatus?
  end

  # NamedConditionsAwareDecision is a named ConditionsAwareDecision, returned by a unioned authorizer.
  struct NamedConditionsAwareDecision
    include Kubernetes::Serializable

    # authorizerName details the name of the authorizer that authored the condition, such that the right Decision can be paired with the right authorizer when evaluating the conditions, even across API server replicas. The name must be stable over time. This name must be unique within a given union authorizer, not necessarily globally.
    @[::JSON::Field(key: "authorizerName")]
    @[::YAML::Field(key: "authorizerName")]
    property authorizer_name : String?
    # decision carries the inner decision returned from the authorizer.
    property decision : ConditionsAwareDecision?
  end

  # NonResourceAttributes includes the authorization attributes available for non-resource requests to the Authorizer interface
  struct NonResourceAttributes
    include Kubernetes::Serializable

    # path is the URL path of the request
    property path : String?
    # verb is the standard HTTP verb
    property verb : String?
  end

  # NonResourceRule holds information that describes a rule for the non-resource
  struct NonResourceRule
    include Kubernetes::Serializable

    # nonResourceURLs is a set of partial urls that a user should have access to.  *s are allowed, but only as the full, final step in the path.  "*" means all.
    @[::JSON::Field(key: "nonResourceURLs")]
    @[::YAML::Field(key: "nonResourceURLs")]
    property non_resource_ur_ls : Array(String)?
    # verbs is a list of kubernetes non-resource API verbs, like: get, post, put, delete, patch, head, options.  "*" means all.
    property verbs : Array(String)?
  end

  # ResourceAttributes includes the authorization attributes available for resource requests to the Authorizer interface
  struct ResourceAttributes
    include Kubernetes::Serializable

    # fieldSelector describes the limitation on access based on field.  It can only limit access, not broaden it.
    @[::JSON::Field(key: "fieldSelector")]
    @[::YAML::Field(key: "fieldSelector")]
    property field_selector : FieldSelectorAttributes?
    # group is the API Group of the Resource.  "*" means all.
    property group : String?
    # labelSelector describes the limitation on access based on labels.  It can only limit access, not broaden it.
    @[::JSON::Field(key: "labelSelector")]
    @[::YAML::Field(key: "labelSelector")]
    property label_selector : LabelSelectorAttributes?
    # name is the name of the resource being requested for a "get" or deleted for a "delete". "" (empty) means all.
    property name : String?
    # namespace is the namespace of the action being requested.  Currently, there is no distinction between no namespace and all namespaces "" (empty) is defaulted for LocalSubjectAccessReviews "" (empty) is empty for cluster-scoped resources "" (empty) means "all" for namespace scoped resources from a SubjectAccessReview or SelfSubjectAccessReview
    property namespace : String?
    # resource is one of the existing resource types.  "*" means all.
    property resource : String?
    # subresource is one of the existing resource types.  "" means none.
    property subresource : String?
    # verb is a kubernetes resource API verb, like: get, list, watch, create, update, delete, proxy.  "*" means all.
    property verb : String?
    # version is the API Version of the Resource.  "*" means all.
    property version : String?
  end

  # ResourceRule is the list of actions the subject is allowed to perform on resources. The list ordering isn't significant, may contain duplicates, and possibly be incomplete.
  struct ResourceRule
    include Kubernetes::Serializable

    # apiGroups is the name of the APIGroup that contains the resources.  If multiple API groups are specified, any action requested against one of the enumerated resources in any API group will be allowed.  "*" means all.
    @[::JSON::Field(key: "apiGroups")]
    @[::YAML::Field(key: "apiGroups")]
    property api_groups : Array(String)?
    # resourceNames is an optional white list of names that the rule applies to.  An empty set means that everything is allowed.  "*" means all.
    @[::JSON::Field(key: "resourceNames")]
    @[::YAML::Field(key: "resourceNames")]
    property resource_names : Array(String)?
    # resources is a list of resources this rule applies to.  "*" means all in the specified apiGroups.
    # "*/foo" represents the subresource 'foo' for all resources in the specified apiGroups.
    property resources : Array(String)?
    # verbs is a list of kubernetes resource API verbs, like: get, list, watch, create, update, delete, proxy.  "*" means all.
    property verbs : Array(String)?
  end

  # SelfSubjectAccessReview checks whether or the current user can perform an action.  Not filling in a spec.namespace means "in all namespaces".  Self is a special case, because users should always be able to check whether they can perform an action
  struct SelfSubjectAccessReview
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # metadata is the standard list metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ObjectMeta?
    # spec holds information about the request being evaluated.  user and groups must be empty
    property spec : SelfSubjectAccessReviewSpec?
    # status is filled in by the server and indicates whether the request is allowed or not
    property status : SubjectAccessReviewStatus?
  end

  # SelfSubjectAccessReviewSpec is a description of the access request.  Exactly one of resourceAttributes and nonResourceAttributes must be set
  struct SelfSubjectAccessReviewSpec
    include Kubernetes::Serializable

    # authorizationOptions contains options for specifying the client's authorization abilities. If unset, only unconditional authorization is supported, for backwards-compatibility. Requires the ConditionalAuthorization feature to be enabled.
    @[::JSON::Field(key: "authorizationOptions")]
    @[::YAML::Field(key: "authorizationOptions")]
    property authorization_options : AuthorizationOptions?
    # nonResourceAttributes describes information for a non-resource access request
    @[::JSON::Field(key: "nonResourceAttributes")]
    @[::YAML::Field(key: "nonResourceAttributes")]
    property non_resource_attributes : NonResourceAttributes?
    # resourceAttributes describes information for a resource access request
    @[::JSON::Field(key: "resourceAttributes")]
    @[::YAML::Field(key: "resourceAttributes")]
    property resource_attributes : ResourceAttributes?
  end

  # SelfSubjectRulesReview enumerates the set of actions the current user can perform within a namespace. The returned list of actions may be incomplete depending on the server's authorization mode, and any errors experienced during the evaluation. SelfSubjectRulesReview should be used by UIs to show/hide actions, or to quickly let an end user reason about their permissions. It should NOT Be used by external systems to drive authorization decisions as this raises confused deputy, cache lifetime/revocation, and correctness concerns. SubjectAccessReview, and LocalAccessReview are the correct way to defer authorization decisions to the API server.
  struct SelfSubjectRulesReview
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # metadata is the standard list metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ObjectMeta?
    # spec holds information about the request being evaluated.
    property spec : SelfSubjectRulesReviewSpec?
    # status is filled in by the server and indicates the set of actions a user can perform.
    property status : SubjectRulesReviewStatus?
  end

  # SelfSubjectRulesReviewSpec defines the specification for SelfSubjectRulesReview.
  struct SelfSubjectRulesReviewSpec
    include Kubernetes::Serializable

    # namespace to evaluate rules for. Required.
    property namespace : String?
  end

  # SubjectAccessReview checks whether or not a user or group can perform an action.
  struct SubjectAccessReview
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # metadata is the standard list metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ObjectMeta?
    # spec holds information about the request being evaluated
    property spec : SubjectAccessReviewSpec?
    # status is filled in by the server and indicates whether the request is allowed or not
    property status : SubjectAccessReviewStatus?
  end

  # SubjectAccessReviewSpec is a description of the access request.  Exactly one of resourceAttributes and nonResourceAttributes must be set
  struct SubjectAccessReviewSpec
    include Kubernetes::Serializable

    # authorizationOptions contains options for specifying the client's authorization abilities. If unset, only unconditional authorization is supported, for backwards-compatibility. Requires the ConditionalAuthorization feature to be enabled.
    @[::JSON::Field(key: "authorizationOptions")]
    @[::YAML::Field(key: "authorizationOptions")]
    property authorization_options : AuthorizationOptions?
    # extra corresponds to the user.Info.GetExtra() method from the authenticator.  Since that is input to the authorizer it needs a reflection here.
    property extra : Hash(String, Array(String))?
    # groups is the groups you're testing for.
    property groups : Array(String)?
    # nonResourceAttributes describes information for a non-resource access request
    @[::JSON::Field(key: "nonResourceAttributes")]
    @[::YAML::Field(key: "nonResourceAttributes")]
    property non_resource_attributes : NonResourceAttributes?
    # resourceAttributes describes information for a resource access request
    @[::JSON::Field(key: "resourceAttributes")]
    @[::YAML::Field(key: "resourceAttributes")]
    property resource_attributes : ResourceAttributes?
    # uid information about the requesting user.
    property uid : String?
    # user is the user you're testing for. If you specify "User" but not "Groups", then is it interpreted as "What if User were not a member of any groups
    property user : String?
  end

  # SubjectAccessReviewStatus
  struct SubjectAccessReviewStatus
    include Kubernetes::Serializable

    # allowed is true if the action would be allowed, false otherwise. allowed=true is mutually exclusive with denied=true and conditionalDecision != nil.
    property allowed : Bool?
    # conditionalDecision represents a conditional decision returned by the authorizer. When conditionalDecision is set, allowed, denied, reason and evaluationError must have their zero values. The top-level decision type should be ConditionsAwareDecisionTypeConditionsMap or ConditionsAwareDecisionTypeUnion, as Allow/Deny/NoOpinion decisions can be represented with SubjectAccessReviewStatus.Allowed and SubjectAccessReviewStatus.Denied alone. May only be set if spec.authorizationOptions.handledDecisionTypes includes `ConditionsMap` and `Union`. Requires the ConditionalAuthorization feature to be enabled.
    @[::JSON::Field(key: "conditionalDecision")]
    @[::YAML::Field(key: "conditionalDecision")]
    property conditional_decision : ConditionsAwareDecision?
    # denied is optional. True if the action would be denied, otherwise false If allowed is false, denied is false, and conditionalDecision is unset, then the authorizer has no opinion on whether to authorize the action. denied=true is mutually exclusive with allowed=true and conditionalDecision != nil.
    property denied : Bool?
    # evaluationError is an indication that some error occurred during the authorization check. It is entirely possible to get an error and be able to continue determine authorization status in spite of it. For instance, RBAC can be missing a role, but enough roles are still present and bound to reason about the request.
    @[::JSON::Field(key: "evaluationError")]
    @[::YAML::Field(key: "evaluationError")]
    property evaluation_error : String?
    # reason is optional.  It indicates why a request was allowed or denied.
    property reason : String?
  end

  # SubjectRulesReviewStatus contains the result of a rules check. This check can be incomplete depending on the set of authorizers the server is configured with and any errors experienced during evaluation. Because authorization rules are additive, if a rule appears in a list it's safe to assume the subject has that permission, even if that list is incomplete.
  struct SubjectRulesReviewStatus
    include Kubernetes::Serializable

    # evaluationError can appear in combination with Rules. It indicates an error occurred during rule evaluation, such as an authorizer that doesn't support rule evaluation, and that ResourceRules and/or NonResourceRules may be incomplete.
    @[::JSON::Field(key: "evaluationError")]
    @[::YAML::Field(key: "evaluationError")]
    property evaluation_error : String?
    # incomplete is true when the rules returned by this call are incomplete. This is most commonly encountered when an authorizer, such as an external authorizer, doesn't support rules evaluation.
    property incomplete : Bool?
    # nonResourceRules is the list of actions the subject is allowed to perform on non-resources. The list ordering isn't significant, may contain duplicates, and possibly be incomplete.
    @[::JSON::Field(key: "nonResourceRules")]
    @[::YAML::Field(key: "nonResourceRules")]
    property non_resource_rules : Array(NonResourceRule)?
    # resourceRules is the list of actions the subject is allowed to perform on resources. The list ordering isn't significant, may contain duplicates, and possibly be incomplete.
    @[::JSON::Field(key: "resourceRules")]
    @[::YAML::Field(key: "resourceRules")]
    property resource_rules : Array(ResourceRule)?
  end

  # UnconditionalDecision represents the data associated with an unconditional decision.
  struct UnconditionalDecision
    include Kubernetes::Serializable

    # evaluationError is an indication that some error occurred during the authorization check. It is entirely possible to get an error and be able to continue determine authorization status in spite of it. For instance, RBAC can be missing a role, but enough roles are still present and bound to reason about the request.
    @[::JSON::Field(key: "evaluationError")]
    @[::YAML::Field(key: "evaluationError")]
    property evaluation_error : String?
    # reason is optional. It indicates why a request was allowed or denied.
    property reason : String?
  end
end
