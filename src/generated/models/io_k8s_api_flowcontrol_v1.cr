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
  # ExemptPriorityLevelConfiguration describes the configurable aspects of the handling of exempt requests. In the mandatory exempt configuration object the values in the fields here can be modified by authorized users, unlike the rest of the `spec`.
  struct ExemptPriorityLevelConfiguration
    include Kubernetes::Serializable

    # `lendablePercent` prescribes the fraction of the level's NominalCL that can be borrowed by other priority levels.  This value of this field must be between 0 and 100, inclusive, and it defaults to 0. The number of seats that other levels can borrow from this level, known as this level's LendableConcurrencyLimit (LendableCL), is defined as follows.
    # LendableCL(i) = round( NominalCL(i) * lendablePercent(i)/100.0 )
    @[JSON::Field(key: "lendablePercent")]
    @[YAML::Field(key: "lendablePercent")]
    property lendable_percent : Int32?
    # `nominalConcurrencyShares` (NCS) contributes to the computation of the NominalConcurrencyLimit (NominalCL) of this level. This is the number of execution seats nominally reserved for this priority level. This DOES NOT limit the dispatching from this priority level but affects the other priority levels through the borrowing mechanism. The server's concurrency limit (ServerCL) is divided among all the priority levels in proportion to their NCS values:
    # NominalCL(i)  = ceil( ServerCL * NCS(i) / sum_ncs ) sum_ncs = sum[priority level k] NCS(k)
    # Bigger numbers mean a larger nominal concurrency limit, at the expense of every other priority level. This field has a default value of zero.
    @[JSON::Field(key: "nominalConcurrencyShares")]
    @[YAML::Field(key: "nominalConcurrencyShares")]
    property nominal_concurrency_shares : Int32?
  end

  # FlowDistinguisherMethod specifies the method of a flow distinguisher.
  struct FlowDistinguisherMethod
    include Kubernetes::Serializable

    # `type` is the type of flow distinguisher method The supported types are "ByUser" and "ByNamespace". Required.
    property type : String?
  end

  # FlowSchema defines the schema of a group of flows. Note that a flow is made up of a set of inbound API requests with similar attributes and is identified by a pair of strings: the name of the FlowSchema and a "flow distinguisher".
  struct FlowSchema
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # `metadata` is the standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ObjectMeta?
    # `spec` is the specification of the desired behavior of a FlowSchema. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status
    property spec : FlowSchemaSpec?
    # `status` is the current status of a FlowSchema. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status
    property status : FlowSchemaStatus?
  end

  # FlowSchemaCondition describes conditions for a FlowSchema.
  struct FlowSchemaCondition
    include Kubernetes::Serializable

    # `lastTransitionTime` is the last time the condition transitioned from one status to another.
    @[JSON::Field(key: "lastTransitionTime")]
    @[YAML::Field(key: "lastTransitionTime")]
    property last_transition_time : Time?
    # `message` is a human-readable message indicating details about last transition.
    property message : String?
    # `reason` is a unique, one-word, CamelCase reason for the condition's last transition.
    property reason : String?
    # `status` is the status of the condition. Can be True, False, Unknown. Required.
    property status : String?
    # `type` is the type of the condition. Required.
    property type : String?
  end

  # FlowSchemaList is a list of FlowSchema objects.
  struct FlowSchemaList
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # `items` is a list of FlowSchemas.
    property items : Array(FlowSchema)?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # `metadata` is the standard list metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ListMeta?
  end

  # FlowSchemaSpec describes how the FlowSchema's specification looks like.
  struct FlowSchemaSpec
    include Kubernetes::Serializable

    # `distinguisherMethod` defines how to compute the flow distinguisher for requests that match this schema. `nil` specifies that the distinguisher is disabled and thus will always be the empty string.
    @[JSON::Field(key: "distinguisherMethod")]
    @[YAML::Field(key: "distinguisherMethod")]
    property distinguisher_method : FlowDistinguisherMethod?
    # `matchingPrecedence` is used to choose among the FlowSchemas that match a given request. The chosen FlowSchema is among those with the numerically lowest (which we take to be logically highest) MatchingPrecedence.  Each MatchingPrecedence value must be ranged in [1,10000]. Note that if the precedence is not specified, it will be set to 1000 as default.
    @[JSON::Field(key: "matchingPrecedence")]
    @[YAML::Field(key: "matchingPrecedence")]
    property matching_precedence : Int32?
    # `priorityLevelConfiguration` should reference a PriorityLevelConfiguration in the cluster. If the reference cannot be resolved, the FlowSchema will be ignored and marked as invalid in its status. Required.
    @[JSON::Field(key: "priorityLevelConfiguration")]
    @[YAML::Field(key: "priorityLevelConfiguration")]
    property priority_level_configuration : PriorityLevelConfigurationReference?
    # `rules` describes which requests will match this flow schema. This FlowSchema matches a request if and only if at least one member of rules matches the request. if it is an empty slice, there will be no requests matching the FlowSchema.
    property rules : Array(PolicyRulesWithSubjects)?
  end

  # FlowSchemaStatus represents the current state of a FlowSchema.
  struct FlowSchemaStatus
    include Kubernetes::Serializable

    # `conditions` is a list of the current states of FlowSchema.
    property conditions : Array(FlowSchemaCondition)?
  end

  # GroupSubject holds detailed information for group-kind subject.
  struct GroupSubject
    include Kubernetes::Serializable

    # name is the user group that matches, or "*" to match all user groups. See https://github.com/kubernetes/apiserver/blob/master/pkg/authentication/user/user.go for some well-known group names. Required.
    property name : String?
  end

  # LimitResponse defines how to handle requests that can not be executed right now.
  struct LimitResponse
    include Kubernetes::Serializable

    # `queuing` holds the configuration parameters for queuing. This field may be non-empty only if `type` is `"Queue"`.
    property queuing : QueuingConfiguration?
    # `type` is "Queue" or "Reject". "Queue" means that requests that can not be executed upon arrival are held in a queue until they can be executed or a queuing limit is reached. "Reject" means that requests that can not be executed upon arrival are rejected. Required.
    property type : String?
  end

  # LimitedPriorityLevelConfiguration specifies how to handle requests that are subject to limits. It addresses two issues:
  # - How are requests for this priority level limited?
  # - What should be done with requests that exceed the limit?
  struct LimitedPriorityLevelConfiguration
    include Kubernetes::Serializable

    # `borrowingLimitPercent`, if present, configures a limit on how many seats this priority level can borrow from other priority levels. The limit is known as this level's BorrowingConcurrencyLimit (BorrowingCL) and is a limit on the total number of seats that this level may borrow at any one time. This field holds the ratio of that limit to the level's nominal concurrency limit. When this field is non-nil, it must hold a non-negative integer and the limit is calculated as follows.
    # BorrowingCL(i) = round( NominalCL(i) * borrowingLimitPercent(i)/100.0 )
    # The value of this field can be more than 100, implying that this priority level can borrow a number of seats that is greater than its own nominal concurrency limit (NominalCL). When this field is left `nil`, the limit is effectively infinite.
    @[JSON::Field(key: "borrowingLimitPercent")]
    @[YAML::Field(key: "borrowingLimitPercent")]
    property borrowing_limit_percent : Int32?
    # `lendablePercent` prescribes the fraction of the level's NominalCL that can be borrowed by other priority levels. The value of this field must be between 0 and 100, inclusive, and it defaults to 0. The number of seats that other levels can borrow from this level, known as this level's LendableConcurrencyLimit (LendableCL), is defined as follows.
    # LendableCL(i) = round( NominalCL(i) * lendablePercent(i)/100.0 )
    @[JSON::Field(key: "lendablePercent")]
    @[YAML::Field(key: "lendablePercent")]
    property lendable_percent : Int32?
    # `limitResponse` indicates what to do with requests that can not be executed right now
    @[JSON::Field(key: "limitResponse")]
    @[YAML::Field(key: "limitResponse")]
    property limit_response : LimitResponse?
    # `nominalConcurrencyShares` (NCS) contributes to the computation of the NominalConcurrencyLimit (NominalCL) of this level. This is the number of execution seats available at this priority level. This is used both for requests dispatched from this priority level as well as requests dispatched from other priority levels borrowing seats from this level. The server's concurrency limit (ServerCL) is divided among the Limited priority levels in proportion to their NCS values:
    # NominalCL(i)  = ceil( ServerCL * NCS(i) / sum_ncs ) sum_ncs = sum[priority level k] NCS(k)
    # Bigger numbers mean a larger nominal concurrency limit, at the expense of every other priority level.
    # If not specified, this field defaults to a value of 30.
    # Setting this field to zero supports the construction of a "jail" for this priority level that is used to hold some request(s)
    @[JSON::Field(key: "nominalConcurrencyShares")]
    @[YAML::Field(key: "nominalConcurrencyShares")]
    property nominal_concurrency_shares : Int32?
  end

  # NonResourcePolicyRule is a predicate that matches non-resource requests according to their verb and the target non-resource URL. A NonResourcePolicyRule matches a request if and only if both (a) at least one member of verbs matches the request and (b) at least one member of nonResourceURLs matches the request.
  struct NonResourcePolicyRule
    include Kubernetes::Serializable

    # `nonResourceURLs` is a set of url prefixes that a user should have access to and may not be empty. For example:
    # - "/healthz" is legal
    # - "/hea*" is illegal
    # - "/hea" is legal but matches nothing
    # - "/hea/*" also matches nothing
    # - "/healthz/*" matches all per-component health checks.
    # "*" matches all non-resource urls. if it is present, it must be the only entry. Required.
    @[JSON::Field(key: "nonResourceURLs")]
    @[YAML::Field(key: "nonResourceURLs")]
    property non_resource_ur_ls : Array(String)?
    # `verbs` is a list of matching verbs and may not be empty. "*" matches all verbs. If it is present, it must be the only entry. Required.
    property verbs : Array(String)?
  end

  # PolicyRulesWithSubjects prescribes a test that applies to a request to an apiserver. The test considers the subject making the request, the verb being requested, and the resource to be acted upon. This PolicyRulesWithSubjects matches a request if and only if both (a) at least one member of subjects matches the request and (b) at least one member of resourceRules or nonResourceRules matches the request.
  struct PolicyRulesWithSubjects
    include Kubernetes::Serializable

    # `nonResourceRules` is a list of NonResourcePolicyRules that identify matching requests according to their verb and the target non-resource URL.
    @[JSON::Field(key: "nonResourceRules")]
    @[YAML::Field(key: "nonResourceRules")]
    property non_resource_rules : Array(NonResourcePolicyRule)?
    # `resourceRules` is a slice of ResourcePolicyRules that identify matching requests according to their verb and the target resource. At least one of `resourceRules` and `nonResourceRules` has to be non-empty.
    @[JSON::Field(key: "resourceRules")]
    @[YAML::Field(key: "resourceRules")]
    property resource_rules : Array(ResourcePolicyRule)?
    # subjects is the list of normal user, serviceaccount, or group that this rule cares about. There must be at least one member in this slice. A slice that includes both the system:authenticated and system:unauthenticated user groups matches every request. Required.
    property subjects : Array(Subject)?
  end

  # PriorityLevelConfiguration represents the configuration of a priority level.
  struct PriorityLevelConfiguration
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # `metadata` is the standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ObjectMeta?
    # `spec` is the specification of the desired behavior of a "request-priority". More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status
    property spec : PriorityLevelConfigurationSpec?
    # `status` is the current status of a "request-priority". More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status
    property status : PriorityLevelConfigurationStatus?
  end

  # PriorityLevelConfigurationCondition defines the condition of priority level.
  struct PriorityLevelConfigurationCondition
    include Kubernetes::Serializable

    # `lastTransitionTime` is the last time the condition transitioned from one status to another.
    @[JSON::Field(key: "lastTransitionTime")]
    @[YAML::Field(key: "lastTransitionTime")]
    property last_transition_time : Time?
    # `message` is a human-readable message indicating details about last transition.
    property message : String?
    # `reason` is a unique, one-word, CamelCase reason for the condition's last transition.
    property reason : String?
    # `status` is the status of the condition. Can be True, False, Unknown. Required.
    property status : String?
    # `type` is the type of the condition. Required.
    property type : String?
  end

  # PriorityLevelConfigurationList is a list of PriorityLevelConfiguration objects.
  struct PriorityLevelConfigurationList
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # `items` is a list of request-priorities.
    property items : Array(PriorityLevelConfiguration)?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # `metadata` is the standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ListMeta?
  end

  # PriorityLevelConfigurationReference contains information that points to the "request-priority" being used.
  struct PriorityLevelConfigurationReference
    include Kubernetes::Serializable

    # `name` is the name of the priority level configuration being referenced Required.
    property name : String?
  end

  # PriorityLevelConfigurationSpec specifies the configuration of a priority level.
  struct PriorityLevelConfigurationSpec
    include Kubernetes::Serializable

    # `exempt` specifies how requests are handled for an exempt priority level. This field MUST be empty if `type` is `"Limited"`. This field MAY be non-empty if `type` is `"Exempt"`. If empty and `type` is `"Exempt"` then the default values for `ExemptPriorityLevelConfiguration` apply.
    property exempt : ExemptPriorityLevelConfiguration?
    # `limited` specifies how requests are handled for a Limited priority level. This field must be non-empty if and only if `type` is `"Limited"`.
    property limited : LimitedPriorityLevelConfiguration?
    # `type` indicates whether this priority level is subject to limitation on request execution.  A value of `"Exempt"` means that requests of this priority level are not subject to a limit (and thus are never queued) and do not detract from the capacity made available to other priority levels.  A value of `"Limited"` means that (a) requests of this priority level _are_ subject to limits and (b) some of the server's limited capacity is made available exclusively to this priority level. Required.
    property type : String?
  end

  # PriorityLevelConfigurationStatus represents the current state of a "request-priority".
  struct PriorityLevelConfigurationStatus
    include Kubernetes::Serializable

    # `conditions` is the current state of "request-priority".
    property conditions : Array(PriorityLevelConfigurationCondition)?
  end

  # QueuingConfiguration holds the configuration parameters for queuing
  struct QueuingConfiguration
    include Kubernetes::Serializable

    # `handSize` is a small positive number that configures the shuffle sharding of requests into queues.  When enqueuing a request at this priority level the request's flow identifier (a string pair) is hashed and the hash value is used to shuffle the list of queues and deal a hand of the size specified here.  The request is put into one of the shortest queues in that hand. `handSize` must be no larger than `queues`, and should be significantly smaller (so that a few heavy flows do not saturate most of the queues).  See the user-facing documentation for more extensive guidance on setting this field.  This field has a default value of 8.
    @[JSON::Field(key: "handSize")]
    @[YAML::Field(key: "handSize")]
    property hand_size : Int32?
    # `queueLengthLimit` is the maximum number of requests allowed to be waiting in a given queue of this priority level at a time; excess requests are rejected.  This value must be positive.  If not specified, it will be defaulted to 50.
    @[JSON::Field(key: "queueLengthLimit")]
    @[YAML::Field(key: "queueLengthLimit")]
    property queue_length_limit : Int32?
    # `queues` is the number of queues for this priority level. The queues exist independently at each apiserver. The value must be positive.  Setting it to 1 effectively precludes shufflesharding and thus makes the distinguisher method of associated flow schemas irrelevant.  This field has a default value of 64.
    property queues : Int32?
  end

  # ResourcePolicyRule is a predicate that matches some resource requests, testing the request's verb and the target resource. A ResourcePolicyRule matches a resource request if and only if: (a) at least one member of verbs matches the request, (b) at least one member of apiGroups matches the request, (c) at least one member of resources matches the request, and (d) either (d1) the request does not specify a namespace (i.e., `Namespace==""`) and clusterScope is true or (d2) the request specifies a namespace and least one member of namespaces matches the request's namespace.
  struct ResourcePolicyRule
    include Kubernetes::Serializable

    # `apiGroups` is a list of matching API groups and may not be empty. "*" matches all API groups and, if present, must be the only entry. Required.
    @[JSON::Field(key: "apiGroups")]
    @[YAML::Field(key: "apiGroups")]
    property api_groups : Array(String)?
    # `clusterScope` indicates whether to match requests that do not specify a namespace (which happens either because the resource is not namespaced or the request targets all namespaces). If this field is omitted or false then the `namespaces` field must contain a non-empty list.
    @[JSON::Field(key: "clusterScope")]
    @[YAML::Field(key: "clusterScope")]
    property cluster_scope : Bool?
    # `namespaces` is a list of target namespaces that restricts matches.  A request that specifies a target namespace matches only if either (a) this list contains that target namespace or (b) this list contains "*".  Note that "*" matches any specified namespace but does not match a request that _does not specify_ a namespace (see the `clusterScope` field for that). This list may be empty, but only if `clusterScope` is true.
    property namespaces : Array(String)?
    # `resources` is a list of matching resources (i.e., lowercase and plural) with, if desired, subresource.  For example, [ "services", "nodes/status" ].  This list may not be empty. "*" matches all resources and, if present, must be the only entry. Required.
    property resources : Array(String)?
    # `verbs` is a list of matching verbs and may not be empty. "*" matches all verbs and, if present, must be the only entry. Required.
    property verbs : Array(String)?
  end

  # ServiceAccountSubject holds detailed information for service-account-kind subject.
  struct ServiceAccountSubject
    include Kubernetes::Serializable

    # `name` is the name of matching ServiceAccount objects, or "*" to match regardless of name. Required.
    property name : String?
    # `namespace` is the namespace of matching ServiceAccount objects. Required.
    property namespace : String?
  end

  # Subject matches the originator of a request, as identified by the request authentication system. There are three ways of matching an originator; by user, group, or service account.
  struct Subject
    include Kubernetes::Serializable

    # `group` matches based on user group name.
    property group : GroupSubject?
    # `kind` indicates which one of the other fields is non-empty. Required
    property kind : String?
    # `serviceAccount` matches ServiceAccounts.
    @[JSON::Field(key: "serviceAccount")]
    @[YAML::Field(key: "serviceAccount")]
    property service_account : ServiceAccountSubject?
    # `user` matches based on username.
    property user : UserSubject?
  end

  # UserSubject holds detailed information for user-kind subject.
  struct UserSubject
    include Kubernetes::Serializable

    # `name` is the username that matches, or "*" to match all usernames. Required.
    property name : String?
  end
end
