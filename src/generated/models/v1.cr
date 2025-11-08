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
  # AuditAnnotation describes how to produce an audit annotation for an API request.
  struct AuditAnnotation
    include Kubernetes::Serializable

    # key specifies the audit annotation key. The audit annotation keys of a ValidatingAdmissionPolicy must be unique. The key must be a qualified name ([A-Za-z0-9][-A-Za-z0-9_.]*) no more than 63 bytes in length.
    # The key is combined with the resource name of the ValidatingAdmissionPolicy to construct an audit annotation key: "{ValidatingAdmissionPolicy name}/{key}".
    # If an admission webhook uses the same resource name as this ValidatingAdmissionPolicy and the same audit annotation key, the annotation key will be identical. In this case, the first annotation written with the key will be included in the audit event and all subsequent annotations with the same key will be discarded.
    # Required.
    property key : String?
    # valueExpression represents the expression which is evaluated by CEL to produce an audit annotation value. The expression must evaluate to either a string or null value. If the expression evaluates to a string, the audit annotation is included with the string value. If the expression evaluates to null or empty string the audit annotation will be omitted. The valueExpression may be no longer than 5kb in length. If the result of the valueExpression is more than 10kb in length, it will be truncated to 10kb.
    # If multiple ValidatingAdmissionPolicyBinding resources match an API request, then the valueExpression will be evaluated for each binding. All unique values produced by the valueExpressions will be joined together in a comma-separated list.
    # Required.
    @[JSON::Field(key: "valueExpression")]
    @[YAML::Field(key: "valueExpression")]
    property value_expression : String?
  end

  # ExpressionWarning is a warning information that targets a specific expression.
  struct ExpressionWarning
    include Kubernetes::Serializable

    # The path to the field that refers the expression. For example, the reference to the expression of the first item of validations is "spec.validations[0].expression"
    @[JSON::Field(key: "fieldRef")]
    @[YAML::Field(key: "fieldRef")]
    property field_ref : String?
    # The content of type checking information in a human-readable form. Each line of the warning contains the type that the expression is checked against, followed by the type check error from the compiler.
    property warning : String?
  end

  # MatchCondition represents a condition which must by fulfilled for a request to be sent to a webhook.
  struct MatchCondition
    include Kubernetes::Serializable

    # Expression represents the expression which will be evaluated by CEL. Must evaluate to bool. CEL expressions have access to the contents of the AdmissionRequest and Authorizer, organized into CEL variables:
    # 'object' - The object from the incoming request. The value is null for DELETE requests. 'oldObject' - The existing object. The value is null for CREATE requests. 'request' - Attributes of the admission request(/pkg/apis/admission/types.go#AdmissionRequest). 'authorizer' - A CEL Authorizer. May be used to perform authorization checks for the principal (user or service account) of the request.
    # See https://pkg.go.dev/k8s.io/apiserver/pkg/cel/library#Authz
    # 'authorizer.requestResource' - A CEL ResourceCheck constructed from the 'authorizer' and configured with the
    # request resource.
    # Documentation on CEL: https://kubernetes.io/docs/reference/using-api/cel/
    # Required.
    property expression : String?
    # Name is an identifier for this match condition, used for strategic merging of MatchConditions, as well as providing an identifier for logging purposes. A good name should be descriptive of the associated expression. Name must be a qualified name consisting of alphanumeric characters, '-', '_' or '.', and must start and end with an alphanumeric character (e.g. 'MyName',  or 'my.name',  or '123-abc', regex used for validation is '([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9]') with an optional DNS subdomain prefix and '/' (e.g. 'example.com/MyName')
    # Required.
    property name : String?
  end

  # MatchResources decides whether to run the admission control policy on an object based on whether it meets the match criteria. The exclude rules take precedence over include rules (if a resource matches both, it is excluded)
  struct MatchResources
    include Kubernetes::Serializable

    # ExcludeResourceRules describes what operations on what resources/subresources the ValidatingAdmissionPolicy should not care about. The exclude rules take precedence over include rules (if a resource matches both, it is excluded)
    @[JSON::Field(key: "excludeResourceRules")]
    @[YAML::Field(key: "excludeResourceRules")]
    property exclude_resource_rules : Array(NamedRuleWithOperations)?
    # matchPolicy defines how the "MatchResources" list is used to match incoming requests. Allowed values are "Exact" or "Equivalent".
    # - Exact: match a request only if it exactly matches a specified rule. For example, if deployments can be modified via apps/v1, apps/v1beta1, and extensions/v1beta1, but "rules" only included `apiGroups:["apps"], apiVersions:["v1"], resources: ["deployments"]`, a request to apps/v1beta1 or extensions/v1beta1 would not be sent to the ValidatingAdmissionPolicy.
    # - Equivalent: match a request if modifies a resource listed in rules, even via another API group or version. For example, if deployments can be modified via apps/v1, apps/v1beta1, and extensions/v1beta1, and "rules" only included `apiGroups:["apps"], apiVersions:["v1"], resources: ["deployments"]`, a request to apps/v1beta1 or extensions/v1beta1 would be converted to apps/v1 and sent to the ValidatingAdmissionPolicy.
    # Defaults to "Equivalent"
    @[JSON::Field(key: "matchPolicy")]
    @[YAML::Field(key: "matchPolicy")]
    property match_policy : String?
    # NamespaceSelector decides whether to run the admission control policy on an object based on whether the namespace for that object matches the selector. If the object itself is a namespace, the matching is performed on object.metadata.labels. If the object is another cluster scoped resource, it never skips the policy.
    # For example, to run the webhook on any objects whose namespace is not associated with "runlevel" of "0" or "1";  you will set the selector as follows: "namespaceSelector": {
    # "matchExpressions": [
    # {
    # "key": "runlevel",
    # "operator": "NotIn",
    # "values": [
    # "0",
    # "1"
    # ]
    # }
    # ]
    # }
    # If instead you want to only run the policy on any objects whose namespace is associated with the "environment" of "prod" or "staging"; you will set the selector as follows: "namespaceSelector": {
    # "matchExpressions": [
    # {
    # "key": "environment",
    # "operator": "In",
    # "values": [
    # "prod",
    # "staging"
    # ]
    # }
    # ]
    # }
    # See https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/ for more examples of label selectors.
    # Default to the empty LabelSelector, which matches everything.
    @[JSON::Field(key: "namespaceSelector")]
    @[YAML::Field(key: "namespaceSelector")]
    property namespace_selector : LabelSelector?
    # ObjectSelector decides whether to run the validation based on if the object has matching labels. objectSelector is evaluated against both the oldObject and newObject that would be sent to the cel validation, and is considered to match if either object matches the selector. A null object (oldObject in the case of create, or newObject in the case of delete) or an object that cannot have labels (like a DeploymentRollback or a PodProxyOptions object) is not considered to match. Use the object selector only if the webhook is opt-in, because end users may skip the admission webhook by setting the labels. Default to the empty LabelSelector, which matches everything.
    @[JSON::Field(key: "objectSelector")]
    @[YAML::Field(key: "objectSelector")]
    property object_selector : LabelSelector?
    # ResourceRules describes what operations on what resources/subresources the ValidatingAdmissionPolicy matches. The policy cares about an operation if it matches _any_ Rule.
    @[JSON::Field(key: "resourceRules")]
    @[YAML::Field(key: "resourceRules")]
    property resource_rules : Array(NamedRuleWithOperations)?
  end

  # MutatingWebhook describes an admission webhook and the resources and operations it applies to.
  struct MutatingWebhook
    include Kubernetes::Serializable

    # AdmissionReviewVersions is an ordered list of preferred `AdmissionReview` versions the Webhook expects. API server will try to use first version in the list which it supports. If none of the versions specified in this list supported by API server, validation will fail for this object. If a persisted webhook configuration specifies allowed versions and does not include any versions known to the API Server, calls to the webhook will fail and be subject to the failure policy.
    @[JSON::Field(key: "admissionReviewVersions")]
    @[YAML::Field(key: "admissionReviewVersions")]
    property admission_review_versions : Array(String)?
    # ClientConfig defines how to communicate with the hook. Required
    @[JSON::Field(key: "clientConfig")]
    @[YAML::Field(key: "clientConfig")]
    property client_config : WebhookClientConfig?
    # FailurePolicy defines how unrecognized errors from the admission endpoint are handled - allowed values are Ignore or Fail. Defaults to Fail.
    @[JSON::Field(key: "failurePolicy")]
    @[YAML::Field(key: "failurePolicy")]
    property failure_policy : String?
    # MatchConditions is a list of conditions that must be met for a request to be sent to this webhook. Match conditions filter requests that have already been matched by the rules, namespaceSelector, and objectSelector. An empty list of matchConditions matches all requests. There are a maximum of 64 match conditions allowed.
    # The exact matching logic is (in order):
    # 1. If ANY matchCondition evaluates to FALSE, the webhook is skipped.
    # 2. If ALL matchConditions evaluate to TRUE, the webhook is called.
    # 3. If any matchCondition evaluates to an error (but none are FALSE):
    # - If failurePolicy=Fail, reject the request
    # - If failurePolicy=Ignore, the error is ignored and the webhook is skipped
    @[JSON::Field(key: "matchConditions")]
    @[YAML::Field(key: "matchConditions")]
    property match_conditions : Array(MatchCondition)?
    # matchPolicy defines how the "rules" list is used to match incoming requests. Allowed values are "Exact" or "Equivalent".
    # - Exact: match a request only if it exactly matches a specified rule. For example, if deployments can be modified via apps/v1, apps/v1beta1, and extensions/v1beta1, but "rules" only included `apiGroups:["apps"], apiVersions:["v1"], resources: ["deployments"]`, a request to apps/v1beta1 or extensions/v1beta1 would not be sent to the webhook.
    # - Equivalent: match a request if modifies a resource listed in rules, even via another API group or version. For example, if deployments can be modified via apps/v1, apps/v1beta1, and extensions/v1beta1, and "rules" only included `apiGroups:["apps"], apiVersions:["v1"], resources: ["deployments"]`, a request to apps/v1beta1 or extensions/v1beta1 would be converted to apps/v1 and sent to the webhook.
    # Defaults to "Equivalent"
    @[JSON::Field(key: "matchPolicy")]
    @[YAML::Field(key: "matchPolicy")]
    property match_policy : String?
    # The name of the admission webhook. Name should be fully qualified, e.g., imagepolicy.kubernetes.io, where "imagepolicy" is the name of the webhook, and kubernetes.io is the name of the organization. Required.
    property name : String?
    # NamespaceSelector decides whether to run the webhook on an object based on whether the namespace for that object matches the selector. If the object itself is a namespace, the matching is performed on object.metadata.labels. If the object is another cluster scoped resource, it never skips the webhook.
    # For example, to run the webhook on any objects whose namespace is not associated with "runlevel" of "0" or "1";  you will set the selector as follows: "namespaceSelector": {
    # "matchExpressions": [
    # {
    # "key": "runlevel",
    # "operator": "NotIn",
    # "values": [
    # "0",
    # "1"
    # ]
    # }
    # ]
    # }
    # If instead you want to only run the webhook on any objects whose namespace is associated with the "environment" of "prod" or "staging"; you will set the selector as follows: "namespaceSelector": {
    # "matchExpressions": [
    # {
    # "key": "environment",
    # "operator": "In",
    # "values": [
    # "prod",
    # "staging"
    # ]
    # }
    # ]
    # }
    # See https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/ for more examples of label selectors.
    # Default to the empty LabelSelector, which matches everything.
    @[JSON::Field(key: "namespaceSelector")]
    @[YAML::Field(key: "namespaceSelector")]
    property namespace_selector : LabelSelector?
    # ObjectSelector decides whether to run the webhook based on if the object has matching labels. objectSelector is evaluated against both the oldObject and newObject that would be sent to the webhook, and is considered to match if either object matches the selector. A null object (oldObject in the case of create, or newObject in the case of delete) or an object that cannot have labels (like a DeploymentRollback or a PodProxyOptions object) is not considered to match. Use the object selector only if the webhook is opt-in, because end users may skip the admission webhook by setting the labels. Default to the empty LabelSelector, which matches everything.
    @[JSON::Field(key: "objectSelector")]
    @[YAML::Field(key: "objectSelector")]
    property object_selector : LabelSelector?
    # reinvocationPolicy indicates whether this webhook should be called multiple times as part of a single admission evaluation. Allowed values are "Never" and "IfNeeded".
    # Never: the webhook will not be called more than once in a single admission evaluation.
    # IfNeeded: the webhook will be called at least one additional time as part of the admission evaluation if the object being admitted is modified by other admission plugins after the initial webhook call. Webhooks that specify this option *must* be idempotent, able to process objects they previously admitted. Note: * the number of additional invocations is not guaranteed to be exactly one. * if additional invocations result in further modifications to the object, webhooks are not guaranteed to be invoked again. * webhooks that use this option may be reordered to minimize the number of additional invocations. * to validate an object after all mutations are guaranteed complete, use a validating admission webhook instead.
    # Defaults to "Never".
    @[JSON::Field(key: "reinvocationPolicy")]
    @[YAML::Field(key: "reinvocationPolicy")]
    property reinvocation_policy : String?
    # Rules describes what operations on what resources/subresources the webhook cares about. The webhook cares about an operation if it matches _any_ Rule. However, in order to prevent ValidatingAdmissionWebhooks and MutatingAdmissionWebhooks from putting the cluster in a state which cannot be recovered from without completely disabling the plugin, ValidatingAdmissionWebhooks and MutatingAdmissionWebhooks are never called on admission requests for ValidatingWebhookConfiguration and MutatingWebhookConfiguration objects.
    property rules : Array(RuleWithOperations)?
    # SideEffects states whether this webhook has side effects. Acceptable values are: None, NoneOnDryRun (webhooks created via v1beta1 may also specify Some or Unknown). Webhooks with side effects MUST implement a reconciliation system, since a request may be rejected by a future step in the admission chain and the side effects therefore need to be undone. Requests with the dryRun attribute will be auto-rejected if they match a webhook with sideEffects == Unknown or Some.
    @[JSON::Field(key: "sideEffects")]
    @[YAML::Field(key: "sideEffects")]
    property side_effects : String?
    # TimeoutSeconds specifies the timeout for this webhook. After the timeout passes, the webhook call will be ignored or the API call will fail based on the failure policy. The timeout value must be between 1 and 30 seconds. Default to 10 seconds.
    @[JSON::Field(key: "timeoutSeconds")]
    @[YAML::Field(key: "timeoutSeconds")]
    property timeout_seconds : Int32?
  end

  # MutatingWebhookConfiguration describes the configuration of and admission webhook that accept or reject and may change the object.
  struct MutatingWebhookConfiguration
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard object metadata; More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata.
    property metadata : ObjectMeta?
    # Webhooks is a list of webhooks and the affected resources and operations.
    property webhooks : Array(MutatingWebhook)?
  end

  # MutatingWebhookConfigurationList is a list of MutatingWebhookConfiguration.
  struct MutatingWebhookConfigurationList
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # List of MutatingWebhookConfiguration.
    property items : Array(MutatingWebhookConfiguration)?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard list metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property metadata : ListMeta?
  end

  # NamedRuleWithOperations is a tuple of Operations and Resources with ResourceNames.
  struct NamedRuleWithOperations
    include Kubernetes::Serializable

    # APIGroups is the API groups the resources belong to. '*' is all groups. If '*' is present, the length of the slice must be one. Required.
    @[JSON::Field(key: "apiGroups")]
    @[YAML::Field(key: "apiGroups")]
    property api_groups : Array(String)?
    # APIVersions is the API versions the resources belong to. '*' is all versions. If '*' is present, the length of the slice must be one. Required.
    @[JSON::Field(key: "apiVersions")]
    @[YAML::Field(key: "apiVersions")]
    property api_versions : Array(String)?
    # Operations is the operations the admission hook cares about - CREATE, UPDATE, DELETE, CONNECT or * for all of those operations and any future admission operations that are added. If '*' is present, the length of the slice must be one. Required.
    property operations : Array(String)?
    # ResourceNames is an optional white list of names that the rule applies to.  An empty set means that everything is allowed.
    @[JSON::Field(key: "resourceNames")]
    @[YAML::Field(key: "resourceNames")]
    property resource_names : Array(String)?
    # Resources is a list of resources this rule applies to.
    # For example: 'pods' means pods. 'pods/log' means the log subresource of pods. '*' means all resources, but not subresources. 'pods/*' means all subresources of pods. '*/scale' means all scale subresources. '*/*' means all resources and their subresources.
    # If wildcard is present, the validation rule will ensure resources do not overlap with each other.
    # Depending on the enclosing object, subresources might not be allowed. Required.
    property resources : Array(String)?
    # scope specifies the scope of this rule. Valid values are "Cluster", "Namespaced", and "*" "Cluster" means that only cluster-scoped resources will match this rule. Namespace API objects are cluster-scoped. "Namespaced" means that only namespaced resources will match this rule. "*" means that there are no scope restrictions. Subresources match the scope of their parent resource. Default is "*".
    property scope : String?
  end

  # ParamKind is a tuple of Group Kind and Version.
  struct ParamKind
    include Kubernetes::Serializable

    # APIVersion is the API group version the resources belong to. In format of "group/version". Required.
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Kind is the API kind the resources belong to. Required.
    property kind : String?
  end

  # ParamRef describes how to locate the params to be used as input to expressions of rules applied by a policy binding.
  struct ParamRef
    include Kubernetes::Serializable

    # name is the name of the resource being referenced.
    # One of `name` or `selector` must be set, but `name` and `selector` are mutually exclusive properties. If one is set, the other must be unset.
    # A single parameter used for all admission requests can be configured by setting the `name` field, leaving `selector` blank, and setting namespace if `paramKind` is namespace-scoped.
    property name : String?
    # namespace is the namespace of the referenced resource. Allows limiting the search for params to a specific namespace. Applies to both `name` and `selector` fields.
    # A per-namespace parameter may be used by specifying a namespace-scoped `paramKind` in the policy and leaving this field empty.
    # - If `paramKind` is cluster-scoped, this field MUST be unset. Setting this field results in a configuration error.
    # - If `paramKind` is namespace-scoped, the namespace of the object being evaluated for admission will be used when this field is left unset. Take care that if this is left empty the binding must not match any cluster-scoped resources, which will result in an error.
    property namespace : String?
    # `parameterNotFoundAction` controls the behavior of the binding when the resource exists, and name or selector is valid, but there are no parameters matched by the binding. If the value is set to `Allow`, then no matched parameters will be treated as successful validation by the binding. If set to `Deny`, then no matched parameters will be subject to the `failurePolicy` of the policy.
    # Allowed values are `Allow` or `Deny`
    # Required
    @[JSON::Field(key: "parameterNotFoundAction")]
    @[YAML::Field(key: "parameterNotFoundAction")]
    property parameter_not_found_action : String?
    # selector can be used to match multiple param objects based on their labels. Supply selector: {} to match all resources of the ParamKind.
    # If multiple params are found, they are all evaluated with the policy expressions and the results are ANDed together.
    # One of `name` or `selector` must be set, but `name` and `selector` are mutually exclusive properties. If one is set, the other must be unset.
    property selector : LabelSelector?
  end

  # RuleWithOperations is a tuple of Operations and Resources. It is recommended to make sure that all the tuple expansions are valid.
  struct RuleWithOperations
    include Kubernetes::Serializable

    # APIGroups is the API groups the resources belong to. '*' is all groups. If '*' is present, the length of the slice must be one. Required.
    @[JSON::Field(key: "apiGroups")]
    @[YAML::Field(key: "apiGroups")]
    property api_groups : Array(String)?
    # APIVersions is the API versions the resources belong to. '*' is all versions. If '*' is present, the length of the slice must be one. Required.
    @[JSON::Field(key: "apiVersions")]
    @[YAML::Field(key: "apiVersions")]
    property api_versions : Array(String)?
    # Operations is the operations the admission hook cares about - CREATE, UPDATE, DELETE, CONNECT or * for all of those operations and any future admission operations that are added. If '*' is present, the length of the slice must be one. Required.
    property operations : Array(String)?
    # Resources is a list of resources this rule applies to.
    # For example: 'pods' means pods. 'pods/log' means the log subresource of pods. '*' means all resources, but not subresources. 'pods/*' means all subresources of pods. '*/scale' means all scale subresources. '*/*' means all resources and their subresources.
    # If wildcard is present, the validation rule will ensure resources do not overlap with each other.
    # Depending on the enclosing object, subresources might not be allowed. Required.
    property resources : Array(String)?
    # scope specifies the scope of this rule. Valid values are "Cluster", "Namespaced", and "*" "Cluster" means that only cluster-scoped resources will match this rule. Namespace API objects are cluster-scoped. "Namespaced" means that only namespaced resources will match this rule. "*" means that there are no scope restrictions. Subresources match the scope of their parent resource. Default is "*".
    property scope : String?
  end

  # TypeChecking contains results of type checking the expressions in the ValidatingAdmissionPolicy
  struct TypeChecking
    include Kubernetes::Serializable

    # The type checking warnings for each expression.
    @[JSON::Field(key: "expressionWarnings")]
    @[YAML::Field(key: "expressionWarnings")]
    property expression_warnings : Array(ExpressionWarning)?
  end

  # ValidatingAdmissionPolicy describes the definition of an admission validation policy that accepts or rejects an object without changing it.
  struct ValidatingAdmissionPolicy
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard object metadata; More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata.
    property metadata : ObjectMeta?
    # Specification of the desired behavior of the ValidatingAdmissionPolicy.
    property spec : ValidatingAdmissionPolicySpec?
    # The status of the ValidatingAdmissionPolicy, including warnings that are useful to determine if the policy behaves in the expected way. Populated by the system. Read-only.
    property status : ValidatingAdmissionPolicyStatus?
  end

  # ValidatingAdmissionPolicyBinding binds the ValidatingAdmissionPolicy with paramerized resources. ValidatingAdmissionPolicyBinding and parameter CRDs together define how cluster administrators configure policies for clusters.
  # For a given admission request, each binding will cause its policy to be evaluated N times, where N is 1 for policies/bindings that don't use params, otherwise N is the number of parameters selected by the binding.
  # The CEL expressions of a policy must have a computed CEL cost below the maximum CEL budget. Each evaluation of the policy is given an independent CEL cost budget. Adding/removing policies, bindings, or params can not affect whether a given (policy, binding, param) combination is within its own CEL budget.
  struct ValidatingAdmissionPolicyBinding
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard object metadata; More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata.
    property metadata : ObjectMeta?
    # Specification of the desired behavior of the ValidatingAdmissionPolicyBinding.
    property spec : ValidatingAdmissionPolicyBindingSpec?
  end

  # ValidatingAdmissionPolicyBindingList is a list of ValidatingAdmissionPolicyBinding.
  struct ValidatingAdmissionPolicyBindingList
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # List of PolicyBinding.
    property items : Array(ValidatingAdmissionPolicyBinding)?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard list metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property metadata : ListMeta?
  end

  # ValidatingAdmissionPolicyBindingSpec is the specification of the ValidatingAdmissionPolicyBinding.
  struct ValidatingAdmissionPolicyBindingSpec
    include Kubernetes::Serializable

    # MatchResources declares what resources match this binding and will be validated by it. Note that this is intersected with the policy's matchConstraints, so only requests that are matched by the policy can be selected by this. If this is unset, all resources matched by the policy are validated by this binding When resourceRules is unset, it does not constrain resource matching. If a resource is matched by the other fields of this object, it will be validated. Note that this is differs from ValidatingAdmissionPolicy matchConstraints, where resourceRules are required.
    @[JSON::Field(key: "matchResources")]
    @[YAML::Field(key: "matchResources")]
    property match_resources : MatchResources?
    # paramRef specifies the parameter resource used to configure the admission control policy. It should point to a resource of the type specified in ParamKind of the bound ValidatingAdmissionPolicy. If the policy specifies a ParamKind and the resource referred to by ParamRef does not exist, this binding is considered mis-configured and the FailurePolicy of the ValidatingAdmissionPolicy applied. If the policy does not specify a ParamKind then this field is ignored, and the rules are evaluated without a param.
    @[JSON::Field(key: "paramRef")]
    @[YAML::Field(key: "paramRef")]
    property param_ref : ParamRef?
    # PolicyName references a ValidatingAdmissionPolicy name which the ValidatingAdmissionPolicyBinding binds to. If the referenced resource does not exist, this binding is considered invalid and will be ignored Required.
    @[JSON::Field(key: "policyName")]
    @[YAML::Field(key: "policyName")]
    property policy_name : String?
    # validationActions declares how Validations of the referenced ValidatingAdmissionPolicy are enforced. If a validation evaluates to false it is always enforced according to these actions.
    # Failures defined by the ValidatingAdmissionPolicy's FailurePolicy are enforced according to these actions only if the FailurePolicy is set to Fail, otherwise the failures are ignored. This includes compilation errors, runtime errors and misconfigurations of the policy.
    # validationActions is declared as a set of action values. Order does not matter. validationActions may not contain duplicates of the same action.
    # The supported actions values are:
    # "Deny" specifies that a validation failure results in a denied request.
    # "Warn" specifies that a validation failure is reported to the request client in HTTP Warning headers, with a warning code of 299. Warnings can be sent both for allowed or denied admission responses.
    # "Audit" specifies that a validation failure is included in the published audit event for the request. The audit event will contain a `validation.policy.admission.k8s.io/validation_failure` audit annotation with a value containing the details of the validation failures, formatted as a JSON list of objects, each with the following fields: - message: The validation failure message string - policy: The resource name of the ValidatingAdmissionPolicy - binding: The resource name of the ValidatingAdmissionPolicyBinding - expressionIndex: The index of the failed validations in the ValidatingAdmissionPolicy - validationActions: The enforcement actions enacted for the validation failure Example audit annotation: `"validation.policy.admission.k8s.io/validation_failure": "[{\"message\": \"Invalid value\", {\"policy\": \"policy.example.com\", {\"binding\": \"policybinding.example.com\", {\"expressionIndex\": \"1\", {\"validationActions\": [\"Audit\"]}]"`
    # Clients should expect to handle additional values by ignoring any values not recognized.
    # "Deny" and "Warn" may not be used together since this combination needlessly duplicates the validation failure both in the API response body and the HTTP warning headers.
    # Required.
    @[JSON::Field(key: "validationActions")]
    @[YAML::Field(key: "validationActions")]
    property validation_actions : Array(String)?
  end

  # ValidatingAdmissionPolicyList is a list of ValidatingAdmissionPolicy.
  struct ValidatingAdmissionPolicyList
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # List of ValidatingAdmissionPolicy.
    property items : Array(ValidatingAdmissionPolicy)?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard list metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property metadata : ListMeta?
  end

  # ValidatingAdmissionPolicySpec is the specification of the desired behavior of the AdmissionPolicy.
  struct ValidatingAdmissionPolicySpec
    include Kubernetes::Serializable

    # auditAnnotations contains CEL expressions which are used to produce audit annotations for the audit event of the API request. validations and auditAnnotations may not both be empty; a least one of validations or auditAnnotations is required.
    @[JSON::Field(key: "auditAnnotations")]
    @[YAML::Field(key: "auditAnnotations")]
    property audit_annotations : Array(AuditAnnotation)?
    # failurePolicy defines how to handle failures for the admission policy. Failures can occur from CEL expression parse errors, type check errors, runtime errors and invalid or mis-configured policy definitions or bindings.
    # A policy is invalid if spec.paramKind refers to a non-existent Kind. A binding is invalid if spec.paramRef.name refers to a non-existent resource.
    # failurePolicy does not define how validations that evaluate to false are handled.
    # When failurePolicy is set to Fail, ValidatingAdmissionPolicyBinding validationActions define how failures are enforced.
    # Allowed values are Ignore or Fail. Defaults to Fail.
    @[JSON::Field(key: "failurePolicy")]
    @[YAML::Field(key: "failurePolicy")]
    property failure_policy : String?
    # MatchConditions is a list of conditions that must be met for a request to be validated. Match conditions filter requests that have already been matched by the rules, namespaceSelector, and objectSelector. An empty list of matchConditions matches all requests. There are a maximum of 64 match conditions allowed.
    # If a parameter object is provided, it can be accessed via the `params` handle in the same manner as validation expressions.
    # The exact matching logic is (in order):
    # 1. If ANY matchCondition evaluates to FALSE, the policy is skipped.
    # 2. If ALL matchConditions evaluate to TRUE, the policy is evaluated.
    # 3. If any matchCondition evaluates to an error (but none are FALSE):
    # - If failurePolicy=Fail, reject the request
    # - If failurePolicy=Ignore, the policy is skipped
    @[JSON::Field(key: "matchConditions")]
    @[YAML::Field(key: "matchConditions")]
    property match_conditions : Array(MatchCondition)?
    # MatchConstraints specifies what resources this policy is designed to validate. The AdmissionPolicy cares about a request if it matches _all_ Constraints. However, in order to prevent clusters from being put into an unstable state that cannot be recovered from via the API ValidatingAdmissionPolicy cannot match ValidatingAdmissionPolicy and ValidatingAdmissionPolicyBinding. Required.
    @[JSON::Field(key: "matchConstraints")]
    @[YAML::Field(key: "matchConstraints")]
    property match_constraints : MatchResources?
    # ParamKind specifies the kind of resources used to parameterize this policy. If absent, there are no parameters for this policy and the param CEL variable will not be provided to validation expressions. If ParamKind refers to a non-existent kind, this policy definition is mis-configured and the FailurePolicy is applied. If paramKind is specified but paramRef is unset in ValidatingAdmissionPolicyBinding, the params variable will be null.
    @[JSON::Field(key: "paramKind")]
    @[YAML::Field(key: "paramKind")]
    property param_kind : ParamKind?
    # Validations contain CEL expressions which is used to apply the validation. Validations and AuditAnnotations may not both be empty; a minimum of one Validations or AuditAnnotations is required.
    property validations : Array(Validation)?
    # Variables contain definitions of variables that can be used in composition of other expressions. Each variable is defined as a named CEL expression. The variables defined here will be available under `variables` in other expressions of the policy except MatchConditions because MatchConditions are evaluated before the rest of the policy.
    # The expression of a variable can refer to other variables defined earlier in the list but not those after. Thus, Variables must be sorted by the order of first appearance and acyclic.
    property variables : Array(Variable)?
  end

  # ValidatingAdmissionPolicyStatus represents the status of an admission validation policy.
  struct ValidatingAdmissionPolicyStatus
    include Kubernetes::Serializable

    # The conditions represent the latest available observations of a policy's current state.
    property conditions : Array(Condition)?
    # The generation observed by the controller.
    @[JSON::Field(key: "observedGeneration")]
    @[YAML::Field(key: "observedGeneration")]
    property observed_generation : Int64?
    # The results of type checking for each expression. Presence of this field indicates the completion of the type checking.
    @[JSON::Field(key: "typeChecking")]
    @[YAML::Field(key: "typeChecking")]
    property type_checking : TypeChecking?
  end

  # ValidatingWebhook describes an admission webhook and the resources and operations it applies to.
  struct ValidatingWebhook
    include Kubernetes::Serializable

    # AdmissionReviewVersions is an ordered list of preferred `AdmissionReview` versions the Webhook expects. API server will try to use first version in the list which it supports. If none of the versions specified in this list supported by API server, validation will fail for this object. If a persisted webhook configuration specifies allowed versions and does not include any versions known to the API Server, calls to the webhook will fail and be subject to the failure policy.
    @[JSON::Field(key: "admissionReviewVersions")]
    @[YAML::Field(key: "admissionReviewVersions")]
    property admission_review_versions : Array(String)?
    # ClientConfig defines how to communicate with the hook. Required
    @[JSON::Field(key: "clientConfig")]
    @[YAML::Field(key: "clientConfig")]
    property client_config : WebhookClientConfig?
    # FailurePolicy defines how unrecognized errors from the admission endpoint are handled - allowed values are Ignore or Fail. Defaults to Fail.
    @[JSON::Field(key: "failurePolicy")]
    @[YAML::Field(key: "failurePolicy")]
    property failure_policy : String?
    # MatchConditions is a list of conditions that must be met for a request to be sent to this webhook. Match conditions filter requests that have already been matched by the rules, namespaceSelector, and objectSelector. An empty list of matchConditions matches all requests. There are a maximum of 64 match conditions allowed.
    # The exact matching logic is (in order):
    # 1. If ANY matchCondition evaluates to FALSE, the webhook is skipped.
    # 2. If ALL matchConditions evaluate to TRUE, the webhook is called.
    # 3. If any matchCondition evaluates to an error (but none are FALSE):
    # - If failurePolicy=Fail, reject the request
    # - If failurePolicy=Ignore, the error is ignored and the webhook is skipped
    @[JSON::Field(key: "matchConditions")]
    @[YAML::Field(key: "matchConditions")]
    property match_conditions : Array(MatchCondition)?
    # matchPolicy defines how the "rules" list is used to match incoming requests. Allowed values are "Exact" or "Equivalent".
    # - Exact: match a request only if it exactly matches a specified rule. For example, if deployments can be modified via apps/v1, apps/v1beta1, and extensions/v1beta1, but "rules" only included `apiGroups:["apps"], apiVersions:["v1"], resources: ["deployments"]`, a request to apps/v1beta1 or extensions/v1beta1 would not be sent to the webhook.
    # - Equivalent: match a request if modifies a resource listed in rules, even via another API group or version. For example, if deployments can be modified via apps/v1, apps/v1beta1, and extensions/v1beta1, and "rules" only included `apiGroups:["apps"], apiVersions:["v1"], resources: ["deployments"]`, a request to apps/v1beta1 or extensions/v1beta1 would be converted to apps/v1 and sent to the webhook.
    # Defaults to "Equivalent"
    @[JSON::Field(key: "matchPolicy")]
    @[YAML::Field(key: "matchPolicy")]
    property match_policy : String?
    # The name of the admission webhook. Name should be fully qualified, e.g., imagepolicy.kubernetes.io, where "imagepolicy" is the name of the webhook, and kubernetes.io is the name of the organization. Required.
    property name : String?
    # NamespaceSelector decides whether to run the webhook on an object based on whether the namespace for that object matches the selector. If the object itself is a namespace, the matching is performed on object.metadata.labels. If the object is another cluster scoped resource, it never skips the webhook.
    # For example, to run the webhook on any objects whose namespace is not associated with "runlevel" of "0" or "1";  you will set the selector as follows: "namespaceSelector": {
    # "matchExpressions": [
    # {
    # "key": "runlevel",
    # "operator": "NotIn",
    # "values": [
    # "0",
    # "1"
    # ]
    # }
    # ]
    # }
    # If instead you want to only run the webhook on any objects whose namespace is associated with the "environment" of "prod" or "staging"; you will set the selector as follows: "namespaceSelector": {
    # "matchExpressions": [
    # {
    # "key": "environment",
    # "operator": "In",
    # "values": [
    # "prod",
    # "staging"
    # ]
    # }
    # ]
    # }
    # See https://kubernetes.io/docs/concepts/overview/working-with-objects/labels for more examples of label selectors.
    # Default to the empty LabelSelector, which matches everything.
    @[JSON::Field(key: "namespaceSelector")]
    @[YAML::Field(key: "namespaceSelector")]
    property namespace_selector : LabelSelector?
    # ObjectSelector decides whether to run the webhook based on if the object has matching labels. objectSelector is evaluated against both the oldObject and newObject that would be sent to the webhook, and is considered to match if either object matches the selector. A null object (oldObject in the case of create, or newObject in the case of delete) or an object that cannot have labels (like a DeploymentRollback or a PodProxyOptions object) is not considered to match. Use the object selector only if the webhook is opt-in, because end users may skip the admission webhook by setting the labels. Default to the empty LabelSelector, which matches everything.
    @[JSON::Field(key: "objectSelector")]
    @[YAML::Field(key: "objectSelector")]
    property object_selector : LabelSelector?
    # Rules describes what operations on what resources/subresources the webhook cares about. The webhook cares about an operation if it matches _any_ Rule. However, in order to prevent ValidatingAdmissionWebhooks and MutatingAdmissionWebhooks from putting the cluster in a state which cannot be recovered from without completely disabling the plugin, ValidatingAdmissionWebhooks and MutatingAdmissionWebhooks are never called on admission requests for ValidatingWebhookConfiguration and MutatingWebhookConfiguration objects.
    property rules : Array(RuleWithOperations)?
    # SideEffects states whether this webhook has side effects. Acceptable values are: None, NoneOnDryRun (webhooks created via v1beta1 may also specify Some or Unknown). Webhooks with side effects MUST implement a reconciliation system, since a request may be rejected by a future step in the admission chain and the side effects therefore need to be undone. Requests with the dryRun attribute will be auto-rejected if they match a webhook with sideEffects == Unknown or Some.
    @[JSON::Field(key: "sideEffects")]
    @[YAML::Field(key: "sideEffects")]
    property side_effects : String?
    # TimeoutSeconds specifies the timeout for this webhook. After the timeout passes, the webhook call will be ignored or the API call will fail based on the failure policy. The timeout value must be between 1 and 30 seconds. Default to 10 seconds.
    @[JSON::Field(key: "timeoutSeconds")]
    @[YAML::Field(key: "timeoutSeconds")]
    property timeout_seconds : Int32?
  end

  # ValidatingWebhookConfiguration describes the configuration of and admission webhook that accept or reject and object without changing it.
  struct ValidatingWebhookConfiguration
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard object metadata; More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata.
    property metadata : ObjectMeta?
    # Webhooks is a list of webhooks and the affected resources and operations.
    property webhooks : Array(ValidatingWebhook)?
  end

  # ValidatingWebhookConfigurationList is a list of ValidatingWebhookConfiguration.
  struct ValidatingWebhookConfigurationList
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # List of ValidatingWebhookConfiguration.
    property items : Array(ValidatingWebhookConfiguration)?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard list metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property metadata : ListMeta?
  end

  # Validation specifies the CEL expression which is used to apply the validation.
  struct Validation
    include Kubernetes::Serializable

    # Expression represents the expression which will be evaluated by CEL. ref: https://github.com/google/cel-spec CEL expressions have access to the contents of the API request/response, organized into CEL variables as well as some other useful variables:
    # - 'object' - The object from the incoming request. The value is null for DELETE requests. - 'oldObject' - The existing object. The value is null for CREATE requests. - 'request' - Attributes of the API request([ref](/pkg/apis/admission/types.go#AdmissionRequest)). - 'params' - Parameter resource referred to by the policy binding being evaluated. Only populated if the policy has a ParamKind. - 'namespaceObject' - The namespace object that the incoming object belongs to. The value is null for cluster-scoped resources. - 'variables' - Map of composited variables, from its name to its lazily evaluated value.
    # For example, a variable named 'foo' can be accessed as 'variables.foo'.
    # - 'authorizer' - A CEL Authorizer. May be used to perform authorization checks for the principal (user or service account) of the request.
    # See https://pkg.go.dev/k8s.io/apiserver/pkg/cel/library#Authz
    # - 'authorizer.requestResource' - A CEL ResourceCheck constructed from the 'authorizer' and configured with the
    # request resource.
    # The `apiVersion`, `kind`, `metadata.name` and `metadata.generateName` are always accessible from the root of the object. No other metadata properties are accessible.
    # Only property names of the form `[a-zA-Z_.-/][a-zA-Z0-9_.-/]*` are accessible. Accessible property names are escaped according to the following rules when accessed in the expression: - '__' escapes to '__underscores__' - '.' escapes to '__dot__' - '-' escapes to '__dash__' - '/' escapes to '__slash__' - Property names that exactly match a CEL RESERVED keyword escape to '__{keyword}__'. The keywords are:
    # "true", "false", "null", "in", "as", "break", "const", "continue", "else", "for", "function", "if",
    # "import", "let", "loop", "package", "namespace", "return".
    # Examples:
    # - Expression accessing a property named "namespace": {"Expression": "object.__namespace__ > 0"}
    # - Expression accessing a property named "x-prop": {"Expression": "object.x__dash__prop > 0"}
    # - Expression accessing a property named "redact__d": {"Expression": "object.redact__underscores__d > 0"}
    # Equality on arrays with list type of 'set' or 'map' ignores element order, i.e. [1, 2] == [2, 1]. Concatenation on arrays with x-kubernetes-list-type use the semantics of the list type:
    # - 'set': `X + Y` performs a union where the array positions of all elements in `X` are preserved and
    # non-intersecting elements in `Y` are appended, retaining their partial order.
    # - 'map': `X + Y` performs a merge where the array positions of all keys in `X` are preserved but the values
    # are overwritten by values in `Y` when the key sets of `X` and `Y` intersect. Elements in `Y` with
    # non-intersecting keys are appended, retaining their partial order.
    # Required.
    property expression : String?
    # Message represents the message displayed when validation fails. The message is required if the Expression contains line breaks. The message must not contain line breaks. If unset, the message is "failed rule: {Rule}". e.g. "must be a URL with the host matching spec.host" If the Expression contains line breaks. Message is required. The message must not contain line breaks. If unset, the message is "failed Expression: {Expression}".
    property message : String?
    # messageExpression declares a CEL expression that evaluates to the validation failure message that is returned when this rule fails. Since messageExpression is used as a failure message, it must evaluate to a string. If both message and messageExpression are present on a validation, then messageExpression will be used if validation fails. If messageExpression results in a runtime error, the runtime error is logged, and the validation failure message is produced as if the messageExpression field were unset. If messageExpression evaluates to an empty string, a string with only spaces, or a string that contains line breaks, then the validation failure message will also be produced as if the messageExpression field were unset, and the fact that messageExpression produced an empty string/string with only spaces/string with line breaks will be logged. messageExpression has access to all the same variables as the `expression` except for 'authorizer' and 'authorizer.requestResource'. Example: "object.x must be less than max ("+string(params.max)+")"
    @[JSON::Field(key: "messageExpression")]
    @[YAML::Field(key: "messageExpression")]
    property message_expression : String?
    # Reason represents a machine-readable description of why this validation failed. If this is the first validation in the list to fail, this reason, as well as the corresponding HTTP response code, are used in the HTTP response to the client. The currently supported reasons are: "Unauthorized", "Forbidden", "Invalid", "RequestEntityTooLarge". If not set, StatusReasonInvalid is used in the response to the client.
    property reason : String?
  end

  # Variable is the definition of a variable that is used for composition. A variable is defined as a named expression.
  struct Variable
    include Kubernetes::Serializable

    # Expression is the expression that will be evaluated as the value of the variable. The CEL expression has access to the same identifiers as the CEL expressions in Validation.
    property expression : String?
    # Name is the name of the variable. The name must be a valid CEL identifier and unique among all variables. The variable can be accessed in other expressions through `variables` For example, if name is "foo", the variable will be available as `variables.foo`
    property name : String?
  end

  # ControllerRevision implements an immutable snapshot of state data. Clients are responsible for serializing and deserializing the objects that contain their internal state. Once a ControllerRevision has been successfully created, it can not be updated. The API Server will fail validation of all requests that attempt to mutate the Data field. ControllerRevisions may, however, be deleted. Note that, due to its use by both the DaemonSet and StatefulSet controllers for update and rollback, this object is beta. However, it may be subject to name and representation changes in future releases, and clients should not depend on its stability. It is primarily for internal use by controllers.
  struct ControllerRevision
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Data is the serialized representation of the state.
    property data : Hash(String, JSON::Any)?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ObjectMeta?
    # Revision indicates the revision of the state represented by Data.
    property revision : Int64?
  end

  # ControllerRevisionList is a resource containing a list of ControllerRevision objects.
  struct ControllerRevisionList
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Items is the list of ControllerRevisions
    property items : Array(ControllerRevision)?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ListMeta?
  end

  # DaemonSet represents the configuration of a daemon set.
  struct DaemonSet
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ObjectMeta?
    # The desired behavior of this daemon set. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status
    property spec : DaemonSetSpec?
    # The current status of this daemon set. This data may be out of date by some window of time. Populated by the system. Read-only. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status
    property status : DaemonSetStatus?
  end

  # DaemonSetCondition describes the state of a DaemonSet at a certain point.
  struct DaemonSetCondition
    include Kubernetes::Serializable

    # Last time the condition transitioned from one status to another.
    @[JSON::Field(key: "lastTransitionTime")]
    @[YAML::Field(key: "lastTransitionTime")]
    property last_transition_time : Time?
    # A human readable message indicating details about the transition.
    property message : String?
    # The reason for the condition's last transition.
    property reason : String?
    # Status of the condition, one of True, False, Unknown.
    property status : String?
    # Type of DaemonSet condition.
    property type : String?
  end

  # DaemonSetList is a collection of daemon sets.
  struct DaemonSetList
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # A list of daemon sets.
    property items : Array(DaemonSet)?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard list metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ListMeta?
  end

  # DaemonSetSpec is the specification of a daemon set.
  struct DaemonSetSpec
    include Kubernetes::Serializable

    # The minimum number of seconds for which a newly created DaemonSet pod should be ready without any of its container crashing, for it to be considered available. Defaults to 0 (pod will be considered available as soon as it is ready).
    @[JSON::Field(key: "minReadySeconds")]
    @[YAML::Field(key: "minReadySeconds")]
    property min_ready_seconds : Int32?
    # The number of old history to retain to allow rollback. This is a pointer to distinguish between explicit zero and not specified. Defaults to 10.
    @[JSON::Field(key: "revisionHistoryLimit")]
    @[YAML::Field(key: "revisionHistoryLimit")]
    property revision_history_limit : Int32?
    # A label query over pods that are managed by the daemon set. Must match in order to be controlled. It must match the pod template's labels. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/#label-selectors
    property selector : LabelSelector?
    # An object that describes the pod that will be created. The DaemonSet will create exactly one copy of this pod on every node that matches the template's node selector (or on every node if no node selector is specified). The only allowed template.spec.restartPolicy value is "Always". More info: https://kubernetes.io/docs/concepts/workloads/controllers/replicationcontroller#pod-template
    property template : PodTemplateSpec?
    # An update strategy to replace existing DaemonSet pods with new pods.
    @[JSON::Field(key: "updateStrategy")]
    @[YAML::Field(key: "updateStrategy")]
    property update_strategy : DaemonSetUpdateStrategy?
  end

  # DaemonSetStatus represents the current status of a daemon set.
  struct DaemonSetStatus
    include Kubernetes::Serializable

    # Count of hash collisions for the DaemonSet. The DaemonSet controller uses this field as a collision avoidance mechanism when it needs to create the name for the newest ControllerRevision.
    @[JSON::Field(key: "collisionCount")]
    @[YAML::Field(key: "collisionCount")]
    property collision_count : Int32?
    # Represents the latest available observations of a DaemonSet's current state.
    property conditions : Array(DaemonSetCondition)?
    # The number of nodes that are running at least 1 daemon pod and are supposed to run the daemon pod. More info: https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/
    @[JSON::Field(key: "currentNumberScheduled")]
    @[YAML::Field(key: "currentNumberScheduled")]
    property current_number_scheduled : Int32?
    # The total number of nodes that should be running the daemon pod (including nodes correctly running the daemon pod). More info: https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/
    @[JSON::Field(key: "desiredNumberScheduled")]
    @[YAML::Field(key: "desiredNumberScheduled")]
    property desired_number_scheduled : Int32?
    # The number of nodes that should be running the daemon pod and have one or more of the daemon pod running and available (ready for at least spec.minReadySeconds)
    @[JSON::Field(key: "numberAvailable")]
    @[YAML::Field(key: "numberAvailable")]
    property number_available : Int32?
    # The number of nodes that are running the daemon pod, but are not supposed to run the daemon pod. More info: https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/
    @[JSON::Field(key: "numberMisscheduled")]
    @[YAML::Field(key: "numberMisscheduled")]
    property number_misscheduled : Int32?
    # numberReady is the number of nodes that should be running the daemon pod and have one or more of the daemon pod running with a Ready Condition.
    @[JSON::Field(key: "numberReady")]
    @[YAML::Field(key: "numberReady")]
    property number_ready : Int32?
    # The number of nodes that should be running the daemon pod and have none of the daemon pod running and available (ready for at least spec.minReadySeconds)
    @[JSON::Field(key: "numberUnavailable")]
    @[YAML::Field(key: "numberUnavailable")]
    property number_unavailable : Int32?
    # The most recent generation observed by the daemon set controller.
    @[JSON::Field(key: "observedGeneration")]
    @[YAML::Field(key: "observedGeneration")]
    property observed_generation : Int64?
    # The total number of nodes that are running updated daemon pod
    @[JSON::Field(key: "updatedNumberScheduled")]
    @[YAML::Field(key: "updatedNumberScheduled")]
    property updated_number_scheduled : Int32?
  end

  # DaemonSetUpdateStrategy is a struct used to control the update strategy for a DaemonSet.
  struct DaemonSetUpdateStrategy
    include Kubernetes::Serializable

    # Rolling update config params. Present only if type = "RollingUpdate".
    @[JSON::Field(key: "rollingUpdate")]
    @[YAML::Field(key: "rollingUpdate")]
    property rolling_update : RollingUpdateDaemonSet?
    # Type of daemon set update. Can be "RollingUpdate" or "OnDelete". Default is RollingUpdate.
    property type : String?
  end

  # Deployment enables declarative updates for Pods and ReplicaSets.
  struct Deployment
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ObjectMeta?
    # Specification of the desired behavior of the Deployment.
    property spec : DeploymentSpec?
    # Most recently observed status of the Deployment.
    property status : DeploymentStatus?
  end

  # DeploymentCondition describes the state of a deployment at a certain point.
  struct DeploymentCondition
    include Kubernetes::Serializable

    # Last time the condition transitioned from one status to another.
    @[JSON::Field(key: "lastTransitionTime")]
    @[YAML::Field(key: "lastTransitionTime")]
    property last_transition_time : Time?
    # The last time this condition was updated.
    @[JSON::Field(key: "lastUpdateTime")]
    @[YAML::Field(key: "lastUpdateTime")]
    property last_update_time : Time?
    # A human readable message indicating details about the transition.
    property message : String?
    # The reason for the condition's last transition.
    property reason : String?
    # Status of the condition, one of True, False, Unknown.
    property status : String?
    # Type of deployment condition.
    property type : String?
  end

  # DeploymentList is a list of Deployments.
  struct DeploymentList
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Items is the list of Deployments.
    property items : Array(Deployment)?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard list metadata.
    property metadata : ListMeta?
  end

  # DeploymentSpec is the specification of the desired behavior of the Deployment.
  struct DeploymentSpec
    include Kubernetes::Serializable

    # Minimum number of seconds for which a newly created pod should be ready without any of its container crashing, for it to be considered available. Defaults to 0 (pod will be considered available as soon as it is ready)
    @[JSON::Field(key: "minReadySeconds")]
    @[YAML::Field(key: "minReadySeconds")]
    property min_ready_seconds : Int32?
    # Indicates that the deployment is paused.
    property paused : Bool?
    # The maximum time in seconds for a deployment to make progress before it is considered to be failed. The deployment controller will continue to process failed deployments and a condition with a ProgressDeadlineExceeded reason will be surfaced in the deployment status. Note that progress will not be estimated during the time a deployment is paused. Defaults to 600s.
    @[JSON::Field(key: "progressDeadlineSeconds")]
    @[YAML::Field(key: "progressDeadlineSeconds")]
    property progress_deadline_seconds : Int32?
    # Number of desired pods. This is a pointer to distinguish between explicit zero and not specified. Defaults to 1.
    property replicas : Int32?
    # The number of old ReplicaSets to retain to allow rollback. This is a pointer to distinguish between explicit zero and not specified. Defaults to 10.
    @[JSON::Field(key: "revisionHistoryLimit")]
    @[YAML::Field(key: "revisionHistoryLimit")]
    property revision_history_limit : Int32?
    # Label selector for pods. Existing ReplicaSets whose pods are selected by this will be the ones affected by this deployment. It must match the pod template's labels.
    property selector : LabelSelector?
    # The deployment strategy to use to replace existing pods with new ones.
    property strategy : DeploymentStrategy?
    # Template describes the pods that will be created. The only allowed template.spec.restartPolicy value is "Always".
    property template : PodTemplateSpec?
  end

  # DeploymentStatus is the most recently observed status of the Deployment.
  struct DeploymentStatus
    include Kubernetes::Serializable

    # Total number of available non-terminating pods (ready for at least minReadySeconds) targeted by this deployment.
    @[JSON::Field(key: "availableReplicas")]
    @[YAML::Field(key: "availableReplicas")]
    property available_replicas : Int32?
    # Count of hash collisions for the Deployment. The Deployment controller uses this field as a collision avoidance mechanism when it needs to create the name for the newest ReplicaSet.
    @[JSON::Field(key: "collisionCount")]
    @[YAML::Field(key: "collisionCount")]
    property collision_count : Int32?
    # Represents the latest available observations of a deployment's current state.
    property conditions : Array(DeploymentCondition)?
    # The generation observed by the deployment controller.
    @[JSON::Field(key: "observedGeneration")]
    @[YAML::Field(key: "observedGeneration")]
    property observed_generation : Int64?
    # Total number of non-terminating pods targeted by this Deployment with a Ready Condition.
    @[JSON::Field(key: "readyReplicas")]
    @[YAML::Field(key: "readyReplicas")]
    property ready_replicas : Int32?
    # Total number of non-terminating pods targeted by this deployment (their labels match the selector).
    property replicas : Int32?
    # Total number of terminating pods targeted by this deployment. Terminating pods have a non-null .metadata.deletionTimestamp and have not yet reached the Failed or Succeeded .status.phase.
    # This is an alpha field. Enable DeploymentReplicaSetTerminatingReplicas to be able to use this field.
    @[JSON::Field(key: "terminatingReplicas")]
    @[YAML::Field(key: "terminatingReplicas")]
    property terminating_replicas : Int32?
    # Total number of unavailable pods targeted by this deployment. This is the total number of pods that are still required for the deployment to have 100% available capacity. They may either be pods that are running but not yet available or pods that still have not been created.
    @[JSON::Field(key: "unavailableReplicas")]
    @[YAML::Field(key: "unavailableReplicas")]
    property unavailable_replicas : Int32?
    # Total number of non-terminating pods targeted by this deployment that have the desired template spec.
    @[JSON::Field(key: "updatedReplicas")]
    @[YAML::Field(key: "updatedReplicas")]
    property updated_replicas : Int32?
  end

  # DeploymentStrategy describes how to replace existing pods with new ones.
  struct DeploymentStrategy
    include Kubernetes::Serializable

    # Rolling update config params. Present only if DeploymentStrategyType = RollingUpdate.
    @[JSON::Field(key: "rollingUpdate")]
    @[YAML::Field(key: "rollingUpdate")]
    property rolling_update : RollingUpdateDeployment?
    # Type of deployment. Can be "Recreate" or "RollingUpdate". Default is RollingUpdate.
    property type : String?
  end

  # ReplicaSet ensures that a specified number of pod replicas are running at any given time.
  struct ReplicaSet
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # If the Labels of a ReplicaSet are empty, they are defaulted to be the same as the Pod(s) that the ReplicaSet manages. Standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ObjectMeta?
    # Spec defines the specification of the desired behavior of the ReplicaSet. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status
    property spec : ReplicaSetSpec?
    # Status is the most recently observed status of the ReplicaSet. This data may be out of date by some window of time. Populated by the system. Read-only. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status
    property status : ReplicaSetStatus?
  end

  # ReplicaSetCondition describes the state of a replica set at a certain point.
  struct ReplicaSetCondition
    include Kubernetes::Serializable

    # The last time the condition transitioned from one status to another.
    @[JSON::Field(key: "lastTransitionTime")]
    @[YAML::Field(key: "lastTransitionTime")]
    property last_transition_time : Time?
    # A human readable message indicating details about the transition.
    property message : String?
    # The reason for the condition's last transition.
    property reason : String?
    # Status of the condition, one of True, False, Unknown.
    property status : String?
    # Type of replica set condition.
    property type : String?
  end

  # ReplicaSetList is a collection of ReplicaSets.
  struct ReplicaSetList
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # List of ReplicaSets. More info: https://kubernetes.io/docs/concepts/workloads/controllers/replicaset
    property items : Array(ReplicaSet)?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard list metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property metadata : ListMeta?
  end

  # ReplicaSetSpec is the specification of a ReplicaSet.
  struct ReplicaSetSpec
    include Kubernetes::Serializable

    # Minimum number of seconds for which a newly created pod should be ready without any of its container crashing, for it to be considered available. Defaults to 0 (pod will be considered available as soon as it is ready)
    @[JSON::Field(key: "minReadySeconds")]
    @[YAML::Field(key: "minReadySeconds")]
    property min_ready_seconds : Int32?
    # Replicas is the number of desired pods. This is a pointer to distinguish between explicit zero and unspecified. Defaults to 1. More info: https://kubernetes.io/docs/concepts/workloads/controllers/replicaset
    property replicas : Int32?
    # Selector is a label query over pods that should match the replica count. Label keys and values that must match in order to be controlled by this replica set. It must match the pod template's labels. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/#label-selectors
    property selector : LabelSelector?
    # Template is the object that describes the pod that will be created if insufficient replicas are detected. More info: https://kubernetes.io/docs/concepts/workloads/controllers/replicaset/#pod-template
    property template : PodTemplateSpec?
  end

  # ReplicaSetStatus represents the current status of a ReplicaSet.
  struct ReplicaSetStatus
    include Kubernetes::Serializable

    # The number of available non-terminating pods (ready for at least minReadySeconds) for this replica set.
    @[JSON::Field(key: "availableReplicas")]
    @[YAML::Field(key: "availableReplicas")]
    property available_replicas : Int32?
    # Represents the latest available observations of a replica set's current state.
    property conditions : Array(ReplicaSetCondition)?
    # The number of non-terminating pods that have labels matching the labels of the pod template of the replicaset.
    @[JSON::Field(key: "fullyLabeledReplicas")]
    @[YAML::Field(key: "fullyLabeledReplicas")]
    property fully_labeled_replicas : Int32?
    # ObservedGeneration reflects the generation of the most recently observed ReplicaSet.
    @[JSON::Field(key: "observedGeneration")]
    @[YAML::Field(key: "observedGeneration")]
    property observed_generation : Int64?
    # The number of non-terminating pods targeted by this ReplicaSet with a Ready Condition.
    @[JSON::Field(key: "readyReplicas")]
    @[YAML::Field(key: "readyReplicas")]
    property ready_replicas : Int32?
    # Replicas is the most recently observed number of non-terminating pods. More info: https://kubernetes.io/docs/concepts/workloads/controllers/replicaset
    property replicas : Int32?
    # The number of terminating pods for this replica set. Terminating pods have a non-null .metadata.deletionTimestamp and have not yet reached the Failed or Succeeded .status.phase.
    # This is an alpha field. Enable DeploymentReplicaSetTerminatingReplicas to be able to use this field.
    @[JSON::Field(key: "terminatingReplicas")]
    @[YAML::Field(key: "terminatingReplicas")]
    property terminating_replicas : Int32?
  end

  # Spec to control the desired behavior of daemon set rolling update.
  struct RollingUpdateDaemonSet
    include Kubernetes::Serializable

    # The maximum number of nodes with an existing available DaemonSet pod that can have an updated DaemonSet pod during during an update. Value can be an absolute number (ex: 5) or a percentage of desired pods (ex: 10%). This can not be 0 if MaxUnavailable is 0. Absolute number is calculated from percentage by rounding up to a minimum of 1. Default value is 0. Example: when this is set to 30%, at most 30% of the total number of nodes that should be running the daemon pod (i.e. status.desiredNumberScheduled) can have their a new pod created before the old pod is marked as deleted. The update starts by launching new pods on 30% of nodes. Once an updated pod is available (Ready for at least minReadySeconds) the old DaemonSet pod on that node is marked deleted. If the old pod becomes unavailable for any reason (Ready transitions to false, is evicted, or is drained) an updated pod is immediately created on that node without considering surge limits. Allowing surge implies the possibility that the resources consumed by the daemonset on any given node can double if the readiness check fails, and so resource intensive daemonsets should take into account that they may cause evictions during disruption.
    @[JSON::Field(key: "maxSurge")]
    @[YAML::Field(key: "maxSurge")]
    property max_surge : IntOrString?
    # The maximum number of DaemonSet pods that can be unavailable during the update. Value can be an absolute number (ex: 5) or a percentage of total number of DaemonSet pods at the start of the update (ex: 10%). Absolute number is calculated from percentage by rounding up. This cannot be 0 if MaxSurge is 0 Default value is 1. Example: when this is set to 30%, at most 30% of the total number of nodes that should be running the daemon pod (i.e. status.desiredNumberScheduled) can have their pods stopped for an update at any given time. The update starts by stopping at most 30% of those DaemonSet pods and then brings up new DaemonSet pods in their place. Once the new pods are available, it then proceeds onto other DaemonSet pods, thus ensuring that at least 70% of original number of DaemonSet pods are available at all times during the update.
    @[JSON::Field(key: "maxUnavailable")]
    @[YAML::Field(key: "maxUnavailable")]
    property max_unavailable : IntOrString?
  end

  # Spec to control the desired behavior of rolling update.
  struct RollingUpdateDeployment
    include Kubernetes::Serializable

    # The maximum number of pods that can be scheduled above the desired number of pods. Value can be an absolute number (ex: 5) or a percentage of desired pods (ex: 10%). This can not be 0 if MaxUnavailable is 0. Absolute number is calculated from percentage by rounding up. Defaults to 25%. Example: when this is set to 30%, the new ReplicaSet can be scaled up immediately when the rolling update starts, such that the total number of old and new pods do not exceed 130% of desired pods. Once old pods have been killed, new ReplicaSet can be scaled up further, ensuring that total number of pods running at any time during the update is at most 130% of desired pods.
    @[JSON::Field(key: "maxSurge")]
    @[YAML::Field(key: "maxSurge")]
    property max_surge : IntOrString?
    # The maximum number of pods that can be unavailable during the update. Value can be an absolute number (ex: 5) or a percentage of desired pods (ex: 10%). Absolute number is calculated from percentage by rounding down. This can not be 0 if MaxSurge is 0. Defaults to 25%. Example: when this is set to 30%, the old ReplicaSet can be scaled down to 70% of desired pods immediately when the rolling update starts. Once new pods are ready, old ReplicaSet can be scaled down further, followed by scaling up the new ReplicaSet, ensuring that the total number of pods available at all times during the update is at least 70% of desired pods.
    @[JSON::Field(key: "maxUnavailable")]
    @[YAML::Field(key: "maxUnavailable")]
    property max_unavailable : IntOrString?
  end

  # RollingUpdateStatefulSetStrategy is used to communicate parameter for RollingUpdateStatefulSetStrategyType.
  struct RollingUpdateStatefulSetStrategy
    include Kubernetes::Serializable

    # The maximum number of pods that can be unavailable during the update. Value can be an absolute number (ex: 5) or a percentage of desired pods (ex: 10%). Absolute number is calculated from percentage by rounding up. This can not be 0. Defaults to 1. This field is alpha-level and is only honored by servers that enable the MaxUnavailableStatefulSet feature. The field applies to all pods in the range 0 to Replicas-1. That means if there is any unavailable pod in the range 0 to Replicas-1, it will be counted towards MaxUnavailable.
    @[JSON::Field(key: "maxUnavailable")]
    @[YAML::Field(key: "maxUnavailable")]
    property max_unavailable : IntOrString?
    # Partition indicates the ordinal at which the StatefulSet should be partitioned for updates. During a rolling update, all pods from ordinal Replicas-1 to Partition are updated. All pods from ordinal Partition-1 to 0 remain untouched. This is helpful in being able to do a canary based deployment. The default value is 0.
    property partition : Int32?
  end

  # StatefulSet represents a set of pods with consistent identities. Identities are defined as:
  # - Network: A single stable DNS and hostname.
  # - Storage: As many VolumeClaims as requested.
  # The StatefulSet guarantees that a given network identity will always map to the same storage identity.
  struct StatefulSet
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ObjectMeta?
    # Spec defines the desired identities of pods in this set.
    property spec : StatefulSetSpec?
    # Status is the current status of Pods in this StatefulSet. This data may be out of date by some window of time.
    property status : StatefulSetStatus?
  end

  # StatefulSetCondition describes the state of a statefulset at a certain point.
  struct StatefulSetCondition
    include Kubernetes::Serializable

    # Last time the condition transitioned from one status to another.
    @[JSON::Field(key: "lastTransitionTime")]
    @[YAML::Field(key: "lastTransitionTime")]
    property last_transition_time : Time?
    # A human readable message indicating details about the transition.
    property message : String?
    # The reason for the condition's last transition.
    property reason : String?
    # Status of the condition, one of True, False, Unknown.
    property status : String?
    # Type of statefulset condition.
    property type : String?
  end

  # StatefulSetList is a collection of StatefulSets.
  struct StatefulSetList
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Items is the list of stateful sets.
    property items : Array(StatefulSet)?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard list's metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ListMeta?
  end

  # StatefulSetOrdinals describes the policy used for replica ordinal assignment in this StatefulSet.
  struct StatefulSetOrdinals
    include Kubernetes::Serializable

    # start is the number representing the first replica's index. It may be used to number replicas from an alternate index (eg: 1-indexed) over the default 0-indexed names, or to orchestrate progressive movement of replicas from one StatefulSet to another. If set, replica indices will be in the range:
    # [.spec.ordinals.start, .spec.ordinals.start + .spec.replicas).
    # If unset, defaults to 0. Replica indices will be in the range:
    # [0, .spec.replicas).
    property start : Int32?
  end

  # StatefulSetPersistentVolumeClaimRetentionPolicy describes the policy used for PVCs created from the StatefulSet VolumeClaimTemplates.
  struct StatefulSetPersistentVolumeClaimRetentionPolicy
    include Kubernetes::Serializable

    # WhenDeleted specifies what happens to PVCs created from StatefulSet VolumeClaimTemplates when the StatefulSet is deleted. The default policy of `Retain` causes PVCs to not be affected by StatefulSet deletion. The `Delete` policy causes those PVCs to be deleted.
    @[JSON::Field(key: "whenDeleted")]
    @[YAML::Field(key: "whenDeleted")]
    property when_deleted : String?
    # WhenScaled specifies what happens to PVCs created from StatefulSet VolumeClaimTemplates when the StatefulSet is scaled down. The default policy of `Retain` causes PVCs to not be affected by a scaledown. The `Delete` policy causes the associated PVCs for any excess pods above the replica count to be deleted.
    @[JSON::Field(key: "whenScaled")]
    @[YAML::Field(key: "whenScaled")]
    property when_scaled : String?
  end

  # A StatefulSetSpec is the specification of a StatefulSet.
  struct StatefulSetSpec
    include Kubernetes::Serializable

    # Minimum number of seconds for which a newly created pod should be ready without any of its container crashing for it to be considered available. Defaults to 0 (pod will be considered available as soon as it is ready)
    @[JSON::Field(key: "minReadySeconds")]
    @[YAML::Field(key: "minReadySeconds")]
    property min_ready_seconds : Int32?
    # ordinals controls the numbering of replica indices in a StatefulSet. The default ordinals behavior assigns a "0" index to the first replica and increments the index by one for each additional replica requested.
    property ordinals : StatefulSetOrdinals?
    # persistentVolumeClaimRetentionPolicy describes the lifecycle of persistent volume claims created from volumeClaimTemplates. By default, all persistent volume claims are created as needed and retained until manually deleted. This policy allows the lifecycle to be altered, for example by deleting persistent volume claims when their stateful set is deleted, or when their pod is scaled down.
    @[JSON::Field(key: "persistentVolumeClaimRetentionPolicy")]
    @[YAML::Field(key: "persistentVolumeClaimRetentionPolicy")]
    property persistent_volume_claim_retention_policy : StatefulSetPersistentVolumeClaimRetentionPolicy?
    # podManagementPolicy controls how pods are created during initial scale up, when replacing pods on nodes, or when scaling down. The default policy is `OrderedReady`, where pods are created in increasing order (pod-0, then pod-1, etc) and the controller will wait until each pod is ready before continuing. When scaling down, the pods are removed in the opposite order. The alternative policy is `Parallel` which will create pods in parallel to match the desired scale without waiting, and on scale down will delete all pods at once.
    @[JSON::Field(key: "podManagementPolicy")]
    @[YAML::Field(key: "podManagementPolicy")]
    property pod_management_policy : String?
    # replicas is the desired number of replicas of the given Template. These are replicas in the sense that they are instantiations of the same Template, but individual replicas also have a consistent identity. If unspecified, defaults to 1.
    property replicas : Int32?
    # revisionHistoryLimit is the maximum number of revisions that will be maintained in the StatefulSet's revision history. The revision history consists of all revisions not represented by a currently applied StatefulSetSpec version. The default value is 10.
    @[JSON::Field(key: "revisionHistoryLimit")]
    @[YAML::Field(key: "revisionHistoryLimit")]
    property revision_history_limit : Int32?
    # selector is a label query over pods that should match the replica count. It must match the pod template's labels. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/#label-selectors
    property selector : LabelSelector?
    # serviceName is the name of the service that governs this StatefulSet. This service must exist before the StatefulSet, and is responsible for the network identity of the set. Pods get DNS/hostnames that follow the pattern: pod-specific-string.serviceName.default.svc.cluster.local where "pod-specific-string" is managed by the StatefulSet controller.
    @[JSON::Field(key: "serviceName")]
    @[YAML::Field(key: "serviceName")]
    property service_name : String?
    # template is the object that describes the pod that will be created if insufficient replicas are detected. Each pod stamped out by the StatefulSet will fulfill this Template, but have a unique identity from the rest of the StatefulSet. Each pod will be named with the format <statefulsetname>-<podindex>. For example, a pod in a StatefulSet named "web" with index number "3" would be named "web-3". The only allowed template.spec.restartPolicy value is "Always".
    property template : PodTemplateSpec?
    # updateStrategy indicates the StatefulSetUpdateStrategy that will be employed to update Pods in the StatefulSet when a revision is made to Template.
    @[JSON::Field(key: "updateStrategy")]
    @[YAML::Field(key: "updateStrategy")]
    property update_strategy : StatefulSetUpdateStrategy?
    # volumeClaimTemplates is a list of claims that pods are allowed to reference. The StatefulSet controller is responsible for mapping network identities to claims in a way that maintains the identity of a pod. Every claim in this list must have at least one matching (by name) volumeMount in one container in the template. A claim in this list takes precedence over any volumes in the template, with the same name.
    @[JSON::Field(key: "volumeClaimTemplates")]
    @[YAML::Field(key: "volumeClaimTemplates")]
    property volume_claim_templates : Array(PersistentVolumeClaim)?
  end

  # StatefulSetStatus represents the current state of a StatefulSet.
  struct StatefulSetStatus
    include Kubernetes::Serializable

    # Total number of available pods (ready for at least minReadySeconds) targeted by this statefulset.
    @[JSON::Field(key: "availableReplicas")]
    @[YAML::Field(key: "availableReplicas")]
    property available_replicas : Int32?
    # collisionCount is the count of hash collisions for the StatefulSet. The StatefulSet controller uses this field as a collision avoidance mechanism when it needs to create the name for the newest ControllerRevision.
    @[JSON::Field(key: "collisionCount")]
    @[YAML::Field(key: "collisionCount")]
    property collision_count : Int32?
    # Represents the latest available observations of a statefulset's current state.
    property conditions : Array(StatefulSetCondition)?
    # currentReplicas is the number of Pods created by the StatefulSet controller from the StatefulSet version indicated by currentRevision.
    @[JSON::Field(key: "currentReplicas")]
    @[YAML::Field(key: "currentReplicas")]
    property current_replicas : Int32?
    # currentRevision, if not empty, indicates the version of the StatefulSet used to generate Pods in the sequence [0,currentReplicas).
    @[JSON::Field(key: "currentRevision")]
    @[YAML::Field(key: "currentRevision")]
    property current_revision : String?
    # observedGeneration is the most recent generation observed for this StatefulSet. It corresponds to the StatefulSet's generation, which is updated on mutation by the API Server.
    @[JSON::Field(key: "observedGeneration")]
    @[YAML::Field(key: "observedGeneration")]
    property observed_generation : Int64?
    # readyReplicas is the number of pods created for this StatefulSet with a Ready Condition.
    @[JSON::Field(key: "readyReplicas")]
    @[YAML::Field(key: "readyReplicas")]
    property ready_replicas : Int32?
    # replicas is the number of Pods created by the StatefulSet controller.
    property replicas : Int32?
    # updateRevision, if not empty, indicates the version of the StatefulSet used to generate Pods in the sequence [replicas-updatedReplicas,replicas)
    @[JSON::Field(key: "updateRevision")]
    @[YAML::Field(key: "updateRevision")]
    property update_revision : String?
    # updatedReplicas is the number of Pods created by the StatefulSet controller from the StatefulSet version indicated by updateRevision.
    @[JSON::Field(key: "updatedReplicas")]
    @[YAML::Field(key: "updatedReplicas")]
    property updated_replicas : Int32?
  end

  # StatefulSetUpdateStrategy indicates the strategy that the StatefulSet controller will use to perform updates. It includes any additional parameters necessary to perform the update for the indicated strategy.
  struct StatefulSetUpdateStrategy
    include Kubernetes::Serializable

    # RollingUpdate is used to communicate parameters when Type is RollingUpdateStatefulSetStrategyType.
    @[JSON::Field(key: "rollingUpdate")]
    @[YAML::Field(key: "rollingUpdate")]
    property rolling_update : RollingUpdateStatefulSetStrategy?
    # Type indicates the type of the StatefulSetUpdateStrategy. Default is RollingUpdate.
    property type : String?
  end

  # BoundObjectReference is a reference to an object that a token is bound to.
  struct BoundObjectReference
    include Kubernetes::Serializable

    # API version of the referent.
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Kind of the referent. Valid kinds are 'Pod' and 'Secret'.
    property kind : String?
    # Name of the referent.
    property name : String?
    # UID of the referent.
    property uid : String?
  end

  # SelfSubjectReview contains the user information that the kube-apiserver has about the user making this request. When using impersonation, users will receive the user info of the user being impersonated.  If impersonation or request header authentication is used, any extra keys will have their case ignored and returned as lowercase.
  struct SelfSubjectReview
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ObjectMeta?
    # Status is filled in by the server with the user attributes.
    property status : SelfSubjectReviewStatus?
  end

  # SelfSubjectReviewStatus is filled by the kube-apiserver and sent back to a user.
  struct SelfSubjectReviewStatus
    include Kubernetes::Serializable

    # User attributes of the user making this request.
    @[JSON::Field(key: "userInfo")]
    @[YAML::Field(key: "userInfo")]
    property user_info : UserInfo?
  end

  # TokenRequestSpec contains client provided parameters of a token request.
  struct TokenRequestSpec
    include Kubernetes::Serializable

    # Audiences are the intendend audiences of the token. A recipient of a token must identify themself with an identifier in the list of audiences of the token, and otherwise should reject the token. A token issued for multiple audiences may be used to authenticate against any of the audiences listed but implies a high degree of trust between the target audiences.
    property audiences : Array(String)?
    # BoundObjectRef is a reference to an object that the token will be bound to. The token will only be valid for as long as the bound object exists. NOTE: The API server's TokenReview endpoint will validate the BoundObjectRef, but other audiences may not. Keep ExpirationSeconds small if you want prompt revocation.
    @[JSON::Field(key: "boundObjectRef")]
    @[YAML::Field(key: "boundObjectRef")]
    property bound_object_ref : BoundObjectReference?
    # ExpirationSeconds is the requested duration of validity of the request. The token issuer may return a token with a different validity duration so a client needs to check the 'expiration' field in a response.
    @[JSON::Field(key: "expirationSeconds")]
    @[YAML::Field(key: "expirationSeconds")]
    property expiration_seconds : Int64?
  end

  # TokenRequestStatus is the result of a token request.
  struct TokenRequestStatus
    include Kubernetes::Serializable

    # ExpirationTimestamp is the time of expiration of the returned token.
    @[JSON::Field(key: "expirationTimestamp")]
    @[YAML::Field(key: "expirationTimestamp")]
    property expiration_timestamp : Time?
    # Token is the opaque bearer token.
    property token : String?
  end

  # TokenReview attempts to authenticate a token to a known user. Note: TokenReview requests may be cached by the webhook token authenticator plugin in the kube-apiserver.
  struct TokenReview
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ObjectMeta?
    # Spec holds information about the request being evaluated
    property spec : TokenReviewSpec?
    # Status is filled in by the server and indicates whether the request can be authenticated.
    property status : TokenReviewStatus?
  end

  # TokenReviewSpec is a description of the token authentication request.
  struct TokenReviewSpec
    include Kubernetes::Serializable

    # Audiences is a list of the identifiers that the resource server presented with the token identifies as. Audience-aware token authenticators will verify that the token was intended for at least one of the audiences in this list. If no audiences are provided, the audience will default to the audience of the Kubernetes apiserver.
    property audiences : Array(String)?
    # Token is the opaque bearer token.
    property token : String?
  end

  # TokenReviewStatus is the result of the token authentication request.
  struct TokenReviewStatus
    include Kubernetes::Serializable

    # Audiences are audience identifiers chosen by the authenticator that are compatible with both the TokenReview and token. An identifier is any identifier in the intersection of the TokenReviewSpec audiences and the token's audiences. A client of the TokenReview API that sets the spec.audiences field should validate that a compatible audience identifier is returned in the status.audiences field to ensure that the TokenReview server is audience aware. If a TokenReview returns an empty status.audience field where status.authenticated is "true", the token is valid against the audience of the Kubernetes API server.
    property audiences : Array(String)?
    # Authenticated indicates that the token was associated with a known user.
    property authenticated : Bool?
    # Error indicates that the token couldn't be checked
    property error : String?
    # User is the UserInfo associated with the provided token.
    property user : UserInfo?
  end

  # UserInfo holds the information about the user needed to implement the user.Info interface.
  struct UserInfo
    include Kubernetes::Serializable

    # Any additional information provided by the authenticator.
    property extra : Hash(String, Array(String))?
    # The names of groups this user is a part of.
    property groups : Array(String)?
    # A unique value that identifies this user across time. If this user is deleted and another user by the same name is added, they will have different UIDs.
    property uid : String?
    # The name that uniquely identifies this user among all active users.
    property username : String?
  end

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

  # CrossVersionObjectReference contains enough information to let you identify the referred resource.
  struct CrossVersionObjectReference
    include Kubernetes::Serializable

    # apiVersion is the API version of the referent
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # kind is the kind of the referent; More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # name is the name of the referent; More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
    property name : String?
  end

  # configuration of a horizontal pod autoscaler.
  struct HorizontalPodAutoscaler
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard object metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ObjectMeta?
    # spec defines the behaviour of autoscaler. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status.
    property spec : HorizontalPodAutoscalerSpec?
    # status is the current information about the autoscaler.
    property status : HorizontalPodAutoscalerStatus?
  end

  # list of horizontal pod autoscaler objects.
  struct HorizontalPodAutoscalerList
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # items is the list of horizontal pod autoscaler objects.
    property items : Array(HorizontalPodAutoscaler)?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard list metadata.
    property metadata : ListMeta?
  end

  # specification of a horizontal pod autoscaler.
  struct HorizontalPodAutoscalerSpec
    include Kubernetes::Serializable

    # maxReplicas is the upper limit for the number of pods that can be set by the autoscaler; cannot be smaller than MinReplicas.
    @[JSON::Field(key: "maxReplicas")]
    @[YAML::Field(key: "maxReplicas")]
    property max_replicas : Int32?
    # minReplicas is the lower limit for the number of replicas to which the autoscaler can scale down.  It defaults to 1 pod.  minReplicas is allowed to be 0 if the alpha feature gate HPAScaleToZero is enabled and at least one Object or External metric is configured.  Scaling is active as long as at least one metric value is available.
    @[JSON::Field(key: "minReplicas")]
    @[YAML::Field(key: "minReplicas")]
    property min_replicas : Int32?
    # reference to scaled resource; horizontal pod autoscaler will learn the current resource consumption and will set the desired number of pods by using its Scale subresource.
    @[JSON::Field(key: "scaleTargetRef")]
    @[YAML::Field(key: "scaleTargetRef")]
    property scale_target_ref : CrossVersionObjectReference?
    # targetCPUUtilizationPercentage is the target average CPU utilization (represented as a percentage of requested CPU) over all the pods; if not specified the default autoscaling policy will be used.
    @[JSON::Field(key: "targetCPUUtilizationPercentage")]
    @[YAML::Field(key: "targetCPUUtilizationPercentage")]
    property target_cpu_utilization_percentage : Int32?
  end

  # current status of a horizontal pod autoscaler
  struct HorizontalPodAutoscalerStatus
    include Kubernetes::Serializable

    # currentCPUUtilizationPercentage is the current average CPU utilization over all pods, represented as a percentage of requested CPU, e.g. 70 means that an average pod is using now 70% of its requested CPU.
    @[JSON::Field(key: "currentCPUUtilizationPercentage")]
    @[YAML::Field(key: "currentCPUUtilizationPercentage")]
    property current_cpu_utilization_percentage : Int32?
    # currentReplicas is the current number of replicas of pods managed by this autoscaler.
    @[JSON::Field(key: "currentReplicas")]
    @[YAML::Field(key: "currentReplicas")]
    property current_replicas : Int32?
    # desiredReplicas is the  desired number of replicas of pods managed by this autoscaler.
    @[JSON::Field(key: "desiredReplicas")]
    @[YAML::Field(key: "desiredReplicas")]
    property desired_replicas : Int32?
    # lastScaleTime is the last time the HorizontalPodAutoscaler scaled the number of pods; used by the autoscaler to control how often the number of pods is changed.
    @[JSON::Field(key: "lastScaleTime")]
    @[YAML::Field(key: "lastScaleTime")]
    property last_scale_time : Time?
    # observedGeneration is the most recent generation observed by this autoscaler.
    @[JSON::Field(key: "observedGeneration")]
    @[YAML::Field(key: "observedGeneration")]
    property observed_generation : Int64?
  end

  # Scale represents a scaling request for a resource.
  struct Scale
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard object metadata; More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata.
    property metadata : ObjectMeta?
    # spec defines the behavior of the scale. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status.
    property spec : ScaleSpec?
    # status is the current status of the scale. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status. Read-only.
    property status : ScaleStatus?
  end

  # ScaleSpec describes the attributes of a scale subresource.
  struct ScaleSpec
    include Kubernetes::Serializable

    # replicas is the desired number of instances for the scaled object.
    property replicas : Int32?
  end

  # ScaleStatus represents the current status of a scale subresource.
  struct ScaleStatus
    include Kubernetes::Serializable

    # replicas is the actual number of observed instances of the scaled object.
    property replicas : Int32?
    # selector is the label query over pods that should match the replicas count. This is same as the label selector but in the string format to avoid introspection by clients. The string will be in the same format as the query-param syntax. More info about label selectors: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/
    property selector : String?
  end

  # CronJob represents the configuration of a single cron job.
  struct CronJob
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ObjectMeta?
    # Specification of the desired behavior of a cron job, including the schedule. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status
    property spec : CronJobSpec?
    # Current status of a cron job. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status
    property status : CronJobStatus?
  end

  # CronJobList is a collection of cron jobs.
  struct CronJobList
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # items is the list of CronJobs.
    property items : Array(CronJob)?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard list metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ListMeta?
  end

  # CronJobSpec describes how the job execution will look like and when it will actually run.
  struct CronJobSpec
    include Kubernetes::Serializable

    # Specifies how to treat concurrent executions of a Job. Valid values are:
    # - "Allow" (default): allows CronJobs to run concurrently; - "Forbid": forbids concurrent runs, skipping next run if previous run hasn't finished yet; - "Replace": cancels currently running job and replaces it with a new one
    @[JSON::Field(key: "concurrencyPolicy")]
    @[YAML::Field(key: "concurrencyPolicy")]
    property concurrency_policy : String?
    # The number of failed finished jobs to retain. Value must be non-negative integer. Defaults to 1.
    @[JSON::Field(key: "failedJobsHistoryLimit")]
    @[YAML::Field(key: "failedJobsHistoryLimit")]
    property failed_jobs_history_limit : Int32?
    # Specifies the job that will be created when executing a CronJob.
    @[JSON::Field(key: "jobTemplate")]
    @[YAML::Field(key: "jobTemplate")]
    property job_template : JobTemplateSpec?
    # The schedule in Cron format, see https://en.wikipedia.org/wiki/Cron.
    property schedule : String?
    # Optional deadline in seconds for starting the job if it misses scheduled time for any reason.  Missed jobs executions will be counted as failed ones.
    @[JSON::Field(key: "startingDeadlineSeconds")]
    @[YAML::Field(key: "startingDeadlineSeconds")]
    property starting_deadline_seconds : Int64?
    # The number of successful finished jobs to retain. Value must be non-negative integer. Defaults to 3.
    @[JSON::Field(key: "successfulJobsHistoryLimit")]
    @[YAML::Field(key: "successfulJobsHistoryLimit")]
    property successful_jobs_history_limit : Int32?
    # This flag tells the controller to suspend subsequent executions, it does not apply to already started executions.  Defaults to false.
    property suspend : Bool?
    # The time zone name for the given schedule, see https://en.wikipedia.org/wiki/List_of_tz_database_time_zones. If not specified, this will default to the time zone of the kube-controller-manager process. The set of valid time zone names and the time zone offset is loaded from the system-wide time zone database by the API server during CronJob validation and the controller manager during execution. If no system-wide time zone database can be found a bundled version of the database is used instead. If the time zone name becomes invalid during the lifetime of a CronJob or due to a change in host configuration, the controller will stop creating new new Jobs and will create a system event with the reason UnknownTimeZone. More information can be found in https://kubernetes.io/docs/concepts/workloads/controllers/cron-jobs/#time-zones
    @[JSON::Field(key: "timeZone")]
    @[YAML::Field(key: "timeZone")]
    property time_zone : String?
  end

  # CronJobStatus represents the current state of a cron job.
  struct CronJobStatus
    include Kubernetes::Serializable

    # A list of pointers to currently running jobs.
    property active : Array(ObjectReference)?
    # Information when was the last time the job was successfully scheduled.
    @[JSON::Field(key: "lastScheduleTime")]
    @[YAML::Field(key: "lastScheduleTime")]
    property last_schedule_time : Time?
    # Information when was the last time the job successfully completed.
    @[JSON::Field(key: "lastSuccessfulTime")]
    @[YAML::Field(key: "lastSuccessfulTime")]
    property last_successful_time : Time?
  end

  # Job represents the configuration of a single job.
  struct Job
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ObjectMeta?
    # Specification of the desired behavior of a job. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status
    property spec : JobSpec?
    # Current status of a job. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status
    property status : JobStatus?
  end

  # JobCondition describes current state of a job.
  struct JobCondition
    include Kubernetes::Serializable

    # Last time the condition was checked.
    @[JSON::Field(key: "lastProbeTime")]
    @[YAML::Field(key: "lastProbeTime")]
    property last_probe_time : Time?
    # Last time the condition transit from one status to another.
    @[JSON::Field(key: "lastTransitionTime")]
    @[YAML::Field(key: "lastTransitionTime")]
    property last_transition_time : Time?
    # Human readable message indicating details about last transition.
    property message : String?
    # (brief) reason for the condition's last transition.
    property reason : String?
    # Status of the condition, one of True, False, Unknown.
    property status : String?
    # Type of job condition, Complete or Failed.
    property type : String?
  end

  # JobList is a collection of jobs.
  struct JobList
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # items is the list of Jobs.
    property items : Array(Job)?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard list metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ListMeta?
  end

  # JobSpec describes how the job execution will look like.
  struct JobSpec
    include Kubernetes::Serializable

    # Specifies the duration in seconds relative to the startTime that the job may be continuously active before the system tries to terminate it; value must be positive integer. If a Job is suspended (at creation or through an update), this timer will effectively be stopped and reset when the Job is resumed again.
    @[JSON::Field(key: "activeDeadlineSeconds")]
    @[YAML::Field(key: "activeDeadlineSeconds")]
    property active_deadline_seconds : Int64?
    # Specifies the number of retries before marking this job failed. Defaults to 6, unless backoffLimitPerIndex (only Indexed Job) is specified. When backoffLimitPerIndex is specified, backoffLimit defaults to 2147483647.
    @[JSON::Field(key: "backoffLimit")]
    @[YAML::Field(key: "backoffLimit")]
    property backoff_limit : Int32?
    # Specifies the limit for the number of retries within an index before marking this index as failed. When enabled the number of failures per index is kept in the pod's batch.kubernetes.io/job-index-failure-count annotation. It can only be set when Job's completionMode=Indexed, and the Pod's restart policy is Never. The field is immutable.
    @[JSON::Field(key: "backoffLimitPerIndex")]
    @[YAML::Field(key: "backoffLimitPerIndex")]
    property backoff_limit_per_index : Int32?
    # completionMode specifies how Pod completions are tracked. It can be `NonIndexed` (default) or `Indexed`.
    # `NonIndexed` means that the Job is considered complete when there have been .spec.completions successfully completed Pods. Each Pod completion is homologous to each other.
    # `Indexed` means that the Pods of a Job get an associated completion index from 0 to (.spec.completions - 1), available in the annotation batch.kubernetes.io/job-completion-index. The Job is considered complete when there is one successfully completed Pod for each index. When value is `Indexed`, .spec.completions must be specified and `.spec.parallelism` must be less than or equal to 10^5. In addition, The Pod name takes the form `$(job-name)-$(index)-$(random-string)`, the Pod hostname takes the form `$(job-name)-$(index)`.
    # More completion modes can be added in the future. If the Job controller observes a mode that it doesn't recognize, which is possible during upgrades due to version skew, the controller skips updates for the Job.
    @[JSON::Field(key: "completionMode")]
    @[YAML::Field(key: "completionMode")]
    property completion_mode : String?
    # Specifies the desired number of successfully finished pods the job should be run with.  Setting to null means that the success of any pod signals the success of all pods, and allows parallelism to have any positive value.  Setting to 1 means that parallelism is limited to 1 and the success of that pod signals the success of the job. More info: https://kubernetes.io/docs/concepts/workloads/controllers/jobs-run-to-completion/
    property completions : Int32?
    # ManagedBy field indicates the controller that manages a Job. The k8s Job controller reconciles jobs which don't have this field at all or the field value is the reserved string `kubernetes.io/job-controller`, but skips reconciling Jobs with a custom value for this field. The value must be a valid domain-prefixed path (e.g. acme.io/foo) - all characters before the first "/" must be a valid subdomain as defined by RFC 1123. All characters trailing the first "/" must be valid HTTP Path characters as defined by RFC 3986. The value cannot exceed 63 characters. This field is immutable.
    # This field is beta-level. The job controller accepts setting the field when the feature gate JobManagedBy is enabled (enabled by default).
    @[JSON::Field(key: "managedBy")]
    @[YAML::Field(key: "managedBy")]
    property managed_by : String?
    # manualSelector controls generation of pod labels and pod selectors. Leave `manualSelector` unset unless you are certain what you are doing. When false or unset, the system pick labels unique to this job and appends those labels to the pod template.  When true, the user is responsible for picking unique labels and specifying the selector.  Failure to pick a unique label may cause this and other jobs to not function correctly.  However, You may see `manualSelector=true` in jobs that were created with the old `extensions/v1beta1` API. More info: https://kubernetes.io/docs/concepts/workloads/controllers/jobs-run-to-completion/#specifying-your-own-pod-selector
    @[JSON::Field(key: "manualSelector")]
    @[YAML::Field(key: "manualSelector")]
    property manual_selector : Bool?
    # Specifies the maximal number of failed indexes before marking the Job as failed, when backoffLimitPerIndex is set. Once the number of failed indexes exceeds this number the entire Job is marked as Failed and its execution is terminated. When left as null the job continues execution of all of its indexes and is marked with the `Complete` Job condition. It can only be specified when backoffLimitPerIndex is set. It can be null or up to completions. It is required and must be less than or equal to 10^4 when is completions greater than 10^5.
    @[JSON::Field(key: "maxFailedIndexes")]
    @[YAML::Field(key: "maxFailedIndexes")]
    property max_failed_indexes : Int32?
    # Specifies the maximum desired number of pods the job should run at any given time. The actual number of pods running in steady state will be less than this number when ((.spec.completions - .status.successful) < .spec.parallelism), i.e. when the work left to do is less than max parallelism. More info: https://kubernetes.io/docs/concepts/workloads/controllers/jobs-run-to-completion/
    property parallelism : Int32?
    # Specifies the policy of handling failed pods. In particular, it allows to specify the set of actions and conditions which need to be satisfied to take the associated action. If empty, the default behaviour applies - the counter of failed pods, represented by the jobs's .status.failed field, is incremented and it is checked against the backoffLimit. This field cannot be used in combination with restartPolicy=OnFailure.
    @[JSON::Field(key: "podFailurePolicy")]
    @[YAML::Field(key: "podFailurePolicy")]
    property pod_failure_policy : PodFailurePolicy?
    # podReplacementPolicy specifies when to create replacement Pods. Possible values are: - TerminatingOrFailed means that we recreate pods
    # when they are terminating (has a metadata.deletionTimestamp) or failed.
    # - Failed means to wait until a previously created Pod is fully terminated (has phase
    # Failed or Succeeded) before creating a replacement Pod.
    # When using podFailurePolicy, Failed is the the only allowed value. TerminatingOrFailed and Failed are allowed values when podFailurePolicy is not in use.
    @[JSON::Field(key: "podReplacementPolicy")]
    @[YAML::Field(key: "podReplacementPolicy")]
    property pod_replacement_policy : String?
    # A label query over pods that should match the pod count. Normally, the system sets this field for you. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/#label-selectors
    property selector : LabelSelector?
    # successPolicy specifies the policy when the Job can be declared as succeeded. If empty, the default behavior applies - the Job is declared as succeeded only when the number of succeeded pods equals to the completions. When the field is specified, it must be immutable and works only for the Indexed Jobs. Once the Job meets the SuccessPolicy, the lingering pods are terminated.
    @[JSON::Field(key: "successPolicy")]
    @[YAML::Field(key: "successPolicy")]
    property success_policy : SuccessPolicy?
    # suspend specifies whether the Job controller should create Pods or not. If a Job is created with suspend set to true, no Pods are created by the Job controller. If a Job is suspended after creation (i.e. the flag goes from false to true), the Job controller will delete all active Pods associated with this Job. Users must design their workload to gracefully handle this. Suspending a Job will reset the StartTime field of the Job, effectively resetting the ActiveDeadlineSeconds timer too. Defaults to false.
    property suspend : Bool?
    # Describes the pod that will be created when executing a job. The only allowed template.spec.restartPolicy values are "Never" or "OnFailure". More info: https://kubernetes.io/docs/concepts/workloads/controllers/jobs-run-to-completion/
    property template : PodTemplateSpec?
    # ttlSecondsAfterFinished limits the lifetime of a Job that has finished execution (either Complete or Failed). If this field is set, ttlSecondsAfterFinished after the Job finishes, it is eligible to be automatically deleted. When the Job is being deleted, its lifecycle guarantees (e.g. finalizers) will be honored. If this field is unset, the Job won't be automatically deleted. If this field is set to zero, the Job becomes eligible to be deleted immediately after it finishes.
    @[JSON::Field(key: "ttlSecondsAfterFinished")]
    @[YAML::Field(key: "ttlSecondsAfterFinished")]
    property ttl_seconds_after_finished : Int32?
  end

  # JobStatus represents the current state of a Job.
  struct JobStatus
    include Kubernetes::Serializable

    # The number of pending and running pods which are not terminating (without a deletionTimestamp). The value is zero for finished jobs.
    property active : Int32?
    # completedIndexes holds the completed indexes when .spec.completionMode = "Indexed" in a text format. The indexes are represented as decimal integers separated by commas. The numbers are listed in increasing order. Three or more consecutive numbers are compressed and represented by the first and last element of the series, separated by a hyphen. For example, if the completed indexes are 1, 3, 4, 5 and 7, they are represented as "1,3-5,7".
    @[JSON::Field(key: "completedIndexes")]
    @[YAML::Field(key: "completedIndexes")]
    property completed_indexes : String?
    # Represents time when the job was completed. It is not guaranteed to be set in happens-before order across separate operations. It is represented in RFC3339 form and is in UTC. The completion time is set when the job finishes successfully, and only then. The value cannot be updated or removed. The value indicates the same or later point in time as the startTime field.
    @[JSON::Field(key: "completionTime")]
    @[YAML::Field(key: "completionTime")]
    property completion_time : Time?
    # The latest available observations of an object's current state. When a Job fails, one of the conditions will have type "Failed" and status true. When a Job is suspended, one of the conditions will have type "Suspended" and status true; when the Job is resumed, the status of this condition will become false. When a Job is completed, one of the conditions will have type "Complete" and status true.
    # A job is considered finished when it is in a terminal condition, either "Complete" or "Failed". A Job cannot have both the "Complete" and "Failed" conditions. Additionally, it cannot be in the "Complete" and "FailureTarget" conditions. The "Complete", "Failed" and "FailureTarget" conditions cannot be disabled.
    # More info: https://kubernetes.io/docs/concepts/workloads/controllers/jobs-run-to-completion/
    property conditions : Array(JobCondition)?
    # The number of pods which reached phase Failed. The value increases monotonically.
    property failed : Int32?
    # FailedIndexes holds the failed indexes when spec.backoffLimitPerIndex is set. The indexes are represented in the text format analogous as for the `completedIndexes` field, ie. they are kept as decimal integers separated by commas. The numbers are listed in increasing order. Three or more consecutive numbers are compressed and represented by the first and last element of the series, separated by a hyphen. For example, if the failed indexes are 1, 3, 4, 5 and 7, they are represented as "1,3-5,7". The set of failed indexes cannot overlap with the set of completed indexes.
    @[JSON::Field(key: "failedIndexes")]
    @[YAML::Field(key: "failedIndexes")]
    property failed_indexes : String?
    # The number of active pods which have a Ready condition and are not terminating (without a deletionTimestamp).
    property ready : Int32?
    # Represents time when the job controller started processing a job. When a Job is created in the suspended state, this field is not set until the first time it is resumed. This field is reset every time a Job is resumed from suspension. It is represented in RFC3339 form and is in UTC.
    # Once set, the field can only be removed when the job is suspended. The field cannot be modified while the job is unsuspended or finished.
    @[JSON::Field(key: "startTime")]
    @[YAML::Field(key: "startTime")]
    property start_time : Time?
    # The number of pods which reached phase Succeeded. The value increases monotonically for a given spec. However, it may decrease in reaction to scale down of elastic indexed jobs.
    property succeeded : Int32?
    # The number of pods which are terminating (in phase Pending or Running and have a deletionTimestamp).
    # This field is beta-level. The job controller populates the field when the feature gate JobPodReplacementPolicy is enabled (enabled by default).
    property terminating : Int32?
    # uncountedTerminatedPods holds the UIDs of Pods that have terminated but the job controller hasn't yet accounted for in the status counters.
    # The job controller creates pods with a finalizer. When a pod terminates (succeeded or failed), the controller does three steps to account for it in the job status:
    # 1. Add the pod UID to the arrays in this field. 2. Remove the pod finalizer. 3. Remove the pod UID from the arrays while increasing the corresponding
    # counter.
    # Old jobs might not be tracked using this field, in which case the field remains null. The structure is empty for finished jobs.
    @[JSON::Field(key: "uncountedTerminatedPods")]
    @[YAML::Field(key: "uncountedTerminatedPods")]
    property uncounted_terminated_pods : UncountedTerminatedPods?
  end

  # JobTemplateSpec describes the data a Job should have when created from a template
  struct JobTemplateSpec
    include Kubernetes::Serializable

    # Standard object's metadata of the jobs created from this template. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ObjectMeta?
    # Specification of the desired behavior of the job. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status
    property spec : JobSpec?
  end

  # PodFailurePolicy describes how failed pods influence the backoffLimit.
  struct PodFailurePolicy
    include Kubernetes::Serializable

    # A list of pod failure policy rules. The rules are evaluated in order. Once a rule matches a Pod failure, the remaining of the rules are ignored. When no rule matches the Pod failure, the default handling applies - the counter of pod failures is incremented and it is checked against the backoffLimit. At most 20 elements are allowed.
    property rules : Array(PodFailurePolicyRule)?
  end

  # PodFailurePolicyOnExitCodesRequirement describes the requirement for handling a failed pod based on its container exit codes. In particular, it lookups the .state.terminated.exitCode for each app container and init container status, represented by the .status.containerStatuses and .status.initContainerStatuses fields in the Pod status, respectively. Containers completed with success (exit code 0) are excluded from the requirement check.
  struct PodFailurePolicyOnExitCodesRequirement
    include Kubernetes::Serializable

    # Restricts the check for exit codes to the container with the specified name. When null, the rule applies to all containers. When specified, it should match one the container or initContainer names in the pod template.
    @[JSON::Field(key: "containerName")]
    @[YAML::Field(key: "containerName")]
    property container_name : String?
    # Represents the relationship between the container exit code(s) and the specified values. Containers completed with success (exit code 0) are excluded from the requirement check. Possible values are:
    # - In: the requirement is satisfied if at least one container exit code
    # (might be multiple if there are multiple containers not restricted
    # by the 'containerName' field) is in the set of specified values.
    # - NotIn: the requirement is satisfied if at least one container exit code
    # (might be multiple if there are multiple containers not restricted
    # by the 'containerName' field) is not in the set of specified values.
    # Additional values are considered to be added in the future. Clients should react to an unknown operator by assuming the requirement is not satisfied.
    property operator : String?
    # Specifies the set of values. Each returned container exit code (might be multiple in case of multiple containers) is checked against this set of values with respect to the operator. The list of values must be ordered and must not contain duplicates. Value '0' cannot be used for the In operator. At least one element is required. At most 255 elements are allowed.
    property values : Array(Int32)?
  end

  # PodFailurePolicyOnPodConditionsPattern describes a pattern for matching an actual pod condition type.
  struct PodFailurePolicyOnPodConditionsPattern
    include Kubernetes::Serializable

    # Specifies the required Pod condition status. To match a pod condition it is required that the specified status equals the pod condition status. Defaults to True.
    property status : String?
    # Specifies the required Pod condition type. To match a pod condition it is required that specified type equals the pod condition type.
    property type : String?
  end

  # PodFailurePolicyRule describes how a pod failure is handled when the requirements are met. One of onExitCodes and onPodConditions, but not both, can be used in each rule.
  struct PodFailurePolicyRule
    include Kubernetes::Serializable

    # Specifies the action taken on a pod failure when the requirements are satisfied. Possible values are:
    # - FailJob: indicates that the pod's job is marked as Failed and all
    # running pods are terminated.
    # - FailIndex: indicates that the pod's index is marked as Failed and will
    # not be restarted.
    # - Ignore: indicates that the counter towards the .backoffLimit is not
    # incremented and a replacement pod is created.
    # - Count: indicates that the pod is handled in the default way - the
    # counter towards the .backoffLimit is incremented.
    # Additional values are considered to be added in the future. Clients should react to an unknown action by skipping the rule.
    property action : String?
    # Represents the requirement on the container exit codes.
    @[JSON::Field(key: "onExitCodes")]
    @[YAML::Field(key: "onExitCodes")]
    property on_exit_codes : PodFailurePolicyOnExitCodesRequirement?
    # Represents the requirement on the pod conditions. The requirement is represented as a list of pod condition patterns. The requirement is satisfied if at least one pattern matches an actual pod condition. At most 20 elements are allowed.
    @[JSON::Field(key: "onPodConditions")]
    @[YAML::Field(key: "onPodConditions")]
    property on_pod_conditions : Array(PodFailurePolicyOnPodConditionsPattern)?
  end

  # SuccessPolicy describes when a Job can be declared as succeeded based on the success of some indexes.
  struct SuccessPolicy
    include Kubernetes::Serializable

    # rules represents the list of alternative rules for the declaring the Jobs as successful before `.status.succeeded >= .spec.completions`. Once any of the rules are met, the "SuccessCriteriaMet" condition is added, and the lingering pods are removed. The terminal state for such a Job has the "Complete" condition. Additionally, these rules are evaluated in order; Once the Job meets one of the rules, other rules are ignored. At most 20 elements are allowed.
    property rules : Array(SuccessPolicyRule)?
  end

  # SuccessPolicyRule describes rule for declaring a Job as succeeded. Each rule must have at least one of the "succeededIndexes" or "succeededCount" specified.
  struct SuccessPolicyRule
    include Kubernetes::Serializable

    # succeededCount specifies the minimal required size of the actual set of the succeeded indexes for the Job. When succeededCount is used along with succeededIndexes, the check is constrained only to the set of indexes specified by succeededIndexes. For example, given that succeededIndexes is "1-4", succeededCount is "3", and completed indexes are "1", "3", and "5", the Job isn't declared as succeeded because only "1" and "3" indexes are considered in that rules. When this field is null, this doesn't default to any value and is never evaluated at any time. When specified it needs to be a positive integer.
    @[JSON::Field(key: "succeededCount")]
    @[YAML::Field(key: "succeededCount")]
    property succeeded_count : Int32?
    # succeededIndexes specifies the set of indexes which need to be contained in the actual set of the succeeded indexes for the Job. The list of indexes must be within 0 to ".spec.completions-1" and must not contain duplicates. At least one element is required. The indexes are represented as intervals separated by commas. The intervals can be a decimal integer or a pair of decimal integers separated by a hyphen. The number are listed in represented by the first and last element of the series, separated by a hyphen. For example, if the completed indexes are 1, 3, 4, 5 and 7, they are represented as "1,3-5,7". When this field is null, this field doesn't default to any value and is never evaluated at any time.
    @[JSON::Field(key: "succeededIndexes")]
    @[YAML::Field(key: "succeededIndexes")]
    property succeeded_indexes : String?
  end

  # UncountedTerminatedPods holds UIDs of Pods that have terminated but haven't been accounted in Job status counters.
  struct UncountedTerminatedPods
    include Kubernetes::Serializable

    # failed holds UIDs of failed Pods.
    property failed : Array(String)?
    # succeeded holds UIDs of succeeded Pods.
    property succeeded : Array(String)?
  end

  # CertificateSigningRequest objects provide a mechanism to obtain x509 certificates by submitting a certificate signing request, and having it asynchronously approved and issued.
  # Kubelets use this API to obtain:
  # 1. client certificates to authenticate to kube-apiserver (with the "kubernetes.io/kube-apiserver-client-kubelet" signerName).
  # 2. serving certificates for TLS endpoints kube-apiserver can connect to securely (with the "kubernetes.io/kubelet-serving" signerName).
  # This API can be used to request client certificates to authenticate to kube-apiserver (with the "kubernetes.io/kube-apiserver-client" signerName), or to obtain certificates from custom non-Kubernetes signers.
  struct CertificateSigningRequest
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    property metadata : ObjectMeta?
    # spec contains the certificate request, and is immutable after creation. Only the request, signerName, expirationSeconds, and usages fields can be set on creation. Other fields are derived by Kubernetes and cannot be modified by users.
    property spec : CertificateSigningRequestSpec?
    # status contains information about whether the request is approved or denied, and the certificate issued by the signer, or the failure condition indicating signer failure.
    property status : CertificateSigningRequestStatus?
  end

  # CertificateSigningRequestCondition describes a condition of a CertificateSigningRequest object
  struct CertificateSigningRequestCondition
    include Kubernetes::Serializable

    # lastTransitionTime is the time the condition last transitioned from one status to another. If unset, when a new condition type is added or an existing condition's status is changed, the server defaults this to the current time.
    @[JSON::Field(key: "lastTransitionTime")]
    @[YAML::Field(key: "lastTransitionTime")]
    property last_transition_time : Time?
    # lastUpdateTime is the time of the last update to this condition
    @[JSON::Field(key: "lastUpdateTime")]
    @[YAML::Field(key: "lastUpdateTime")]
    property last_update_time : Time?
    # message contains a human readable message with details about the request state
    property message : String?
    # reason indicates a brief reason for the request state
    property reason : String?
    # status of the condition, one of True, False, Unknown. Approved, Denied, and Failed conditions may not be "False" or "Unknown".
    property status : String?
    # type of the condition. Known conditions are "Approved", "Denied", and "Failed".
    # An "Approved" condition is added via the /approval subresource, indicating the request was approved and should be issued by the signer.
    # A "Denied" condition is added via the /approval subresource, indicating the request was denied and should not be issued by the signer.
    # A "Failed" condition is added via the /status subresource, indicating the signer failed to issue the certificate.
    # Approved and Denied conditions are mutually exclusive. Approved, Denied, and Failed conditions cannot be removed once added.
    # Only one condition of a given type is allowed.
    property type : String?
  end

  # CertificateSigningRequestList is a collection of CertificateSigningRequest objects
  struct CertificateSigningRequestList
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # items is a collection of CertificateSigningRequest objects
    property items : Array(CertificateSigningRequest)?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    property metadata : ListMeta?
  end

  # CertificateSigningRequestSpec contains the certificate request.
  struct CertificateSigningRequestSpec
    include Kubernetes::Serializable

    # expirationSeconds is the requested duration of validity of the issued certificate. The certificate signer may issue a certificate with a different validity duration so a client must check the delta between the notBefore and and notAfter fields in the issued certificate to determine the actual duration.
    # The v1.22+ in-tree implementations of the well-known Kubernetes signers will honor this field as long as the requested duration is not greater than the maximum duration they will honor per the --cluster-signing-duration CLI flag to the Kubernetes controller manager.
    # Certificate signers may not honor this field for various reasons:
    # 1. Old signer that is unaware of the field (such as the in-tree
    # implementations prior to v1.22)
    # 2. Signer whose configured maximum is shorter than the requested duration
    # 3. Signer whose configured minimum is longer than the requested duration
    # The minimum valid value for expirationSeconds is 600, i.e. 10 minutes.
    @[JSON::Field(key: "expirationSeconds")]
    @[YAML::Field(key: "expirationSeconds")]
    property expiration_seconds : Int32?
    # extra contains extra attributes of the user that created the CertificateSigningRequest. Populated by the API server on creation and immutable.
    property extra : Hash(String, Array(String))?
    # groups contains group membership of the user that created the CertificateSigningRequest. Populated by the API server on creation and immutable.
    property groups : Array(String)?
    # request contains an x509 certificate signing request encoded in a "CERTIFICATE REQUEST" PEM block. When serialized as JSON or YAML, the data is additionally base64-encoded.
    property request : String?
    # signerName indicates the requested signer, and is a qualified name.
    # List/watch requests for CertificateSigningRequests can filter on this field using a "spec.signerName=NAME" fieldSelector.
    # Well-known Kubernetes signers are:
    # 1. "kubernetes.io/kube-apiserver-client": issues client certificates that can be used to authenticate to kube-apiserver.
    # Requests for this signer are never auto-approved by kube-controller-manager, can be issued by the "csrsigning" controller in kube-controller-manager.
    # 2. "kubernetes.io/kube-apiserver-client-kubelet": issues client certificates that kubelets use to authenticate to kube-apiserver.
    # Requests for this signer can be auto-approved by the "csrapproving" controller in kube-controller-manager, and can be issued by the "csrsigning" controller in kube-controller-manager.
    # 3. "kubernetes.io/kubelet-serving" issues serving certificates that kubelets use to serve TLS endpoints, which kube-apiserver can connect to securely.
    # Requests for this signer are never auto-approved by kube-controller-manager, and can be issued by the "csrsigning" controller in kube-controller-manager.
    # More details are available at https://k8s.io/docs/reference/access-authn-authz/certificate-signing-requests/#kubernetes-signers
    # Custom signerNames can also be specified. The signer defines:
    # 1. Trust distribution: how trust (CA bundles) are distributed.
    # 2. Permitted subjects: and behavior when a disallowed subject is requested.
    # 3. Required, permitted, or forbidden x509 extensions in the request (including whether subjectAltNames are allowed, which types, restrictions on allowed values) and behavior when a disallowed extension is requested.
    # 4. Required, permitted, or forbidden key usages / extended key usages.
    # 5. Expiration/certificate lifetime: whether it is fixed by the signer, configurable by the admin.
    # 6. Whether or not requests for CA certificates are allowed.
    @[JSON::Field(key: "signerName")]
    @[YAML::Field(key: "signerName")]
    property signer_name : String?
    # uid contains the uid of the user that created the CertificateSigningRequest. Populated by the API server on creation and immutable.
    property uid : String?
    # usages specifies a set of key usages requested in the issued certificate.
    # Requests for TLS client certificates typically request: "digital signature", "key encipherment", "client auth".
    # Requests for TLS serving certificates typically request: "key encipherment", "digital signature", "server auth".
    # Valid values are:
    # "signing", "digital signature", "content commitment",
    # "key encipherment", "key agreement", "data encipherment",
    # "cert sign", "crl sign", "encipher only", "decipher only", "any",
    # "server auth", "client auth",
    # "code signing", "email protection", "s/mime",
    # "ipsec end system", "ipsec tunnel", "ipsec user",
    # "timestamping", "ocsp signing", "microsoft sgc", "netscape sgc"
    property usages : Array(String)?
    # username contains the name of the user that created the CertificateSigningRequest. Populated by the API server on creation and immutable.
    property username : String?
  end

  # CertificateSigningRequestStatus contains conditions used to indicate approved/denied/failed status of the request, and the issued certificate.
  struct CertificateSigningRequestStatus
    include Kubernetes::Serializable

    # certificate is populated with an issued certificate by the signer after an Approved condition is present. This field is set via the /status subresource. Once populated, this field is immutable.
    # If the certificate signing request is denied, a condition of type "Denied" is added and this field remains empty. If the signer cannot issue the certificate, a condition of type "Failed" is added and this field remains empty.
    # Validation requirements:
    # 1. certificate must contain one or more PEM blocks.
    # 2. All PEM blocks must have the "CERTIFICATE" label, contain no headers, and the encoded data
    # must be a BER-encoded ASN.1 Certificate structure as described in section 4 of RFC5280.
    # 3. Non-PEM content may appear before or after the "CERTIFICATE" PEM blocks and is unvalidated,
    # to allow for explanatory text as described in section 5.2 of RFC7468.
    # If more than one PEM block is present, and the definition of the requested spec.signerName does not indicate otherwise, the first block is the issued certificate, and subsequent blocks should be treated as intermediate certificates and presented in TLS handshakes.
    # The certificate is encoded in PEM format.
    # When serialized as JSON or YAML, the data is additionally base64-encoded, so it consists of:
    # base64(
    # -----BEGIN CERTIFICATE-----
    # ...
    # -----END CERTIFICATE-----
    # )
    property certificate : String?
    # conditions applied to the request. Known conditions are "Approved", "Denied", and "Failed".
    property conditions : Array(CertificateSigningRequestCondition)?
  end

  # Lease defines a lease concept.
  struct Lease
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ObjectMeta?
    # spec contains the specification of the Lease. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status
    property spec : LeaseSpec?
  end

  # LeaseList is a list of Lease objects.
  struct LeaseList
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # items is a list of schema objects.
    property items : Array(Lease)?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard list metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ListMeta?
  end

  # LeaseSpec is a specification of a Lease.
  struct LeaseSpec
    include Kubernetes::Serializable

    # acquireTime is a time when the current lease was acquired.
    @[JSON::Field(key: "acquireTime")]
    @[YAML::Field(key: "acquireTime")]
    property acquire_time : Time?
    # holderIdentity contains the identity of the holder of a current lease. If Coordinated Leader Election is used, the holder identity must be equal to the elected LeaseCandidate.metadata.name field.
    @[JSON::Field(key: "holderIdentity")]
    @[YAML::Field(key: "holderIdentity")]
    property holder_identity : String?
    # leaseDurationSeconds is a duration that candidates for a lease need to wait to force acquire it. This is measured against the time of last observed renewTime.
    @[JSON::Field(key: "leaseDurationSeconds")]
    @[YAML::Field(key: "leaseDurationSeconds")]
    property lease_duration_seconds : Int32?
    # leaseTransitions is the number of transitions of a lease between holders.
    @[JSON::Field(key: "leaseTransitions")]
    @[YAML::Field(key: "leaseTransitions")]
    property lease_transitions : Int32?
    # PreferredHolder signals to a lease holder that the lease has a more optimal holder and should be given up. This field can only be set if Strategy is also set.
    @[JSON::Field(key: "preferredHolder")]
    @[YAML::Field(key: "preferredHolder")]
    property preferred_holder : String?
    # renewTime is a time when the current holder of a lease has last updated the lease.
    @[JSON::Field(key: "renewTime")]
    @[YAML::Field(key: "renewTime")]
    property renew_time : Time?
    # Strategy indicates the strategy for picking the leader for coordinated leader election. If the field is not specified, there is no active coordination for this lease. (Alpha) Using this field requires the CoordinatedLeaderElection feature gate to be enabled.
    property strategy : String?
  end

  # Represents a Persistent Disk resource in AWS.
  # An AWS EBS disk must exist before mounting to a container. The disk must also be in the same AWS zone as the kubelet. An AWS EBS disk can only be mounted as read/write once. AWS EBS volumes support ownership management and SELinux relabeling.
  struct AWSElasticBlockStoreVolumeSource
    include Kubernetes::Serializable

    # fsType is the filesystem type of the volume that you want to mount. Tip: Ensure that the filesystem type is supported by the host operating system. Examples: "ext4", "xfs", "ntfs". Implicitly inferred to be "ext4" if unspecified. More info: https://kubernetes.io/docs/concepts/storage/volumes#awselasticblockstore
    @[JSON::Field(key: "fsType")]
    @[YAML::Field(key: "fsType")]
    property fs_type : String?
    # partition is the partition in the volume that you want to mount. If omitted, the default is to mount by volume name. Examples: For volume /dev/sda1, you specify the partition as "1". Similarly, the volume partition for /dev/sda is "0" (or you can leave the property empty).
    property partition : Int32?
    # readOnly value true will force the readOnly setting in VolumeMounts. More info: https://kubernetes.io/docs/concepts/storage/volumes#awselasticblockstore
    @[JSON::Field(key: "readOnly")]
    @[YAML::Field(key: "readOnly")]
    property read_only : Bool?
    # volumeID is unique ID of the persistent disk resource in AWS (Amazon EBS volume). More info: https://kubernetes.io/docs/concepts/storage/volumes#awselasticblockstore
    @[JSON::Field(key: "volumeID")]
    @[YAML::Field(key: "volumeID")]
    property volume_id : String?
  end

  # Affinity is a group of affinity scheduling rules.
  struct Affinity
    include Kubernetes::Serializable

    # Describes node affinity scheduling rules for the pod.
    @[JSON::Field(key: "nodeAffinity")]
    @[YAML::Field(key: "nodeAffinity")]
    property node_affinity : NodeAffinity?
    # Describes pod affinity scheduling rules (e.g. co-locate this pod in the same node, zone, etc. as some other pod(s)).
    @[JSON::Field(key: "podAffinity")]
    @[YAML::Field(key: "podAffinity")]
    property pod_affinity : PodAffinity?
    # Describes pod anti-affinity scheduling rules (e.g. avoid putting this pod in the same node, zone, etc. as some other pod(s)).
    @[JSON::Field(key: "podAntiAffinity")]
    @[YAML::Field(key: "podAntiAffinity")]
    property pod_anti_affinity : PodAntiAffinity?
  end

  # AppArmorProfile defines a pod or container's AppArmor settings.
  struct AppArmorProfile
    include Kubernetes::Serializable

    # localhostProfile indicates a profile loaded on the node that should be used. The profile must be preconfigured on the node to work. Must match the loaded name of the profile. Must be set if and only if type is "Localhost".
    @[JSON::Field(key: "localhostProfile")]
    @[YAML::Field(key: "localhostProfile")]
    property localhost_profile : String?
    # type indicates which kind of AppArmor profile will be applied. Valid options are:
    # Localhost - a profile pre-loaded on the node.
    # RuntimeDefault - the container runtime's default profile.
    # Unconfined - no AppArmor enforcement.
    property type : String?
  end

  # AttachedVolume describes a volume attached to a node
  struct AttachedVolume
    include Kubernetes::Serializable

    # DevicePath represents the device path where the volume should be available
    @[JSON::Field(key: "devicePath")]
    @[YAML::Field(key: "devicePath")]
    property device_path : String?
    # Name of the attached volume
    property name : String?
  end

  # AzureDisk represents an Azure Data Disk mount on the host and bind mount to the pod.
  struct AzureDiskVolumeSource
    include Kubernetes::Serializable

    # cachingMode is the Host Caching mode: None, Read Only, Read Write.
    @[JSON::Field(key: "cachingMode")]
    @[YAML::Field(key: "cachingMode")]
    property caching_mode : String?
    # diskName is the Name of the data disk in the blob storage
    @[JSON::Field(key: "diskName")]
    @[YAML::Field(key: "diskName")]
    property disk_name : String?
    # diskURI is the URI of data disk in the blob storage
    @[JSON::Field(key: "diskURI")]
    @[YAML::Field(key: "diskURI")]
    property disk_uri : String?
    # fsType is Filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. "ext4", "xfs", "ntfs". Implicitly inferred to be "ext4" if unspecified.
    @[JSON::Field(key: "fsType")]
    @[YAML::Field(key: "fsType")]
    property fs_type : String?
    # kind expected values are Shared: multiple blob disks per storage account  Dedicated: single blob disk per storage account  Managed: azure managed data disk (only in managed availability set). defaults to shared
    property kind : String?
    # readOnly Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts.
    @[JSON::Field(key: "readOnly")]
    @[YAML::Field(key: "readOnly")]
    property read_only : Bool?
  end

  # AzureFile represents an Azure File Service mount on the host and bind mount to the pod.
  struct AzureFilePersistentVolumeSource
    include Kubernetes::Serializable

    # readOnly defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts.
    @[JSON::Field(key: "readOnly")]
    @[YAML::Field(key: "readOnly")]
    property read_only : Bool?
    # secretName is the name of secret that contains Azure Storage Account Name and Key
    @[JSON::Field(key: "secretName")]
    @[YAML::Field(key: "secretName")]
    property secret_name : String?
    # secretNamespace is the namespace of the secret that contains Azure Storage Account Name and Key default is the same as the Pod
    @[JSON::Field(key: "secretNamespace")]
    @[YAML::Field(key: "secretNamespace")]
    property secret_namespace : String?
    # shareName is the azure Share Name
    @[JSON::Field(key: "shareName")]
    @[YAML::Field(key: "shareName")]
    property share_name : String?
  end

  # AzureFile represents an Azure File Service mount on the host and bind mount to the pod.
  struct AzureFileVolumeSource
    include Kubernetes::Serializable

    # readOnly defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts.
    @[JSON::Field(key: "readOnly")]
    @[YAML::Field(key: "readOnly")]
    property read_only : Bool?
    # secretName is the  name of secret that contains Azure Storage Account Name and Key
    @[JSON::Field(key: "secretName")]
    @[YAML::Field(key: "secretName")]
    property secret_name : String?
    # shareName is the azure share Name
    @[JSON::Field(key: "shareName")]
    @[YAML::Field(key: "shareName")]
    property share_name : String?
  end

  # Binding ties one object to another; for example, a pod is bound to a node by a scheduler.
  struct Binding
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ObjectMeta?
    # The target object that you want to bind to the standard object.
    property target : ObjectReference?
  end

  # Represents storage that is managed by an external CSI volume driver
  struct CSIPersistentVolumeSource
    include Kubernetes::Serializable

    # controllerExpandSecretRef is a reference to the secret object containing sensitive information to pass to the CSI driver to complete the CSI ControllerExpandVolume call. This field is optional, and may be empty if no secret is required. If the secret object contains more than one secret, all secrets are passed.
    @[JSON::Field(key: "controllerExpandSecretRef")]
    @[YAML::Field(key: "controllerExpandSecretRef")]
    property controller_expand_secret_ref : SecretReference?
    # controllerPublishSecretRef is a reference to the secret object containing sensitive information to pass to the CSI driver to complete the CSI ControllerPublishVolume and ControllerUnpublishVolume calls. This field is optional, and may be empty if no secret is required. If the secret object contains more than one secret, all secrets are passed.
    @[JSON::Field(key: "controllerPublishSecretRef")]
    @[YAML::Field(key: "controllerPublishSecretRef")]
    property controller_publish_secret_ref : SecretReference?
    # driver is the name of the driver to use for this volume. Required.
    property driver : String?
    # fsType to mount. Must be a filesystem type supported by the host operating system. Ex. "ext4", "xfs", "ntfs".
    @[JSON::Field(key: "fsType")]
    @[YAML::Field(key: "fsType")]
    property fs_type : String?
    # nodeExpandSecretRef is a reference to the secret object containing sensitive information to pass to the CSI driver to complete the CSI NodeExpandVolume call. This field is optional, may be omitted if no secret is required. If the secret object contains more than one secret, all secrets are passed.
    @[JSON::Field(key: "nodeExpandSecretRef")]
    @[YAML::Field(key: "nodeExpandSecretRef")]
    property node_expand_secret_ref : SecretReference?
    # nodePublishSecretRef is a reference to the secret object containing sensitive information to pass to the CSI driver to complete the CSI NodePublishVolume and NodeUnpublishVolume calls. This field is optional, and may be empty if no secret is required. If the secret object contains more than one secret, all secrets are passed.
    @[JSON::Field(key: "nodePublishSecretRef")]
    @[YAML::Field(key: "nodePublishSecretRef")]
    property node_publish_secret_ref : SecretReference?
    # nodeStageSecretRef is a reference to the secret object containing sensitive information to pass to the CSI driver to complete the CSI NodeStageVolume and NodeStageVolume and NodeUnstageVolume calls. This field is optional, and may be empty if no secret is required. If the secret object contains more than one secret, all secrets are passed.
    @[JSON::Field(key: "nodeStageSecretRef")]
    @[YAML::Field(key: "nodeStageSecretRef")]
    property node_stage_secret_ref : SecretReference?
    # readOnly value to pass to ControllerPublishVolumeRequest. Defaults to false (read/write).
    @[JSON::Field(key: "readOnly")]
    @[YAML::Field(key: "readOnly")]
    property read_only : Bool?
    # volumeAttributes of the volume to publish.
    @[JSON::Field(key: "volumeAttributes")]
    @[YAML::Field(key: "volumeAttributes")]
    property volume_attributes : Hash(String, String)?
    # volumeHandle is the unique volume name returned by the CSI volume plugin’s CreateVolume to refer to the volume on all subsequent calls. Required.
    @[JSON::Field(key: "volumeHandle")]
    @[YAML::Field(key: "volumeHandle")]
    property volume_handle : String?
  end

  # Represents a source location of a volume to mount, managed by an external CSI driver
  struct CSIVolumeSource
    include Kubernetes::Serializable

    # driver is the name of the CSI driver that handles this volume. Consult with your admin for the correct name as registered in the cluster.
    property driver : String?
    # fsType to mount. Ex. "ext4", "xfs", "ntfs". If not provided, the empty value is passed to the associated CSI driver which will determine the default filesystem to apply.
    @[JSON::Field(key: "fsType")]
    @[YAML::Field(key: "fsType")]
    property fs_type : String?
    # nodePublishSecretRef is a reference to the secret object containing sensitive information to pass to the CSI driver to complete the CSI NodePublishVolume and NodeUnpublishVolume calls. This field is optional, and  may be empty if no secret is required. If the secret object contains more than one secret, all secret references are passed.
    @[JSON::Field(key: "nodePublishSecretRef")]
    @[YAML::Field(key: "nodePublishSecretRef")]
    property node_publish_secret_ref : LocalObjectReference?
    # readOnly specifies a read-only configuration for the volume. Defaults to false (read/write).
    @[JSON::Field(key: "readOnly")]
    @[YAML::Field(key: "readOnly")]
    property read_only : Bool?
    # volumeAttributes stores driver-specific properties that are passed to the CSI driver. Consult your driver's documentation for supported values.
    @[JSON::Field(key: "volumeAttributes")]
    @[YAML::Field(key: "volumeAttributes")]
    property volume_attributes : Hash(String, String)?
  end

  # Adds and removes POSIX capabilities from running containers.
  struct Capabilities
    include Kubernetes::Serializable

    # Added capabilities
    property add : Array(String)?
    # Removed capabilities
    property drop : Array(String)?
  end

  # Represents a Ceph Filesystem mount that lasts the lifetime of a pod Cephfs volumes do not support ownership management or SELinux relabeling.
  struct CephFSPersistentVolumeSource
    include Kubernetes::Serializable

    # monitors is Required: Monitors is a collection of Ceph monitors More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it
    property monitors : Array(String)?
    # path is Optional: Used as the mounted root, rather than the full Ceph tree, default is /
    property path : String?
    # readOnly is Optional: Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts. More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it
    @[JSON::Field(key: "readOnly")]
    @[YAML::Field(key: "readOnly")]
    property read_only : Bool?
    # secretFile is Optional: SecretFile is the path to key ring for User, default is /etc/ceph/user.secret More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it
    @[JSON::Field(key: "secretFile")]
    @[YAML::Field(key: "secretFile")]
    property secret_file : String?
    # secretRef is Optional: SecretRef is reference to the authentication secret for User, default is empty. More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it
    @[JSON::Field(key: "secretRef")]
    @[YAML::Field(key: "secretRef")]
    property secret_ref : SecretReference?
    # user is Optional: User is the rados user name, default is admin More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it
    property user : String?
  end

  # Represents a Ceph Filesystem mount that lasts the lifetime of a pod Cephfs volumes do not support ownership management or SELinux relabeling.
  struct CephFSVolumeSource
    include Kubernetes::Serializable

    # monitors is Required: Monitors is a collection of Ceph monitors More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it
    property monitors : Array(String)?
    # path is Optional: Used as the mounted root, rather than the full Ceph tree, default is /
    property path : String?
    # readOnly is Optional: Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts. More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it
    @[JSON::Field(key: "readOnly")]
    @[YAML::Field(key: "readOnly")]
    property read_only : Bool?
    # secretFile is Optional: SecretFile is the path to key ring for User, default is /etc/ceph/user.secret More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it
    @[JSON::Field(key: "secretFile")]
    @[YAML::Field(key: "secretFile")]
    property secret_file : String?
    # secretRef is Optional: SecretRef is reference to the authentication secret for User, default is empty. More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it
    @[JSON::Field(key: "secretRef")]
    @[YAML::Field(key: "secretRef")]
    property secret_ref : LocalObjectReference?
    # user is optional: User is the rados user name, default is admin More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it
    property user : String?
  end

  # Represents a cinder volume resource in Openstack. A Cinder volume must exist before mounting to a container. The volume must also be in the same region as the kubelet. Cinder volumes support ownership management and SELinux relabeling.
  struct CinderPersistentVolumeSource
    include Kubernetes::Serializable

    # fsType Filesystem type to mount. Must be a filesystem type supported by the host operating system. Examples: "ext4", "xfs", "ntfs". Implicitly inferred to be "ext4" if unspecified. More info: https://examples.k8s.io/mysql-cinder-pd/README.md
    @[JSON::Field(key: "fsType")]
    @[YAML::Field(key: "fsType")]
    property fs_type : String?
    # readOnly is Optional: Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts. More info: https://examples.k8s.io/mysql-cinder-pd/README.md
    @[JSON::Field(key: "readOnly")]
    @[YAML::Field(key: "readOnly")]
    property read_only : Bool?
    # secretRef is Optional: points to a secret object containing parameters used to connect to OpenStack.
    @[JSON::Field(key: "secretRef")]
    @[YAML::Field(key: "secretRef")]
    property secret_ref : SecretReference?
    # volumeID used to identify the volume in cinder. More info: https://examples.k8s.io/mysql-cinder-pd/README.md
    @[JSON::Field(key: "volumeID")]
    @[YAML::Field(key: "volumeID")]
    property volume_id : String?
  end

  # Represents a cinder volume resource in Openstack. A Cinder volume must exist before mounting to a container. The volume must also be in the same region as the kubelet. Cinder volumes support ownership management and SELinux relabeling.
  struct CinderVolumeSource
    include Kubernetes::Serializable

    # fsType is the filesystem type to mount. Must be a filesystem type supported by the host operating system. Examples: "ext4", "xfs", "ntfs". Implicitly inferred to be "ext4" if unspecified. More info: https://examples.k8s.io/mysql-cinder-pd/README.md
    @[JSON::Field(key: "fsType")]
    @[YAML::Field(key: "fsType")]
    property fs_type : String?
    # readOnly defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts. More info: https://examples.k8s.io/mysql-cinder-pd/README.md
    @[JSON::Field(key: "readOnly")]
    @[YAML::Field(key: "readOnly")]
    property read_only : Bool?
    # secretRef is optional: points to a secret object containing parameters used to connect to OpenStack.
    @[JSON::Field(key: "secretRef")]
    @[YAML::Field(key: "secretRef")]
    property secret_ref : LocalObjectReference?
    # volumeID used to identify the volume in cinder. More info: https://examples.k8s.io/mysql-cinder-pd/README.md
    @[JSON::Field(key: "volumeID")]
    @[YAML::Field(key: "volumeID")]
    property volume_id : String?
  end

  # ClientIPConfig represents the configurations of Client IP based session affinity.
  struct ClientIPConfig
    include Kubernetes::Serializable

    # timeoutSeconds specifies the seconds of ClientIP type session sticky time. The value must be >0 && <=86400(for 1 day) if ServiceAffinity == "ClientIP". Default value is 10800(for 3 hours).
    @[JSON::Field(key: "timeoutSeconds")]
    @[YAML::Field(key: "timeoutSeconds")]
    property timeout_seconds : Int32?
  end

  # ClusterTrustBundleProjection describes how to select a set of ClusterTrustBundle objects and project their contents into the pod filesystem.
  struct ClusterTrustBundleProjection
    include Kubernetes::Serializable

    # Select all ClusterTrustBundles that match this label selector.  Only has effect if signerName is set.  Mutually-exclusive with name.  If unset, interpreted as "match nothing".  If set but empty, interpreted as "match everything".
    @[JSON::Field(key: "labelSelector")]
    @[YAML::Field(key: "labelSelector")]
    property label_selector : LabelSelector?
    # Select a single ClusterTrustBundle by object name.  Mutually-exclusive with signerName and labelSelector.
    property name : String?
    # If true, don't block pod startup if the referenced ClusterTrustBundle(s) aren't available.  If using name, then the named ClusterTrustBundle is allowed not to exist.  If using signerName, then the combination of signerName and labelSelector is allowed to match zero ClusterTrustBundles.
    property optional : Bool?
    # Relative path from the volume root to write the bundle.
    property path : String?
    # Select all ClusterTrustBundles that match this signer name. Mutually-exclusive with name.  The contents of all selected ClusterTrustBundles will be unified and deduplicated.
    @[JSON::Field(key: "signerName")]
    @[YAML::Field(key: "signerName")]
    property signer_name : String?
  end

  # Information about the condition of a component.
  struct ComponentCondition
    include Kubernetes::Serializable

    # Condition error code for a component. For example, a health check error code.
    property error : String?
    # Message about the condition for a component. For example, information about a health check.
    property message : String?
    # Status of the condition for a component. Valid values for "Healthy": "True", "False", or "Unknown".
    property status : String?
    # Type of condition for a component. Valid value: "Healthy"
    property type : String?
  end

  # ComponentStatus (and ComponentStatusList) holds the cluster validation info. Deprecated: This API is deprecated in v1.19+
  struct ComponentStatus
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # List of component conditions observed
    property conditions : Array(ComponentCondition)?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ObjectMeta?
  end

  # Status of all the conditions for the component as a list of ComponentStatus objects. Deprecated: This API is deprecated in v1.19+
  struct ComponentStatusList
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # List of ComponentStatus objects.
    property items : Array(ComponentStatus)?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard list metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property metadata : ListMeta?
  end

  # ConfigMap holds configuration data for pods to consume.
  struct ConfigMap
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # BinaryData contains the binary data. Each key must consist of alphanumeric characters, '-', '_' or '.'. BinaryData can contain byte sequences that are not in the UTF-8 range. The keys stored in BinaryData must not overlap with the ones in the Data field, this is enforced during validation process. Using this field will require 1.10+ apiserver and kubelet.
    @[JSON::Field(key: "binaryData")]
    @[YAML::Field(key: "binaryData")]
    property binary_data : Hash(String, String)?
    # Data contains the configuration data. Each key must consist of alphanumeric characters, '-', '_' or '.'. Values with non-UTF-8 byte sequences must use the BinaryData field. The keys stored in Data must not overlap with the keys in the BinaryData field, this is enforced during validation process.
    property data : Hash(String, String)?
    # Immutable, if set to true, ensures that data stored in the ConfigMap cannot be updated (only object metadata can be modified). If not set to true, the field can be modified at any time. Defaulted to nil.
    property immutable : Bool?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ObjectMeta?
  end

  # ConfigMapEnvSource selects a ConfigMap to populate the environment variables with.
  # The contents of the target ConfigMap's Data field will represent the key-value pairs as environment variables.
  struct ConfigMapEnvSource
    include Kubernetes::Serializable

    # Name of the referent. This field is effectively required, but due to backwards compatibility is allowed to be empty. Instances of this type with an empty value here are almost certainly wrong. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
    property name : String?
    # Specify whether the ConfigMap must be defined
    property optional : Bool?
  end

  # Selects a key from a ConfigMap.
  struct ConfigMapKeySelector
    include Kubernetes::Serializable

    # The key to select.
    property key : String?
    # Name of the referent. This field is effectively required, but due to backwards compatibility is allowed to be empty. Instances of this type with an empty value here are almost certainly wrong. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
    property name : String?
    # Specify whether the ConfigMap or its key must be defined
    property optional : Bool?
  end

  # ConfigMapList is a resource containing a list of ConfigMap objects.
  struct ConfigMapList
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Items is the list of ConfigMaps.
    property items : Array(ConfigMap)?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ListMeta?
  end

  # ConfigMapNodeConfigSource contains the information to reference a ConfigMap as a config source for the Node. This API is deprecated since 1.22: https://git.k8s.io/enhancements/keps/sig-node/281-dynamic-kubelet-configuration
  struct ConfigMapNodeConfigSource
    include Kubernetes::Serializable

    # KubeletConfigKey declares which key of the referenced ConfigMap corresponds to the KubeletConfiguration structure This field is required in all cases.
    @[JSON::Field(key: "kubeletConfigKey")]
    @[YAML::Field(key: "kubeletConfigKey")]
    property kubelet_config_key : String?
    # Name is the metadata.name of the referenced ConfigMap. This field is required in all cases.
    property name : String?
    # Namespace is the metadata.namespace of the referenced ConfigMap. This field is required in all cases.
    property namespace : String?
    # ResourceVersion is the metadata.ResourceVersion of the referenced ConfigMap. This field is forbidden in Node.Spec, and required in Node.Status.
    @[JSON::Field(key: "resourceVersion")]
    @[YAML::Field(key: "resourceVersion")]
    property resource_version : String?
    # UID is the metadata.UID of the referenced ConfigMap. This field is forbidden in Node.Spec, and required in Node.Status.
    property uid : String?
  end

  # Adapts a ConfigMap into a projected volume.
  # The contents of the target ConfigMap's Data field will be presented in a projected volume as files using the keys in the Data field as the file names, unless the items element is populated with specific mappings of keys to paths. Note that this is identical to a configmap volume source without the default mode.
  struct ConfigMapProjection
    include Kubernetes::Serializable

    # items if unspecified, each key-value pair in the Data field of the referenced ConfigMap will be projected into the volume as a file whose name is the key and content is the value. If specified, the listed keys will be projected into the specified paths, and unlisted keys will not be present. If a key is specified which is not present in the ConfigMap, the volume setup will error unless it is marked optional. Paths must be relative and may not contain the '..' path or start with '..'.
    property items : Array(KeyToPath)?
    # Name of the referent. This field is effectively required, but due to backwards compatibility is allowed to be empty. Instances of this type with an empty value here are almost certainly wrong. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
    property name : String?
    # optional specify whether the ConfigMap or its keys must be defined
    property optional : Bool?
  end

  # Adapts a ConfigMap into a volume.
  # The contents of the target ConfigMap's Data field will be presented in a volume as files using the keys in the Data field as the file names, unless the items element is populated with specific mappings of keys to paths. ConfigMap volumes support ownership management and SELinux relabeling.
  struct ConfigMapVolumeSource
    include Kubernetes::Serializable

    # defaultMode is optional: mode bits used to set permissions on created files by default. Must be an octal value between 0000 and 0777 or a decimal value between 0 and 511. YAML accepts both octal and decimal values, JSON requires decimal values for mode bits. Defaults to 0644. Directories within the path are not affected by this setting. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set.
    @[JSON::Field(key: "defaultMode")]
    @[YAML::Field(key: "defaultMode")]
    property default_mode : Int32?
    # items if unspecified, each key-value pair in the Data field of the referenced ConfigMap will be projected into the volume as a file whose name is the key and content is the value. If specified, the listed keys will be projected into the specified paths, and unlisted keys will not be present. If a key is specified which is not present in the ConfigMap, the volume setup will error unless it is marked optional. Paths must be relative and may not contain the '..' path or start with '..'.
    property items : Array(KeyToPath)?
    # Name of the referent. This field is effectively required, but due to backwards compatibility is allowed to be empty. Instances of this type with an empty value here are almost certainly wrong. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
    property name : String?
    # optional specify whether the ConfigMap or its keys must be defined
    property optional : Bool?
  end

  # A single application container that you want to run within a pod.
  struct Container
    include Kubernetes::Serializable

    # Arguments to the entrypoint. The container image's CMD is used if this is not provided. Variable references $(VAR_NAME) are expanded using the container's environment. If a variable cannot be resolved, the reference in the input string will be unchanged. Double $$ are reduced to a single $, which allows for escaping the $(VAR_NAME) syntax: i.e. "$$(VAR_NAME)" will produce the string literal "$(VAR_NAME)". Escaped references will never be expanded, regardless of whether the variable exists or not. Cannot be updated. More info: https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#running-a-command-in-a-shell
    property args : Array(String)?
    # Entrypoint array. Not executed within a shell. The container image's ENTRYPOINT is used if this is not provided. Variable references $(VAR_NAME) are expanded using the container's environment. If a variable cannot be resolved, the reference in the input string will be unchanged. Double $$ are reduced to a single $, which allows for escaping the $(VAR_NAME) syntax: i.e. "$$(VAR_NAME)" will produce the string literal "$(VAR_NAME)". Escaped references will never be expanded, regardless of whether the variable exists or not. Cannot be updated. More info: https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#running-a-command-in-a-shell
    property command : Array(String)?
    # List of environment variables to set in the container. Cannot be updated.
    property env : Array(EnvVar)?
    # List of sources to populate environment variables in the container. The keys defined within a source may consist of any printable ASCII characters except '='. When a key exists in multiple sources, the value associated with the last source will take precedence. Values defined by an Env with a duplicate key will take precedence. Cannot be updated.
    @[JSON::Field(key: "envFrom")]
    @[YAML::Field(key: "envFrom")]
    property env_from : Array(EnvFromSource)?
    # Container image name. More info: https://kubernetes.io/docs/concepts/containers/images This field is optional to allow higher level config management to default or override container images in workload controllers like Deployments and StatefulSets.
    property image : String?
    # Image pull policy. One of Always, Never, IfNotPresent. Defaults to Always if :latest tag is specified, or IfNotPresent otherwise. Cannot be updated. More info: https://kubernetes.io/docs/concepts/containers/images#updating-images
    @[JSON::Field(key: "imagePullPolicy")]
    @[YAML::Field(key: "imagePullPolicy")]
    property image_pull_policy : String?
    # Actions that the management system should take in response to container lifecycle events. Cannot be updated.
    property lifecycle : Lifecycle?
    # Periodic probe of container liveness. Container will be restarted if the probe fails. Cannot be updated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
    @[JSON::Field(key: "livenessProbe")]
    @[YAML::Field(key: "livenessProbe")]
    property liveness_probe : Probe?
    # Name of the container specified as a DNS_LABEL. Each container in a pod must have a unique name (DNS_LABEL). Cannot be updated.
    property name : String?
    # List of ports to expose from the container. Not specifying a port here DOES NOT prevent that port from being exposed. Any port which is listening on the default "0.0.0.0" address inside a container will be accessible from the network. Modifying this array with strategic merge patch may corrupt the data. For more information See https://github.com/kubernetes/kubernetes/issues/108255. Cannot be updated.
    property ports : Array(ContainerPort)?
    # Periodic probe of container service readiness. Container will be removed from service endpoints if the probe fails. Cannot be updated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
    @[JSON::Field(key: "readinessProbe")]
    @[YAML::Field(key: "readinessProbe")]
    property readiness_probe : Probe?
    # Resources resize policy for the container.
    @[JSON::Field(key: "resizePolicy")]
    @[YAML::Field(key: "resizePolicy")]
    property resize_policy : Array(ContainerResizePolicy)?
    # Compute Resources required by this container. Cannot be updated. More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
    property resources : ResourceRequirements?
    # RestartPolicy defines the restart behavior of individual containers in a pod. This overrides the pod-level restart policy. When this field is not specified, the restart behavior is defined by the Pod's restart policy and the container type. Additionally, setting the RestartPolicy as "Always" for the init container will have the following effect: this init container will be continually restarted on exit until all regular containers have terminated. Once all regular containers have completed, all init containers with restartPolicy "Always" will be shut down. This lifecycle differs from normal init containers and is often referred to as a "sidecar" container. Although this init container still starts in the init container sequence, it does not wait for the container to complete before proceeding to the next init container. Instead, the next init container starts immediately after this init container is started, or after any startupProbe has successfully completed.
    @[JSON::Field(key: "restartPolicy")]
    @[YAML::Field(key: "restartPolicy")]
    property restart_policy : String?
    # Represents a list of rules to be checked to determine if the container should be restarted on exit. The rules are evaluated in order. Once a rule matches a container exit condition, the remaining rules are ignored. If no rule matches the container exit condition, the Container-level restart policy determines the whether the container is restarted or not. Constraints on the rules: - At most 20 rules are allowed. - Rules can have the same action. - Identical rules are not forbidden in validations. When rules are specified, container MUST set RestartPolicy explicitly even it if matches the Pod's RestartPolicy.
    @[JSON::Field(key: "restartPolicyRules")]
    @[YAML::Field(key: "restartPolicyRules")]
    property restart_policy_rules : Array(ContainerRestartRule)?
    # SecurityContext defines the security options the container should be run with. If set, the fields of SecurityContext override the equivalent fields of PodSecurityContext. More info: https://kubernetes.io/docs/tasks/configure-pod-container/security-context/
    @[JSON::Field(key: "securityContext")]
    @[YAML::Field(key: "securityContext")]
    property security_context : SecurityContext?
    # StartupProbe indicates that the Pod has successfully initialized. If specified, no other probes are executed until this completes successfully. If this probe fails, the Pod will be restarted, just as if the livenessProbe failed. This can be used to provide different probe parameters at the beginning of a Pod's lifecycle, when it might take a long time to load data or warm a cache, than during steady-state operation. This cannot be updated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
    @[JSON::Field(key: "startupProbe")]
    @[YAML::Field(key: "startupProbe")]
    property startup_probe : Probe?
    # Whether this container should allocate a buffer for stdin in the container runtime. If this is not set, reads from stdin in the container will always result in EOF. Default is false.
    property stdin : Bool?
    # Whether the container runtime should close the stdin channel after it has been opened by a single attach. When stdin is true the stdin stream will remain open across multiple attach sessions. If stdinOnce is set to true, stdin is opened on container start, is empty until the first client attaches to stdin, and then remains open and accepts data until the client disconnects, at which time stdin is closed and remains closed until the container is restarted. If this flag is false, a container processes that reads from stdin will never receive an EOF. Default is false
    @[JSON::Field(key: "stdinOnce")]
    @[YAML::Field(key: "stdinOnce")]
    property stdin_once : Bool?
    # Optional: Path at which the file to which the container's termination message will be written is mounted into the container's filesystem. Message written is intended to be brief final status, such as an assertion failure message. Will be truncated by the node if greater than 4096 bytes. The total message length across all containers will be limited to 12kb. Defaults to /dev/termination-log. Cannot be updated.
    @[JSON::Field(key: "terminationMessagePath")]
    @[YAML::Field(key: "terminationMessagePath")]
    property termination_message_path : String?
    # Indicate how the termination message should be populated. File will use the contents of terminationMessagePath to populate the container status message on both success and failure. FallbackToLogsOnError will use the last chunk of container log output if the termination message file is empty and the container exited with an error. The log output is limited to 2048 bytes or 80 lines, whichever is smaller. Defaults to File. Cannot be updated.
    @[JSON::Field(key: "terminationMessagePolicy")]
    @[YAML::Field(key: "terminationMessagePolicy")]
    property termination_message_policy : String?
    # Whether this container should allocate a TTY for itself, also requires 'stdin' to be true. Default is false.
    property tty : Bool?
    # volumeDevices is the list of block devices to be used by the container.
    @[JSON::Field(key: "volumeDevices")]
    @[YAML::Field(key: "volumeDevices")]
    property volume_devices : Array(VolumeDevice)?
    # Pod volumes to mount into the container's filesystem. Cannot be updated.
    @[JSON::Field(key: "volumeMounts")]
    @[YAML::Field(key: "volumeMounts")]
    property volume_mounts : Array(VolumeMount)?
    # Container's working directory. If not specified, the container runtime's default will be used, which might be configured in the container image. Cannot be updated.
    @[JSON::Field(key: "workingDir")]
    @[YAML::Field(key: "workingDir")]
    property working_dir : String?
  end

  # ContainerExtendedResourceRequest has the mapping of container name, extended resource name to the device request name.
  struct ContainerExtendedResourceRequest
    include Kubernetes::Serializable

    # The name of the container requesting resources.
    @[JSON::Field(key: "containerName")]
    @[YAML::Field(key: "containerName")]
    property container_name : String?
    # The name of the request in the special ResourceClaim which corresponds to the extended resource.
    @[JSON::Field(key: "requestName")]
    @[YAML::Field(key: "requestName")]
    property request_name : String?
    # The name of the extended resource in that container which gets backed by DRA.
    @[JSON::Field(key: "resourceName")]
    @[YAML::Field(key: "resourceName")]
    property resource_name : String?
  end

  # Describe a container image
  struct ContainerImage
    include Kubernetes::Serializable

    # Names by which this image is known. e.g. ["kubernetes.example/hyperkube:v1.0.7", "cloud-vendor.registry.example/cloud-vendor/hyperkube:v1.0.7"]
    property names : Array(String)?
    # The size of the image in bytes.
    @[JSON::Field(key: "sizeBytes")]
    @[YAML::Field(key: "sizeBytes")]
    property size_bytes : Int64?
  end

  # ContainerPort represents a network port in a single container.
  struct ContainerPort
    include Kubernetes::Serializable

    # Number of port to expose on the pod's IP address. This must be a valid port number, 0 < x < 65536.
    @[JSON::Field(key: "containerPort")]
    @[YAML::Field(key: "containerPort")]
    property container_port : Int32?
    # What host IP to bind the external port to.
    @[JSON::Field(key: "hostIP")]
    @[YAML::Field(key: "hostIP")]
    property host_ip : String?
    # Number of port to expose on the host. If specified, this must be a valid port number, 0 < x < 65536. If HostNetwork is specified, this must match ContainerPort. Most containers do not need this.
    @[JSON::Field(key: "hostPort")]
    @[YAML::Field(key: "hostPort")]
    property host_port : Int32?
    # If specified, this must be an IANA_SVC_NAME and unique within the pod. Each named port in a pod must have a unique name. Name for the port that can be referred to by services.
    property name : String?
    # Protocol for port. Must be UDP, TCP, or SCTP. Defaults to "TCP".
    property protocol : String?
  end

  # ContainerResizePolicy represents resource resize policy for the container.
  struct ContainerResizePolicy
    include Kubernetes::Serializable

    # Name of the resource to which this resource resize policy applies. Supported values: cpu, memory.
    @[JSON::Field(key: "resourceName")]
    @[YAML::Field(key: "resourceName")]
    property resource_name : String?
    # Restart policy to apply when specified resource is resized. If not specified, it defaults to NotRequired.
    @[JSON::Field(key: "restartPolicy")]
    @[YAML::Field(key: "restartPolicy")]
    property restart_policy : String?
  end

  # ContainerRestartRule describes how a container exit is handled.
  struct ContainerRestartRule
    include Kubernetes::Serializable

    # Specifies the action taken on a container exit if the requirements are satisfied. The only possible value is "Restart" to restart the container.
    property action : String?
    # Represents the exit codes to check on container exits.
    @[JSON::Field(key: "exitCodes")]
    @[YAML::Field(key: "exitCodes")]
    property exit_codes : ContainerRestartRuleOnExitCodes?
  end

  # ContainerRestartRuleOnExitCodes describes the condition for handling an exited container based on its exit codes.
  struct ContainerRestartRuleOnExitCodes
    include Kubernetes::Serializable

    # Represents the relationship between the container exit code(s) and the specified values. Possible values are: - In: the requirement is satisfied if the container exit code is in the
    # set of specified values.
    # - NotIn: the requirement is satisfied if the container exit code is
    # not in the set of specified values.
    property operator : String?
    # Specifies the set of values to check for container exit codes. At most 255 elements are allowed.
    property values : Array(Int32)?
  end

  # ContainerState holds a possible state of container. Only one of its members may be specified. If none of them is specified, the default one is ContainerStateWaiting.
  struct ContainerState
    include Kubernetes::Serializable

    # Details about a running container
    property running : ContainerStateRunning?
    # Details about a terminated container
    property terminated : ContainerStateTerminated?
    # Details about a waiting container
    property waiting : ContainerStateWaiting?
  end

  # ContainerStateRunning is a running state of a container.
  struct ContainerStateRunning
    include Kubernetes::Serializable

    # Time at which the container was last (re-)started
    @[JSON::Field(key: "startedAt")]
    @[YAML::Field(key: "startedAt")]
    property started_at : Time?
  end

  # ContainerStateTerminated is a terminated state of a container.
  struct ContainerStateTerminated
    include Kubernetes::Serializable

    # Container's ID in the format '<type>://<container_id>'
    @[JSON::Field(key: "containerID")]
    @[YAML::Field(key: "containerID")]
    property container_id : String?
    # Exit status from the last termination of the container
    @[JSON::Field(key: "exitCode")]
    @[YAML::Field(key: "exitCode")]
    property exit_code : Int32?
    # Time at which the container last terminated
    @[JSON::Field(key: "finishedAt")]
    @[YAML::Field(key: "finishedAt")]
    property finished_at : Time?
    # Message regarding the last termination of the container
    property message : String?
    # (brief) reason from the last termination of the container
    property reason : String?
    # Signal from the last termination of the container
    property signal : Int32?
    # Time at which previous execution of the container started
    @[JSON::Field(key: "startedAt")]
    @[YAML::Field(key: "startedAt")]
    property started_at : Time?
  end

  # ContainerStateWaiting is a waiting state of a container.
  struct ContainerStateWaiting
    include Kubernetes::Serializable

    # Message regarding why the container is not yet running.
    property message : String?
    # (brief) reason the container is not yet running.
    property reason : String?
  end

  # ContainerStatus contains details for the current status of this container.
  struct ContainerStatus
    include Kubernetes::Serializable

    # AllocatedResources represents the compute resources allocated for this container by the node. Kubelet sets this value to Container.Resources.Requests upon successful pod admission and after successfully admitting desired pod resize.
    @[JSON::Field(key: "allocatedResources")]
    @[YAML::Field(key: "allocatedResources")]
    property allocated_resources : Hash(String, String)?
    # AllocatedResourcesStatus represents the status of various resources allocated for this Pod.
    @[JSON::Field(key: "allocatedResourcesStatus")]
    @[YAML::Field(key: "allocatedResourcesStatus")]
    property allocated_resources_status : Array(ResourceStatus)?
    # ContainerID is the ID of the container in the format '<type>://<container_id>'. Where type is a container runtime identifier, returned from Version call of CRI API (for example "containerd").
    @[JSON::Field(key: "containerID")]
    @[YAML::Field(key: "containerID")]
    property container_id : String?
    # Image is the name of container image that the container is running. The container image may not match the image used in the PodSpec, as it may have been resolved by the runtime. More info: https://kubernetes.io/docs/concepts/containers/images.
    property image : String?
    # ImageID is the image ID of the container's image. The image ID may not match the image ID of the image used in the PodSpec, as it may have been resolved by the runtime.
    @[JSON::Field(key: "imageID")]
    @[YAML::Field(key: "imageID")]
    property image_id : String?
    # LastTerminationState holds the last termination state of the container to help debug container crashes and restarts. This field is not populated if the container is still running and RestartCount is 0.
    @[JSON::Field(key: "lastState")]
    @[YAML::Field(key: "lastState")]
    property last_state : ContainerState?
    # Name is a DNS_LABEL representing the unique name of the container. Each container in a pod must have a unique name across all container types. Cannot be updated.
    property name : String?
    # Ready specifies whether the container is currently passing its readiness check. The value will change as readiness probes keep executing. If no readiness probes are specified, this field defaults to true once the container is fully started (see Started field).
    # The value is typically used to determine whether a container is ready to accept traffic.
    property ready : Bool?
    # Resources represents the compute resource requests and limits that have been successfully enacted on the running container after it has been started or has been successfully resized.
    property resources : ResourceRequirements?
    # RestartCount holds the number of times the container has been restarted. Kubelet makes an effort to always increment the value, but there are cases when the state may be lost due to node restarts and then the value may be reset to 0. The value is never negative.
    @[JSON::Field(key: "restartCount")]
    @[YAML::Field(key: "restartCount")]
    property restart_count : Int32?
    # Started indicates whether the container has finished its postStart lifecycle hook and passed its startup probe. Initialized as false, becomes true after startupProbe is considered successful. Resets to false when the container is restarted, or if kubelet loses state temporarily. In both cases, startup probes will run again. Is always true when no startupProbe is defined and container is running and has passed the postStart lifecycle hook. The null value must be treated the same as false.
    property started : Bool?
    # State holds details about the container's current condition.
    property state : ContainerState?
    # StopSignal reports the effective stop signal for this container
    @[JSON::Field(key: "stopSignal")]
    @[YAML::Field(key: "stopSignal")]
    property stop_signal : String?
    # User represents user identity information initially attached to the first process of the container
    property user : ContainerUser?
    # Status of volume mounts.
    @[JSON::Field(key: "volumeMounts")]
    @[YAML::Field(key: "volumeMounts")]
    property volume_mounts : Array(VolumeMountStatus)?
  end

  # ContainerUser represents user identity information
  struct ContainerUser
    include Kubernetes::Serializable

    # Linux holds user identity information initially attached to the first process of the containers in Linux. Note that the actual running identity can be changed if the process has enough privilege to do so.
    property linux : LinuxContainerUser?
  end

  # DaemonEndpoint contains information about a single Daemon endpoint.
  struct DaemonEndpoint
    include Kubernetes::Serializable

    # Port number of the given endpoint.
    @[JSON::Field(key: "Port")]
    @[YAML::Field(key: "Port")]
    property port : Int32?
  end

  # Represents downward API info for projecting into a projected volume. Note that this is identical to a downwardAPI volume source without the default mode.
  struct DownwardAPIProjection
    include Kubernetes::Serializable

    # Items is a list of DownwardAPIVolume file
    property items : Array(DownwardAPIVolumeFile)?
  end

  # DownwardAPIVolumeFile represents information to create the file containing the pod field
  struct DownwardAPIVolumeFile
    include Kubernetes::Serializable

    # Required: Selects a field of the pod: only annotations, labels, name, namespace and uid are supported.
    @[JSON::Field(key: "fieldRef")]
    @[YAML::Field(key: "fieldRef")]
    property field_ref : ObjectFieldSelector?
    # Optional: mode bits used to set permissions on this file, must be an octal value between 0000 and 0777 or a decimal value between 0 and 511. YAML accepts both octal and decimal values, JSON requires decimal values for mode bits. If not specified, the volume defaultMode will be used. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set.
    property mode : Int32?
    # Required: Path is  the relative path name of the file to be created. Must not be absolute or contain the '..' path. Must be utf-8 encoded. The first item of the relative path must not start with '..'
    property path : String?
    # Selects a resource of the container: only resources limits and requests (limits.cpu, limits.memory, requests.cpu and requests.memory) are currently supported.
    @[JSON::Field(key: "resourceFieldRef")]
    @[YAML::Field(key: "resourceFieldRef")]
    property resource_field_ref : ResourceFieldSelector?
  end

  # DownwardAPIVolumeSource represents a volume containing downward API info. Downward API volumes support ownership management and SELinux relabeling.
  struct DownwardAPIVolumeSource
    include Kubernetes::Serializable

    # Optional: mode bits to use on created files by default. Must be a Optional: mode bits used to set permissions on created files by default. Must be an octal value between 0000 and 0777 or a decimal value between 0 and 511. YAML accepts both octal and decimal values, JSON requires decimal values for mode bits. Defaults to 0644. Directories within the path are not affected by this setting. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set.
    @[JSON::Field(key: "defaultMode")]
    @[YAML::Field(key: "defaultMode")]
    property default_mode : Int32?
    # Items is a list of downward API volume file
    property items : Array(DownwardAPIVolumeFile)?
  end

  # Represents an empty directory for a pod. Empty directory volumes support ownership management and SELinux relabeling.
  struct EmptyDirVolumeSource
    include Kubernetes::Serializable

    # medium represents what type of storage medium should back this directory. The default is "" which means to use the node's default medium. Must be an empty string (default) or Memory. More info: https://kubernetes.io/docs/concepts/storage/volumes#emptydir
    property medium : String?
    # sizeLimit is the total amount of local storage required for this EmptyDir volume. The size limit is also applicable for memory medium. The maximum usage on memory medium EmptyDir would be the minimum value between the SizeLimit specified here and the sum of memory limits of all containers in a pod. The default is nil which means that the limit is undefined. More info: https://kubernetes.io/docs/concepts/storage/volumes#emptydir
    @[JSON::Field(key: "sizeLimit")]
    @[YAML::Field(key: "sizeLimit")]
    property size_limit : String?
  end

  # EndpointAddress is a tuple that describes single IP address. Deprecated: This API is deprecated in v1.33+.
  struct EndpointAddress
    include Kubernetes::Serializable

    # The Hostname of this endpoint
    property hostname : String?
    # The IP of this endpoint. May not be loopback (127.0.0.0/8 or ::1), link-local (169.254.0.0/16 or fe80::/10), or link-local multicast (224.0.0.0/24 or ff02::/16).
    property ip : String?
    # Optional: Node hosting this endpoint. This can be used to determine endpoints local to a node.
    @[JSON::Field(key: "nodeName")]
    @[YAML::Field(key: "nodeName")]
    property node_name : String?
    # Reference to object providing the endpoint.
    @[JSON::Field(key: "targetRef")]
    @[YAML::Field(key: "targetRef")]
    property target_ref : ObjectReference?
  end

  # EndpointSubset is a group of addresses with a common set of ports. The expanded set of endpoints is the Cartesian product of Addresses x Ports. For example, given:
  # {
  # Addresses: [{"ip": "10.10.1.1"}, {"ip": "10.10.2.2"}],
  # Ports:     [{"name": "a", "port": 8675}, {"name": "b", "port": 309}]
  # }
  # The resulting set of endpoints can be viewed as:
  # a: [ 10.10.1.1:8675, 10.10.2.2:8675 ],
  # b: [ 10.10.1.1:309, 10.10.2.2:309 ]
  # Deprecated: This API is deprecated in v1.33+.
  struct EndpointSubset
    include Kubernetes::Serializable

    # IP addresses which offer the related ports that are marked as ready. These endpoints should be considered safe for load balancers and clients to utilize.
    property addresses : Array(EndpointAddress)?
    # IP addresses which offer the related ports but are not currently marked as ready because they have not yet finished starting, have recently failed a readiness check, or have recently failed a liveness check.
    @[JSON::Field(key: "notReadyAddresses")]
    @[YAML::Field(key: "notReadyAddresses")]
    property not_ready_addresses : Array(EndpointAddress)?
    # Port numbers available on the related IP addresses.
    property ports : Array(EndpointPort)?
  end

  # Endpoints is a collection of endpoints that implement the actual service. Example:
  # Name: "mysvc",
  # Subsets: [
  # {
  # Addresses: [{"ip": "10.10.1.1"}, {"ip": "10.10.2.2"}],
  # Ports: [{"name": "a", "port": 8675}, {"name": "b", "port": 309}]
  # },
  # {
  # Addresses: [{"ip": "10.10.3.3"}],
  # Ports: [{"name": "a", "port": 93}, {"name": "b", "port": 76}]
  # },
  # ]
  # Endpoints is a legacy API and does not contain information about all Service features. Use discoveryv1.EndpointSlice for complete information about Service endpoints.
  # Deprecated: This API is deprecated in v1.33+. Use discoveryv1.EndpointSlice.
  struct Endpoints
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ObjectMeta?
    # The set of all endpoints is the union of all subsets. Addresses are placed into subsets according to the IPs they share. A single address with multiple ports, some of which are ready and some of which are not (because they come from different containers) will result in the address being displayed in different subsets for the different ports. No address will appear in both Addresses and NotReadyAddresses in the same subset. Sets of addresses and ports that comprise a service.
    property subsets : Array(EndpointSubset)?
  end

  # EndpointsList is a list of endpoints. Deprecated: This API is deprecated in v1.33+.
  struct EndpointsList
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # List of endpoints.
    property items : Array(Endpoints)?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard list metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property metadata : ListMeta?
  end

  # EnvFromSource represents the source of a set of ConfigMaps or Secrets
  struct EnvFromSource
    include Kubernetes::Serializable

    # The ConfigMap to select from
    @[JSON::Field(key: "configMapRef")]
    @[YAML::Field(key: "configMapRef")]
    property config_map_ref : ConfigMapEnvSource?
    # Optional text to prepend to the name of each environment variable. May consist of any printable ASCII characters except '='.
    property prefix : String?
    # The Secret to select from
    @[JSON::Field(key: "secretRef")]
    @[YAML::Field(key: "secretRef")]
    property secret_ref : SecretEnvSource?
  end

  # EnvVar represents an environment variable present in a Container.
  struct EnvVar
    include Kubernetes::Serializable

    # Name of the environment variable. May consist of any printable ASCII characters except '='.
    property name : String?
    # Variable references $(VAR_NAME) are expanded using the previously defined environment variables in the container and any service environment variables. If a variable cannot be resolved, the reference in the input string will be unchanged. Double $$ are reduced to a single $, which allows for escaping the $(VAR_NAME) syntax: i.e. "$$(VAR_NAME)" will produce the string literal "$(VAR_NAME)". Escaped references will never be expanded, regardless of whether the variable exists or not. Defaults to "".
    property value : String?
    # Source for the environment variable's value. Cannot be used if value is not empty.
    @[JSON::Field(key: "valueFrom")]
    @[YAML::Field(key: "valueFrom")]
    property value_from : EnvVarSource?
  end

  # EnvVarSource represents a source for the value of an EnvVar.
  struct EnvVarSource
    include Kubernetes::Serializable

    # Selects a key of a ConfigMap.
    @[JSON::Field(key: "configMapKeyRef")]
    @[YAML::Field(key: "configMapKeyRef")]
    property config_map_key_ref : ConfigMapKeySelector?
    # Selects a field of the pod: supports metadata.name, metadata.namespace, `metadata.labels['<KEY>']`, `metadata.annotations['<KEY>']`, spec.nodeName, spec.serviceAccountName, status.hostIP, status.podIP, status.podIPs.
    @[JSON::Field(key: "fieldRef")]
    @[YAML::Field(key: "fieldRef")]
    property field_ref : ObjectFieldSelector?
    # FileKeyRef selects a key of the env file. Requires the EnvFiles feature gate to be enabled.
    @[JSON::Field(key: "fileKeyRef")]
    @[YAML::Field(key: "fileKeyRef")]
    property file_key_ref : FileKeySelector?
    # Selects a resource of the container: only resources limits and requests (limits.cpu, limits.memory, limits.ephemeral-storage, requests.cpu, requests.memory and requests.ephemeral-storage) are currently supported.
    @[JSON::Field(key: "resourceFieldRef")]
    @[YAML::Field(key: "resourceFieldRef")]
    property resource_field_ref : ResourceFieldSelector?
    # Selects a key of a secret in the pod's namespace
    @[JSON::Field(key: "secretKeyRef")]
    @[YAML::Field(key: "secretKeyRef")]
    property secret_key_ref : SecretKeySelector?
  end

  # An EphemeralContainer is a temporary container that you may add to an existing Pod for user-initiated activities such as debugging. Ephemeral containers have no resource or scheduling guarantees, and they will not be restarted when they exit or when a Pod is removed or restarted. The kubelet may evict a Pod if an ephemeral container causes the Pod to exceed its resource allocation.
  # To add an ephemeral container, use the ephemeralcontainers subresource of an existing Pod. Ephemeral containers may not be removed or restarted.
  struct EphemeralContainer
    include Kubernetes::Serializable

    # Arguments to the entrypoint. The image's CMD is used if this is not provided. Variable references $(VAR_NAME) are expanded using the container's environment. If a variable cannot be resolved, the reference in the input string will be unchanged. Double $$ are reduced to a single $, which allows for escaping the $(VAR_NAME) syntax: i.e. "$$(VAR_NAME)" will produce the string literal "$(VAR_NAME)". Escaped references will never be expanded, regardless of whether the variable exists or not. Cannot be updated. More info: https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#running-a-command-in-a-shell
    property args : Array(String)?
    # Entrypoint array. Not executed within a shell. The image's ENTRYPOINT is used if this is not provided. Variable references $(VAR_NAME) are expanded using the container's environment. If a variable cannot be resolved, the reference in the input string will be unchanged. Double $$ are reduced to a single $, which allows for escaping the $(VAR_NAME) syntax: i.e. "$$(VAR_NAME)" will produce the string literal "$(VAR_NAME)". Escaped references will never be expanded, regardless of whether the variable exists or not. Cannot be updated. More info: https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#running-a-command-in-a-shell
    property command : Array(String)?
    # List of environment variables to set in the container. Cannot be updated.
    property env : Array(EnvVar)?
    # List of sources to populate environment variables in the container. The keys defined within a source may consist of any printable ASCII characters except '='. When a key exists in multiple sources, the value associated with the last source will take precedence. Values defined by an Env with a duplicate key will take precedence. Cannot be updated.
    @[JSON::Field(key: "envFrom")]
    @[YAML::Field(key: "envFrom")]
    property env_from : Array(EnvFromSource)?
    # Container image name. More info: https://kubernetes.io/docs/concepts/containers/images
    property image : String?
    # Image pull policy. One of Always, Never, IfNotPresent. Defaults to Always if :latest tag is specified, or IfNotPresent otherwise. Cannot be updated. More info: https://kubernetes.io/docs/concepts/containers/images#updating-images
    @[JSON::Field(key: "imagePullPolicy")]
    @[YAML::Field(key: "imagePullPolicy")]
    property image_pull_policy : String?
    # Lifecycle is not allowed for ephemeral containers.
    property lifecycle : Lifecycle?
    # Probes are not allowed for ephemeral containers.
    @[JSON::Field(key: "livenessProbe")]
    @[YAML::Field(key: "livenessProbe")]
    property liveness_probe : Probe?
    # Name of the ephemeral container specified as a DNS_LABEL. This name must be unique among all containers, init containers and ephemeral containers.
    property name : String?
    # Ports are not allowed for ephemeral containers.
    property ports : Array(ContainerPort)?
    # Probes are not allowed for ephemeral containers.
    @[JSON::Field(key: "readinessProbe")]
    @[YAML::Field(key: "readinessProbe")]
    property readiness_probe : Probe?
    # Resources resize policy for the container.
    @[JSON::Field(key: "resizePolicy")]
    @[YAML::Field(key: "resizePolicy")]
    property resize_policy : Array(ContainerResizePolicy)?
    # Resources are not allowed for ephemeral containers. Ephemeral containers use spare resources already allocated to the pod.
    property resources : ResourceRequirements?
    # Restart policy for the container to manage the restart behavior of each container within a pod. You cannot set this field on ephemeral containers.
    @[JSON::Field(key: "restartPolicy")]
    @[YAML::Field(key: "restartPolicy")]
    property restart_policy : String?
    # Represents a list of rules to be checked to determine if the container should be restarted on exit. You cannot set this field on ephemeral containers.
    @[JSON::Field(key: "restartPolicyRules")]
    @[YAML::Field(key: "restartPolicyRules")]
    property restart_policy_rules : Array(ContainerRestartRule)?
    # Optional: SecurityContext defines the security options the ephemeral container should be run with. If set, the fields of SecurityContext override the equivalent fields of PodSecurityContext.
    @[JSON::Field(key: "securityContext")]
    @[YAML::Field(key: "securityContext")]
    property security_context : SecurityContext?
    # Probes are not allowed for ephemeral containers.
    @[JSON::Field(key: "startupProbe")]
    @[YAML::Field(key: "startupProbe")]
    property startup_probe : Probe?
    # Whether this container should allocate a buffer for stdin in the container runtime. If this is not set, reads from stdin in the container will always result in EOF. Default is false.
    property stdin : Bool?
    # Whether the container runtime should close the stdin channel after it has been opened by a single attach. When stdin is true the stdin stream will remain open across multiple attach sessions. If stdinOnce is set to true, stdin is opened on container start, is empty until the first client attaches to stdin, and then remains open and accepts data until the client disconnects, at which time stdin is closed and remains closed until the container is restarted. If this flag is false, a container processes that reads from stdin will never receive an EOF. Default is false
    @[JSON::Field(key: "stdinOnce")]
    @[YAML::Field(key: "stdinOnce")]
    property stdin_once : Bool?
    # If set, the name of the container from PodSpec that this ephemeral container targets. The ephemeral container will be run in the namespaces (IPC, PID, etc) of this container. If not set then the ephemeral container uses the namespaces configured in the Pod spec.
    # The container runtime must implement support for this feature. If the runtime does not support namespace targeting then the result of setting this field is undefined.
    @[JSON::Field(key: "targetContainerName")]
    @[YAML::Field(key: "targetContainerName")]
    property target_container_name : String?
    # Optional: Path at which the file to which the container's termination message will be written is mounted into the container's filesystem. Message written is intended to be brief final status, such as an assertion failure message. Will be truncated by the node if greater than 4096 bytes. The total message length across all containers will be limited to 12kb. Defaults to /dev/termination-log. Cannot be updated.
    @[JSON::Field(key: "terminationMessagePath")]
    @[YAML::Field(key: "terminationMessagePath")]
    property termination_message_path : String?
    # Indicate how the termination message should be populated. File will use the contents of terminationMessagePath to populate the container status message on both success and failure. FallbackToLogsOnError will use the last chunk of container log output if the termination message file is empty and the container exited with an error. The log output is limited to 2048 bytes or 80 lines, whichever is smaller. Defaults to File. Cannot be updated.
    @[JSON::Field(key: "terminationMessagePolicy")]
    @[YAML::Field(key: "terminationMessagePolicy")]
    property termination_message_policy : String?
    # Whether this container should allocate a TTY for itself, also requires 'stdin' to be true. Default is false.
    property tty : Bool?
    # volumeDevices is the list of block devices to be used by the container.
    @[JSON::Field(key: "volumeDevices")]
    @[YAML::Field(key: "volumeDevices")]
    property volume_devices : Array(VolumeDevice)?
    # Pod volumes to mount into the container's filesystem. Subpath mounts are not allowed for ephemeral containers. Cannot be updated.
    @[JSON::Field(key: "volumeMounts")]
    @[YAML::Field(key: "volumeMounts")]
    property volume_mounts : Array(VolumeMount)?
    # Container's working directory. If not specified, the container runtime's default will be used, which might be configured in the container image. Cannot be updated.
    @[JSON::Field(key: "workingDir")]
    @[YAML::Field(key: "workingDir")]
    property working_dir : String?
  end

  # Represents an ephemeral volume that is handled by a normal storage driver.
  struct EphemeralVolumeSource
    include Kubernetes::Serializable

    # Will be used to create a stand-alone PVC to provision the volume. The pod in which this EphemeralVolumeSource is embedded will be the owner of the PVC, i.e. the PVC will be deleted together with the pod.  The name of the PVC will be `<pod name>-<volume name>` where `<volume name>` is the name from the `PodSpec.Volumes` array entry. Pod validation will reject the pod if the concatenated name is not valid for a PVC (for example, too long).
    # An existing PVC with that name that is not owned by the pod will *not* be used for the pod to avoid using an unrelated volume by mistake. Starting the pod is then blocked until the unrelated PVC is removed. If such a pre-created PVC is meant to be used by the pod, the PVC has to updated with an owner reference to the pod once the pod exists. Normally this should not be necessary, but it may be useful when manually reconstructing a broken cluster.
    # This field is read-only and no changes will be made by Kubernetes to the PVC after it has been created.
    # Required, must not be nil.
    @[JSON::Field(key: "volumeClaimTemplate")]
    @[YAML::Field(key: "volumeClaimTemplate")]
    property volume_claim_template : PersistentVolumeClaimTemplate?
  end

  # EventSource contains information for an event.
  struct EventSource
    include Kubernetes::Serializable

    # Component from which the event is generated.
    property component : String?
    # Node name on which the event is generated.
    property host : String?
  end

  # ExecAction describes a "run in container" action.
  struct ExecAction
    include Kubernetes::Serializable

    # Command is the command line to execute inside the container, the working directory for the command  is root ('/') in the container's filesystem. The command is simply exec'd, it is not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use a shell, you need to explicitly call out to that shell. Exit status of 0 is treated as live/healthy and non-zero is unhealthy.
    property command : Array(String)?
  end

  # Represents a Fibre Channel volume. Fibre Channel volumes can only be mounted as read/write once. Fibre Channel volumes support ownership management and SELinux relabeling.
  struct FCVolumeSource
    include Kubernetes::Serializable

    # fsType is the filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. "ext4", "xfs", "ntfs". Implicitly inferred to be "ext4" if unspecified.
    @[JSON::Field(key: "fsType")]
    @[YAML::Field(key: "fsType")]
    property fs_type : String?
    # lun is Optional: FC target lun number
    property lun : Int32?
    # readOnly is Optional: Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts.
    @[JSON::Field(key: "readOnly")]
    @[YAML::Field(key: "readOnly")]
    property read_only : Bool?
    # targetWWNs is Optional: FC target worldwide names (WWNs)
    @[JSON::Field(key: "targetWWNs")]
    @[YAML::Field(key: "targetWWNs")]
    property target_ww_ns : Array(String)?
    # wwids Optional: FC volume world wide identifiers (wwids) Either wwids or combination of targetWWNs and lun must be set, but not both simultaneously.
    property wwids : Array(String)?
  end

  # FileKeySelector selects a key of the env file.
  struct FileKeySelector
    include Kubernetes::Serializable

    # The key within the env file. An invalid key will prevent the pod from starting. The keys defined within a source may consist of any printable ASCII characters except '='. During Alpha stage of the EnvFiles feature gate, the key size is limited to 128 characters.
    property key : String?
    # Specify whether the file or its key must be defined. If the file or key does not exist, then the env var is not published. If optional is set to true and the specified key does not exist, the environment variable will not be set in the Pod's containers.
    # If optional is set to false and the specified key does not exist, an error will be returned during Pod creation.
    property optional : Bool?
    # The path within the volume from which to select the file. Must be relative and may not contain the '..' path or start with '..'.
    property path : String?
    # The name of the volume mount containing the env file.
    @[JSON::Field(key: "volumeName")]
    @[YAML::Field(key: "volumeName")]
    property volume_name : String?
  end

  # FlexPersistentVolumeSource represents a generic persistent volume resource that is provisioned/attached using an exec based plugin.
  struct FlexPersistentVolumeSource
    include Kubernetes::Serializable

    # driver is the name of the driver to use for this volume.
    property driver : String?
    # fsType is the Filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. "ext4", "xfs", "ntfs". The default filesystem depends on FlexVolume script.
    @[JSON::Field(key: "fsType")]
    @[YAML::Field(key: "fsType")]
    property fs_type : String?
    # options is Optional: this field holds extra command options if any.
    property options : Hash(String, String)?
    # readOnly is Optional: defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts.
    @[JSON::Field(key: "readOnly")]
    @[YAML::Field(key: "readOnly")]
    property read_only : Bool?
    # secretRef is Optional: SecretRef is reference to the secret object containing sensitive information to pass to the plugin scripts. This may be empty if no secret object is specified. If the secret object contains more than one secret, all secrets are passed to the plugin scripts.
    @[JSON::Field(key: "secretRef")]
    @[YAML::Field(key: "secretRef")]
    property secret_ref : SecretReference?
  end

  # FlexVolume represents a generic volume resource that is provisioned/attached using an exec based plugin.
  struct FlexVolumeSource
    include Kubernetes::Serializable

    # driver is the name of the driver to use for this volume.
    property driver : String?
    # fsType is the filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. "ext4", "xfs", "ntfs". The default filesystem depends on FlexVolume script.
    @[JSON::Field(key: "fsType")]
    @[YAML::Field(key: "fsType")]
    property fs_type : String?
    # options is Optional: this field holds extra command options if any.
    property options : Hash(String, String)?
    # readOnly is Optional: defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts.
    @[JSON::Field(key: "readOnly")]
    @[YAML::Field(key: "readOnly")]
    property read_only : Bool?
    # secretRef is Optional: secretRef is reference to the secret object containing sensitive information to pass to the plugin scripts. This may be empty if no secret object is specified. If the secret object contains more than one secret, all secrets are passed to the plugin scripts.
    @[JSON::Field(key: "secretRef")]
    @[YAML::Field(key: "secretRef")]
    property secret_ref : LocalObjectReference?
  end

  # Represents a Flocker volume mounted by the Flocker agent. One and only one of datasetName and datasetUUID should be set. Flocker volumes do not support ownership management or SELinux relabeling.
  struct FlockerVolumeSource
    include Kubernetes::Serializable

    # datasetName is Name of the dataset stored as metadata -> name on the dataset for Flocker should be considered as deprecated
    @[JSON::Field(key: "datasetName")]
    @[YAML::Field(key: "datasetName")]
    property dataset_name : String?
    # datasetUUID is the UUID of the dataset. This is unique identifier of a Flocker dataset
    @[JSON::Field(key: "datasetUUID")]
    @[YAML::Field(key: "datasetUUID")]
    property dataset_uuid : String?
  end

  # Represents a Persistent Disk resource in Google Compute Engine.
  # A GCE PD must exist before mounting to a container. The disk must also be in the same GCE project and zone as the kubelet. A GCE PD can only be mounted as read/write once or read-only many times. GCE PDs support ownership management and SELinux relabeling.
  struct GCEPersistentDiskVolumeSource
    include Kubernetes::Serializable

    # fsType is filesystem type of the volume that you want to mount. Tip: Ensure that the filesystem type is supported by the host operating system. Examples: "ext4", "xfs", "ntfs". Implicitly inferred to be "ext4" if unspecified. More info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk
    @[JSON::Field(key: "fsType")]
    @[YAML::Field(key: "fsType")]
    property fs_type : String?
    # partition is the partition in the volume that you want to mount. If omitted, the default is to mount by volume name. Examples: For volume /dev/sda1, you specify the partition as "1". Similarly, the volume partition for /dev/sda is "0" (or you can leave the property empty). More info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk
    property partition : Int32?
    # pdName is unique name of the PD resource in GCE. Used to identify the disk in GCE. More info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk
    @[JSON::Field(key: "pdName")]
    @[YAML::Field(key: "pdName")]
    property pd_name : String?
    # readOnly here will force the ReadOnly setting in VolumeMounts. Defaults to false. More info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk
    @[JSON::Field(key: "readOnly")]
    @[YAML::Field(key: "readOnly")]
    property read_only : Bool?
  end

  # GRPCAction specifies an action involving a GRPC service.
  struct GRPCAction
    include Kubernetes::Serializable

    # Port number of the gRPC service. Number must be in the range 1 to 65535.
    property port : Int32?
    # Service is the name of the service to place in the gRPC HealthCheckRequest (see https://github.com/grpc/grpc/blob/master/doc/health-checking.md).
    # If this is not specified, the default behavior is defined by gRPC.
    property service : String?
  end

  # Represents a volume that is populated with the contents of a git repository. Git repo volumes do not support ownership management. Git repo volumes support SELinux relabeling.
  # DEPRECATED: GitRepo is deprecated. To provision a container with a git repo, mount an EmptyDir into an InitContainer that clones the repo using git, then mount the EmptyDir into the Pod's container.
  struct GitRepoVolumeSource
    include Kubernetes::Serializable

    # directory is the target directory name. Must not contain or start with '..'.  If '.' is supplied, the volume directory will be the git repository.  Otherwise, if specified, the volume will contain the git repository in the subdirectory with the given name.
    property directory : String?
    # repository is the URL
    property repository : String?
    # revision is the commit hash for the specified revision.
    property revision : String?
  end

  # Represents a Glusterfs mount that lasts the lifetime of a pod. Glusterfs volumes do not support ownership management or SELinux relabeling.
  struct GlusterfsPersistentVolumeSource
    include Kubernetes::Serializable

    # endpoints is the endpoint name that details Glusterfs topology. More info: https://examples.k8s.io/volumes/glusterfs/README.md#create-a-pod
    property endpoints : String?
    # endpointsNamespace is the namespace that contains Glusterfs endpoint. If this field is empty, the EndpointNamespace defaults to the same namespace as the bound PVC. More info: https://examples.k8s.io/volumes/glusterfs/README.md#create-a-pod
    @[JSON::Field(key: "endpointsNamespace")]
    @[YAML::Field(key: "endpointsNamespace")]
    property endpoints_namespace : String?
    # path is the Glusterfs volume path. More info: https://examples.k8s.io/volumes/glusterfs/README.md#create-a-pod
    property path : String?
    # readOnly here will force the Glusterfs volume to be mounted with read-only permissions. Defaults to false. More info: https://examples.k8s.io/volumes/glusterfs/README.md#create-a-pod
    @[JSON::Field(key: "readOnly")]
    @[YAML::Field(key: "readOnly")]
    property read_only : Bool?
  end

  # Represents a Glusterfs mount that lasts the lifetime of a pod. Glusterfs volumes do not support ownership management or SELinux relabeling.
  struct GlusterfsVolumeSource
    include Kubernetes::Serializable

    # endpoints is the endpoint name that details Glusterfs topology.
    property endpoints : String?
    # path is the Glusterfs volume path. More info: https://examples.k8s.io/volumes/glusterfs/README.md#create-a-pod
    property path : String?
    # readOnly here will force the Glusterfs volume to be mounted with read-only permissions. Defaults to false. More info: https://examples.k8s.io/volumes/glusterfs/README.md#create-a-pod
    @[JSON::Field(key: "readOnly")]
    @[YAML::Field(key: "readOnly")]
    property read_only : Bool?
  end

  # HTTPGetAction describes an action based on HTTP Get requests.
  struct HTTPGetAction
    include Kubernetes::Serializable

    # Host name to connect to, defaults to the pod IP. You probably want to set "Host" in httpHeaders instead.
    property host : String?
    # Custom headers to set in the request. HTTP allows repeated headers.
    @[JSON::Field(key: "httpHeaders")]
    @[YAML::Field(key: "httpHeaders")]
    property http_headers : Array(HTTPHeader)?
    # Path to access on the HTTP server.
    property path : String?
    # Name or number of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME.
    property port : IntOrString?
    # Scheme to use for connecting to the host. Defaults to HTTP.
    property scheme : String?
  end

  # HTTPHeader describes a custom header to be used in HTTP probes
  struct HTTPHeader
    include Kubernetes::Serializable

    # The header field name. This will be canonicalized upon output, so case-variant names will be understood as the same header.
    property name : String?
    # The header field value
    property value : String?
  end

  # HostAlias holds the mapping between IP and hostnames that will be injected as an entry in the pod's hosts file.
  struct HostAlias
    include Kubernetes::Serializable

    # Hostnames for the above IP address.
    property hostnames : Array(String)?
    # IP address of the host file entry.
    property ip : String?
  end

  # HostIP represents a single IP address allocated to the host.
  struct HostIP
    include Kubernetes::Serializable

    # IP is the IP address assigned to the host
    property ip : String?
  end

  # Represents a host path mapped into a pod. Host path volumes do not support ownership management or SELinux relabeling.
  struct HostPathVolumeSource
    include Kubernetes::Serializable

    # path of the directory on the host. If the path is a symlink, it will follow the link to the real path. More info: https://kubernetes.io/docs/concepts/storage/volumes#hostpath
    property path : String?
    # type for HostPath Volume Defaults to "" More info: https://kubernetes.io/docs/concepts/storage/volumes#hostpath
    property type : String?
  end

  # ISCSIPersistentVolumeSource represents an ISCSI disk. ISCSI volumes can only be mounted as read/write once. ISCSI volumes support ownership management and SELinux relabeling.
  struct ISCSIPersistentVolumeSource
    include Kubernetes::Serializable

    # chapAuthDiscovery defines whether support iSCSI Discovery CHAP authentication
    @[JSON::Field(key: "chapAuthDiscovery")]
    @[YAML::Field(key: "chapAuthDiscovery")]
    property chap_auth_discovery : Bool?
    # chapAuthSession defines whether support iSCSI Session CHAP authentication
    @[JSON::Field(key: "chapAuthSession")]
    @[YAML::Field(key: "chapAuthSession")]
    property chap_auth_session : Bool?
    # fsType is the filesystem type of the volume that you want to mount. Tip: Ensure that the filesystem type is supported by the host operating system. Examples: "ext4", "xfs", "ntfs". Implicitly inferred to be "ext4" if unspecified. More info: https://kubernetes.io/docs/concepts/storage/volumes#iscsi
    @[JSON::Field(key: "fsType")]
    @[YAML::Field(key: "fsType")]
    property fs_type : String?
    # initiatorName is the custom iSCSI Initiator Name. If initiatorName is specified with iscsiInterface simultaneously, new iSCSI interface <target portal>:<volume name> will be created for the connection.
    @[JSON::Field(key: "initiatorName")]
    @[YAML::Field(key: "initiatorName")]
    property initiator_name : String?
    # iqn is Target iSCSI Qualified Name.
    property iqn : String?
    # iscsiInterface is the interface Name that uses an iSCSI transport. Defaults to 'default' (tcp).
    @[JSON::Field(key: "iscsiInterface")]
    @[YAML::Field(key: "iscsiInterface")]
    property iscsi_interface : String?
    # lun is iSCSI Target Lun number.
    property lun : Int32?
    # portals is the iSCSI Target Portal List. The Portal is either an IP or ip_addr:port if the port is other than default (typically TCP ports 860 and 3260).
    property portals : Array(String)?
    # readOnly here will force the ReadOnly setting in VolumeMounts. Defaults to false.
    @[JSON::Field(key: "readOnly")]
    @[YAML::Field(key: "readOnly")]
    property read_only : Bool?
    # secretRef is the CHAP Secret for iSCSI target and initiator authentication
    @[JSON::Field(key: "secretRef")]
    @[YAML::Field(key: "secretRef")]
    property secret_ref : SecretReference?
    # targetPortal is iSCSI Target Portal. The Portal is either an IP or ip_addr:port if the port is other than default (typically TCP ports 860 and 3260).
    @[JSON::Field(key: "targetPortal")]
    @[YAML::Field(key: "targetPortal")]
    property target_portal : String?
  end

  # Represents an ISCSI disk. ISCSI volumes can only be mounted as read/write once. ISCSI volumes support ownership management and SELinux relabeling.
  struct ISCSIVolumeSource
    include Kubernetes::Serializable

    # chapAuthDiscovery defines whether support iSCSI Discovery CHAP authentication
    @[JSON::Field(key: "chapAuthDiscovery")]
    @[YAML::Field(key: "chapAuthDiscovery")]
    property chap_auth_discovery : Bool?
    # chapAuthSession defines whether support iSCSI Session CHAP authentication
    @[JSON::Field(key: "chapAuthSession")]
    @[YAML::Field(key: "chapAuthSession")]
    property chap_auth_session : Bool?
    # fsType is the filesystem type of the volume that you want to mount. Tip: Ensure that the filesystem type is supported by the host operating system. Examples: "ext4", "xfs", "ntfs". Implicitly inferred to be "ext4" if unspecified. More info: https://kubernetes.io/docs/concepts/storage/volumes#iscsi
    @[JSON::Field(key: "fsType")]
    @[YAML::Field(key: "fsType")]
    property fs_type : String?
    # initiatorName is the custom iSCSI Initiator Name. If initiatorName is specified with iscsiInterface simultaneously, new iSCSI interface <target portal>:<volume name> will be created for the connection.
    @[JSON::Field(key: "initiatorName")]
    @[YAML::Field(key: "initiatorName")]
    property initiator_name : String?
    # iqn is the target iSCSI Qualified Name.
    property iqn : String?
    # iscsiInterface is the interface Name that uses an iSCSI transport. Defaults to 'default' (tcp).
    @[JSON::Field(key: "iscsiInterface")]
    @[YAML::Field(key: "iscsiInterface")]
    property iscsi_interface : String?
    # lun represents iSCSI Target Lun number.
    property lun : Int32?
    # portals is the iSCSI Target Portal List. The portal is either an IP or ip_addr:port if the port is other than default (typically TCP ports 860 and 3260).
    property portals : Array(String)?
    # readOnly here will force the ReadOnly setting in VolumeMounts. Defaults to false.
    @[JSON::Field(key: "readOnly")]
    @[YAML::Field(key: "readOnly")]
    property read_only : Bool?
    # secretRef is the CHAP Secret for iSCSI target and initiator authentication
    @[JSON::Field(key: "secretRef")]
    @[YAML::Field(key: "secretRef")]
    property secret_ref : LocalObjectReference?
    # targetPortal is iSCSI Target Portal. The Portal is either an IP or ip_addr:port if the port is other than default (typically TCP ports 860 and 3260).
    @[JSON::Field(key: "targetPortal")]
    @[YAML::Field(key: "targetPortal")]
    property target_portal : String?
  end

  # ImageVolumeSource represents a image volume resource.
  struct ImageVolumeSource
    include Kubernetes::Serializable

    # Policy for pulling OCI objects. Possible values are: Always: the kubelet always attempts to pull the reference. Container creation will fail If the pull fails. Never: the kubelet never pulls the reference and only uses a local image or artifact. Container creation will fail if the reference isn't present. IfNotPresent: the kubelet pulls if the reference isn't already present on disk. Container creation will fail if the reference isn't present and the pull fails. Defaults to Always if :latest tag is specified, or IfNotPresent otherwise.
    @[JSON::Field(key: "pullPolicy")]
    @[YAML::Field(key: "pullPolicy")]
    property pull_policy : String?
    # Required: Image or artifact reference to be used. Behaves in the same way as pod.spec.containers[*].image. Pull secrets will be assembled in the same way as for the container image by looking up node credentials, SA image pull secrets, and pod spec image pull secrets. More info: https://kubernetes.io/docs/concepts/containers/images This field is optional to allow higher level config management to default or override container images in workload controllers like Deployments and StatefulSets.
    property reference : String?
  end

  # Maps a string key to a path within a volume.
  struct KeyToPath
    include Kubernetes::Serializable

    # key is the key to project.
    property key : String?
    # mode is Optional: mode bits used to set permissions on this file. Must be an octal value between 0000 and 0777 or a decimal value between 0 and 511. YAML accepts both octal and decimal values, JSON requires decimal values for mode bits. If not specified, the volume defaultMode will be used. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set.
    property mode : Int32?
    # path is the relative path of the file to map the key to. May not be an absolute path. May not contain the path element '..'. May not start with the string '..'.
    property path : String?
  end

  # Lifecycle describes actions that the management system should take in response to container lifecycle events. For the PostStart and PreStop lifecycle handlers, management of the container blocks until the action is complete, unless the container process fails, in which case the handler is aborted.
  struct Lifecycle
    include Kubernetes::Serializable

    # PostStart is called immediately after a container is created. If the handler fails, the container is terminated and restarted according to its restart policy. Other management of the container blocks until the hook completes. More info: https://kubernetes.io/docs/concepts/containers/container-lifecycle-hooks/#container-hooks
    @[JSON::Field(key: "postStart")]
    @[YAML::Field(key: "postStart")]
    property post_start : LifecycleHandler?
    # PreStop is called immediately before a container is terminated due to an API request or management event such as liveness/startup probe failure, preemption, resource contention, etc. The handler is not called if the container crashes or exits. The Pod's termination grace period countdown begins before the PreStop hook is executed. Regardless of the outcome of the handler, the container will eventually terminate within the Pod's termination grace period (unless delayed by finalizers). Other management of the container blocks until the hook completes or until the termination grace period is reached. More info: https://kubernetes.io/docs/concepts/containers/container-lifecycle-hooks/#container-hooks
    @[JSON::Field(key: "preStop")]
    @[YAML::Field(key: "preStop")]
    property pre_stop : LifecycleHandler?
    # StopSignal defines which signal will be sent to a container when it is being stopped. If not specified, the default is defined by the container runtime in use. StopSignal can only be set for Pods with a non-empty .spec.os.name
    @[JSON::Field(key: "stopSignal")]
    @[YAML::Field(key: "stopSignal")]
    property stop_signal : String?
  end

  # LifecycleHandler defines a specific action that should be taken in a lifecycle hook. One and only one of the fields, except TCPSocket must be specified.
  struct LifecycleHandler
    include Kubernetes::Serializable

    # Exec specifies a command to execute in the container.
    property exec : ExecAction?
    # HTTPGet specifies an HTTP GET request to perform.
    @[JSON::Field(key: "httpGet")]
    @[YAML::Field(key: "httpGet")]
    property http_get : HTTPGetAction?
    # Sleep represents a duration that the container should sleep.
    property sleep : SleepAction?
    # Deprecated. TCPSocket is NOT supported as a LifecycleHandler and kept for backward compatibility. There is no validation of this field and lifecycle hooks will fail at runtime when it is specified.
    @[JSON::Field(key: "tcpSocket")]
    @[YAML::Field(key: "tcpSocket")]
    property tcp_socket : TCPSocketAction?
  end

  # LimitRange sets resource usage limits for each kind of resource in a Namespace.
  struct LimitRange
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ObjectMeta?
    # Spec defines the limits enforced. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status
    property spec : LimitRangeSpec?
  end

  # LimitRangeItem defines a min/max usage limit for any resource that matches on kind.
  struct LimitRangeItem
    include Kubernetes::Serializable

    # Default resource requirement limit value by resource name if resource limit is omitted.
    property default : Hash(String, String)?
    # DefaultRequest is the default resource requirement request value by resource name if resource request is omitted.
    @[JSON::Field(key: "defaultRequest")]
    @[YAML::Field(key: "defaultRequest")]
    property default_request : Hash(String, String)?
    # Max usage constraints on this kind by resource name.
    property max : Hash(String, String)?
    # MaxLimitRequestRatio if specified, the named resource must have a request and limit that are both non-zero where limit divided by request is less than or equal to the enumerated value; this represents the max burst for the named resource.
    @[JSON::Field(key: "maxLimitRequestRatio")]
    @[YAML::Field(key: "maxLimitRequestRatio")]
    property max_limit_request_ratio : Hash(String, String)?
    # Min usage constraints on this kind by resource name.
    property min : Hash(String, String)?
    # Type of resource that this limit applies to.
    property type : String?
  end

  # LimitRangeList is a list of LimitRange items.
  struct LimitRangeList
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Items is a list of LimitRange objects. More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
    property items : Array(LimitRange)?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard list metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property metadata : ListMeta?
  end

  # LimitRangeSpec defines a min/max usage limit for resources that match on kind.
  struct LimitRangeSpec
    include Kubernetes::Serializable

    # Limits is the list of LimitRangeItem objects that are enforced.
    property limits : Array(LimitRangeItem)?
  end

  # LinuxContainerUser represents user identity information in Linux containers
  struct LinuxContainerUser
    include Kubernetes::Serializable

    # GID is the primary gid initially attached to the first process in the container
    property gid : Int64?
    # SupplementalGroups are the supplemental groups initially attached to the first process in the container
    @[JSON::Field(key: "supplementalGroups")]
    @[YAML::Field(key: "supplementalGroups")]
    property supplemental_groups : Array(Int64)?
    # UID is the primary uid initially attached to the first process in the container
    property uid : Int64?
  end

  # LoadBalancerIngress represents the status of a load-balancer ingress point: traffic intended for the service should be sent to an ingress point.
  struct LoadBalancerIngress
    include Kubernetes::Serializable

    # Hostname is set for load-balancer ingress points that are DNS based (typically AWS load-balancers)
    property hostname : String?
    # IP is set for load-balancer ingress points that are IP based (typically GCE or OpenStack load-balancers)
    property ip : String?
    # IPMode specifies how the load-balancer IP behaves, and may only be specified when the ip field is specified. Setting this to "VIP" indicates that traffic is delivered to the node with the destination set to the load-balancer's IP and port. Setting this to "Proxy" indicates that traffic is delivered to the node or pod with the destination set to the node's IP and node port or the pod's IP and port. Service implementations may use this information to adjust traffic routing.
    @[JSON::Field(key: "ipMode")]
    @[YAML::Field(key: "ipMode")]
    property ip_mode : String?
    # Ports is a list of records of service ports If used, every port defined in the service should have an entry in it
    property ports : Array(PortStatus)?
  end

  # LoadBalancerStatus represents the status of a load-balancer.
  struct LoadBalancerStatus
    include Kubernetes::Serializable

    # Ingress is a list containing ingress points for the load-balancer. Traffic intended for the service should be sent to these ingress points.
    property ingress : Array(LoadBalancerIngress)?
  end

  # LocalObjectReference contains enough information to let you locate the referenced object inside the same namespace.
  struct LocalObjectReference
    include Kubernetes::Serializable

    # Name of the referent. This field is effectively required, but due to backwards compatibility is allowed to be empty. Instances of this type with an empty value here are almost certainly wrong. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
    property name : String?
  end

  # Local represents directly-attached storage with node affinity
  struct LocalVolumeSource
    include Kubernetes::Serializable

    # fsType is the filesystem type to mount. It applies only when the Path is a block device. Must be a filesystem type supported by the host operating system. Ex. "ext4", "xfs", "ntfs". The default value is to auto-select a filesystem if unspecified.
    @[JSON::Field(key: "fsType")]
    @[YAML::Field(key: "fsType")]
    property fs_type : String?
    # path of the full path to the volume on the node. It can be either a directory or block device (disk, partition, ...).
    property path : String?
  end

  # ModifyVolumeStatus represents the status object of ControllerModifyVolume operation
  struct ModifyVolumeStatus
    include Kubernetes::Serializable

    # status is the status of the ControllerModifyVolume operation. It can be in any of following states:
    # - Pending
    # Pending indicates that the PersistentVolumeClaim cannot be modified due to unmet requirements, such as
    # the specified VolumeAttributesClass not existing.
    # - InProgress
    # InProgress indicates that the volume is being modified.
    # - Infeasible
    # Infeasible indicates that the request has been rejected as invalid by the CSI driver. To
    # resolve the error, a valid VolumeAttributesClass needs to be specified.
    # Note: New statuses can be added in the future. Consumers should check for unknown statuses and fail appropriately.
    property status : String?
    # targetVolumeAttributesClassName is the name of the VolumeAttributesClass the PVC currently being reconciled
    @[JSON::Field(key: "targetVolumeAttributesClassName")]
    @[YAML::Field(key: "targetVolumeAttributesClassName")]
    property target_volume_attributes_class_name : String?
  end

  # Represents an NFS mount that lasts the lifetime of a pod. NFS volumes do not support ownership management or SELinux relabeling.
  struct NFSVolumeSource
    include Kubernetes::Serializable

    # path that is exported by the NFS server. More info: https://kubernetes.io/docs/concepts/storage/volumes#nfs
    property path : String?
    # readOnly here will force the NFS export to be mounted with read-only permissions. Defaults to false. More info: https://kubernetes.io/docs/concepts/storage/volumes#nfs
    @[JSON::Field(key: "readOnly")]
    @[YAML::Field(key: "readOnly")]
    property read_only : Bool?
    # server is the hostname or IP address of the NFS server. More info: https://kubernetes.io/docs/concepts/storage/volumes#nfs
    property server : String?
  end

  # Namespace provides a scope for Names. Use of multiple namespaces is optional.
  struct Namespace
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ObjectMeta?
    # Spec defines the behavior of the Namespace. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status
    property spec : NamespaceSpec?
    # Status describes the current status of a Namespace. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status
    property status : NamespaceStatus?
  end

  # NamespaceCondition contains details about state of namespace.
  struct NamespaceCondition
    include Kubernetes::Serializable

    # Last time the condition transitioned from one status to another.
    @[JSON::Field(key: "lastTransitionTime")]
    @[YAML::Field(key: "lastTransitionTime")]
    property last_transition_time : Time?
    # Human-readable message indicating details about last transition.
    property message : String?
    # Unique, one-word, CamelCase reason for the condition's last transition.
    property reason : String?
    # Status of the condition, one of True, False, Unknown.
    property status : String?
    # Type of namespace controller condition.
    property type : String?
  end

  # NamespaceList is a list of Namespaces.
  struct NamespaceList
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Items is the list of Namespace objects in the list. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/
    property items : Array(Namespace)?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard list metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property metadata : ListMeta?
  end

  # NamespaceSpec describes the attributes on a Namespace.
  struct NamespaceSpec
    include Kubernetes::Serializable

    # Finalizers is an opaque list of values that must be empty to permanently remove object from storage. More info: https://kubernetes.io/docs/tasks/administer-cluster/namespaces/
    property finalizers : Array(String)?
  end

  # NamespaceStatus is information about the current status of a Namespace.
  struct NamespaceStatus
    include Kubernetes::Serializable

    # Represents the latest available observations of a namespace's current state.
    property conditions : Array(NamespaceCondition)?
    # Phase is the current lifecycle phase of the namespace. More info: https://kubernetes.io/docs/tasks/administer-cluster/namespaces/
    property phase : String?
  end

  # Node is a worker node in Kubernetes. Each node will have a unique identifier in the cache (i.e. in etcd).
  struct Node
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ObjectMeta?
    # Spec defines the behavior of a node. https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status
    property spec : NodeSpec?
    # Most recently observed status of the node. Populated by the system. Read-only. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status
    property status : NodeStatus?
  end

  # NodeAddress contains information for the node's address.
  struct NodeAddress
    include Kubernetes::Serializable

    # The node address.
    property address : String?
    # Node address type, one of Hostname, ExternalIP or InternalIP.
    property type : String?
  end

  # Node affinity is a group of node affinity scheduling rules.
  struct NodeAffinity
    include Kubernetes::Serializable

    # The scheduler will prefer to schedule pods to nodes that satisfy the affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding "weight" to the sum if the node matches the corresponding matchExpressions; the node(s) with the highest sum are the most preferred.
    @[JSON::Field(key: "preferredDuringSchedulingIgnoredDuringExecution")]
    @[YAML::Field(key: "preferredDuringSchedulingIgnoredDuringExecution")]
    property preferred_during_scheduling_ignored_during_execution : Array(PreferredSchedulingTerm)?
    # If the affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to an update), the system may or may not try to eventually evict the pod from its node.
    @[JSON::Field(key: "requiredDuringSchedulingIgnoredDuringExecution")]
    @[YAML::Field(key: "requiredDuringSchedulingIgnoredDuringExecution")]
    property required_during_scheduling_ignored_during_execution : NodeSelector?
  end

  # NodeCondition contains condition information for a node.
  struct NodeCondition
    include Kubernetes::Serializable

    # Last time we got an update on a given condition.
    @[JSON::Field(key: "lastHeartbeatTime")]
    @[YAML::Field(key: "lastHeartbeatTime")]
    property last_heartbeat_time : Time?
    # Last time the condition transit from one status to another.
    @[JSON::Field(key: "lastTransitionTime")]
    @[YAML::Field(key: "lastTransitionTime")]
    property last_transition_time : Time?
    # Human readable message indicating details about last transition.
    property message : String?
    # (brief) reason for the condition's last transition.
    property reason : String?
    # Status of the condition, one of True, False, Unknown.
    property status : String?
    # Type of node condition.
    property type : String?
  end

  # NodeConfigSource specifies a source of node configuration. Exactly one subfield (excluding metadata) must be non-nil. This API is deprecated since 1.22
  struct NodeConfigSource
    include Kubernetes::Serializable

    # ConfigMap is a reference to a Node's ConfigMap
    @[JSON::Field(key: "configMap")]
    @[YAML::Field(key: "configMap")]
    property config_map : ConfigMapNodeConfigSource?
  end

  # NodeConfigStatus describes the status of the config assigned by Node.Spec.ConfigSource.
  struct NodeConfigStatus
    include Kubernetes::Serializable

    # Active reports the checkpointed config the node is actively using. Active will represent either the current version of the Assigned config, or the current LastKnownGood config, depending on whether attempting to use the Assigned config results in an error.
    property active : NodeConfigSource?
    # Assigned reports the checkpointed config the node will try to use. When Node.Spec.ConfigSource is updated, the node checkpoints the associated config payload to local disk, along with a record indicating intended config. The node refers to this record to choose its config checkpoint, and reports this record in Assigned. Assigned only updates in the status after the record has been checkpointed to disk. When the Kubelet is restarted, it tries to make the Assigned config the Active config by loading and validating the checkpointed payload identified by Assigned.
    property assigned : NodeConfigSource?
    # Error describes any problems reconciling the Spec.ConfigSource to the Active config. Errors may occur, for example, attempting to checkpoint Spec.ConfigSource to the local Assigned record, attempting to checkpoint the payload associated with Spec.ConfigSource, attempting to load or validate the Assigned config, etc. Errors may occur at different points while syncing config. Earlier errors (e.g. download or checkpointing errors) will not result in a rollback to LastKnownGood, and may resolve across Kubelet retries. Later errors (e.g. loading or validating a checkpointed config) will result in a rollback to LastKnownGood. In the latter case, it is usually possible to resolve the error by fixing the config assigned in Spec.ConfigSource. You can find additional information for debugging by searching the error message in the Kubelet log. Error is a human-readable description of the error state; machines can check whether or not Error is empty, but should not rely on the stability of the Error text across Kubelet versions.
    property error : String?
    # LastKnownGood reports the checkpointed config the node will fall back to when it encounters an error attempting to use the Assigned config. The Assigned config becomes the LastKnownGood config when the node determines that the Assigned config is stable and correct. This is currently implemented as a 10-minute soak period starting when the local record of Assigned config is updated. If the Assigned config is Active at the end of this period, it becomes the LastKnownGood. Note that if Spec.ConfigSource is reset to nil (use local defaults), the LastKnownGood is also immediately reset to nil, because the local default config is always assumed good. You should not make assumptions about the node's method of determining config stability and correctness, as this may change or become configurable in the future.
    @[JSON::Field(key: "lastKnownGood")]
    @[YAML::Field(key: "lastKnownGood")]
    property last_known_good : NodeConfigSource?
  end

  # NodeDaemonEndpoints lists ports opened by daemons running on the Node.
  struct NodeDaemonEndpoints
    include Kubernetes::Serializable

    # Endpoint on which Kubelet is listening.
    @[JSON::Field(key: "kubeletEndpoint")]
    @[YAML::Field(key: "kubeletEndpoint")]
    property kubelet_endpoint : DaemonEndpoint?
  end

  # NodeFeatures describes the set of features implemented by the CRI implementation. The features contained in the NodeFeatures should depend only on the cri implementation independent of runtime handlers.
  struct NodeFeatures
    include Kubernetes::Serializable

    # SupplementalGroupsPolicy is set to true if the runtime supports SupplementalGroupsPolicy and ContainerUser.
    @[JSON::Field(key: "supplementalGroupsPolicy")]
    @[YAML::Field(key: "supplementalGroupsPolicy")]
    property supplemental_groups_policy : Bool?
  end

  # NodeList is the whole list of all Nodes which have been registered with master.
  struct NodeList
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # List of nodes
    property items : Array(Node)?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard list metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property metadata : ListMeta?
  end

  # NodeRuntimeHandler is a set of runtime handler information.
  struct NodeRuntimeHandler
    include Kubernetes::Serializable

    # Supported features.
    property features : NodeRuntimeHandlerFeatures?
    # Runtime handler name. Empty for the default runtime handler.
    property name : String?
  end

  # NodeRuntimeHandlerFeatures is a set of features implemented by the runtime handler.
  struct NodeRuntimeHandlerFeatures
    include Kubernetes::Serializable

    # RecursiveReadOnlyMounts is set to true if the runtime handler supports RecursiveReadOnlyMounts.
    @[JSON::Field(key: "recursiveReadOnlyMounts")]
    @[YAML::Field(key: "recursiveReadOnlyMounts")]
    property recursive_read_only_mounts : Bool?
    # UserNamespaces is set to true if the runtime handler supports UserNamespaces, including for volumes.
    @[JSON::Field(key: "userNamespaces")]
    @[YAML::Field(key: "userNamespaces")]
    property user_namespaces : Bool?
  end

  # A node selector represents the union of the results of one or more label queries over a set of nodes; that is, it represents the OR of the selectors represented by the node selector terms.
  struct NodeSelector
    include Kubernetes::Serializable

    # Required. A list of node selector terms. The terms are ORed.
    @[JSON::Field(key: "nodeSelectorTerms")]
    @[YAML::Field(key: "nodeSelectorTerms")]
    property node_selector_terms : Array(NodeSelectorTerm)?
  end

  # A node selector requirement is a selector that contains values, a key, and an operator that relates the key and values.
  struct NodeSelectorRequirement
    include Kubernetes::Serializable

    # The label key that the selector applies to.
    property key : String?
    # Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt.
    property operator : String?
    # An array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. If the operator is Gt or Lt, the values array must have a single element, which will be interpreted as an integer. This array is replaced during a strategic merge patch.
    property values : Array(String)?
  end

  # A null or empty node selector term matches no objects. The requirements of them are ANDed. The TopologySelectorTerm type implements a subset of the NodeSelectorTerm.
  struct NodeSelectorTerm
    include Kubernetes::Serializable

    # A list of node selector requirements by node's labels.
    @[JSON::Field(key: "matchExpressions")]
    @[YAML::Field(key: "matchExpressions")]
    property match_expressions : Array(NodeSelectorRequirement)?
    # A list of node selector requirements by node's fields.
    @[JSON::Field(key: "matchFields")]
    @[YAML::Field(key: "matchFields")]
    property match_fields : Array(NodeSelectorRequirement)?
  end

  # NodeSpec describes the attributes that a node is created with.
  struct NodeSpec
    include Kubernetes::Serializable

    # Deprecated: Previously used to specify the source of the node's configuration for the DynamicKubeletConfig feature. This feature is removed.
    @[JSON::Field(key: "configSource")]
    @[YAML::Field(key: "configSource")]
    property config_source : NodeConfigSource?
    # Deprecated. Not all kubelets will set this field. Remove field after 1.13. see: https://issues.k8s.io/61966
    @[JSON::Field(key: "externalID")]
    @[YAML::Field(key: "externalID")]
    property external_id : String?
    # PodCIDR represents the pod IP range assigned to the node.
    @[JSON::Field(key: "podCIDR")]
    @[YAML::Field(key: "podCIDR")]
    property pod_cidr : String?
    # podCIDRs represents the IP ranges assigned to the node for usage by Pods on that node. If this field is specified, the 0th entry must match the podCIDR field. It may contain at most 1 value for each of IPv4 and IPv6.
    @[JSON::Field(key: "podCIDRs")]
    @[YAML::Field(key: "podCIDRs")]
    property pod_cid_rs : Array(String)?
    # ID of the node assigned by the cloud provider in the format: <ProviderName>://<ProviderSpecificNodeID>
    @[JSON::Field(key: "providerID")]
    @[YAML::Field(key: "providerID")]
    property provider_id : String?
    # If specified, the node's taints.
    property taints : Array(Taint)?
    # Unschedulable controls node schedulability of new pods. By default, node is schedulable. More info: https://kubernetes.io/docs/concepts/nodes/node/#manual-node-administration
    property unschedulable : Bool?
  end

  # NodeStatus is information about the current status of a node.
  struct NodeStatus
    include Kubernetes::Serializable

    # List of addresses reachable to the node. Queried from cloud provider, if available. More info: https://kubernetes.io/docs/reference/node/node-status/#addresses Note: This field is declared as mergeable, but the merge key is not sufficiently unique, which can cause data corruption when it is merged. Callers should instead use a full-replacement patch. See https://pr.k8s.io/79391 for an example. Consumers should assume that addresses can change during the lifetime of a Node. However, there are some exceptions where this may not be possible, such as Pods that inherit a Node's address in its own status or consumers of the downward API (status.hostIP).
    property addresses : Array(NodeAddress)?
    # Allocatable represents the resources of a node that are available for scheduling. Defaults to Capacity.
    property allocatable : Hash(String, String)?
    # Capacity represents the total resources of a node. More info: https://kubernetes.io/docs/reference/node/node-status/#capacity
    property capacity : Hash(String, String)?
    # Conditions is an array of current observed node conditions. More info: https://kubernetes.io/docs/reference/node/node-status/#condition
    property conditions : Array(NodeCondition)?
    # Status of the config assigned to the node via the dynamic Kubelet config feature.
    property config : NodeConfigStatus?
    # Endpoints of daemons running on the Node.
    @[JSON::Field(key: "daemonEndpoints")]
    @[YAML::Field(key: "daemonEndpoints")]
    property daemon_endpoints : NodeDaemonEndpoints?
    # Features describes the set of features implemented by the CRI implementation.
    property features : NodeFeatures?
    # List of container images on this node
    property images : Array(ContainerImage)?
    # Set of ids/uuids to uniquely identify the node. More info: https://kubernetes.io/docs/reference/node/node-status/#info
    @[JSON::Field(key: "nodeInfo")]
    @[YAML::Field(key: "nodeInfo")]
    property node_info : NodeSystemInfo?
    # NodePhase is the recently observed lifecycle phase of the node. More info: https://kubernetes.io/docs/concepts/nodes/node/#phase The field is never populated, and now is deprecated.
    property phase : String?
    # The available runtime handlers.
    @[JSON::Field(key: "runtimeHandlers")]
    @[YAML::Field(key: "runtimeHandlers")]
    property runtime_handlers : Array(NodeRuntimeHandler)?
    # List of volumes that are attached to the node.
    @[JSON::Field(key: "volumesAttached")]
    @[YAML::Field(key: "volumesAttached")]
    property volumes_attached : Array(AttachedVolume)?
    # List of attachable volumes in use (mounted) by the node.
    @[JSON::Field(key: "volumesInUse")]
    @[YAML::Field(key: "volumesInUse")]
    property volumes_in_use : Array(String)?
  end

  # NodeSwapStatus represents swap memory information.
  struct NodeSwapStatus
    include Kubernetes::Serializable

    # Total amount of swap memory in bytes.
    property capacity : Int64?
  end

  # NodeSystemInfo is a set of ids/uuids to uniquely identify the node.
  struct NodeSystemInfo
    include Kubernetes::Serializable

    # The Architecture reported by the node
    property architecture : String?
    # Boot ID reported by the node.
    @[JSON::Field(key: "bootID")]
    @[YAML::Field(key: "bootID")]
    property boot_id : String?
    # ContainerRuntime Version reported by the node through runtime remote API (e.g. containerd://1.4.2).
    @[JSON::Field(key: "containerRuntimeVersion")]
    @[YAML::Field(key: "containerRuntimeVersion")]
    property container_runtime_version : String?
    # Kernel Version reported by the node from 'uname -r' (e.g. 3.16.0-0.bpo.4-amd64).
    @[JSON::Field(key: "kernelVersion")]
    @[YAML::Field(key: "kernelVersion")]
    property kernel_version : String?
    # Deprecated: KubeProxy Version reported by the node.
    @[JSON::Field(key: "kubeProxyVersion")]
    @[YAML::Field(key: "kubeProxyVersion")]
    property kube_proxy_version : String?
    # Kubelet Version reported by the node.
    @[JSON::Field(key: "kubeletVersion")]
    @[YAML::Field(key: "kubeletVersion")]
    property kubelet_version : String?
    # MachineID reported by the node. For unique machine identification in the cluster this field is preferred. Learn more from man(5) machine-id: http://man7.org/linux/man-pages/man5/machine-id.5.html
    @[JSON::Field(key: "machineID")]
    @[YAML::Field(key: "machineID")]
    property machine_id : String?
    # The Operating System reported by the node
    @[JSON::Field(key: "operatingSystem")]
    @[YAML::Field(key: "operatingSystem")]
    property operating_system : String?
    # OS Image reported by the node from /etc/os-release (e.g. Debian GNU/Linux 7 (wheezy)).
    @[JSON::Field(key: "osImage")]
    @[YAML::Field(key: "osImage")]
    property os_image : String?
    # Swap Info reported by the node.
    property swap : NodeSwapStatus?
    # SystemUUID reported by the node. For unique machine identification MachineID is preferred. This field is specific to Red Hat hosts https://access.redhat.com/documentation/en-us/red_hat_subscription_management/1/html/rhsm/uuid
    @[JSON::Field(key: "systemUUID")]
    @[YAML::Field(key: "systemUUID")]
    property system_uuid : String?
  end

  # ObjectFieldSelector selects an APIVersioned field of an object.
  struct ObjectFieldSelector
    include Kubernetes::Serializable

    # Version of the schema the FieldPath is written in terms of, defaults to "v1".
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Path of the field to select in the specified API version.
    @[JSON::Field(key: "fieldPath")]
    @[YAML::Field(key: "fieldPath")]
    property field_path : String?
  end

  # ObjectReference contains enough information to let you inspect or modify the referred object.
  struct ObjectReference
    include Kubernetes::Serializable

    # API version of the referent.
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # If referring to a piece of an object instead of an entire object, this string should contain a valid JSON/Go field access statement, such as desiredState.manifest.containers[2]. For example, if the object reference is to a container within a pod, this would take on a value like: "spec.containers{name}" (where "name" refers to the name of the container that triggered the event) or if no container name is specified "spec.containers[2]" (container with index 2 in this pod). This syntax is chosen only to have some well-defined way of referencing a part of an object.
    @[JSON::Field(key: "fieldPath")]
    @[YAML::Field(key: "fieldPath")]
    property field_path : String?
    # Kind of the referent. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
    property name : String?
    # Namespace of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/
    property namespace : String?
    # Specific resourceVersion to which this reference is made, if any. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#concurrency-control-and-consistency
    @[JSON::Field(key: "resourceVersion")]
    @[YAML::Field(key: "resourceVersion")]
    property resource_version : String?
    # UID of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#uids
    property uid : String?
  end

  # PersistentVolume (PV) is a storage resource provisioned by an administrator. It is analogous to a node. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes
  struct PersistentVolume
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ObjectMeta?
    # spec defines a specification of a persistent volume owned by the cluster. Provisioned by an administrator. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistent-volumes
    property spec : PersistentVolumeSpec?
    # status represents the current information/status for the persistent volume. Populated by the system. Read-only. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistent-volumes
    property status : PersistentVolumeStatus?
  end

  # PersistentVolumeClaim is a user's request for and claim to a persistent volume
  struct PersistentVolumeClaim
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ObjectMeta?
    # spec defines the desired characteristics of a volume requested by a pod author. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims
    property spec : PersistentVolumeClaimSpec?
    # status represents the current information/status of a persistent volume claim. Read-only. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims
    property status : PersistentVolumeClaimStatus?
  end

  # PersistentVolumeClaimCondition contains details about state of pvc
  struct PersistentVolumeClaimCondition
    include Kubernetes::Serializable

    # lastProbeTime is the time we probed the condition.
    @[JSON::Field(key: "lastProbeTime")]
    @[YAML::Field(key: "lastProbeTime")]
    property last_probe_time : Time?
    # lastTransitionTime is the time the condition transitioned from one status to another.
    @[JSON::Field(key: "lastTransitionTime")]
    @[YAML::Field(key: "lastTransitionTime")]
    property last_transition_time : Time?
    # message is the human-readable message indicating details about last transition.
    property message : String?
    # reason is a unique, this should be a short, machine understandable string that gives the reason for condition's last transition. If it reports "Resizing" that means the underlying persistent volume is being resized.
    property reason : String?
    # Status is the status of the condition. Can be True, False, Unknown. More info: https://kubernetes.io/docs/reference/kubernetes-api/config-and-storage-resources/persistent-volume-claim-v1/#:~:text=state%20of%20pvc-,conditions.status,-(string)%2C%20required
    property status : String?
    # Type is the type of the condition. More info: https://kubernetes.io/docs/reference/kubernetes-api/config-and-storage-resources/persistent-volume-claim-v1/#:~:text=set%20to%20%27ResizeStarted%27.-,PersistentVolumeClaimCondition,-contains%20details%20about
    property type : String?
  end

  # PersistentVolumeClaimList is a list of PersistentVolumeClaim items.
  struct PersistentVolumeClaimList
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # items is a list of persistent volume claims. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims
    property items : Array(PersistentVolumeClaim)?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard list metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property metadata : ListMeta?
  end

  # PersistentVolumeClaimSpec describes the common attributes of storage devices and allows a Source for provider-specific attributes
  struct PersistentVolumeClaimSpec
    include Kubernetes::Serializable

    # accessModes contains the desired access modes the volume should have. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes-1
    @[JSON::Field(key: "accessModes")]
    @[YAML::Field(key: "accessModes")]
    property access_modes : Array(String)?
    # dataSource field can be used to specify either: * An existing VolumeSnapshot object (snapshot.storage.k8s.io/VolumeSnapshot) * An existing PVC (PersistentVolumeClaim) If the provisioner or an external controller can support the specified data source, it will create a new volume based on the contents of the specified data source. When the AnyVolumeDataSource feature gate is enabled, dataSource contents will be copied to dataSourceRef, and dataSourceRef contents will be copied to dataSource when dataSourceRef.namespace is not specified. If the namespace is specified, then dataSourceRef will not be copied to dataSource.
    @[JSON::Field(key: "dataSource")]
    @[YAML::Field(key: "dataSource")]
    property data_source : TypedLocalObjectReference?
    # dataSourceRef specifies the object from which to populate the volume with data, if a non-empty volume is desired. This may be any object from a non-empty API group (non core object) or a PersistentVolumeClaim object. When this field is specified, volume binding will only succeed if the type of the specified object matches some installed volume populator or dynamic provisioner. This field will replace the functionality of the dataSource field and as such if both fields are non-empty, they must have the same value. For backwards compatibility, when namespace isn't specified in dataSourceRef, both fields (dataSource and dataSourceRef) will be set to the same value automatically if one of them is empty and the other is non-empty. When namespace is specified in dataSourceRef, dataSource isn't set to the same value and must be empty. There are three important differences between dataSource and dataSourceRef: * While dataSource only allows two specific types of objects, dataSourceRef
    # allows any non-core object, as well as PersistentVolumeClaim objects.
    # * While dataSource ignores disallowed values (dropping them), dataSourceRef
    # preserves all values, and generates an error if a disallowed value is
    # specified.
    # * While dataSource only allows local objects, dataSourceRef allows objects
    # in any namespaces.
    # (Beta) Using this field requires the AnyVolumeDataSource feature gate to be enabled. (Alpha) Using the namespace field of dataSourceRef requires the CrossNamespaceVolumeDataSource feature gate to be enabled.
    @[JSON::Field(key: "dataSourceRef")]
    @[YAML::Field(key: "dataSourceRef")]
    property data_source_ref : TypedObjectReference?
    # resources represents the minimum resources the volume should have. If RecoverVolumeExpansionFailure feature is enabled users are allowed to specify resource requirements that are lower than previous value but must still be higher than capacity recorded in the status field of the claim. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#resources
    property resources : VolumeResourceRequirements?
    # selector is a label query over volumes to consider for binding.
    property selector : LabelSelector?
    # storageClassName is the name of the StorageClass required by the claim. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#class-1
    @[JSON::Field(key: "storageClassName")]
    @[YAML::Field(key: "storageClassName")]
    property storage_class_name : String?
    # volumeAttributesClassName may be used to set the VolumeAttributesClass used by this claim. If specified, the CSI driver will create or update the volume with the attributes defined in the corresponding VolumeAttributesClass. This has a different purpose than storageClassName, it can be changed after the claim is created. An empty string or nil value indicates that no VolumeAttributesClass will be applied to the claim. If the claim enters an Infeasible error state, this field can be reset to its previous value (including nil) to cancel the modification. If the resource referred to by volumeAttributesClass does not exist, this PersistentVolumeClaim will be set to a Pending state, as reflected by the modifyVolumeStatus field, until such as a resource exists. More info: https://kubernetes.io/docs/concepts/storage/volume-attributes-classes/
    @[JSON::Field(key: "volumeAttributesClassName")]
    @[YAML::Field(key: "volumeAttributesClassName")]
    property volume_attributes_class_name : String?
    # volumeMode defines what type of volume is required by the claim. Value of Filesystem is implied when not included in claim spec.
    @[JSON::Field(key: "volumeMode")]
    @[YAML::Field(key: "volumeMode")]
    property volume_mode : String?
    # volumeName is the binding reference to the PersistentVolume backing this claim.
    @[JSON::Field(key: "volumeName")]
    @[YAML::Field(key: "volumeName")]
    property volume_name : String?
  end

  # PersistentVolumeClaimStatus is the current status of a persistent volume claim.
  struct PersistentVolumeClaimStatus
    include Kubernetes::Serializable

    # accessModes contains the actual access modes the volume backing the PVC has. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes-1
    @[JSON::Field(key: "accessModes")]
    @[YAML::Field(key: "accessModes")]
    property access_modes : Array(String)?
    # allocatedResourceStatuses stores status of resource being resized for the given PVC. Key names follow standard Kubernetes label syntax. Valid values are either:
    # * Un-prefixed keys:
    # - storage - the capacity of the volume.
    # * Custom resources must use implementation-defined prefixed names such as "example.com/my-custom-resource"
    # Apart from above values - keys that are unprefixed or have kubernetes.io prefix are considered reserved and hence may not be used.
    # ClaimResourceStatus can be in any of following states:
    # - ControllerResizeInProgress:
    # State set when resize controller starts resizing the volume in control-plane.
    # - ControllerResizeFailed:
    # State set when resize has failed in resize controller with a terminal error.
    # - NodeResizePending:
    # State set when resize controller has finished resizing the volume but further resizing of
    # volume is needed on the node.
    # - NodeResizeInProgress:
    # State set when kubelet starts resizing the volume.
    # - NodeResizeFailed:
    # State set when resizing has failed in kubelet with a terminal error. Transient errors don't set
    # NodeResizeFailed.
    # For example: if expanding a PVC for more capacity - this field can be one of the following states:
    # - pvc.status.allocatedResourceStatus['storage'] = "ControllerResizeInProgress"
    # - pvc.status.allocatedResourceStatus['storage'] = "ControllerResizeFailed"
    # - pvc.status.allocatedResourceStatus['storage'] = "NodeResizePending"
    # - pvc.status.allocatedResourceStatus['storage'] = "NodeResizeInProgress"
    # - pvc.status.allocatedResourceStatus['storage'] = "NodeResizeFailed"
    # When this field is not set, it means that no resize operation is in progress for the given PVC.
    # A controller that receives PVC update with previously unknown resourceName or ClaimResourceStatus should ignore the update for the purpose it was designed. For example - a controller that only is responsible for resizing capacity of the volume, should ignore PVC updates that change other valid resources associated with PVC.
    # This is an alpha field and requires enabling RecoverVolumeExpansionFailure feature.
    @[JSON::Field(key: "allocatedResourceStatuses")]
    @[YAML::Field(key: "allocatedResourceStatuses")]
    property allocated_resource_statuses : Hash(String, String)?
    # allocatedResources tracks the resources allocated to a PVC including its capacity. Key names follow standard Kubernetes label syntax. Valid values are either:
    # * Un-prefixed keys:
    # - storage - the capacity of the volume.
    # * Custom resources must use implementation-defined prefixed names such as "example.com/my-custom-resource"
    # Apart from above values - keys that are unprefixed or have kubernetes.io prefix are considered reserved and hence may not be used.
    # Capacity reported here may be larger than the actual capacity when a volume expansion operation is requested. For storage quota, the larger value from allocatedResources and PVC.spec.resources is used. If allocatedResources is not set, PVC.spec.resources alone is used for quota calculation. If a volume expansion capacity request is lowered, allocatedResources is only lowered if there are no expansion operations in progress and if the actual volume capacity is equal or lower than the requested capacity.
    # A controller that receives PVC update with previously unknown resourceName should ignore the update for the purpose it was designed. For example - a controller that only is responsible for resizing capacity of the volume, should ignore PVC updates that change other valid resources associated with PVC.
    # This is an alpha field and requires enabling RecoverVolumeExpansionFailure feature.
    @[JSON::Field(key: "allocatedResources")]
    @[YAML::Field(key: "allocatedResources")]
    property allocated_resources : Hash(String, String)?
    # capacity represents the actual resources of the underlying volume.
    property capacity : Hash(String, String)?
    # conditions is the current Condition of persistent volume claim. If underlying persistent volume is being resized then the Condition will be set to 'Resizing'.
    property conditions : Array(PersistentVolumeClaimCondition)?
    # currentVolumeAttributesClassName is the current name of the VolumeAttributesClass the PVC is using. When unset, there is no VolumeAttributeClass applied to this PersistentVolumeClaim
    @[JSON::Field(key: "currentVolumeAttributesClassName")]
    @[YAML::Field(key: "currentVolumeAttributesClassName")]
    property current_volume_attributes_class_name : String?
    # ModifyVolumeStatus represents the status object of ControllerModifyVolume operation. When this is unset, there is no ModifyVolume operation being attempted.
    @[JSON::Field(key: "modifyVolumeStatus")]
    @[YAML::Field(key: "modifyVolumeStatus")]
    property modify_volume_status : ModifyVolumeStatus?
    # phase represents the current phase of PersistentVolumeClaim.
    property phase : String?
  end

  # PersistentVolumeClaimTemplate is used to produce PersistentVolumeClaim objects as part of an EphemeralVolumeSource.
  struct PersistentVolumeClaimTemplate
    include Kubernetes::Serializable

    # May contain labels and annotations that will be copied into the PVC when creating it. No other fields are allowed and will be rejected during validation.
    property metadata : ObjectMeta?
    # The specification for the PersistentVolumeClaim. The entire content is copied unchanged into the PVC that gets created from this template. The same fields as in a PersistentVolumeClaim are also valid here.
    property spec : PersistentVolumeClaimSpec?
  end

  # PersistentVolumeClaimVolumeSource references the user's PVC in the same namespace. This volume finds the bound PV and mounts that volume for the pod. A PersistentVolumeClaimVolumeSource is, essentially, a wrapper around another type of volume that is owned by someone else (the system).
  struct PersistentVolumeClaimVolumeSource
    include Kubernetes::Serializable

    # claimName is the name of a PersistentVolumeClaim in the same namespace as the pod using this volume. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims
    @[JSON::Field(key: "claimName")]
    @[YAML::Field(key: "claimName")]
    property claim_name : String?
    # readOnly Will force the ReadOnly setting in VolumeMounts. Default false.
    @[JSON::Field(key: "readOnly")]
    @[YAML::Field(key: "readOnly")]
    property read_only : Bool?
  end

  # PersistentVolumeList is a list of PersistentVolume items.
  struct PersistentVolumeList
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # items is a list of persistent volumes. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes
    property items : Array(PersistentVolume)?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard list metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property metadata : ListMeta?
  end

  # PersistentVolumeSpec is the specification of a persistent volume.
  struct PersistentVolumeSpec
    include Kubernetes::Serializable

    # accessModes contains all ways the volume can be mounted. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes
    @[JSON::Field(key: "accessModes")]
    @[YAML::Field(key: "accessModes")]
    property access_modes : Array(String)?
    # awsElasticBlockStore represents an AWS Disk resource that is attached to a kubelet's host machine and then exposed to the pod. Deprecated: AWSElasticBlockStore is deprecated. All operations for the in-tree awsElasticBlockStore type are redirected to the ebs.csi.aws.com CSI driver. More info: https://kubernetes.io/docs/concepts/storage/volumes#awselasticblockstore
    @[JSON::Field(key: "awsElasticBlockStore")]
    @[YAML::Field(key: "awsElasticBlockStore")]
    property aws_elastic_block_store : AWSElasticBlockStoreVolumeSource?
    # azureDisk represents an Azure Data Disk mount on the host and bind mount to the pod. Deprecated: AzureDisk is deprecated. All operations for the in-tree azureDisk type are redirected to the disk.csi.azure.com CSI driver.
    @[JSON::Field(key: "azureDisk")]
    @[YAML::Field(key: "azureDisk")]
    property azure_disk : AzureDiskVolumeSource?
    # azureFile represents an Azure File Service mount on the host and bind mount to the pod. Deprecated: AzureFile is deprecated. All operations for the in-tree azureFile type are redirected to the file.csi.azure.com CSI driver.
    @[JSON::Field(key: "azureFile")]
    @[YAML::Field(key: "azureFile")]
    property azure_file : AzureFilePersistentVolumeSource?
    # capacity is the description of the persistent volume's resources and capacity. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#capacity
    property capacity : Hash(String, String)?
    # cephFS represents a Ceph FS mount on the host that shares a pod's lifetime. Deprecated: CephFS is deprecated and the in-tree cephfs type is no longer supported.
    property cephfs : CephFSPersistentVolumeSource?
    # cinder represents a cinder volume attached and mounted on kubelets host machine. Deprecated: Cinder is deprecated. All operations for the in-tree cinder type are redirected to the cinder.csi.openstack.org CSI driver. More info: https://examples.k8s.io/mysql-cinder-pd/README.md
    property cinder : CinderPersistentVolumeSource?
    # claimRef is part of a bi-directional binding between PersistentVolume and PersistentVolumeClaim. Expected to be non-nil when bound. claim.VolumeName is the authoritative bind between PV and PVC. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#binding
    @[JSON::Field(key: "claimRef")]
    @[YAML::Field(key: "claimRef")]
    property claim_ref : ObjectReference?
    # csi represents storage that is handled by an external CSI driver.
    property csi : CSIPersistentVolumeSource?
    # fc represents a Fibre Channel resource that is attached to a kubelet's host machine and then exposed to the pod.
    property fc : FCVolumeSource?
    # flexVolume represents a generic volume resource that is provisioned/attached using an exec based plugin. Deprecated: FlexVolume is deprecated. Consider using a CSIDriver instead.
    @[JSON::Field(key: "flexVolume")]
    @[YAML::Field(key: "flexVolume")]
    property flex_volume : FlexPersistentVolumeSource?
    # flocker represents a Flocker volume attached to a kubelet's host machine and exposed to the pod for its usage. This depends on the Flocker control service being running. Deprecated: Flocker is deprecated and the in-tree flocker type is no longer supported.
    property flocker : FlockerVolumeSource?
    # gcePersistentDisk represents a GCE Disk resource that is attached to a kubelet's host machine and then exposed to the pod. Provisioned by an admin. Deprecated: GCEPersistentDisk is deprecated. All operations for the in-tree gcePersistentDisk type are redirected to the pd.csi.storage.gke.io CSI driver. More info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk
    @[JSON::Field(key: "gcePersistentDisk")]
    @[YAML::Field(key: "gcePersistentDisk")]
    property gce_persistent_disk : GCEPersistentDiskVolumeSource?
    # glusterfs represents a Glusterfs volume that is attached to a host and exposed to the pod. Provisioned by an admin. Deprecated: Glusterfs is deprecated and the in-tree glusterfs type is no longer supported. More info: https://examples.k8s.io/volumes/glusterfs/README.md
    property glusterfs : GlusterfsPersistentVolumeSource?
    # hostPath represents a directory on the host. Provisioned by a developer or tester. This is useful for single-node development and testing only! On-host storage is not supported in any way and WILL NOT WORK in a multi-node cluster. More info: https://kubernetes.io/docs/concepts/storage/volumes#hostpath
    @[JSON::Field(key: "hostPath")]
    @[YAML::Field(key: "hostPath")]
    property host_path : HostPathVolumeSource?
    # iscsi represents an ISCSI Disk resource that is attached to a kubelet's host machine and then exposed to the pod. Provisioned by an admin.
    property iscsi : ISCSIPersistentVolumeSource?
    # local represents directly-attached storage with node affinity
    property local : LocalVolumeSource?
    # mountOptions is the list of mount options, e.g. ["ro", "soft"]. Not validated - mount will simply fail if one is invalid. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes/#mount-options
    @[JSON::Field(key: "mountOptions")]
    @[YAML::Field(key: "mountOptions")]
    property mount_options : Array(String)?
    # nfs represents an NFS mount on the host. Provisioned by an admin. More info: https://kubernetes.io/docs/concepts/storage/volumes#nfs
    property nfs : NFSVolumeSource?
    # nodeAffinity defines constraints that limit what nodes this volume can be accessed from. This field influences the scheduling of pods that use this volume.
    @[JSON::Field(key: "nodeAffinity")]
    @[YAML::Field(key: "nodeAffinity")]
    property node_affinity : VolumeNodeAffinity?
    # persistentVolumeReclaimPolicy defines what happens to a persistent volume when released from its claim. Valid options are Retain (default for manually created PersistentVolumes), Delete (default for dynamically provisioned PersistentVolumes), and Recycle (deprecated). Recycle must be supported by the volume plugin underlying this PersistentVolume. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#reclaiming
    @[JSON::Field(key: "persistentVolumeReclaimPolicy")]
    @[YAML::Field(key: "persistentVolumeReclaimPolicy")]
    property persistent_volume_reclaim_policy : String?
    # photonPersistentDisk represents a PhotonController persistent disk attached and mounted on kubelets host machine. Deprecated: PhotonPersistentDisk is deprecated and the in-tree photonPersistentDisk type is no longer supported.
    @[JSON::Field(key: "photonPersistentDisk")]
    @[YAML::Field(key: "photonPersistentDisk")]
    property photon_persistent_disk : PhotonPersistentDiskVolumeSource?
    # portworxVolume represents a portworx volume attached and mounted on kubelets host machine. Deprecated: PortworxVolume is deprecated. All operations for the in-tree portworxVolume type are redirected to the pxd.portworx.com CSI driver when the CSIMigrationPortworx feature-gate is on.
    @[JSON::Field(key: "portworxVolume")]
    @[YAML::Field(key: "portworxVolume")]
    property portworx_volume : PortworxVolumeSource?
    # quobyte represents a Quobyte mount on the host that shares a pod's lifetime. Deprecated: Quobyte is deprecated and the in-tree quobyte type is no longer supported.
    property quobyte : QuobyteVolumeSource?
    # rbd represents a Rados Block Device mount on the host that shares a pod's lifetime. Deprecated: RBD is deprecated and the in-tree rbd type is no longer supported. More info: https://examples.k8s.io/volumes/rbd/README.md
    property rbd : RBDPersistentVolumeSource?
    # scaleIO represents a ScaleIO persistent volume attached and mounted on Kubernetes nodes. Deprecated: ScaleIO is deprecated and the in-tree scaleIO type is no longer supported.
    @[JSON::Field(key: "scaleIO")]
    @[YAML::Field(key: "scaleIO")]
    property scale_io : ScaleIOPersistentVolumeSource?
    # storageClassName is the name of StorageClass to which this persistent volume belongs. Empty value means that this volume does not belong to any StorageClass.
    @[JSON::Field(key: "storageClassName")]
    @[YAML::Field(key: "storageClassName")]
    property storage_class_name : String?
    # storageOS represents a StorageOS volume that is attached to the kubelet's host machine and mounted into the pod. Deprecated: StorageOS is deprecated and the in-tree storageos type is no longer supported. More info: https://examples.k8s.io/volumes/storageos/README.md
    property storageos : StorageOSPersistentVolumeSource?
    # Name of VolumeAttributesClass to which this persistent volume belongs. Empty value is not allowed. When this field is not set, it indicates that this volume does not belong to any VolumeAttributesClass. This field is mutable and can be changed by the CSI driver after a volume has been updated successfully to a new class. For an unbound PersistentVolume, the volumeAttributesClassName will be matched with unbound PersistentVolumeClaims during the binding process.
    @[JSON::Field(key: "volumeAttributesClassName")]
    @[YAML::Field(key: "volumeAttributesClassName")]
    property volume_attributes_class_name : String?
    # volumeMode defines if a volume is intended to be used with a formatted filesystem or to remain in raw block state. Value of Filesystem is implied when not included in spec.
    @[JSON::Field(key: "volumeMode")]
    @[YAML::Field(key: "volumeMode")]
    property volume_mode : String?
    # vsphereVolume represents a vSphere volume attached and mounted on kubelets host machine. Deprecated: VsphereVolume is deprecated. All operations for the in-tree vsphereVolume type are redirected to the csi.vsphere.vmware.com CSI driver.
    @[JSON::Field(key: "vsphereVolume")]
    @[YAML::Field(key: "vsphereVolume")]
    property vsphere_volume : VsphereVirtualDiskVolumeSource?
  end

  # PersistentVolumeStatus is the current status of a persistent volume.
  struct PersistentVolumeStatus
    include Kubernetes::Serializable

    # lastPhaseTransitionTime is the time the phase transitioned from one to another and automatically resets to current time everytime a volume phase transitions.
    @[JSON::Field(key: "lastPhaseTransitionTime")]
    @[YAML::Field(key: "lastPhaseTransitionTime")]
    property last_phase_transition_time : Time?
    # message is a human-readable message indicating details about why the volume is in this state.
    property message : String?
    # phase indicates if a volume is available, bound to a claim, or released by a claim. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#phase
    property phase : String?
    # reason is a brief CamelCase string that describes any failure and is meant for machine parsing and tidy display in the CLI.
    property reason : String?
  end

  # Represents a Photon Controller persistent disk resource.
  struct PhotonPersistentDiskVolumeSource
    include Kubernetes::Serializable

    # fsType is the filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. "ext4", "xfs", "ntfs". Implicitly inferred to be "ext4" if unspecified.
    @[JSON::Field(key: "fsType")]
    @[YAML::Field(key: "fsType")]
    property fs_type : String?
    # pdID is the ID that identifies Photon Controller persistent disk
    @[JSON::Field(key: "pdID")]
    @[YAML::Field(key: "pdID")]
    property pd_id : String?
  end

  # Pod is a collection of containers that can run on a host. This resource is created by clients and scheduled onto hosts.
  struct Pod
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ObjectMeta?
    # Specification of the desired behavior of the pod. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status
    property spec : PodSpec?
    # Most recently observed status of the pod. This data may not be up to date. Populated by the system. Read-only. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status
    property status : PodStatus?
  end

  # Pod affinity is a group of inter pod affinity scheduling rules.
  struct PodAffinity
    include Kubernetes::Serializable

    # The scheduler will prefer to schedule pods to nodes that satisfy the affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding "weight" to the sum if the node has pods which matches the corresponding podAffinityTerm; the node(s) with the highest sum are the most preferred.
    @[JSON::Field(key: "preferredDuringSchedulingIgnoredDuringExecution")]
    @[YAML::Field(key: "preferredDuringSchedulingIgnoredDuringExecution")]
    property preferred_during_scheduling_ignored_during_execution : Array(WeightedPodAffinityTerm)?
    # If the affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to a pod label update), the system may or may not try to eventually evict the pod from its node. When there are multiple elements, the lists of nodes corresponding to each podAffinityTerm are intersected, i.e. all terms must be satisfied.
    @[JSON::Field(key: "requiredDuringSchedulingIgnoredDuringExecution")]
    @[YAML::Field(key: "requiredDuringSchedulingIgnoredDuringExecution")]
    property required_during_scheduling_ignored_during_execution : Array(PodAffinityTerm)?
  end

  # Defines a set of pods (namely those matching the labelSelector relative to the given namespace(s)) that this pod should be co-located (affinity) or not co-located (anti-affinity) with, where co-located is defined as running on a node whose value of the label with key <topologyKey> matches that of any node on which a pod of the set of pods is running
  struct PodAffinityTerm
    include Kubernetes::Serializable

    # A label query over a set of resources, in this case pods. If it's null, this PodAffinityTerm matches with no Pods.
    @[JSON::Field(key: "labelSelector")]
    @[YAML::Field(key: "labelSelector")]
    property label_selector : LabelSelector?
    # MatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration. The keys are used to lookup values from the incoming pod labels, those key-value labels are merged with `labelSelector` as `key in (value)` to select the group of existing pods which pods will be taken into consideration for the incoming pod's pod (anti) affinity. Keys that don't exist in the incoming pod labels will be ignored. The default value is empty. The same key is forbidden to exist in both matchLabelKeys and labelSelector. Also, matchLabelKeys cannot be set when labelSelector isn't set.
    @[JSON::Field(key: "matchLabelKeys")]
    @[YAML::Field(key: "matchLabelKeys")]
    property match_label_keys : Array(String)?
    # MismatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration. The keys are used to lookup values from the incoming pod labels, those key-value labels are merged with `labelSelector` as `key notin (value)` to select the group of existing pods which pods will be taken into consideration for the incoming pod's pod (anti) affinity. Keys that don't exist in the incoming pod labels will be ignored. The default value is empty. The same key is forbidden to exist in both mismatchLabelKeys and labelSelector. Also, mismatchLabelKeys cannot be set when labelSelector isn't set.
    @[JSON::Field(key: "mismatchLabelKeys")]
    @[YAML::Field(key: "mismatchLabelKeys")]
    property mismatch_label_keys : Array(String)?
    # A label query over the set of namespaces that the term applies to. The term is applied to the union of the namespaces selected by this field and the ones listed in the namespaces field. null selector and null or empty namespaces list means "this pod's namespace". An empty selector ({}) matches all namespaces.
    @[JSON::Field(key: "namespaceSelector")]
    @[YAML::Field(key: "namespaceSelector")]
    property namespace_selector : LabelSelector?
    # namespaces specifies a static list of namespace names that the term applies to. The term is applied to the union of the namespaces listed in this field and the ones selected by namespaceSelector. null or empty namespaces list and null namespaceSelector means "this pod's namespace".
    property namespaces : Array(String)?
    # This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed.
    @[JSON::Field(key: "topologyKey")]
    @[YAML::Field(key: "topologyKey")]
    property topology_key : String?
  end

  # Pod anti affinity is a group of inter pod anti affinity scheduling rules.
  struct PodAntiAffinity
    include Kubernetes::Serializable

    # The scheduler will prefer to schedule pods to nodes that satisfy the anti-affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling anti-affinity expressions, etc.), compute a sum by iterating through the elements of this field and subtracting "weight" from the sum if the node has pods which matches the corresponding podAffinityTerm; the node(s) with the highest sum are the most preferred.
    @[JSON::Field(key: "preferredDuringSchedulingIgnoredDuringExecution")]
    @[YAML::Field(key: "preferredDuringSchedulingIgnoredDuringExecution")]
    property preferred_during_scheduling_ignored_during_execution : Array(WeightedPodAffinityTerm)?
    # If the anti-affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the anti-affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to a pod label update), the system may or may not try to eventually evict the pod from its node. When there are multiple elements, the lists of nodes corresponding to each podAffinityTerm are intersected, i.e. all terms must be satisfied.
    @[JSON::Field(key: "requiredDuringSchedulingIgnoredDuringExecution")]
    @[YAML::Field(key: "requiredDuringSchedulingIgnoredDuringExecution")]
    property required_during_scheduling_ignored_during_execution : Array(PodAffinityTerm)?
  end

  # PodCertificateProjection provides a private key and X.509 certificate in the pod filesystem.
  struct PodCertificateProjection
    include Kubernetes::Serializable

    # Write the certificate chain at this path in the projected volume.
    # Most applications should use credentialBundlePath.  When using keyPath and certificateChainPath, your application needs to check that the key and leaf certificate are consistent, because it is possible to read the files mid-rotation.
    @[JSON::Field(key: "certificateChainPath")]
    @[YAML::Field(key: "certificateChainPath")]
    property certificate_chain_path : String?
    # Write the credential bundle at this path in the projected volume.
    # The credential bundle is a single file that contains multiple PEM blocks. The first PEM block is a PRIVATE KEY block, containing a PKCS#8 private key.
    # The remaining blocks are CERTIFICATE blocks, containing the issued certificate chain from the signer (leaf and any intermediates).
    # Using credentialBundlePath lets your Pod's application code make a single atomic read that retrieves a consistent key and certificate chain.  If you project them to separate files, your application code will need to additionally check that the leaf certificate was issued to the key.
    @[JSON::Field(key: "credentialBundlePath")]
    @[YAML::Field(key: "credentialBundlePath")]
    property credential_bundle_path : String?
    # Write the key at this path in the projected volume.
    # Most applications should use credentialBundlePath.  When using keyPath and certificateChainPath, your application needs to check that the key and leaf certificate are consistent, because it is possible to read the files mid-rotation.
    @[JSON::Field(key: "keyPath")]
    @[YAML::Field(key: "keyPath")]
    property key_path : String?
    # The type of keypair Kubelet will generate for the pod.
    # Valid values are "RSA3072", "RSA4096", "ECDSAP256", "ECDSAP384", "ECDSAP521", and "ED25519".
    @[JSON::Field(key: "keyType")]
    @[YAML::Field(key: "keyType")]
    property key_type : String?
    # maxExpirationSeconds is the maximum lifetime permitted for the certificate.
    # Kubelet copies this value verbatim into the PodCertificateRequests it generates for this projection.
    # If omitted, kube-apiserver will set it to 86400(24 hours). kube-apiserver will reject values shorter than 3600 (1 hour).  The maximum allowable value is 7862400 (91 days).
    # The signer implementation is then free to issue a certificate with any lifetime *shorter* than MaxExpirationSeconds, but no shorter than 3600 seconds (1 hour).  This constraint is enforced by kube-apiserver. `kubernetes.io` signers will never issue certificates with a lifetime longer than 24 hours.
    @[JSON::Field(key: "maxExpirationSeconds")]
    @[YAML::Field(key: "maxExpirationSeconds")]
    property max_expiration_seconds : Int32?
    # Kubelet's generated CSRs will be addressed to this signer.
    @[JSON::Field(key: "signerName")]
    @[YAML::Field(key: "signerName")]
    property signer_name : String?
  end

  # PodCondition contains details for the current condition of this pod.
  struct PodCondition
    include Kubernetes::Serializable

    # Last time we probed the condition.
    @[JSON::Field(key: "lastProbeTime")]
    @[YAML::Field(key: "lastProbeTime")]
    property last_probe_time : Time?
    # Last time the condition transitioned from one status to another.
    @[JSON::Field(key: "lastTransitionTime")]
    @[YAML::Field(key: "lastTransitionTime")]
    property last_transition_time : Time?
    # Human-readable message indicating details about last transition.
    property message : String?
    # If set, this represents the .metadata.generation that the pod condition was set based upon. This is an alpha field. Enable PodObservedGenerationTracking to be able to use this field.
    @[JSON::Field(key: "observedGeneration")]
    @[YAML::Field(key: "observedGeneration")]
    property observed_generation : Int64?
    # Unique, one-word, CamelCase reason for the condition's last transition.
    property reason : String?
    # Status is the status of the condition. Can be True, False, Unknown. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#pod-conditions
    property status : String?
    # Type is the type of the condition. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#pod-conditions
    property type : String?
  end

  # PodDNSConfig defines the DNS parameters of a pod in addition to those generated from DNSPolicy.
  struct PodDNSConfig
    include Kubernetes::Serializable

    # A list of DNS name server IP addresses. This will be appended to the base nameservers generated from DNSPolicy. Duplicated nameservers will be removed.
    property nameservers : Array(String)?
    # A list of DNS resolver options. This will be merged with the base options generated from DNSPolicy. Duplicated entries will be removed. Resolution options given in Options will override those that appear in the base DNSPolicy.
    property options : Array(PodDNSConfigOption)?
    # A list of DNS search domains for host-name lookup. This will be appended to the base search paths generated from DNSPolicy. Duplicated search paths will be removed.
    property searches : Array(String)?
  end

  # PodDNSConfigOption defines DNS resolver options of a pod.
  struct PodDNSConfigOption
    include Kubernetes::Serializable

    # Name is this DNS resolver option's name. Required.
    property name : String?
    # Value is this DNS resolver option's value.
    property value : String?
  end

  # PodExtendedResourceClaimStatus is stored in the PodStatus for the extended resource requests backed by DRA. It stores the generated name for the corresponding special ResourceClaim created by the scheduler.
  struct PodExtendedResourceClaimStatus
    include Kubernetes::Serializable

    # RequestMappings identifies the mapping of <container, extended resource backed by DRA> to  device request in the generated ResourceClaim.
    @[JSON::Field(key: "requestMappings")]
    @[YAML::Field(key: "requestMappings")]
    property request_mappings : Array(ContainerExtendedResourceRequest)?
    # ResourceClaimName is the name of the ResourceClaim that was generated for the Pod in the namespace of the Pod.
    @[JSON::Field(key: "resourceClaimName")]
    @[YAML::Field(key: "resourceClaimName")]
    property resource_claim_name : String?
  end

  # PodIP represents a single IP address allocated to the pod.
  struct PodIP
    include Kubernetes::Serializable

    # IP is the IP address assigned to the pod
    property ip : String?
  end

  # PodList is a list of Pods.
  struct PodList
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # List of pods. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md
    property items : Array(Pod)?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard list metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property metadata : ListMeta?
  end

  # PodOS defines the OS parameters of a pod.
  struct PodOS
    include Kubernetes::Serializable

    # Name is the name of the operating system. The currently supported values are linux and windows. Additional value may be defined in future and can be one of: https://github.com/opencontainers/runtime-spec/blob/master/config.md#platform-specific-configuration Clients should expect to handle additional values and treat unrecognized values in this field as os: null
    property name : String?
  end

  # PodReadinessGate contains the reference to a pod condition
  struct PodReadinessGate
    include Kubernetes::Serializable

    # ConditionType refers to a condition in the pod's condition list with matching type.
    @[JSON::Field(key: "conditionType")]
    @[YAML::Field(key: "conditionType")]
    property condition_type : String?
  end

  # PodResourceClaim references exactly one ResourceClaim, either directly or by naming a ResourceClaimTemplate which is then turned into a ResourceClaim for the pod.
  # It adds a name to it that uniquely identifies the ResourceClaim inside the Pod. Containers that need access to the ResourceClaim reference it with this name.
  struct PodResourceClaim
    include Kubernetes::Serializable

    # Name uniquely identifies this resource claim inside the pod. This must be a DNS_LABEL.
    property name : String?
    # ResourceClaimName is the name of a ResourceClaim object in the same namespace as this pod.
    # Exactly one of ResourceClaimName and ResourceClaimTemplateName must be set.
    @[JSON::Field(key: "resourceClaimName")]
    @[YAML::Field(key: "resourceClaimName")]
    property resource_claim_name : String?
    # ResourceClaimTemplateName is the name of a ResourceClaimTemplate object in the same namespace as this pod.
    # The template will be used to create a new ResourceClaim, which will be bound to this pod. When this pod is deleted, the ResourceClaim will also be deleted. The pod name and resource name, along with a generated component, will be used to form a unique name for the ResourceClaim, which will be recorded in pod.status.resourceClaimStatuses.
    # This field is immutable and no changes will be made to the corresponding ResourceClaim by the control plane after creating the ResourceClaim.
    # Exactly one of ResourceClaimName and ResourceClaimTemplateName must be set.
    @[JSON::Field(key: "resourceClaimTemplateName")]
    @[YAML::Field(key: "resourceClaimTemplateName")]
    property resource_claim_template_name : String?
  end

  # PodResourceClaimStatus is stored in the PodStatus for each PodResourceClaim which references a ResourceClaimTemplate. It stores the generated name for the corresponding ResourceClaim.
  struct PodResourceClaimStatus
    include Kubernetes::Serializable

    # Name uniquely identifies this resource claim inside the pod. This must match the name of an entry in pod.spec.resourceClaims, which implies that the string must be a DNS_LABEL.
    property name : String?
    # ResourceClaimName is the name of the ResourceClaim that was generated for the Pod in the namespace of the Pod. If this is unset, then generating a ResourceClaim was not necessary. The pod.spec.resourceClaims entry can be ignored in this case.
    @[JSON::Field(key: "resourceClaimName")]
    @[YAML::Field(key: "resourceClaimName")]
    property resource_claim_name : String?
  end

  # PodSchedulingGate is associated to a Pod to guard its scheduling.
  struct PodSchedulingGate
    include Kubernetes::Serializable

    # Name of the scheduling gate. Each scheduling gate must have a unique name field.
    property name : String?
  end

  # PodSecurityContext holds pod-level security attributes and common container settings. Some fields are also present in container.securityContext.  Field values of container.securityContext take precedence over field values of PodSecurityContext.
  struct PodSecurityContext
    include Kubernetes::Serializable

    # appArmorProfile is the AppArmor options to use by the containers in this pod. Note that this field cannot be set when spec.os.name is windows.
    @[JSON::Field(key: "appArmorProfile")]
    @[YAML::Field(key: "appArmorProfile")]
    property app_armor_profile : AppArmorProfile?
    # A special supplemental group that applies to all containers in a pod. Some volume types allow the Kubelet to change the ownership of that volume to be owned by the pod:
    # 1. The owning GID will be the FSGroup 2. The setgid bit is set (new files created in the volume will be owned by FSGroup) 3. The permission bits are OR'd with rw-rw----
    # If unset, the Kubelet will not modify the ownership and permissions of any volume. Note that this field cannot be set when spec.os.name is windows.
    @[JSON::Field(key: "fsGroup")]
    @[YAML::Field(key: "fsGroup")]
    property fs_group : Int64?
    # fsGroupChangePolicy defines behavior of changing ownership and permission of the volume before being exposed inside Pod. This field will only apply to volume types which support fsGroup based ownership(and permissions). It will have no effect on ephemeral volume types such as: secret, configmaps and emptydir. Valid values are "OnRootMismatch" and "Always". If not specified, "Always" is used. Note that this field cannot be set when spec.os.name is windows.
    @[JSON::Field(key: "fsGroupChangePolicy")]
    @[YAML::Field(key: "fsGroupChangePolicy")]
    property fs_group_change_policy : String?
    # The GID to run the entrypoint of the container process. Uses runtime default if unset. May also be set in SecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence for that container. Note that this field cannot be set when spec.os.name is windows.
    @[JSON::Field(key: "runAsGroup")]
    @[YAML::Field(key: "runAsGroup")]
    property run_as_group : Int64?
    # Indicates that the container must run as a non-root user. If true, the Kubelet will validate the image at runtime to ensure that it does not run as UID 0 (root) and fail to start the container if it does. If unset or false, no such validation will be performed. May also be set in SecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence.
    @[JSON::Field(key: "runAsNonRoot")]
    @[YAML::Field(key: "runAsNonRoot")]
    property run_as_non_root : Bool?
    # The UID to run the entrypoint of the container process. Defaults to user specified in image metadata if unspecified. May also be set in SecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence for that container. Note that this field cannot be set when spec.os.name is windows.
    @[JSON::Field(key: "runAsUser")]
    @[YAML::Field(key: "runAsUser")]
    property run_as_user : Int64?
    # seLinuxChangePolicy defines how the container's SELinux label is applied to all volumes used by the Pod. It has no effect on nodes that do not support SELinux or to volumes does not support SELinux. Valid values are "MountOption" and "Recursive".
    # "Recursive" means relabeling of all files on all Pod volumes by the container runtime. This may be slow for large volumes, but allows mixing privileged and unprivileged Pods sharing the same volume on the same node.
    # "MountOption" mounts all eligible Pod volumes with `-o context` mount option. This requires all Pods that share the same volume to use the same SELinux label. It is not possible to share the same volume among privileged and unprivileged Pods. Eligible volumes are in-tree FibreChannel and iSCSI volumes, and all CSI volumes whose CSI driver announces SELinux support by setting spec.seLinuxMount: true in their CSIDriver instance. Other volumes are always re-labelled recursively. "MountOption" value is allowed only when SELinuxMount feature gate is enabled.
    # If not specified and SELinuxMount feature gate is enabled, "MountOption" is used. If not specified and SELinuxMount feature gate is disabled, "MountOption" is used for ReadWriteOncePod volumes and "Recursive" for all other volumes.
    # This field affects only Pods that have SELinux label set, either in PodSecurityContext or in SecurityContext of all containers.
    # All Pods that use the same volume should use the same seLinuxChangePolicy, otherwise some pods can get stuck in ContainerCreating state. Note that this field cannot be set when spec.os.name is windows.
    @[JSON::Field(key: "seLinuxChangePolicy")]
    @[YAML::Field(key: "seLinuxChangePolicy")]
    property se_linux_change_policy : String?
    # The SELinux context to be applied to all containers. If unspecified, the container runtime will allocate a random SELinux context for each container.  May also be set in SecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence for that container. Note that this field cannot be set when spec.os.name is windows.
    @[JSON::Field(key: "seLinuxOptions")]
    @[YAML::Field(key: "seLinuxOptions")]
    property se_linux_options : SELinuxOptions?
    # The seccomp options to use by the containers in this pod. Note that this field cannot be set when spec.os.name is windows.
    @[JSON::Field(key: "seccompProfile")]
    @[YAML::Field(key: "seccompProfile")]
    property seccomp_profile : SeccompProfile?
    # A list of groups applied to the first process run in each container, in addition to the container's primary GID and fsGroup (if specified).  If the SupplementalGroupsPolicy feature is enabled, the supplementalGroupsPolicy field determines whether these are in addition to or instead of any group memberships defined in the container image. If unspecified, no additional groups are added, though group memberships defined in the container image may still be used, depending on the supplementalGroupsPolicy field. Note that this field cannot be set when spec.os.name is windows.
    @[JSON::Field(key: "supplementalGroups")]
    @[YAML::Field(key: "supplementalGroups")]
    property supplemental_groups : Array(Int64)?
    # Defines how supplemental groups of the first container processes are calculated. Valid values are "Merge" and "Strict". If not specified, "Merge" is used. (Alpha) Using the field requires the SupplementalGroupsPolicy feature gate to be enabled and the container runtime must implement support for this feature. Note that this field cannot be set when spec.os.name is windows.
    @[JSON::Field(key: "supplementalGroupsPolicy")]
    @[YAML::Field(key: "supplementalGroupsPolicy")]
    property supplemental_groups_policy : String?
    # Sysctls hold a list of namespaced sysctls used for the pod. Pods with unsupported sysctls (by the container runtime) might fail to launch. Note that this field cannot be set when spec.os.name is windows.
    property sysctls : Array(Sysctl)?
    # The Windows specific settings applied to all containers. If unspecified, the options within a container's SecurityContext will be used. If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence. Note that this field cannot be set when spec.os.name is linux.
    @[JSON::Field(key: "windowsOptions")]
    @[YAML::Field(key: "windowsOptions")]
    property windows_options : WindowsSecurityContextOptions?
  end

  # PodSpec is a description of a pod.
  struct PodSpec
    include Kubernetes::Serializable

    # Optional duration in seconds the pod may be active on the node relative to StartTime before the system will actively try to mark it failed and kill associated containers. Value must be a positive integer.
    @[JSON::Field(key: "activeDeadlineSeconds")]
    @[YAML::Field(key: "activeDeadlineSeconds")]
    property active_deadline_seconds : Int64?
    # If specified, the pod's scheduling constraints
    property affinity : Affinity?
    # AutomountServiceAccountToken indicates whether a service account token should be automatically mounted.
    @[JSON::Field(key: "automountServiceAccountToken")]
    @[YAML::Field(key: "automountServiceAccountToken")]
    property automount_service_account_token : Bool?
    # List of containers belonging to the pod. Containers cannot currently be added or removed. There must be at least one container in a Pod. Cannot be updated.
    property containers : Array(Container)?
    # Specifies the DNS parameters of a pod. Parameters specified here will be merged to the generated DNS configuration based on DNSPolicy.
    @[JSON::Field(key: "dnsConfig")]
    @[YAML::Field(key: "dnsConfig")]
    property dns_config : PodDNSConfig?
    # Set DNS policy for the pod. Defaults to "ClusterFirst". Valid values are 'ClusterFirstWithHostNet', 'ClusterFirst', 'Default' or 'None'. DNS parameters given in DNSConfig will be merged with the policy selected with DNSPolicy. To have DNS options set along with hostNetwork, you have to specify DNS policy explicitly to 'ClusterFirstWithHostNet'.
    @[JSON::Field(key: "dnsPolicy")]
    @[YAML::Field(key: "dnsPolicy")]
    property dns_policy : String?
    # EnableServiceLinks indicates whether information about services should be injected into pod's environment variables, matching the syntax of Docker links. Optional: Defaults to true.
    @[JSON::Field(key: "enableServiceLinks")]
    @[YAML::Field(key: "enableServiceLinks")]
    property enable_service_links : Bool?
    # List of ephemeral containers run in this pod. Ephemeral containers may be run in an existing pod to perform user-initiated actions such as debugging. This list cannot be specified when creating a pod, and it cannot be modified by updating the pod spec. In order to add an ephemeral container to an existing pod, use the pod's ephemeralcontainers subresource.
    @[JSON::Field(key: "ephemeralContainers")]
    @[YAML::Field(key: "ephemeralContainers")]
    property ephemeral_containers : Array(EphemeralContainer)?
    # HostAliases is an optional list of hosts and IPs that will be injected into the pod's hosts file if specified.
    @[JSON::Field(key: "hostAliases")]
    @[YAML::Field(key: "hostAliases")]
    property host_aliases : Array(HostAlias)?
    # Use the host's ipc namespace. Optional: Default to false.
    @[JSON::Field(key: "hostIPC")]
    @[YAML::Field(key: "hostIPC")]
    property host_ipc : Bool?
    # Host networking requested for this pod. Use the host's network namespace. When using HostNetwork you should specify ports so the scheduler is aware. When `hostNetwork` is true, specified `hostPort` fields in port definitions must match `containerPort`, and unspecified `hostPort` fields in port definitions are defaulted to match `containerPort`. Default to false.
    @[JSON::Field(key: "hostNetwork")]
    @[YAML::Field(key: "hostNetwork")]
    property host_network : Bool?
    # Use the host's pid namespace. Optional: Default to false.
    @[JSON::Field(key: "hostPID")]
    @[YAML::Field(key: "hostPID")]
    property host_pid : Bool?
    # Use the host's user namespace. Optional: Default to true. If set to true or not present, the pod will be run in the host user namespace, useful for when the pod needs a feature only available to the host user namespace, such as loading a kernel module with CAP_SYS_MODULE. When set to false, a new userns is created for the pod. Setting false is useful for mitigating container breakout vulnerabilities even allowing users to run their containers as root without actually having root privileges on the host. This field is alpha-level and is only honored by servers that enable the UserNamespacesSupport feature.
    @[JSON::Field(key: "hostUsers")]
    @[YAML::Field(key: "hostUsers")]
    property host_users : Bool?
    # Specifies the hostname of the Pod If not specified, the pod's hostname will be set to a system-defined value.
    property hostname : String?
    # HostnameOverride specifies an explicit override for the pod's hostname as perceived by the pod. This field only specifies the pod's hostname and does not affect its DNS records. When this field is set to a non-empty string: - It takes precedence over the values set in `hostname` and `subdomain`. - The Pod's hostname will be set to this value. - `setHostnameAsFQDN` must be nil or set to false. - `hostNetwork` must be set to false.
    # This field must be a valid DNS subdomain as defined in RFC 1123 and contain at most 64 characters. Requires the HostnameOverride feature gate to be enabled.
    @[JSON::Field(key: "hostnameOverride")]
    @[YAML::Field(key: "hostnameOverride")]
    property hostname_override : String?
    # ImagePullSecrets is an optional list of references to secrets in the same namespace to use for pulling any of the images used by this PodSpec. If specified, these secrets will be passed to individual puller implementations for them to use. More info: https://kubernetes.io/docs/concepts/containers/images#specifying-imagepullsecrets-on-a-pod
    @[JSON::Field(key: "imagePullSecrets")]
    @[YAML::Field(key: "imagePullSecrets")]
    property image_pull_secrets : Array(LocalObjectReference)?
    # List of initialization containers belonging to the pod. Init containers are executed in order prior to containers being started. If any init container fails, the pod is considered to have failed and is handled according to its restartPolicy. The name for an init container or normal container must be unique among all containers. Init containers may not have Lifecycle actions, Readiness probes, Liveness probes, or Startup probes. The resourceRequirements of an init container are taken into account during scheduling by finding the highest request/limit for each resource type, and then using the max of that value or the sum of the normal containers. Limits are applied to init containers in a similar fashion. Init containers cannot currently be added or removed. Cannot be updated. More info: https://kubernetes.io/docs/concepts/workloads/pods/init-containers/
    @[JSON::Field(key: "initContainers")]
    @[YAML::Field(key: "initContainers")]
    property init_containers : Array(Container)?
    # NodeName indicates in which node this pod is scheduled. If empty, this pod is a candidate for scheduling by the scheduler defined in schedulerName. Once this field is set, the kubelet for this node becomes responsible for the lifecycle of this pod. This field should not be used to express a desire for the pod to be scheduled on a specific node. https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#nodename
    @[JSON::Field(key: "nodeName")]
    @[YAML::Field(key: "nodeName")]
    property node_name : String?
    # NodeSelector is a selector which must be true for the pod to fit on a node. Selector which must match a node's labels for the pod to be scheduled on that node. More info: https://kubernetes.io/docs/concepts/configuration/assign-pod-node/
    @[JSON::Field(key: "nodeSelector")]
    @[YAML::Field(key: "nodeSelector")]
    property node_selector : Hash(String, String)?
    # Specifies the OS of the containers in the pod. Some pod and container fields are restricted if this is set.
    # If the OS field is set to linux, the following fields must be unset: -securityContext.windowsOptions
    # If the OS field is set to windows, following fields must be unset: - spec.hostPID - spec.hostIPC - spec.hostUsers - spec.resources - spec.securityContext.appArmorProfile - spec.securityContext.seLinuxOptions - spec.securityContext.seccompProfile - spec.securityContext.fsGroup - spec.securityContext.fsGroupChangePolicy - spec.securityContext.sysctls - spec.shareProcessNamespace - spec.securityContext.runAsUser - spec.securityContext.runAsGroup - spec.securityContext.supplementalGroups - spec.securityContext.supplementalGroupsPolicy - spec.containers[*].securityContext.appArmorProfile - spec.containers[*].securityContext.seLinuxOptions - spec.containers[*].securityContext.seccompProfile - spec.containers[*].securityContext.capabilities - spec.containers[*].securityContext.readOnlyRootFilesystem - spec.containers[*].securityContext.privileged - spec.containers[*].securityContext.allowPrivilegeEscalation - spec.containers[*].securityContext.procMount - spec.containers[*].securityContext.runAsUser - spec.containers[*].securityContext.runAsGroup
    property os : PodOS?
    # Overhead represents the resource overhead associated with running a pod for a given RuntimeClass. This field will be autopopulated at admission time by the RuntimeClass admission controller. If the RuntimeClass admission controller is enabled, overhead must not be set in Pod create requests. The RuntimeClass admission controller will reject Pod create requests which have the overhead already set. If RuntimeClass is configured and selected in the PodSpec, Overhead will be set to the value defined in the corresponding RuntimeClass, otherwise it will remain unset and treated as zero. More info: https://git.k8s.io/enhancements/keps/sig-node/688-pod-overhead/README.md
    property overhead : Hash(String, String)?
    # PreemptionPolicy is the Policy for preempting pods with lower priority. One of Never, PreemptLowerPriority. Defaults to PreemptLowerPriority if unset.
    @[JSON::Field(key: "preemptionPolicy")]
    @[YAML::Field(key: "preemptionPolicy")]
    property preemption_policy : String?
    # The priority value. Various system components use this field to find the priority of the pod. When Priority Admission Controller is enabled, it prevents users from setting this field. The admission controller populates this field from PriorityClassName. The higher the value, the higher the priority.
    property priority : Int32?
    # If specified, indicates the pod's priority. "system-node-critical" and "system-cluster-critical" are two special keywords which indicate the highest priorities with the former being the highest priority. Any other name must be defined by creating a PriorityClass object with that name. If not specified, the pod priority will be default or zero if there is no default.
    @[JSON::Field(key: "priorityClassName")]
    @[YAML::Field(key: "priorityClassName")]
    property priority_class_name : String?
    # If specified, all readiness gates will be evaluated for pod readiness. A pod is ready when all its containers are ready AND all conditions specified in the readiness gates have status equal to "True" More info: https://git.k8s.io/enhancements/keps/sig-network/580-pod-readiness-gates
    @[JSON::Field(key: "readinessGates")]
    @[YAML::Field(key: "readinessGates")]
    property readiness_gates : Array(PodReadinessGate)?
    # ResourceClaims defines which ResourceClaims must be allocated and reserved before the Pod is allowed to start. The resources will be made available to those containers which consume them by name.
    # This is an alpha field and requires enabling the DynamicResourceAllocation feature gate.
    # This field is immutable.
    @[JSON::Field(key: "resourceClaims")]
    @[YAML::Field(key: "resourceClaims")]
    property resource_claims : Array(PodResourceClaim)?
    # Resources is the total amount of CPU and Memory resources required by all containers in the pod. It supports specifying Requests and Limits for "cpu", "memory" and "hugepages-" resource names only. ResourceClaims are not supported.
    # This field enables fine-grained control over resource allocation for the entire pod, allowing resource sharing among containers in a pod.
    # This is an alpha field and requires enabling the PodLevelResources feature gate.
    property resources : ResourceRequirements?
    # Restart policy for all containers within the pod. One of Always, OnFailure, Never. In some contexts, only a subset of those values may be permitted. Default to Always. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/#restart-policy
    @[JSON::Field(key: "restartPolicy")]
    @[YAML::Field(key: "restartPolicy")]
    property restart_policy : String?
    # RuntimeClassName refers to a RuntimeClass object in the node.k8s.io group, which should be used to run this pod.  If no RuntimeClass resource matches the named class, the pod will not be run. If unset or empty, the "legacy" RuntimeClass will be used, which is an implicit class with an empty definition that uses the default runtime handler. More info: https://git.k8s.io/enhancements/keps/sig-node/585-runtime-class
    @[JSON::Field(key: "runtimeClassName")]
    @[YAML::Field(key: "runtimeClassName")]
    property runtime_class_name : String?
    # If specified, the pod will be dispatched by specified scheduler. If not specified, the pod will be dispatched by default scheduler.
    @[JSON::Field(key: "schedulerName")]
    @[YAML::Field(key: "schedulerName")]
    property scheduler_name : String?
    # SchedulingGates is an opaque list of values that if specified will block scheduling the pod. If schedulingGates is not empty, the pod will stay in the SchedulingGated state and the scheduler will not attempt to schedule the pod.
    # SchedulingGates can only be set at pod creation time, and be removed only afterwards.
    @[JSON::Field(key: "schedulingGates")]
    @[YAML::Field(key: "schedulingGates")]
    property scheduling_gates : Array(PodSchedulingGate)?
    # SecurityContext holds pod-level security attributes and common container settings. Optional: Defaults to empty.  See type description for default values of each field.
    @[JSON::Field(key: "securityContext")]
    @[YAML::Field(key: "securityContext")]
    property security_context : PodSecurityContext?
    # DeprecatedServiceAccount is a deprecated alias for ServiceAccountName. Deprecated: Use serviceAccountName instead.
    @[JSON::Field(key: "serviceAccount")]
    @[YAML::Field(key: "serviceAccount")]
    property service_account : String?
    # ServiceAccountName is the name of the ServiceAccount to use to run this pod. More info: https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/
    @[JSON::Field(key: "serviceAccountName")]
    @[YAML::Field(key: "serviceAccountName")]
    property service_account_name : String?
    # If true the pod's hostname will be configured as the pod's FQDN, rather than the leaf name (the default). In Linux containers, this means setting the FQDN in the hostname field of the kernel (the nodename field of struct utsname). In Windows containers, this means setting the registry value of hostname for the registry key HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\Tcpip\\Parameters to FQDN. If a pod does not have FQDN, this has no effect. Default to false.
    @[JSON::Field(key: "setHostnameAsFQDN")]
    @[YAML::Field(key: "setHostnameAsFQDN")]
    property set_hostname_as_fqdn : Bool?
    # Share a single process namespace between all of the containers in a pod. When this is set containers will be able to view and signal processes from other containers in the same pod, and the first process in each container will not be assigned PID 1. HostPID and ShareProcessNamespace cannot both be set. Optional: Default to false.
    @[JSON::Field(key: "shareProcessNamespace")]
    @[YAML::Field(key: "shareProcessNamespace")]
    property share_process_namespace : Bool?
    # If specified, the fully qualified Pod hostname will be "<hostname>.<subdomain>.<pod namespace>.svc.<cluster domain>". If not specified, the pod will not have a domainname at all.
    property subdomain : String?
    # Optional duration in seconds the pod needs to terminate gracefully. May be decreased in delete request. Value must be non-negative integer. The value zero indicates stop immediately via the kill signal (no opportunity to shut down). If this value is nil, the default grace period will be used instead. The grace period is the duration in seconds after the processes running in the pod are sent a termination signal and the time when the processes are forcibly halted with a kill signal. Set this value longer than the expected cleanup time for your process. Defaults to 30 seconds.
    @[JSON::Field(key: "terminationGracePeriodSeconds")]
    @[YAML::Field(key: "terminationGracePeriodSeconds")]
    property termination_grace_period_seconds : Int64?
    # If specified, the pod's tolerations.
    property tolerations : Array(Toleration)?
    # TopologySpreadConstraints describes how a group of pods ought to spread across topology domains. Scheduler will schedule pods in a way which abides by the constraints. All topologySpreadConstraints are ANDed.
    @[JSON::Field(key: "topologySpreadConstraints")]
    @[YAML::Field(key: "topologySpreadConstraints")]
    property topology_spread_constraints : Array(TopologySpreadConstraint)?
    # List of volumes that can be mounted by containers belonging to the pod. More info: https://kubernetes.io/docs/concepts/storage/volumes
    property volumes : Array(Volume)?
  end

  # PodStatus represents information about the status of a pod. Status may trail the actual state of a system, especially if the node that hosts the pod cannot contact the control plane.
  struct PodStatus
    include Kubernetes::Serializable

    # Current service state of pod. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#pod-conditions
    property conditions : Array(PodCondition)?
    # Statuses of containers in this pod. Each container in the pod should have at most one status in this list, and all statuses should be for containers in the pod. However this is not enforced. If a status for a non-existent container is present in the list, or the list has duplicate names, the behavior of various Kubernetes components is not defined and those statuses might be ignored. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#pod-and-container-status
    @[JSON::Field(key: "containerStatuses")]
    @[YAML::Field(key: "containerStatuses")]
    property container_statuses : Array(ContainerStatus)?
    # Statuses for any ephemeral containers that have run in this pod. Each ephemeral container in the pod should have at most one status in this list, and all statuses should be for containers in the pod. However this is not enforced. If a status for a non-existent container is present in the list, or the list has duplicate names, the behavior of various Kubernetes components is not defined and those statuses might be ignored. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#pod-and-container-status
    @[JSON::Field(key: "ephemeralContainerStatuses")]
    @[YAML::Field(key: "ephemeralContainerStatuses")]
    property ephemeral_container_statuses : Array(ContainerStatus)?
    # Status of extended resource claim backed by DRA.
    @[JSON::Field(key: "extendedResourceClaimStatus")]
    @[YAML::Field(key: "extendedResourceClaimStatus")]
    property extended_resource_claim_status : PodExtendedResourceClaimStatus?
    # hostIP holds the IP address of the host to which the pod is assigned. Empty if the pod has not started yet. A pod can be assigned to a node that has a problem in kubelet which in turns mean that HostIP will not be updated even if there is a node is assigned to pod
    @[JSON::Field(key: "hostIP")]
    @[YAML::Field(key: "hostIP")]
    property host_ip : String?
    # hostIPs holds the IP addresses allocated to the host. If this field is specified, the first entry must match the hostIP field. This list is empty if the pod has not started yet. A pod can be assigned to a node that has a problem in kubelet which in turns means that HostIPs will not be updated even if there is a node is assigned to this pod.
    @[JSON::Field(key: "hostIPs")]
    @[YAML::Field(key: "hostIPs")]
    property host_i_ps : Array(HostIP)?
    # Statuses of init containers in this pod. The most recent successful non-restartable init container will have ready = true, the most recently started container will have startTime set. Each init container in the pod should have at most one status in this list, and all statuses should be for containers in the pod. However this is not enforced. If a status for a non-existent container is present in the list, or the list has duplicate names, the behavior of various Kubernetes components is not defined and those statuses might be ignored. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/#pod-and-container-status
    @[JSON::Field(key: "initContainerStatuses")]
    @[YAML::Field(key: "initContainerStatuses")]
    property init_container_statuses : Array(ContainerStatus)?
    # A human readable message indicating details about why the pod is in this condition.
    property message : String?
    # nominatedNodeName is set only when this pod preempts other pods on the node, but it cannot be scheduled right away as preemption victims receive their graceful termination periods. This field does not guarantee that the pod will be scheduled on this node. Scheduler may decide to place the pod elsewhere if other nodes become available sooner. Scheduler may also decide to give the resources on this node to a higher priority pod that is created after preemption. As a result, this field may be different than PodSpec.nodeName when the pod is scheduled.
    @[JSON::Field(key: "nominatedNodeName")]
    @[YAML::Field(key: "nominatedNodeName")]
    property nominated_node_name : String?
    # If set, this represents the .metadata.generation that the pod status was set based upon. This is an alpha field. Enable PodObservedGenerationTracking to be able to use this field.
    @[JSON::Field(key: "observedGeneration")]
    @[YAML::Field(key: "observedGeneration")]
    property observed_generation : Int64?
    # The phase of a Pod is a simple, high-level summary of where the Pod is in its lifecycle. The conditions array, the reason and message fields, and the individual container status arrays contain more detail about the pod's status. There are five possible phase values:
    # Pending: The pod has been accepted by the Kubernetes system, but one or more of the container images has not been created. This includes time before being scheduled as well as time spent downloading images over the network, which could take a while. Running: The pod has been bound to a node, and all of the containers have been created. At least one container is still running, or is in the process of starting or restarting. Succeeded: All containers in the pod have terminated in success, and will not be restarted. Failed: All containers in the pod have terminated, and at least one container has terminated in failure. The container either exited with non-zero status or was terminated by the system. Unknown: For some reason the state of the pod could not be obtained, typically due to an error in communicating with the host of the pod.
    # More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#pod-phase
    property phase : String?
    # podIP address allocated to the pod. Routable at least within the cluster. Empty if not yet allocated.
    @[JSON::Field(key: "podIP")]
    @[YAML::Field(key: "podIP")]
    property pod_ip : String?
    # podIPs holds the IP addresses allocated to the pod. If this field is specified, the 0th entry must match the podIP field. Pods may be allocated at most 1 value for each of IPv4 and IPv6. This list is empty if no IPs have been allocated yet.
    @[JSON::Field(key: "podIPs")]
    @[YAML::Field(key: "podIPs")]
    property pod_i_ps : Array(PodIP)?
    # The Quality of Service (QOS) classification assigned to the pod based on resource requirements See PodQOSClass type for available QOS classes More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-qos/#quality-of-service-classes
    @[JSON::Field(key: "qosClass")]
    @[YAML::Field(key: "qosClass")]
    property qos_class : String?
    # A brief CamelCase message indicating details about why the pod is in this state. e.g. 'Evicted'
    property reason : String?
    # Status of resources resize desired for pod's containers. It is empty if no resources resize is pending. Any changes to container resources will automatically set this to "Proposed" Deprecated: Resize status is moved to two pod conditions PodResizePending and PodResizeInProgress. PodResizePending will track states where the spec has been resized, but the Kubelet has not yet allocated the resources. PodResizeInProgress will track in-progress resizes, and should be present whenever allocated resources != acknowledged resources.
    property resize : String?
    # Status of resource claims.
    @[JSON::Field(key: "resourceClaimStatuses")]
    @[YAML::Field(key: "resourceClaimStatuses")]
    property resource_claim_statuses : Array(PodResourceClaimStatus)?
    # RFC 3339 date and time at which the object was acknowledged by the Kubelet. This is before the Kubelet pulled the container image(s) for the pod.
    @[JSON::Field(key: "startTime")]
    @[YAML::Field(key: "startTime")]
    property start_time : Time?
  end

  # PodTemplate describes a template for creating copies of a predefined pod.
  struct PodTemplate
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ObjectMeta?
    # Template defines the pods that will be created from this pod template. https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status
    property template : PodTemplateSpec?
  end

  # PodTemplateList is a list of PodTemplates.
  struct PodTemplateList
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # List of pod templates
    property items : Array(PodTemplate)?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard list metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property metadata : ListMeta?
  end

  # PodTemplateSpec describes the data a pod should have when created from a template
  struct PodTemplateSpec
    include Kubernetes::Serializable

    # Standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ObjectMeta?
    # Specification of the desired behavior of the pod. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status
    property spec : PodSpec?
  end

  # PortStatus represents the error condition of a service port
  struct PortStatus
    include Kubernetes::Serializable

    # Error is to record the problem with the service port The format of the error shall comply with the following rules: - built-in error values shall be specified in this file and those shall use
    # CamelCase names
    # - cloud provider specific error values must have names that comply with the
    # format foo.example.com/CamelCase.
    property error : String?
    # Port is the port number of the service port of which status is recorded here
    property port : Int32?
    # Protocol is the protocol of the service port of which status is recorded here The supported values are: "TCP", "UDP", "SCTP"
    property protocol : String?
  end

  # PortworxVolumeSource represents a Portworx volume resource.
  struct PortworxVolumeSource
    include Kubernetes::Serializable

    # fSType represents the filesystem type to mount Must be a filesystem type supported by the host operating system. Ex. "ext4", "xfs". Implicitly inferred to be "ext4" if unspecified.
    @[JSON::Field(key: "fsType")]
    @[YAML::Field(key: "fsType")]
    property fs_type : String?
    # readOnly defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts.
    @[JSON::Field(key: "readOnly")]
    @[YAML::Field(key: "readOnly")]
    property read_only : Bool?
    # volumeID uniquely identifies a Portworx volume
    @[JSON::Field(key: "volumeID")]
    @[YAML::Field(key: "volumeID")]
    property volume_id : String?
  end

  # An empty preferred scheduling term matches all objects with implicit weight 0 (i.e. it's a no-op). A null preferred scheduling term matches no objects (i.e. is also a no-op).
  struct PreferredSchedulingTerm
    include Kubernetes::Serializable

    # A node selector term, associated with the corresponding weight.
    property preference : NodeSelectorTerm?
    # Weight associated with matching the corresponding nodeSelectorTerm, in the range 1-100.
    property weight : Int32?
  end

  # Probe describes a health check to be performed against a container to determine whether it is alive or ready to receive traffic.
  struct Probe
    include Kubernetes::Serializable

    # Exec specifies a command to execute in the container.
    property exec : ExecAction?
    # Minimum consecutive failures for the probe to be considered failed after having succeeded. Defaults to 3. Minimum value is 1.
    @[JSON::Field(key: "failureThreshold")]
    @[YAML::Field(key: "failureThreshold")]
    property failure_threshold : Int32?
    # GRPC specifies a GRPC HealthCheckRequest.
    property grpc : GRPCAction?
    # HTTPGet specifies an HTTP GET request to perform.
    @[JSON::Field(key: "httpGet")]
    @[YAML::Field(key: "httpGet")]
    property http_get : HTTPGetAction?
    # Number of seconds after the container has started before liveness probes are initiated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
    @[JSON::Field(key: "initialDelaySeconds")]
    @[YAML::Field(key: "initialDelaySeconds")]
    property initial_delay_seconds : Int32?
    # How often (in seconds) to perform the probe. Default to 10 seconds. Minimum value is 1.
    @[JSON::Field(key: "periodSeconds")]
    @[YAML::Field(key: "periodSeconds")]
    property period_seconds : Int32?
    # Minimum consecutive successes for the probe to be considered successful after having failed. Defaults to 1. Must be 1 for liveness and startup. Minimum value is 1.
    @[JSON::Field(key: "successThreshold")]
    @[YAML::Field(key: "successThreshold")]
    property success_threshold : Int32?
    # TCPSocket specifies a connection to a TCP port.
    @[JSON::Field(key: "tcpSocket")]
    @[YAML::Field(key: "tcpSocket")]
    property tcp_socket : TCPSocketAction?
    # Optional duration in seconds the pod needs to terminate gracefully upon probe failure. The grace period is the duration in seconds after the processes running in the pod are sent a termination signal and the time when the processes are forcibly halted with a kill signal. Set this value longer than the expected cleanup time for your process. If this value is nil, the pod's terminationGracePeriodSeconds will be used. Otherwise, this value overrides the value provided by the pod spec. Value must be non-negative integer. The value zero indicates stop immediately via the kill signal (no opportunity to shut down). This is a beta field and requires enabling ProbeTerminationGracePeriod feature gate. Minimum value is 1. spec.terminationGracePeriodSeconds is used if unset.
    @[JSON::Field(key: "terminationGracePeriodSeconds")]
    @[YAML::Field(key: "terminationGracePeriodSeconds")]
    property termination_grace_period_seconds : Int64?
    # Number of seconds after which the probe times out. Defaults to 1 second. Minimum value is 1. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
    @[JSON::Field(key: "timeoutSeconds")]
    @[YAML::Field(key: "timeoutSeconds")]
    property timeout_seconds : Int32?
  end

  # Represents a projected volume source
  struct ProjectedVolumeSource
    include Kubernetes::Serializable

    # defaultMode are the mode bits used to set permissions on created files by default. Must be an octal value between 0000 and 0777 or a decimal value between 0 and 511. YAML accepts both octal and decimal values, JSON requires decimal values for mode bits. Directories within the path are not affected by this setting. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set.
    @[JSON::Field(key: "defaultMode")]
    @[YAML::Field(key: "defaultMode")]
    property default_mode : Int32?
    # sources is the list of volume projections. Each entry in this list handles one source.
    property sources : Array(VolumeProjection)?
  end

  # Represents a Quobyte mount that lasts the lifetime of a pod. Quobyte volumes do not support ownership management or SELinux relabeling.
  struct QuobyteVolumeSource
    include Kubernetes::Serializable

    # group to map volume access to Default is no group
    property group : String?
    # readOnly here will force the Quobyte volume to be mounted with read-only permissions. Defaults to false.
    @[JSON::Field(key: "readOnly")]
    @[YAML::Field(key: "readOnly")]
    property read_only : Bool?
    # registry represents a single or multiple Quobyte Registry services specified as a string as host:port pair (multiple entries are separated with commas) which acts as the central registry for volumes
    property registry : String?
    # tenant owning the given Quobyte volume in the Backend Used with dynamically provisioned Quobyte volumes, value is set by the plugin
    property tenant : String?
    # user to map volume access to Defaults to serivceaccount user
    property user : String?
    # volume is a string that references an already created Quobyte volume by name.
    property volume : String?
  end

  # Represents a Rados Block Device mount that lasts the lifetime of a pod. RBD volumes support ownership management and SELinux relabeling.
  struct RBDPersistentVolumeSource
    include Kubernetes::Serializable

    # fsType is the filesystem type of the volume that you want to mount. Tip: Ensure that the filesystem type is supported by the host operating system. Examples: "ext4", "xfs", "ntfs". Implicitly inferred to be "ext4" if unspecified. More info: https://kubernetes.io/docs/concepts/storage/volumes#rbd
    @[JSON::Field(key: "fsType")]
    @[YAML::Field(key: "fsType")]
    property fs_type : String?
    # image is the rados image name. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it
    property image : String?
    # keyring is the path to key ring for RBDUser. Default is /etc/ceph/keyring. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it
    property keyring : String?
    # monitors is a collection of Ceph monitors. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it
    property monitors : Array(String)?
    # pool is the rados pool name. Default is rbd. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it
    property pool : String?
    # readOnly here will force the ReadOnly setting in VolumeMounts. Defaults to false. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it
    @[JSON::Field(key: "readOnly")]
    @[YAML::Field(key: "readOnly")]
    property read_only : Bool?
    # secretRef is name of the authentication secret for RBDUser. If provided overrides keyring. Default is nil. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it
    @[JSON::Field(key: "secretRef")]
    @[YAML::Field(key: "secretRef")]
    property secret_ref : SecretReference?
    # user is the rados user name. Default is admin. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it
    property user : String?
  end

  # Represents a Rados Block Device mount that lasts the lifetime of a pod. RBD volumes support ownership management and SELinux relabeling.
  struct RBDVolumeSource
    include Kubernetes::Serializable

    # fsType is the filesystem type of the volume that you want to mount. Tip: Ensure that the filesystem type is supported by the host operating system. Examples: "ext4", "xfs", "ntfs". Implicitly inferred to be "ext4" if unspecified. More info: https://kubernetes.io/docs/concepts/storage/volumes#rbd
    @[JSON::Field(key: "fsType")]
    @[YAML::Field(key: "fsType")]
    property fs_type : String?
    # image is the rados image name. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it
    property image : String?
    # keyring is the path to key ring for RBDUser. Default is /etc/ceph/keyring. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it
    property keyring : String?
    # monitors is a collection of Ceph monitors. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it
    property monitors : Array(String)?
    # pool is the rados pool name. Default is rbd. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it
    property pool : String?
    # readOnly here will force the ReadOnly setting in VolumeMounts. Defaults to false. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it
    @[JSON::Field(key: "readOnly")]
    @[YAML::Field(key: "readOnly")]
    property read_only : Bool?
    # secretRef is name of the authentication secret for RBDUser. If provided overrides keyring. Default is nil. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it
    @[JSON::Field(key: "secretRef")]
    @[YAML::Field(key: "secretRef")]
    property secret_ref : LocalObjectReference?
    # user is the rados user name. Default is admin. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it
    property user : String?
  end

  # ReplicationController represents the configuration of a replication controller.
  struct ReplicationController
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # If the Labels of a ReplicationController are empty, they are defaulted to be the same as the Pod(s) that the replication controller manages. Standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ObjectMeta?
    # Spec defines the specification of the desired behavior of the replication controller. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status
    property spec : ReplicationControllerSpec?
    # Status is the most recently observed status of the replication controller. This data may be out of date by some window of time. Populated by the system. Read-only. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status
    property status : ReplicationControllerStatus?
  end

  # ReplicationControllerCondition describes the state of a replication controller at a certain point.
  struct ReplicationControllerCondition
    include Kubernetes::Serializable

    # The last time the condition transitioned from one status to another.
    @[JSON::Field(key: "lastTransitionTime")]
    @[YAML::Field(key: "lastTransitionTime")]
    property last_transition_time : Time?
    # A human readable message indicating details about the transition.
    property message : String?
    # The reason for the condition's last transition.
    property reason : String?
    # Status of the condition, one of True, False, Unknown.
    property status : String?
    # Type of replication controller condition.
    property type : String?
  end

  # ReplicationControllerList is a collection of replication controllers.
  struct ReplicationControllerList
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # List of replication controllers. More info: https://kubernetes.io/docs/concepts/workloads/controllers/replicationcontroller
    property items : Array(ReplicationController)?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard list metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property metadata : ListMeta?
  end

  # ReplicationControllerSpec is the specification of a replication controller.
  struct ReplicationControllerSpec
    include Kubernetes::Serializable

    # Minimum number of seconds for which a newly created pod should be ready without any of its container crashing, for it to be considered available. Defaults to 0 (pod will be considered available as soon as it is ready)
    @[JSON::Field(key: "minReadySeconds")]
    @[YAML::Field(key: "minReadySeconds")]
    property min_ready_seconds : Int32?
    # Replicas is the number of desired replicas. This is a pointer to distinguish between explicit zero and unspecified. Defaults to 1. More info: https://kubernetes.io/docs/concepts/workloads/controllers/replicationcontroller#what-is-a-replicationcontroller
    property replicas : Int32?
    # Selector is a label query over pods that should match the Replicas count. If Selector is empty, it is defaulted to the labels present on the Pod template. Label keys and values that must match in order to be controlled by this replication controller, if empty defaulted to labels on Pod template. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/#label-selectors
    property selector : Hash(String, String)?
    # Template is the object that describes the pod that will be created if insufficient replicas are detected. This takes precedence over a TemplateRef. The only allowed template.spec.restartPolicy value is "Always". More info: https://kubernetes.io/docs/concepts/workloads/controllers/replicationcontroller#pod-template
    property template : PodTemplateSpec?
  end

  # ReplicationControllerStatus represents the current status of a replication controller.
  struct ReplicationControllerStatus
    include Kubernetes::Serializable

    # The number of available replicas (ready for at least minReadySeconds) for this replication controller.
    @[JSON::Field(key: "availableReplicas")]
    @[YAML::Field(key: "availableReplicas")]
    property available_replicas : Int32?
    # Represents the latest available observations of a replication controller's current state.
    property conditions : Array(ReplicationControllerCondition)?
    # The number of pods that have labels matching the labels of the pod template of the replication controller.
    @[JSON::Field(key: "fullyLabeledReplicas")]
    @[YAML::Field(key: "fullyLabeledReplicas")]
    property fully_labeled_replicas : Int32?
    # ObservedGeneration reflects the generation of the most recently observed replication controller.
    @[JSON::Field(key: "observedGeneration")]
    @[YAML::Field(key: "observedGeneration")]
    property observed_generation : Int64?
    # The number of ready replicas for this replication controller.
    @[JSON::Field(key: "readyReplicas")]
    @[YAML::Field(key: "readyReplicas")]
    property ready_replicas : Int32?
    # Replicas is the most recently observed number of replicas. More info: https://kubernetes.io/docs/concepts/workloads/controllers/replicationcontroller#what-is-a-replicationcontroller
    property replicas : Int32?
  end

  # ResourceFieldSelector represents container resources (cpu, memory) and their output format
  struct ResourceFieldSelector
    include Kubernetes::Serializable

    # Container name: required for volumes, optional for env vars
    @[JSON::Field(key: "containerName")]
    @[YAML::Field(key: "containerName")]
    property container_name : String?
    # Specifies the output format of the exposed resources, defaults to "1"
    property divisor : String?
    # Required: resource to select
    property resource : String?
  end

  # ResourceHealth represents the health of a resource. It has the latest device health information. This is a part of KEP https://kep.k8s.io/4680.
  struct ResourceHealth
    include Kubernetes::Serializable

    # Health of the resource. can be one of:
    # - Healthy: operates as normal
    # - Unhealthy: reported unhealthy. We consider this a temporary health issue
    # since we do not have a mechanism today to distinguish
    # temporary and permanent issues.
    # - Unknown: The status cannot be determined.
    # For example, Device Plugin got unregistered and hasn't been re-registered since.
    # In future we may want to introduce the PermanentlyUnhealthy Status.
    property health : String?
    # ResourceID is the unique identifier of the resource. See the ResourceID type for more information.
    @[JSON::Field(key: "resourceID")]
    @[YAML::Field(key: "resourceID")]
    property resource_id : String?
  end

  # ResourceQuota sets aggregate quota restrictions enforced per namespace
  struct ResourceQuota
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ObjectMeta?
    # Spec defines the desired quota. https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status
    property spec : ResourceQuotaSpec?
    # Status defines the actual enforced quota and its current usage. https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status
    property status : ResourceQuotaStatus?
  end

  # ResourceQuotaList is a list of ResourceQuota items.
  struct ResourceQuotaList
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Items is a list of ResourceQuota objects. More info: https://kubernetes.io/docs/concepts/policy/resource-quotas/
    property items : Array(ResourceQuota)?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard list metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property metadata : ListMeta?
  end

  # ResourceQuotaSpec defines the desired hard limits to enforce for Quota.
  struct ResourceQuotaSpec
    include Kubernetes::Serializable

    # hard is the set of desired hard limits for each named resource. More info: https://kubernetes.io/docs/concepts/policy/resource-quotas/
    property hard : Hash(String, String)?
    # scopeSelector is also a collection of filters like scopes that must match each object tracked by a quota but expressed using ScopeSelectorOperator in combination with possible values. For a resource to match, both scopes AND scopeSelector (if specified in spec), must be matched.
    @[JSON::Field(key: "scopeSelector")]
    @[YAML::Field(key: "scopeSelector")]
    property scope_selector : ScopeSelector?
    # A collection of filters that must match each object tracked by a quota. If not specified, the quota matches all objects.
    property scopes : Array(String)?
  end

  # ResourceQuotaStatus defines the enforced hard limits and observed use.
  struct ResourceQuotaStatus
    include Kubernetes::Serializable

    # Hard is the set of enforced hard limits for each named resource. More info: https://kubernetes.io/docs/concepts/policy/resource-quotas/
    property hard : Hash(String, String)?
    # Used is the current observed total usage of the resource in the namespace.
    property used : Hash(String, String)?
  end

  # ResourceRequirements describes the compute resource requirements.
  struct ResourceRequirements
    include Kubernetes::Serializable

    # Claims lists the names of resources, defined in spec.resourceClaims, that are used by this container.
    # This field depends on the DynamicResourceAllocation feature gate.
    # This field is immutable. It can only be set for containers.
    property claims : Array(ResourceClaim)?
    # Limits describes the maximum amount of compute resources allowed. More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
    property limits : Hash(String, String)?
    # Requests describes the minimum amount of compute resources required. If Requests is omitted for a container, it defaults to Limits if that is explicitly specified, otherwise to an implementation-defined value. Requests cannot exceed Limits. More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
    property requests : Hash(String, String)?
  end

  # ResourceStatus represents the status of a single resource allocated to a Pod.
  struct ResourceStatus
    include Kubernetes::Serializable

    # Name of the resource. Must be unique within the pod and in case of non-DRA resource, match one of the resources from the pod spec. For DRA resources, the value must be "claim:<claim_name>/<request>". When this status is reported about a container, the "claim_name" and "request" must match one of the claims of this container.
    property name : String?
    # List of unique resources health. Each element in the list contains an unique resource ID and its health. At a minimum, for the lifetime of a Pod, resource ID must uniquely identify the resource allocated to the Pod on the Node. If other Pod on the same Node reports the status with the same resource ID, it must be the same resource they share. See ResourceID type definition for a specific format it has in various use cases.
    property resources : Array(ResourceHealth)?
  end

  # SELinuxOptions are the labels to be applied to the container
  struct SELinuxOptions
    include Kubernetes::Serializable

    # Level is SELinux level label that applies to the container.
    property level : String?
    # Role is a SELinux role label that applies to the container.
    property role : String?
    # Type is a SELinux type label that applies to the container.
    property type : String?
    # User is a SELinux user label that applies to the container.
    property user : String?
  end

  # ScaleIOPersistentVolumeSource represents a persistent ScaleIO volume
  struct ScaleIOPersistentVolumeSource
    include Kubernetes::Serializable

    # fsType is the filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. "ext4", "xfs", "ntfs". Default is "xfs"
    @[JSON::Field(key: "fsType")]
    @[YAML::Field(key: "fsType")]
    property fs_type : String?
    # gateway is the host address of the ScaleIO API Gateway.
    property gateway : String?
    # protectionDomain is the name of the ScaleIO Protection Domain for the configured storage.
    @[JSON::Field(key: "protectionDomain")]
    @[YAML::Field(key: "protectionDomain")]
    property protection_domain : String?
    # readOnly defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts.
    @[JSON::Field(key: "readOnly")]
    @[YAML::Field(key: "readOnly")]
    property read_only : Bool?
    # secretRef references to the secret for ScaleIO user and other sensitive information. If this is not provided, Login operation will fail.
    @[JSON::Field(key: "secretRef")]
    @[YAML::Field(key: "secretRef")]
    property secret_ref : SecretReference?
    # sslEnabled is the flag to enable/disable SSL communication with Gateway, default false
    @[JSON::Field(key: "sslEnabled")]
    @[YAML::Field(key: "sslEnabled")]
    property ssl_enabled : Bool?
    # storageMode indicates whether the storage for a volume should be ThickProvisioned or ThinProvisioned. Default is ThinProvisioned.
    @[JSON::Field(key: "storageMode")]
    @[YAML::Field(key: "storageMode")]
    property storage_mode : String?
    # storagePool is the ScaleIO Storage Pool associated with the protection domain.
    @[JSON::Field(key: "storagePool")]
    @[YAML::Field(key: "storagePool")]
    property storage_pool : String?
    # system is the name of the storage system as configured in ScaleIO.
    property system : String?
    # volumeName is the name of a volume already created in the ScaleIO system that is associated with this volume source.
    @[JSON::Field(key: "volumeName")]
    @[YAML::Field(key: "volumeName")]
    property volume_name : String?
  end

  # ScaleIOVolumeSource represents a persistent ScaleIO volume
  struct ScaleIOVolumeSource
    include Kubernetes::Serializable

    # fsType is the filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. "ext4", "xfs", "ntfs". Default is "xfs".
    @[JSON::Field(key: "fsType")]
    @[YAML::Field(key: "fsType")]
    property fs_type : String?
    # gateway is the host address of the ScaleIO API Gateway.
    property gateway : String?
    # protectionDomain is the name of the ScaleIO Protection Domain for the configured storage.
    @[JSON::Field(key: "protectionDomain")]
    @[YAML::Field(key: "protectionDomain")]
    property protection_domain : String?
    # readOnly Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts.
    @[JSON::Field(key: "readOnly")]
    @[YAML::Field(key: "readOnly")]
    property read_only : Bool?
    # secretRef references to the secret for ScaleIO user and other sensitive information. If this is not provided, Login operation will fail.
    @[JSON::Field(key: "secretRef")]
    @[YAML::Field(key: "secretRef")]
    property secret_ref : LocalObjectReference?
    # sslEnabled Flag enable/disable SSL communication with Gateway, default false
    @[JSON::Field(key: "sslEnabled")]
    @[YAML::Field(key: "sslEnabled")]
    property ssl_enabled : Bool?
    # storageMode indicates whether the storage for a volume should be ThickProvisioned or ThinProvisioned. Default is ThinProvisioned.
    @[JSON::Field(key: "storageMode")]
    @[YAML::Field(key: "storageMode")]
    property storage_mode : String?
    # storagePool is the ScaleIO Storage Pool associated with the protection domain.
    @[JSON::Field(key: "storagePool")]
    @[YAML::Field(key: "storagePool")]
    property storage_pool : String?
    # system is the name of the storage system as configured in ScaleIO.
    property system : String?
    # volumeName is the name of a volume already created in the ScaleIO system that is associated with this volume source.
    @[JSON::Field(key: "volumeName")]
    @[YAML::Field(key: "volumeName")]
    property volume_name : String?
  end

  # A scope selector represents the AND of the selectors represented by the scoped-resource selector requirements.
  struct ScopeSelector
    include Kubernetes::Serializable

    # A list of scope selector requirements by scope of the resources.
    @[JSON::Field(key: "matchExpressions")]
    @[YAML::Field(key: "matchExpressions")]
    property match_expressions : Array(ScopedResourceSelectorRequirement)?
  end

  # A scoped-resource selector requirement is a selector that contains values, a scope name, and an operator that relates the scope name and values.
  struct ScopedResourceSelectorRequirement
    include Kubernetes::Serializable

    # Represents a scope's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist.
    property operator : String?
    # The name of the scope that the selector applies to.
    @[JSON::Field(key: "scopeName")]
    @[YAML::Field(key: "scopeName")]
    property scope_name : String?
    # An array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch.
    property values : Array(String)?
  end

  # SeccompProfile defines a pod/container's seccomp profile settings. Only one profile source may be set.
  struct SeccompProfile
    include Kubernetes::Serializable

    # localhostProfile indicates a profile defined in a file on the node should be used. The profile must be preconfigured on the node to work. Must be a descending path, relative to the kubelet's configured seccomp profile location. Must be set if type is "Localhost". Must NOT be set for any other type.
    @[JSON::Field(key: "localhostProfile")]
    @[YAML::Field(key: "localhostProfile")]
    property localhost_profile : String?
    # type indicates which kind of seccomp profile will be applied. Valid options are:
    # Localhost - a profile defined in a file on the node should be used. RuntimeDefault - the container runtime default profile should be used. Unconfined - no profile should be applied.
    property type : String?
  end

  # Secret holds secret data of a certain type. The total bytes of the values in the Data field must be less than MaxSecretSize bytes.
  struct Secret
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Data contains the secret data. Each key must consist of alphanumeric characters, '-', '_' or '.'. The serialized form of the secret data is a base64 encoded string, representing the arbitrary (possibly non-string) data value here. Described in https://tools.ietf.org/html/rfc4648#section-4
    property data : Hash(String, String)?
    # Immutable, if set to true, ensures that data stored in the Secret cannot be updated (only object metadata can be modified). If not set to true, the field can be modified at any time. Defaulted to nil.
    property immutable : Bool?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ObjectMeta?
    # stringData allows specifying non-binary secret data in string form. It is provided as a write-only input field for convenience. All keys and values are merged into the data field on write, overwriting any existing values. The stringData field is never output when reading from the API.
    @[JSON::Field(key: "stringData")]
    @[YAML::Field(key: "stringData")]
    property string_data : Hash(String, String)?
    # Used to facilitate programmatic handling of secret data. More info: https://kubernetes.io/docs/concepts/configuration/secret/#secret-types
    property type : String?
  end

  # SecretEnvSource selects a Secret to populate the environment variables with.
  # The contents of the target Secret's Data field will represent the key-value pairs as environment variables.
  struct SecretEnvSource
    include Kubernetes::Serializable

    # Name of the referent. This field is effectively required, but due to backwards compatibility is allowed to be empty. Instances of this type with an empty value here are almost certainly wrong. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
    property name : String?
    # Specify whether the Secret must be defined
    property optional : Bool?
  end

  # SecretKeySelector selects a key of a Secret.
  struct SecretKeySelector
    include Kubernetes::Serializable

    # The key of the secret to select from.  Must be a valid secret key.
    property key : String?
    # Name of the referent. This field is effectively required, but due to backwards compatibility is allowed to be empty. Instances of this type with an empty value here are almost certainly wrong. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
    property name : String?
    # Specify whether the Secret or its key must be defined
    property optional : Bool?
  end

  # SecretList is a list of Secret.
  struct SecretList
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Items is a list of secret objects. More info: https://kubernetes.io/docs/concepts/configuration/secret
    property items : Array(Secret)?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard list metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property metadata : ListMeta?
  end

  # Adapts a secret into a projected volume.
  # The contents of the target Secret's Data field will be presented in a projected volume as files using the keys in the Data field as the file names. Note that this is identical to a secret volume source without the default mode.
  struct SecretProjection
    include Kubernetes::Serializable

    # items if unspecified, each key-value pair in the Data field of the referenced Secret will be projected into the volume as a file whose name is the key and content is the value. If specified, the listed keys will be projected into the specified paths, and unlisted keys will not be present. If a key is specified which is not present in the Secret, the volume setup will error unless it is marked optional. Paths must be relative and may not contain the '..' path or start with '..'.
    property items : Array(KeyToPath)?
    # Name of the referent. This field is effectively required, but due to backwards compatibility is allowed to be empty. Instances of this type with an empty value here are almost certainly wrong. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
    property name : String?
    # optional field specify whether the Secret or its key must be defined
    property optional : Bool?
  end

  # SecretReference represents a Secret Reference. It has enough information to retrieve secret in any namespace
  struct SecretReference
    include Kubernetes::Serializable

    # name is unique within a namespace to reference a secret resource.
    property name : String?
    # namespace defines the space within which the secret name must be unique.
    property namespace : String?
  end

  # Adapts a Secret into a volume.
  # The contents of the target Secret's Data field will be presented in a volume as files using the keys in the Data field as the file names. Secret volumes support ownership management and SELinux relabeling.
  struct SecretVolumeSource
    include Kubernetes::Serializable

    # defaultMode is Optional: mode bits used to set permissions on created files by default. Must be an octal value between 0000 and 0777 or a decimal value between 0 and 511. YAML accepts both octal and decimal values, JSON requires decimal values for mode bits. Defaults to 0644. Directories within the path are not affected by this setting. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set.
    @[JSON::Field(key: "defaultMode")]
    @[YAML::Field(key: "defaultMode")]
    property default_mode : Int32?
    # items If unspecified, each key-value pair in the Data field of the referenced Secret will be projected into the volume as a file whose name is the key and content is the value. If specified, the listed keys will be projected into the specified paths, and unlisted keys will not be present. If a key is specified which is not present in the Secret, the volume setup will error unless it is marked optional. Paths must be relative and may not contain the '..' path or start with '..'.
    property items : Array(KeyToPath)?
    # optional field specify whether the Secret or its keys must be defined
    property optional : Bool?
    # secretName is the name of the secret in the pod's namespace to use. More info: https://kubernetes.io/docs/concepts/storage/volumes#secret
    @[JSON::Field(key: "secretName")]
    @[YAML::Field(key: "secretName")]
    property secret_name : String?
  end

  # SecurityContext holds security configuration that will be applied to a container. Some fields are present in both SecurityContext and PodSecurityContext.  When both are set, the values in SecurityContext take precedence.
  struct SecurityContext
    include Kubernetes::Serializable

    # AllowPrivilegeEscalation controls whether a process can gain more privileges than its parent process. This bool directly controls if the no_new_privs flag will be set on the container process. AllowPrivilegeEscalation is true always when the container is: 1) run as Privileged 2) has CAP_SYS_ADMIN Note that this field cannot be set when spec.os.name is windows.
    @[JSON::Field(key: "allowPrivilegeEscalation")]
    @[YAML::Field(key: "allowPrivilegeEscalation")]
    property allow_privilege_escalation : Bool?
    # appArmorProfile is the AppArmor options to use by this container. If set, this profile overrides the pod's appArmorProfile. Note that this field cannot be set when spec.os.name is windows.
    @[JSON::Field(key: "appArmorProfile")]
    @[YAML::Field(key: "appArmorProfile")]
    property app_armor_profile : AppArmorProfile?
    # The capabilities to add/drop when running containers. Defaults to the default set of capabilities granted by the container runtime. Note that this field cannot be set when spec.os.name is windows.
    property capabilities : Capabilities?
    # Run container in privileged mode. Processes in privileged containers are essentially equivalent to root on the host. Defaults to false. Note that this field cannot be set when spec.os.name is windows.
    property privileged : Bool?
    # procMount denotes the type of proc mount to use for the containers. The default value is Default which uses the container runtime defaults for readonly paths and masked paths. This requires the ProcMountType feature flag to be enabled. Note that this field cannot be set when spec.os.name is windows.
    @[JSON::Field(key: "procMount")]
    @[YAML::Field(key: "procMount")]
    property proc_mount : String?
    # Whether this container has a read-only root filesystem. Default is false. Note that this field cannot be set when spec.os.name is windows.
    @[JSON::Field(key: "readOnlyRootFilesystem")]
    @[YAML::Field(key: "readOnlyRootFilesystem")]
    property read_only_root_filesystem : Bool?
    # The GID to run the entrypoint of the container process. Uses runtime default if unset. May also be set in PodSecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence. Note that this field cannot be set when spec.os.name is windows.
    @[JSON::Field(key: "runAsGroup")]
    @[YAML::Field(key: "runAsGroup")]
    property run_as_group : Int64?
    # Indicates that the container must run as a non-root user. If true, the Kubelet will validate the image at runtime to ensure that it does not run as UID 0 (root) and fail to start the container if it does. If unset or false, no such validation will be performed. May also be set in PodSecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence.
    @[JSON::Field(key: "runAsNonRoot")]
    @[YAML::Field(key: "runAsNonRoot")]
    property run_as_non_root : Bool?
    # The UID to run the entrypoint of the container process. Defaults to user specified in image metadata if unspecified. May also be set in PodSecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence. Note that this field cannot be set when spec.os.name is windows.
    @[JSON::Field(key: "runAsUser")]
    @[YAML::Field(key: "runAsUser")]
    property run_as_user : Int64?
    # The SELinux context to be applied to the container. If unspecified, the container runtime will allocate a random SELinux context for each container.  May also be set in PodSecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence. Note that this field cannot be set when spec.os.name is windows.
    @[JSON::Field(key: "seLinuxOptions")]
    @[YAML::Field(key: "seLinuxOptions")]
    property se_linux_options : SELinuxOptions?
    # The seccomp options to use by this container. If seccomp options are provided at both the pod & container level, the container options override the pod options. Note that this field cannot be set when spec.os.name is windows.
    @[JSON::Field(key: "seccompProfile")]
    @[YAML::Field(key: "seccompProfile")]
    property seccomp_profile : SeccompProfile?
    # The Windows specific settings applied to all containers. If unspecified, the options from the PodSecurityContext will be used. If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence. Note that this field cannot be set when spec.os.name is linux.
    @[JSON::Field(key: "windowsOptions")]
    @[YAML::Field(key: "windowsOptions")]
    property windows_options : WindowsSecurityContextOptions?
  end

  # Service is a named abstraction of software service (for example, mysql) consisting of local port (for example 3306) that the proxy listens on, and the selector that determines which pods will answer requests sent through the proxy.
  struct Service
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ObjectMeta?
    # Spec defines the behavior of a service. https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status
    property spec : ServiceSpec?
    # Most recently observed status of the service. Populated by the system. Read-only. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status
    property status : ServiceStatus?
  end

  # ServiceAccount binds together: * a name, understood by users, and perhaps by peripheral systems, for an identity * a principal that can be authenticated and authorized * a set of secrets
  struct ServiceAccount
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # AutomountServiceAccountToken indicates whether pods running as this service account should have an API token automatically mounted. Can be overridden at the pod level.
    @[JSON::Field(key: "automountServiceAccountToken")]
    @[YAML::Field(key: "automountServiceAccountToken")]
    property automount_service_account_token : Bool?
    # ImagePullSecrets is a list of references to secrets in the same namespace to use for pulling any images in pods that reference this ServiceAccount. ImagePullSecrets are distinct from Secrets because Secrets can be mounted in the pod, but ImagePullSecrets are only accessed by the kubelet. More info: https://kubernetes.io/docs/concepts/containers/images/#specifying-imagepullsecrets-on-a-pod
    @[JSON::Field(key: "imagePullSecrets")]
    @[YAML::Field(key: "imagePullSecrets")]
    property image_pull_secrets : Array(LocalObjectReference)?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ObjectMeta?
    # Secrets is a list of the secrets in the same namespace that pods running using this ServiceAccount are allowed to use. Pods are only limited to this list if this service account has a "kubernetes.io/enforce-mountable-secrets" annotation set to "true". The "kubernetes.io/enforce-mountable-secrets" annotation is deprecated since v1.32. Prefer separate namespaces to isolate access to mounted secrets. This field should not be used to find auto-generated service account token secrets for use outside of pods. Instead, tokens can be requested directly using the TokenRequest API, or service account token secrets can be manually created. More info: https://kubernetes.io/docs/concepts/configuration/secret
    property secrets : Array(ObjectReference)?
  end

  # ServiceAccountList is a list of ServiceAccount objects
  struct ServiceAccountList
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # List of ServiceAccounts. More info: https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/
    property items : Array(ServiceAccount)?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard list metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property metadata : ListMeta?
  end

  # ServiceAccountTokenProjection represents a projected service account token volume. This projection can be used to insert a service account token into the pods runtime filesystem for use against APIs (Kubernetes API Server or otherwise).
  struct ServiceAccountTokenProjection
    include Kubernetes::Serializable

    # audience is the intended audience of the token. A recipient of a token must identify itself with an identifier specified in the audience of the token, and otherwise should reject the token. The audience defaults to the identifier of the apiserver.
    property audience : String?
    # expirationSeconds is the requested duration of validity of the service account token. As the token approaches expiration, the kubelet volume plugin will proactively rotate the service account token. The kubelet will start trying to rotate the token if the token is older than 80 percent of its time to live or if the token is older than 24 hours.Defaults to 1 hour and must be at least 10 minutes.
    @[JSON::Field(key: "expirationSeconds")]
    @[YAML::Field(key: "expirationSeconds")]
    property expiration_seconds : Int64?
    # path is the path relative to the mount point of the file to project the token into.
    property path : String?
  end

  # ServiceList holds a list of services.
  struct ServiceList
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # List of services
    property items : Array(Service)?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard list metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property metadata : ListMeta?
  end

  # ServicePort contains information on service's port.
  struct ServicePort
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
    # The name of this port within the service. This must be a DNS_LABEL. All ports within a ServiceSpec must have unique names. When considering the endpoints for a Service, this must match the 'name' field in the EndpointPort. Optional if only one ServicePort is defined on this service.
    property name : String?
    # The port on each node on which this service is exposed when type is NodePort or LoadBalancer.  Usually assigned by the system. If a value is specified, in-range, and not in use it will be used, otherwise the operation will fail.  If not specified, a port will be allocated if this Service requires one.  If this field is specified when creating a Service which does not need it, creation will fail. This field will be wiped when updating a Service to no longer need it (e.g. changing type from NodePort to ClusterIP). More info: https://kubernetes.io/docs/concepts/services-networking/service/#type-nodeport
    @[JSON::Field(key: "nodePort")]
    @[YAML::Field(key: "nodePort")]
    property node_port : Int32?
    # The port that will be exposed by this service.
    property port : Int32?
    # The IP protocol for this port. Supports "TCP", "UDP", and "SCTP". Default is TCP.
    property protocol : String?
    # Number or name of the port to access on the pods targeted by the service. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME. If this is a string, it will be looked up as a named port in the target Pod's container ports. If this is not specified, the value of the 'port' field is used (an identity map). This field is ignored for services with clusterIP=None, and should be omitted or set equal to the 'port' field. More info: https://kubernetes.io/docs/concepts/services-networking/service/#defining-a-service
    @[JSON::Field(key: "targetPort")]
    @[YAML::Field(key: "targetPort")]
    property target_port : IntOrString?
  end

  # ServiceSpec describes the attributes that a user creates on a service.
  struct ServiceSpec
    include Kubernetes::Serializable

    # allocateLoadBalancerNodePorts defines if NodePorts will be automatically allocated for services with type LoadBalancer.  Default is "true". It may be set to "false" if the cluster load-balancer does not rely on NodePorts.  If the caller requests specific NodePorts (by specifying a value), those requests will be respected, regardless of this field. This field may only be set for services with type LoadBalancer and will be cleared if the type is changed to any other type.
    @[JSON::Field(key: "allocateLoadBalancerNodePorts")]
    @[YAML::Field(key: "allocateLoadBalancerNodePorts")]
    property allocate_load_balancer_node_ports : Bool?
    # clusterIP is the IP address of the service and is usually assigned randomly. If an address is specified manually, is in-range (as per system configuration), and is not in use, it will be allocated to the service; otherwise creation of the service will fail. This field may not be changed through updates unless the type field is also being changed to ExternalName (which requires this field to be blank) or the type field is being changed from ExternalName (in which case this field may optionally be specified, as describe above).  Valid values are "None", empty string (""), or a valid IP address. Setting this to "None" makes a "headless service" (no virtual IP), which is useful when direct endpoint connections are preferred and proxying is not required.  Only applies to types ClusterIP, NodePort, and LoadBalancer. If this field is specified when creating a Service of type ExternalName, creation will fail. This field will be wiped when updating a Service to type ExternalName. More info: https://kubernetes.io/docs/concepts/services-networking/service/#virtual-ips-and-service-proxies
    @[JSON::Field(key: "clusterIP")]
    @[YAML::Field(key: "clusterIP")]
    property cluster_ip : String?
    # ClusterIPs is a list of IP addresses assigned to this service, and are usually assigned randomly.  If an address is specified manually, is in-range (as per system configuration), and is not in use, it will be allocated to the service; otherwise creation of the service will fail. This field may not be changed through updates unless the type field is also being changed to ExternalName (which requires this field to be empty) or the type field is being changed from ExternalName (in which case this field may optionally be specified, as describe above).  Valid values are "None", empty string (""), or a valid IP address.  Setting this to "None" makes a "headless service" (no virtual IP), which is useful when direct endpoint connections are preferred and proxying is not required.  Only applies to types ClusterIP, NodePort, and LoadBalancer. If this field is specified when creating a Service of type ExternalName, creation will fail. This field will be wiped when updating a Service to type ExternalName.  If this field is not specified, it will be initialized from the clusterIP field.  If this field is specified, clients must ensure that clusterIPs[0] and clusterIP have the same value.
    # This field may hold a maximum of two entries (dual-stack IPs, in either order). These IPs must correspond to the values of the ipFamilies field. Both clusterIPs and ipFamilies are governed by the ipFamilyPolicy field. More info: https://kubernetes.io/docs/concepts/services-networking/service/#virtual-ips-and-service-proxies
    @[JSON::Field(key: "clusterIPs")]
    @[YAML::Field(key: "clusterIPs")]
    property cluster_i_ps : Array(String)?
    # externalIPs is a list of IP addresses for which nodes in the cluster will also accept traffic for this service.  These IPs are not managed by Kubernetes.  The user is responsible for ensuring that traffic arrives at a node with this IP.  A common example is external load-balancers that are not part of the Kubernetes system.
    @[JSON::Field(key: "externalIPs")]
    @[YAML::Field(key: "externalIPs")]
    property external_i_ps : Array(String)?
    # externalName is the external reference that discovery mechanisms will return as an alias for this service (e.g. a DNS CNAME record). No proxying will be involved.  Must be a lowercase RFC-1123 hostname (https://tools.ietf.org/html/rfc1123) and requires `type` to be "ExternalName".
    @[JSON::Field(key: "externalName")]
    @[YAML::Field(key: "externalName")]
    property external_name : String?
    # externalTrafficPolicy describes how nodes distribute service traffic they receive on one of the Service's "externally-facing" addresses (NodePorts, ExternalIPs, and LoadBalancer IPs). If set to "Local", the proxy will configure the service in a way that assumes that external load balancers will take care of balancing the service traffic between nodes, and so each node will deliver traffic only to the node-local endpoints of the service, without masquerading the client source IP. (Traffic mistakenly sent to a node with no endpoints will be dropped.) The default value, "Cluster", uses the standard behavior of routing to all endpoints evenly (possibly modified by topology and other features). Note that traffic sent to an External IP or LoadBalancer IP from within the cluster will always get "Cluster" semantics, but clients sending to a NodePort from within the cluster may need to take traffic policy into account when picking a node.
    @[JSON::Field(key: "externalTrafficPolicy")]
    @[YAML::Field(key: "externalTrafficPolicy")]
    property external_traffic_policy : String?
    # healthCheckNodePort specifies the healthcheck nodePort for the service. This only applies when type is set to LoadBalancer and externalTrafficPolicy is set to Local. If a value is specified, is in-range, and is not in use, it will be used.  If not specified, a value will be automatically allocated.  External systems (e.g. load-balancers) can use this port to determine if a given node holds endpoints for this service or not.  If this field is specified when creating a Service which does not need it, creation will fail. This field will be wiped when updating a Service to no longer need it (e.g. changing type). This field cannot be updated once set.
    @[JSON::Field(key: "healthCheckNodePort")]
    @[YAML::Field(key: "healthCheckNodePort")]
    property health_check_node_port : Int32?
    # InternalTrafficPolicy describes how nodes distribute service traffic they receive on the ClusterIP. If set to "Local", the proxy will assume that pods only want to talk to endpoints of the service on the same node as the pod, dropping the traffic if there are no local endpoints. The default value, "Cluster", uses the standard behavior of routing to all endpoints evenly (possibly modified by topology and other features).
    @[JSON::Field(key: "internalTrafficPolicy")]
    @[YAML::Field(key: "internalTrafficPolicy")]
    property internal_traffic_policy : String?
    # IPFamilies is a list of IP families (e.g. IPv4, IPv6) assigned to this service. This field is usually assigned automatically based on cluster configuration and the ipFamilyPolicy field. If this field is specified manually, the requested family is available in the cluster, and ipFamilyPolicy allows it, it will be used; otherwise creation of the service will fail. This field is conditionally mutable: it allows for adding or removing a secondary IP family, but it does not allow changing the primary IP family of the Service. Valid values are "IPv4" and "IPv6".  This field only applies to Services of types ClusterIP, NodePort, and LoadBalancer, and does apply to "headless" services. This field will be wiped when updating a Service to type ExternalName.
    # This field may hold a maximum of two entries (dual-stack families, in either order).  These families must correspond to the values of the clusterIPs field, if specified. Both clusterIPs and ipFamilies are governed by the ipFamilyPolicy field.
    @[JSON::Field(key: "ipFamilies")]
    @[YAML::Field(key: "ipFamilies")]
    property ip_families : Array(String)?
    # IPFamilyPolicy represents the dual-stack-ness requested or required by this Service. If there is no value provided, then this field will be set to SingleStack. Services can be "SingleStack" (a single IP family), "PreferDualStack" (two IP families on dual-stack configured clusters or a single IP family on single-stack clusters), or "RequireDualStack" (two IP families on dual-stack configured clusters, otherwise fail). The ipFamilies and clusterIPs fields depend on the value of this field. This field will be wiped when updating a service to type ExternalName.
    @[JSON::Field(key: "ipFamilyPolicy")]
    @[YAML::Field(key: "ipFamilyPolicy")]
    property ip_family_policy : String?
    # loadBalancerClass is the class of the load balancer implementation this Service belongs to. If specified, the value of this field must be a label-style identifier, with an optional prefix, e.g. "internal-vip" or "example.com/internal-vip". Unprefixed names are reserved for end-users. This field can only be set when the Service type is 'LoadBalancer'. If not set, the default load balancer implementation is used, today this is typically done through the cloud provider integration, but should apply for any default implementation. If set, it is assumed that a load balancer implementation is watching for Services with a matching class. Any default load balancer implementation (e.g. cloud providers) should ignore Services that set this field. This field can only be set when creating or updating a Service to type 'LoadBalancer'. Once set, it can not be changed. This field will be wiped when a service is updated to a non 'LoadBalancer' type.
    @[JSON::Field(key: "loadBalancerClass")]
    @[YAML::Field(key: "loadBalancerClass")]
    property load_balancer_class : String?
    # Only applies to Service Type: LoadBalancer. This feature depends on whether the underlying cloud-provider supports specifying the loadBalancerIP when a load balancer is created. This field will be ignored if the cloud-provider does not support the feature. Deprecated: This field was under-specified and its meaning varies across implementations. Using it is non-portable and it may not support dual-stack. Users are encouraged to use implementation-specific annotations when available.
    @[JSON::Field(key: "loadBalancerIP")]
    @[YAML::Field(key: "loadBalancerIP")]
    property load_balancer_ip : String?
    # If specified and supported by the platform, this will restrict traffic through the cloud-provider load-balancer will be restricted to the specified client IPs. This field will be ignored if the cloud-provider does not support the feature." More info: https://kubernetes.io/docs/tasks/access-application-cluster/create-external-load-balancer/
    @[JSON::Field(key: "loadBalancerSourceRanges")]
    @[YAML::Field(key: "loadBalancerSourceRanges")]
    property load_balancer_source_ranges : Array(String)?
    # The list of ports that are exposed by this service. More info: https://kubernetes.io/docs/concepts/services-networking/service/#virtual-ips-and-service-proxies
    property ports : Array(ServicePort)?
    # publishNotReadyAddresses indicates that any agent which deals with endpoints for this Service should disregard any indications of ready/not-ready. The primary use case for setting this field is for a StatefulSet's Headless Service to propagate SRV DNS records for its Pods for the purpose of peer discovery. The Kubernetes controllers that generate Endpoints and EndpointSlice resources for Services interpret this to mean that all endpoints are considered "ready" even if the Pods themselves are not. Agents which consume only Kubernetes generated endpoints through the Endpoints or EndpointSlice resources can safely assume this behavior.
    @[JSON::Field(key: "publishNotReadyAddresses")]
    @[YAML::Field(key: "publishNotReadyAddresses")]
    property publish_not_ready_addresses : Bool?
    # Route service traffic to pods with label keys and values matching this selector. If empty or not present, the service is assumed to have an external process managing its endpoints, which Kubernetes will not modify. Only applies to types ClusterIP, NodePort, and LoadBalancer. Ignored if type is ExternalName. More info: https://kubernetes.io/docs/concepts/services-networking/service/
    property selector : Hash(String, String)?
    # Supports "ClientIP" and "None". Used to maintain session affinity. Enable client IP based session affinity. Must be ClientIP or None. Defaults to None. More info: https://kubernetes.io/docs/concepts/services-networking/service/#virtual-ips-and-service-proxies
    @[JSON::Field(key: "sessionAffinity")]
    @[YAML::Field(key: "sessionAffinity")]
    property session_affinity : String?
    # sessionAffinityConfig contains the configurations of session affinity.
    @[JSON::Field(key: "sessionAffinityConfig")]
    @[YAML::Field(key: "sessionAffinityConfig")]
    property session_affinity_config : SessionAffinityConfig?
    # TrafficDistribution offers a way to express preferences for how traffic is distributed to Service endpoints. Implementations can use this field as a hint, but are not required to guarantee strict adherence. If the field is not set, the implementation will apply its default routing strategy. If set to "PreferClose", implementations should prioritize endpoints that are in the same zone.
    @[JSON::Field(key: "trafficDistribution")]
    @[YAML::Field(key: "trafficDistribution")]
    property traffic_distribution : String?
    # type determines how the Service is exposed. Defaults to ClusterIP. Valid options are ExternalName, ClusterIP, NodePort, and LoadBalancer. "ClusterIP" allocates a cluster-internal IP address for load-balancing to endpoints. Endpoints are determined by the selector or if that is not specified, by manual construction of an Endpoints object or EndpointSlice objects. If clusterIP is "None", no virtual IP is allocated and the endpoints are published as a set of endpoints rather than a virtual IP. "NodePort" builds on ClusterIP and allocates a port on every node which routes to the same endpoints as the clusterIP. "LoadBalancer" builds on NodePort and creates an external load-balancer (if supported in the current cloud) which routes to the same endpoints as the clusterIP. "ExternalName" aliases this service to the specified externalName. Several other fields do not apply to ExternalName services. More info: https://kubernetes.io/docs/concepts/services-networking/service/#publishing-services-service-types
    property type : String?
  end

  # ServiceStatus represents the current status of a service.
  struct ServiceStatus
    include Kubernetes::Serializable

    # Current service state
    property conditions : Array(Condition)?
    # LoadBalancer contains the current status of the load-balancer, if one is present.
    @[JSON::Field(key: "loadBalancer")]
    @[YAML::Field(key: "loadBalancer")]
    property load_balancer : LoadBalancerStatus?
  end

  # SessionAffinityConfig represents the configurations of session affinity.
  struct SessionAffinityConfig
    include Kubernetes::Serializable

    # clientIP contains the configurations of Client IP based session affinity.
    @[JSON::Field(key: "clientIP")]
    @[YAML::Field(key: "clientIP")]
    property client_ip : ClientIPConfig?
  end

  # SleepAction describes a "sleep" action.
  struct SleepAction
    include Kubernetes::Serializable

    # Seconds is the number of seconds to sleep.
    property seconds : Int64?
  end

  # Represents a StorageOS persistent volume resource.
  struct StorageOSPersistentVolumeSource
    include Kubernetes::Serializable

    # fsType is the filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. "ext4", "xfs", "ntfs". Implicitly inferred to be "ext4" if unspecified.
    @[JSON::Field(key: "fsType")]
    @[YAML::Field(key: "fsType")]
    property fs_type : String?
    # readOnly defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts.
    @[JSON::Field(key: "readOnly")]
    @[YAML::Field(key: "readOnly")]
    property read_only : Bool?
    # secretRef specifies the secret to use for obtaining the StorageOS API credentials.  If not specified, default values will be attempted.
    @[JSON::Field(key: "secretRef")]
    @[YAML::Field(key: "secretRef")]
    property secret_ref : ObjectReference?
    # volumeName is the human-readable name of the StorageOS volume.  Volume names are only unique within a namespace.
    @[JSON::Field(key: "volumeName")]
    @[YAML::Field(key: "volumeName")]
    property volume_name : String?
    # volumeNamespace specifies the scope of the volume within StorageOS.  If no namespace is specified then the Pod's namespace will be used.  This allows the Kubernetes name scoping to be mirrored within StorageOS for tighter integration. Set VolumeName to any name to override the default behaviour. Set to "default" if you are not using namespaces within StorageOS. Namespaces that do not pre-exist within StorageOS will be created.
    @[JSON::Field(key: "volumeNamespace")]
    @[YAML::Field(key: "volumeNamespace")]
    property volume_namespace : String?
  end

  # Represents a StorageOS persistent volume resource.
  struct StorageOSVolumeSource
    include Kubernetes::Serializable

    # fsType is the filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. "ext4", "xfs", "ntfs". Implicitly inferred to be "ext4" if unspecified.
    @[JSON::Field(key: "fsType")]
    @[YAML::Field(key: "fsType")]
    property fs_type : String?
    # readOnly defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts.
    @[JSON::Field(key: "readOnly")]
    @[YAML::Field(key: "readOnly")]
    property read_only : Bool?
    # secretRef specifies the secret to use for obtaining the StorageOS API credentials.  If not specified, default values will be attempted.
    @[JSON::Field(key: "secretRef")]
    @[YAML::Field(key: "secretRef")]
    property secret_ref : LocalObjectReference?
    # volumeName is the human-readable name of the StorageOS volume.  Volume names are only unique within a namespace.
    @[JSON::Field(key: "volumeName")]
    @[YAML::Field(key: "volumeName")]
    property volume_name : String?
    # volumeNamespace specifies the scope of the volume within StorageOS.  If no namespace is specified then the Pod's namespace will be used.  This allows the Kubernetes name scoping to be mirrored within StorageOS for tighter integration. Set VolumeName to any name to override the default behaviour. Set to "default" if you are not using namespaces within StorageOS. Namespaces that do not pre-exist within StorageOS will be created.
    @[JSON::Field(key: "volumeNamespace")]
    @[YAML::Field(key: "volumeNamespace")]
    property volume_namespace : String?
  end

  # Sysctl defines a kernel parameter to be set
  struct Sysctl
    include Kubernetes::Serializable

    # Name of a property to set
    property name : String?
    # Value of a property to set
    property value : String?
  end

  # TCPSocketAction describes an action based on opening a socket
  struct TCPSocketAction
    include Kubernetes::Serializable

    # Optional: Host name to connect to, defaults to the pod IP.
    property host : String?
    # Number or name of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME.
    property port : IntOrString?
  end

  # The node this Taint is attached to has the "effect" on any pod that does not tolerate the Taint.
  struct Taint
    include Kubernetes::Serializable

    # Required. The effect of the taint on pods that do not tolerate the taint. Valid effects are NoSchedule, PreferNoSchedule and NoExecute.
    property effect : String?
    # Required. The taint key to be applied to a node.
    property key : String?
    # TimeAdded represents the time at which the taint was added.
    @[JSON::Field(key: "timeAdded")]
    @[YAML::Field(key: "timeAdded")]
    property time_added : Time?
    # The taint value corresponding to the taint key.
    property value : String?
  end

  # The pod this Toleration is attached to tolerates any taint that matches the triple <key,value,effect> using the matching operator <operator>.
  struct Toleration
    include Kubernetes::Serializable

    # Effect indicates the taint effect to match. Empty means match all taint effects. When specified, allowed values are NoSchedule, PreferNoSchedule and NoExecute.
    property effect : String?
    # Key is the taint key that the toleration applies to. Empty means match all taint keys. If the key is empty, operator must be Exists; this combination means to match all values and all keys.
    property key : String?
    # Operator represents a key's relationship to the value. Valid operators are Exists and Equal. Defaults to Equal. Exists is equivalent to wildcard for value, so that a pod can tolerate all taints of a particular category.
    property operator : String?
    # TolerationSeconds represents the period of time the toleration (which must be of effect NoExecute, otherwise this field is ignored) tolerates the taint. By default, it is not set, which means tolerate the taint forever (do not evict). Zero and negative values will be treated as 0 (evict immediately) by the system.
    @[JSON::Field(key: "tolerationSeconds")]
    @[YAML::Field(key: "tolerationSeconds")]
    property toleration_seconds : Int64?
    # Value is the taint value the toleration matches to. If the operator is Exists, the value should be empty, otherwise just a regular string.
    property value : String?
  end

  # A topology selector requirement is a selector that matches given label. This is an alpha feature and may change in the future.
  struct TopologySelectorLabelRequirement
    include Kubernetes::Serializable

    # The label key that the selector applies to.
    property key : String?
    # An array of string values. One value must match the label to be selected. Each entry in Values is ORed.
    property values : Array(String)?
  end

  # A topology selector term represents the result of label queries. A null or empty topology selector term matches no objects. The requirements of them are ANDed. It provides a subset of functionality as NodeSelectorTerm. This is an alpha feature and may change in the future.
  struct TopologySelectorTerm
    include Kubernetes::Serializable

    # A list of topology selector requirements by labels.
    @[JSON::Field(key: "matchLabelExpressions")]
    @[YAML::Field(key: "matchLabelExpressions")]
    property match_label_expressions : Array(TopologySelectorLabelRequirement)?
  end

  # TopologySpreadConstraint specifies how to spread matching pods among the given topology.
  struct TopologySpreadConstraint
    include Kubernetes::Serializable

    # LabelSelector is used to find matching pods. Pods that match this label selector are counted to determine the number of pods in their corresponding topology domain.
    @[JSON::Field(key: "labelSelector")]
    @[YAML::Field(key: "labelSelector")]
    property label_selector : LabelSelector?
    # MatchLabelKeys is a set of pod label keys to select the pods over which spreading will be calculated. The keys are used to lookup values from the incoming pod labels, those key-value labels are ANDed with labelSelector to select the group of existing pods over which spreading will be calculated for the incoming pod. The same key is forbidden to exist in both MatchLabelKeys and LabelSelector. MatchLabelKeys cannot be set when LabelSelector isn't set. Keys that don't exist in the incoming pod labels will be ignored. A null or empty list means only match against labelSelector.
    # This is a beta field and requires the MatchLabelKeysInPodTopologySpread feature gate to be enabled (enabled by default).
    @[JSON::Field(key: "matchLabelKeys")]
    @[YAML::Field(key: "matchLabelKeys")]
    property match_label_keys : Array(String)?
    # MaxSkew describes the degree to which pods may be unevenly distributed. When `whenUnsatisfiable=DoNotSchedule`, it is the maximum permitted difference between the number of matching pods in the target topology and the global minimum. The global minimum is the minimum number of matching pods in an eligible domain or zero if the number of eligible domains is less than MinDomains. For example, in a 3-zone cluster, MaxSkew is set to 1, and pods with the same labelSelector spread as 2/2/1: In this case, the global minimum is 1. | zone1 | zone2 | zone3 | |  P P  |  P P  |   P   | - if MaxSkew is 1, incoming pod can only be scheduled to zone3 to become 2/2/2; scheduling it onto zone1(zone2) would make the ActualSkew(3-1) on zone1(zone2) violate MaxSkew(1). - if MaxSkew is 2, incoming pod can be scheduled onto any zone. When `whenUnsatisfiable=ScheduleAnyway`, it is used to give higher precedence to topologies that satisfy it. It's a required field. Default value is 1 and 0 is not allowed.
    @[JSON::Field(key: "maxSkew")]
    @[YAML::Field(key: "maxSkew")]
    property max_skew : Int32?
    # MinDomains indicates a minimum number of eligible domains. When the number of eligible domains with matching topology keys is less than minDomains, Pod Topology Spread treats "global minimum" as 0, and then the calculation of Skew is performed. And when the number of eligible domains with matching topology keys equals or greater than minDomains, this value has no effect on scheduling. As a result, when the number of eligible domains is less than minDomains, scheduler won't schedule more than maxSkew Pods to those domains. If value is nil, the constraint behaves as if MinDomains is equal to 1. Valid values are integers greater than 0. When value is not nil, WhenUnsatisfiable must be DoNotSchedule.
    # For example, in a 3-zone cluster, MaxSkew is set to 2, MinDomains is set to 5 and pods with the same labelSelector spread as 2/2/2: | zone1 | zone2 | zone3 | |  P P  |  P P  |  P P  | The number of domains is less than 5(MinDomains), so "global minimum" is treated as 0. In this situation, new pod with the same labelSelector cannot be scheduled, because computed skew will be 3(3 - 0) if new Pod is scheduled to any of the three zones, it will violate MaxSkew.
    @[JSON::Field(key: "minDomains")]
    @[YAML::Field(key: "minDomains")]
    property min_domains : Int32?
    # NodeAffinityPolicy indicates how we will treat Pod's nodeAffinity/nodeSelector when calculating pod topology spread skew. Options are: - Honor: only nodes matching nodeAffinity/nodeSelector are included in the calculations. - Ignore: nodeAffinity/nodeSelector are ignored. All nodes are included in the calculations.
    # If this value is nil, the behavior is equivalent to the Honor policy.
    @[JSON::Field(key: "nodeAffinityPolicy")]
    @[YAML::Field(key: "nodeAffinityPolicy")]
    property node_affinity_policy : String?
    # NodeTaintsPolicy indicates how we will treat node taints when calculating pod topology spread skew. Options are: - Honor: nodes without taints, along with tainted nodes for which the incoming pod has a toleration, are included. - Ignore: node taints are ignored. All nodes are included.
    # If this value is nil, the behavior is equivalent to the Ignore policy.
    @[JSON::Field(key: "nodeTaintsPolicy")]
    @[YAML::Field(key: "nodeTaintsPolicy")]
    property node_taints_policy : String?
    # TopologyKey is the key of node labels. Nodes that have a label with this key and identical values are considered to be in the same topology. We consider each <key, value> as a "bucket", and try to put balanced number of pods into each bucket. We define a domain as a particular instance of a topology. Also, we define an eligible domain as a domain whose nodes meet the requirements of nodeAffinityPolicy and nodeTaintsPolicy. e.g. If TopologyKey is "kubernetes.io/hostname", each Node is a domain of that topology. And, if TopologyKey is "topology.kubernetes.io/zone", each zone is a domain of that topology. It's a required field.
    @[JSON::Field(key: "topologyKey")]
    @[YAML::Field(key: "topologyKey")]
    property topology_key : String?
    # WhenUnsatisfiable indicates how to deal with a pod if it doesn't satisfy the spread constraint. - DoNotSchedule (default) tells the scheduler not to schedule it. - ScheduleAnyway tells the scheduler to schedule the pod in any location,
    # but giving higher precedence to topologies that would help reduce the
    # skew.
    # A constraint is considered "Unsatisfiable" for an incoming pod if and only if every possible node assignment for that pod would violate "MaxSkew" on some topology. For example, in a 3-zone cluster, MaxSkew is set to 1, and pods with the same labelSelector spread as 3/1/1: | zone1 | zone2 | zone3 | | P P P |   P   |   P   | If WhenUnsatisfiable is set to DoNotSchedule, incoming pod can only be scheduled to zone2(zone3) to become 3/2/1(3/1/2) as ActualSkew(2-1) on zone2(zone3) satisfies MaxSkew(1). In other words, the cluster can still be imbalanced, but scheduler won't make it *more* imbalanced. It's a required field.
    @[JSON::Field(key: "whenUnsatisfiable")]
    @[YAML::Field(key: "whenUnsatisfiable")]
    property when_unsatisfiable : String?
  end

  # TypedLocalObjectReference contains enough information to let you locate the typed referenced object inside the same namespace.
  struct TypedLocalObjectReference
    include Kubernetes::Serializable

    # APIGroup is the group for the resource being referenced. If APIGroup is not specified, the specified Kind must be in the core API group. For any other third-party types, APIGroup is required.
    @[JSON::Field(key: "apiGroup")]
    @[YAML::Field(key: "apiGroup")]
    property api_group : String?
    # Kind is the type of resource being referenced
    property kind : String?
    # Name is the name of resource being referenced
    property name : String?
  end

  # TypedObjectReference contains enough information to let you locate the typed referenced object
  struct TypedObjectReference
    include Kubernetes::Serializable

    # APIGroup is the group for the resource being referenced. If APIGroup is not specified, the specified Kind must be in the core API group. For any other third-party types, APIGroup is required.
    @[JSON::Field(key: "apiGroup")]
    @[YAML::Field(key: "apiGroup")]
    property api_group : String?
    # Kind is the type of resource being referenced
    property kind : String?
    # Name is the name of resource being referenced
    property name : String?
    # Namespace is the namespace of resource being referenced Note that when a namespace is specified, a gateway.networking.k8s.io/ReferenceGrant object is required in the referent namespace to allow that namespace's owner to accept the reference. See the ReferenceGrant documentation for details. (Alpha) This field requires the CrossNamespaceVolumeDataSource feature gate to be enabled.
    property namespace : String?
  end

  # Volume represents a named volume in a pod that may be accessed by any container in the pod.
  struct Volume
    include Kubernetes::Serializable

    # awsElasticBlockStore represents an AWS Disk resource that is attached to a kubelet's host machine and then exposed to the pod. Deprecated: AWSElasticBlockStore is deprecated. All operations for the in-tree awsElasticBlockStore type are redirected to the ebs.csi.aws.com CSI driver. More info: https://kubernetes.io/docs/concepts/storage/volumes#awselasticblockstore
    @[JSON::Field(key: "awsElasticBlockStore")]
    @[YAML::Field(key: "awsElasticBlockStore")]
    property aws_elastic_block_store : AWSElasticBlockStoreVolumeSource?
    # azureDisk represents an Azure Data Disk mount on the host and bind mount to the pod. Deprecated: AzureDisk is deprecated. All operations for the in-tree azureDisk type are redirected to the disk.csi.azure.com CSI driver.
    @[JSON::Field(key: "azureDisk")]
    @[YAML::Field(key: "azureDisk")]
    property azure_disk : AzureDiskVolumeSource?
    # azureFile represents an Azure File Service mount on the host and bind mount to the pod. Deprecated: AzureFile is deprecated. All operations for the in-tree azureFile type are redirected to the file.csi.azure.com CSI driver.
    @[JSON::Field(key: "azureFile")]
    @[YAML::Field(key: "azureFile")]
    property azure_file : AzureFileVolumeSource?
    # cephFS represents a Ceph FS mount on the host that shares a pod's lifetime. Deprecated: CephFS is deprecated and the in-tree cephfs type is no longer supported.
    property cephfs : CephFSVolumeSource?
    # cinder represents a cinder volume attached and mounted on kubelets host machine. Deprecated: Cinder is deprecated. All operations for the in-tree cinder type are redirected to the cinder.csi.openstack.org CSI driver. More info: https://examples.k8s.io/mysql-cinder-pd/README.md
    property cinder : CinderVolumeSource?
    # configMap represents a configMap that should populate this volume
    @[JSON::Field(key: "configMap")]
    @[YAML::Field(key: "configMap")]
    property config_map : ConfigMapVolumeSource?
    # csi (Container Storage Interface) represents ephemeral storage that is handled by certain external CSI drivers.
    property csi : CSIVolumeSource?
    # downwardAPI represents downward API about the pod that should populate this volume
    @[JSON::Field(key: "downwardAPI")]
    @[YAML::Field(key: "downwardAPI")]
    property downward_api : DownwardAPIVolumeSource?
    # emptyDir represents a temporary directory that shares a pod's lifetime. More info: https://kubernetes.io/docs/concepts/storage/volumes#emptydir
    @[JSON::Field(key: "emptyDir")]
    @[YAML::Field(key: "emptyDir")]
    property empty_dir : EmptyDirVolumeSource?
    # ephemeral represents a volume that is handled by a cluster storage driver. The volume's lifecycle is tied to the pod that defines it - it will be created before the pod starts, and deleted when the pod is removed.
    # Use this if: a) the volume is only needed while the pod runs, b) features of normal volumes like restoring from snapshot or capacity
    # tracking are needed,
    # c) the storage driver is specified through a storage class, and d) the storage driver supports dynamic volume provisioning through
    # a PersistentVolumeClaim (see EphemeralVolumeSource for more
    # information on the connection between this volume type
    # and PersistentVolumeClaim).
    # Use PersistentVolumeClaim or one of the vendor-specific APIs for volumes that persist for longer than the lifecycle of an individual pod.
    # Use CSI for light-weight local ephemeral volumes if the CSI driver is meant to be used that way - see the documentation of the driver for more information.
    # A pod can use both types of ephemeral volumes and persistent volumes at the same time.
    property ephemeral : EphemeralVolumeSource?
    # fc represents a Fibre Channel resource that is attached to a kubelet's host machine and then exposed to the pod.
    property fc : FCVolumeSource?
    # flexVolume represents a generic volume resource that is provisioned/attached using an exec based plugin. Deprecated: FlexVolume is deprecated. Consider using a CSIDriver instead.
    @[JSON::Field(key: "flexVolume")]
    @[YAML::Field(key: "flexVolume")]
    property flex_volume : FlexVolumeSource?
    # flocker represents a Flocker volume attached to a kubelet's host machine. This depends on the Flocker control service being running. Deprecated: Flocker is deprecated and the in-tree flocker type is no longer supported.
    property flocker : FlockerVolumeSource?
    # gcePersistentDisk represents a GCE Disk resource that is attached to a kubelet's host machine and then exposed to the pod. Deprecated: GCEPersistentDisk is deprecated. All operations for the in-tree gcePersistentDisk type are redirected to the pd.csi.storage.gke.io CSI driver. More info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk
    @[JSON::Field(key: "gcePersistentDisk")]
    @[YAML::Field(key: "gcePersistentDisk")]
    property gce_persistent_disk : GCEPersistentDiskVolumeSource?
    # gitRepo represents a git repository at a particular revision. Deprecated: GitRepo is deprecated. To provision a container with a git repo, mount an EmptyDir into an InitContainer that clones the repo using git, then mount the EmptyDir into the Pod's container.
    @[JSON::Field(key: "gitRepo")]
    @[YAML::Field(key: "gitRepo")]
    property git_repo : GitRepoVolumeSource?
    # glusterfs represents a Glusterfs mount on the host that shares a pod's lifetime. Deprecated: Glusterfs is deprecated and the in-tree glusterfs type is no longer supported.
    property glusterfs : GlusterfsVolumeSource?
    # hostPath represents a pre-existing file or directory on the host machine that is directly exposed to the container. This is generally used for system agents or other privileged things that are allowed to see the host machine. Most containers will NOT need this. More info: https://kubernetes.io/docs/concepts/storage/volumes#hostpath
    @[JSON::Field(key: "hostPath")]
    @[YAML::Field(key: "hostPath")]
    property host_path : HostPathVolumeSource?
    # image represents an OCI object (a container image or artifact) pulled and mounted on the kubelet's host machine. The volume is resolved at pod startup depending on which PullPolicy value is provided:
    # - Always: the kubelet always attempts to pull the reference. Container creation will fail If the pull fails. - Never: the kubelet never pulls the reference and only uses a local image or artifact. Container creation will fail if the reference isn't present. - IfNotPresent: the kubelet pulls if the reference isn't already present on disk. Container creation will fail if the reference isn't present and the pull fails.
    # The volume gets re-resolved if the pod gets deleted and recreated, which means that new remote content will become available on pod recreation. A failure to resolve or pull the image during pod startup will block containers from starting and may add significant latency. Failures will be retried using normal volume backoff and will be reported on the pod reason and message. The types of objects that may be mounted by this volume are defined by the container runtime implementation on a host machine and at minimum must include all valid types supported by the container image field. The OCI object gets mounted in a single directory (spec.containers[*].volumeMounts.mountPath) by merging the manifest layers in the same way as for container images. The volume will be mounted read-only (ro) and non-executable files (noexec). Sub path mounts for containers are not supported (spec.containers[*].volumeMounts.subpath) before 1.33. The field spec.securityContext.fsGroupChangePolicy has no effect on this volume type.
    property image : ImageVolumeSource?
    # iscsi represents an ISCSI Disk resource that is attached to a kubelet's host machine and then exposed to the pod. More info: https://kubernetes.io/docs/concepts/storage/volumes/#iscsi
    property iscsi : ISCSIVolumeSource?
    # name of the volume. Must be a DNS_LABEL and unique within the pod. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
    property name : String?
    # nfs represents an NFS mount on the host that shares a pod's lifetime More info: https://kubernetes.io/docs/concepts/storage/volumes#nfs
    property nfs : NFSVolumeSource?
    # persistentVolumeClaimVolumeSource represents a reference to a PersistentVolumeClaim in the same namespace. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims
    @[JSON::Field(key: "persistentVolumeClaim")]
    @[YAML::Field(key: "persistentVolumeClaim")]
    property persistent_volume_claim : PersistentVolumeClaimVolumeSource?
    # photonPersistentDisk represents a PhotonController persistent disk attached and mounted on kubelets host machine. Deprecated: PhotonPersistentDisk is deprecated and the in-tree photonPersistentDisk type is no longer supported.
    @[JSON::Field(key: "photonPersistentDisk")]
    @[YAML::Field(key: "photonPersistentDisk")]
    property photon_persistent_disk : PhotonPersistentDiskVolumeSource?
    # portworxVolume represents a portworx volume attached and mounted on kubelets host machine. Deprecated: PortworxVolume is deprecated. All operations for the in-tree portworxVolume type are redirected to the pxd.portworx.com CSI driver when the CSIMigrationPortworx feature-gate is on.
    @[JSON::Field(key: "portworxVolume")]
    @[YAML::Field(key: "portworxVolume")]
    property portworx_volume : PortworxVolumeSource?
    # projected items for all in one resources secrets, configmaps, and downward API
    property projected : ProjectedVolumeSource?
    # quobyte represents a Quobyte mount on the host that shares a pod's lifetime. Deprecated: Quobyte is deprecated and the in-tree quobyte type is no longer supported.
    property quobyte : QuobyteVolumeSource?
    # rbd represents a Rados Block Device mount on the host that shares a pod's lifetime. Deprecated: RBD is deprecated and the in-tree rbd type is no longer supported.
    property rbd : RBDVolumeSource?
    # scaleIO represents a ScaleIO persistent volume attached and mounted on Kubernetes nodes. Deprecated: ScaleIO is deprecated and the in-tree scaleIO type is no longer supported.
    @[JSON::Field(key: "scaleIO")]
    @[YAML::Field(key: "scaleIO")]
    property scale_io : ScaleIOVolumeSource?
    # secret represents a secret that should populate this volume. More info: https://kubernetes.io/docs/concepts/storage/volumes#secret
    property secret : SecretVolumeSource?
    # storageOS represents a StorageOS volume attached and mounted on Kubernetes nodes. Deprecated: StorageOS is deprecated and the in-tree storageos type is no longer supported.
    property storageos : StorageOSVolumeSource?
    # vsphereVolume represents a vSphere volume attached and mounted on kubelets host machine. Deprecated: VsphereVolume is deprecated. All operations for the in-tree vsphereVolume type are redirected to the csi.vsphere.vmware.com CSI driver.
    @[JSON::Field(key: "vsphereVolume")]
    @[YAML::Field(key: "vsphereVolume")]
    property vsphere_volume : VsphereVirtualDiskVolumeSource?
  end

  # volumeDevice describes a mapping of a raw block device within a container.
  struct VolumeDevice
    include Kubernetes::Serializable

    # devicePath is the path inside of the container that the device will be mapped to.
    @[JSON::Field(key: "devicePath")]
    @[YAML::Field(key: "devicePath")]
    property device_path : String?
    # name must match the name of a persistentVolumeClaim in the pod
    property name : String?
  end

  # VolumeMount describes a mounting of a Volume within a container.
  struct VolumeMount
    include Kubernetes::Serializable

    # Path within the container at which the volume should be mounted.  Must not contain ':'.
    @[JSON::Field(key: "mountPath")]
    @[YAML::Field(key: "mountPath")]
    property mount_path : String?
    # mountPropagation determines how mounts are propagated from the host to container and the other way around. When not set, MountPropagationNone is used. This field is beta in 1.10. When RecursiveReadOnly is set to IfPossible or to Enabled, MountPropagation must be None or unspecified (which defaults to None).
    @[JSON::Field(key: "mountPropagation")]
    @[YAML::Field(key: "mountPropagation")]
    property mount_propagation : String?
    # This must match the Name of a Volume.
    property name : String?
    # Mounted read-only if true, read-write otherwise (false or unspecified). Defaults to false.
    @[JSON::Field(key: "readOnly")]
    @[YAML::Field(key: "readOnly")]
    property read_only : Bool?
    # RecursiveReadOnly specifies whether read-only mounts should be handled recursively.
    # If ReadOnly is false, this field has no meaning and must be unspecified.
    # If ReadOnly is true, and this field is set to Disabled, the mount is not made recursively read-only.  If this field is set to IfPossible, the mount is made recursively read-only, if it is supported by the container runtime.  If this field is set to Enabled, the mount is made recursively read-only if it is supported by the container runtime, otherwise the pod will not be started and an error will be generated to indicate the reason.
    # If this field is set to IfPossible or Enabled, MountPropagation must be set to None (or be unspecified, which defaults to None).
    # If this field is not specified, it is treated as an equivalent of Disabled.
    @[JSON::Field(key: "recursiveReadOnly")]
    @[YAML::Field(key: "recursiveReadOnly")]
    property recursive_read_only : String?
    # Path within the volume from which the container's volume should be mounted. Defaults to "" (volume's root).
    @[JSON::Field(key: "subPath")]
    @[YAML::Field(key: "subPath")]
    property sub_path : String?
    # Expanded path within the volume from which the container's volume should be mounted. Behaves similarly to SubPath but environment variable references $(VAR_NAME) are expanded using the container's environment. Defaults to "" (volume's root). SubPathExpr and SubPath are mutually exclusive.
    @[JSON::Field(key: "subPathExpr")]
    @[YAML::Field(key: "subPathExpr")]
    property sub_path_expr : String?
  end

  # VolumeMountStatus shows status of volume mounts.
  struct VolumeMountStatus
    include Kubernetes::Serializable

    # MountPath corresponds to the original VolumeMount.
    @[JSON::Field(key: "mountPath")]
    @[YAML::Field(key: "mountPath")]
    property mount_path : String?
    # Name corresponds to the name of the original VolumeMount.
    property name : String?
    # ReadOnly corresponds to the original VolumeMount.
    @[JSON::Field(key: "readOnly")]
    @[YAML::Field(key: "readOnly")]
    property read_only : Bool?
    # RecursiveReadOnly must be set to Disabled, Enabled, or unspecified (for non-readonly mounts). An IfPossible value in the original VolumeMount must be translated to Disabled or Enabled, depending on the mount result.
    @[JSON::Field(key: "recursiveReadOnly")]
    @[YAML::Field(key: "recursiveReadOnly")]
    property recursive_read_only : String?
  end

  # VolumeNodeAffinity defines constraints that limit what nodes this volume can be accessed from.
  struct VolumeNodeAffinity
    include Kubernetes::Serializable

    # required specifies hard node constraints that must be met.
    property required : NodeSelector?
  end

  # Projection that may be projected along with other supported volume types. Exactly one of these fields must be set.
  struct VolumeProjection
    include Kubernetes::Serializable

    # ClusterTrustBundle allows a pod to access the `.spec.trustBundle` field of ClusterTrustBundle objects in an auto-updating file.
    # Alpha, gated by the ClusterTrustBundleProjection feature gate.
    # ClusterTrustBundle objects can either be selected by name, or by the combination of signer name and a label selector.
    # Kubelet performs aggressive normalization of the PEM contents written into the pod filesystem.  Esoteric PEM features such as inter-block comments and block headers are stripped.  Certificates are deduplicated. The ordering of certificates within the file is arbitrary, and Kubelet may change the order over time.
    @[JSON::Field(key: "clusterTrustBundle")]
    @[YAML::Field(key: "clusterTrustBundle")]
    property cluster_trust_bundle : ClusterTrustBundleProjection?
    # configMap information about the configMap data to project
    @[JSON::Field(key: "configMap")]
    @[YAML::Field(key: "configMap")]
    property config_map : ConfigMapProjection?
    # downwardAPI information about the downwardAPI data to project
    @[JSON::Field(key: "downwardAPI")]
    @[YAML::Field(key: "downwardAPI")]
    property downward_api : DownwardAPIProjection?
    # Projects an auto-rotating credential bundle (private key and certificate chain) that the pod can use either as a TLS client or server.
    # Kubelet generates a private key and uses it to send a PodCertificateRequest to the named signer.  Once the signer approves the request and issues a certificate chain, Kubelet writes the key and certificate chain to the pod filesystem.  The pod does not start until certificates have been issued for each podCertificate projected volume source in its spec.
    # Kubelet will begin trying to rotate the certificate at the time indicated by the signer using the PodCertificateRequest.Status.BeginRefreshAt timestamp.
    # Kubelet can write a single file, indicated by the credentialBundlePath field, or separate files, indicated by the keyPath and certificateChainPath fields.
    # The credential bundle is a single file in PEM format.  The first PEM entry is the private key (in PKCS#8 format), and the remaining PEM entries are the certificate chain issued by the signer (typically, signers will return their certificate chain in leaf-to-root order).
    # Prefer using the credential bundle format, since your application code can read it atomically.  If you use keyPath and certificateChainPath, your application must make two separate file reads. If these coincide with a certificate rotation, it is possible that the private key and leaf certificate you read may not correspond to each other.  Your application will need to check for this condition, and re-read until they are consistent.
    # The named signer controls chooses the format of the certificate it issues; consult the signer implementation's documentation to learn how to use the certificates it issues.
    @[JSON::Field(key: "podCertificate")]
    @[YAML::Field(key: "podCertificate")]
    property pod_certificate : PodCertificateProjection?
    # secret information about the secret data to project
    property secret : SecretProjection?
    # serviceAccountToken is information about the serviceAccountToken data to project
    @[JSON::Field(key: "serviceAccountToken")]
    @[YAML::Field(key: "serviceAccountToken")]
    property service_account_token : ServiceAccountTokenProjection?
  end

  # VolumeResourceRequirements describes the storage resource requirements for a volume.
  struct VolumeResourceRequirements
    include Kubernetes::Serializable

    # Limits describes the maximum amount of compute resources allowed. More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
    property limits : Hash(String, String)?
    # Requests describes the minimum amount of compute resources required. If Requests is omitted for a container, it defaults to Limits if that is explicitly specified, otherwise to an implementation-defined value. Requests cannot exceed Limits. More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
    property requests : Hash(String, String)?
  end

  # Represents a vSphere volume resource.
  struct VsphereVirtualDiskVolumeSource
    include Kubernetes::Serializable

    # fsType is filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. "ext4", "xfs", "ntfs". Implicitly inferred to be "ext4" if unspecified.
    @[JSON::Field(key: "fsType")]
    @[YAML::Field(key: "fsType")]
    property fs_type : String?
    # storagePolicyID is the storage Policy Based Management (SPBM) profile ID associated with the StoragePolicyName.
    @[JSON::Field(key: "storagePolicyID")]
    @[YAML::Field(key: "storagePolicyID")]
    property storage_policy_id : String?
    # storagePolicyName is the storage Policy Based Management (SPBM) profile name.
    @[JSON::Field(key: "storagePolicyName")]
    @[YAML::Field(key: "storagePolicyName")]
    property storage_policy_name : String?
    # volumePath is the path that identifies vSphere volume vmdk
    @[JSON::Field(key: "volumePath")]
    @[YAML::Field(key: "volumePath")]
    property volume_path : String?
  end

  # The weights of all of the matched WeightedPodAffinityTerm fields are added per-node to find the most preferred node(s)
  struct WeightedPodAffinityTerm
    include Kubernetes::Serializable

    # Required. A pod affinity term, associated with the corresponding weight.
    @[JSON::Field(key: "podAffinityTerm")]
    @[YAML::Field(key: "podAffinityTerm")]
    property pod_affinity_term : PodAffinityTerm?
    # weight associated with matching the corresponding podAffinityTerm, in the range 1-100.
    property weight : Int32?
  end

  # WindowsSecurityContextOptions contain Windows-specific options and credentials.
  struct WindowsSecurityContextOptions
    include Kubernetes::Serializable

    # GMSACredentialSpec is where the GMSA admission webhook (https://github.com/kubernetes-sigs/windows-gmsa) inlines the contents of the GMSA credential spec named by the GMSACredentialSpecName field.
    @[JSON::Field(key: "gmsaCredentialSpec")]
    @[YAML::Field(key: "gmsaCredentialSpec")]
    property gmsa_credential_spec : String?
    # GMSACredentialSpecName is the name of the GMSA credential spec to use.
    @[JSON::Field(key: "gmsaCredentialSpecName")]
    @[YAML::Field(key: "gmsaCredentialSpecName")]
    property gmsa_credential_spec_name : String?
    # HostProcess determines if a container should be run as a 'Host Process' container. All of a Pod's containers must have the same effective HostProcess value (it is not allowed to have a mix of HostProcess containers and non-HostProcess containers). In addition, if HostProcess is true then HostNetwork must also be set to true.
    @[JSON::Field(key: "hostProcess")]
    @[YAML::Field(key: "hostProcess")]
    property host_process : Bool?
    # The UserName in Windows to run the entrypoint of the container process. Defaults to the user specified in image metadata if unspecified. May also be set in PodSecurityContext. If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence.
    @[JSON::Field(key: "runAsUserName")]
    @[YAML::Field(key: "runAsUserName")]
    property run_as_user_name : String?
  end

  # Endpoint represents a single logical "backend" implementing a service.
  struct Endpoint
    include Kubernetes::Serializable

    # addresses of this endpoint. For EndpointSlices of addressType "IPv4" or "IPv6", the values are IP addresses in canonical form. The syntax and semantics of other addressType values are not defined. This must contain at least one address but no more than 100. EndpointSlices generated by the EndpointSlice controller will always have exactly 1 address. No semantics are defined for additional addresses beyond the first, and kube-proxy does not look at them.
    property addresses : Array(String)?
    # conditions contains information about the current status of the endpoint.
    property conditions : EndpointConditions?
    # deprecatedTopology contains topology information part of the v1beta1 API. This field is deprecated, and will be removed when the v1beta1 API is removed (no sooner than kubernetes v1.24).  While this field can hold values, it is not writable through the v1 API, and any attempts to write to it will be silently ignored. Topology information can be found in the zone and nodeName fields instead.
    @[JSON::Field(key: "deprecatedTopology")]
    @[YAML::Field(key: "deprecatedTopology")]
    property deprecated_topology : Hash(String, String)?
    # hints contains information associated with how an endpoint should be consumed.
    property hints : EndpointHints?
    # hostname of this endpoint. This field may be used by consumers of endpoints to distinguish endpoints from each other (e.g. in DNS names). Multiple endpoints which use the same hostname should be considered fungible (e.g. multiple A values in DNS). Must be lowercase and pass DNS Label (RFC 1123) validation.
    property hostname : String?
    # nodeName represents the name of the Node hosting this endpoint. This can be used to determine endpoints local to a Node.
    @[JSON::Field(key: "nodeName")]
    @[YAML::Field(key: "nodeName")]
    property node_name : String?
    # targetRef is a reference to a Kubernetes object that represents this endpoint.
    @[JSON::Field(key: "targetRef")]
    @[YAML::Field(key: "targetRef")]
    property target_ref : ObjectReference?
    # zone is the name of the Zone this endpoint exists in.
    property zone : String?
  end

  # EndpointConditions represents the current condition of an endpoint.
  struct EndpointConditions
    include Kubernetes::Serializable

    # ready indicates that this endpoint is ready to receive traffic, according to whatever system is managing the endpoint. A nil value should be interpreted as "true". In general, an endpoint should be marked ready if it is serving and not terminating, though this can be overridden in some cases, such as when the associated Service has set the publishNotReadyAddresses flag.
    property ready : Bool?
    # serving indicates that this endpoint is able to receive traffic, according to whatever system is managing the endpoint. For endpoints backed by pods, the EndpointSlice controller will mark the endpoint as serving if the pod's Ready condition is True. A nil value should be interpreted as "true".
    property serving : Bool?
    # terminating indicates that this endpoint is terminating. A nil value should be interpreted as "false".
    property terminating : Bool?
  end

  # EndpointHints provides hints describing how an endpoint should be consumed.
  struct EndpointHints
    include Kubernetes::Serializable

    # forNodes indicates the node(s) this endpoint should be consumed by when using topology aware routing. May contain a maximum of 8 entries. This is an Alpha feature and is only used when the PreferSameTrafficDistribution feature gate is enabled.
    @[JSON::Field(key: "forNodes")]
    @[YAML::Field(key: "forNodes")]
    property for_nodes : Array(ForNode)?
    # forZones indicates the zone(s) this endpoint should be consumed by when using topology aware routing. May contain a maximum of 8 entries.
    @[JSON::Field(key: "forZones")]
    @[YAML::Field(key: "forZones")]
    property for_zones : Array(ForZone)?
  end

  # EndpointSlice represents a set of service endpoints. Most EndpointSlices are created by the EndpointSlice controller to represent the Pods selected by Service objects. For a given service there may be multiple EndpointSlice objects which must be joined to produce the full set of endpoints; you can find all of the slices for a given service by listing EndpointSlices in the service's namespace whose `kubernetes.io/service-name` label contains the service's name.
  struct EndpointSlice
    include Kubernetes::Serializable

    # addressType specifies the type of address carried by this EndpointSlice. All addresses in this slice must be the same type. This field is immutable after creation. The following address types are currently supported: * IPv4: Represents an IPv4 Address. * IPv6: Represents an IPv6 Address. * FQDN: Represents a Fully Qualified Domain Name. (Deprecated) The EndpointSlice controller only generates, and kube-proxy only processes, slices of addressType "IPv4" and "IPv6". No semantics are defined for the "FQDN" type.
    @[JSON::Field(key: "addressType")]
    @[YAML::Field(key: "addressType")]
    property address_type : String?
    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # endpoints is a list of unique endpoints in this slice. Each slice may include a maximum of 1000 endpoints.
    property endpoints : Array(Endpoint)?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard object's metadata.
    property metadata : ObjectMeta?
    # ports specifies the list of network ports exposed by each endpoint in this slice. Each port must have a unique name. Each slice may include a maximum of 100 ports. Services always have at least 1 port, so EndpointSlices generated by the EndpointSlice controller will likewise always have at least 1 port. EndpointSlices used for other purposes may have an empty ports list.
    property ports : Array(EndpointPort)?
  end

  # EndpointSliceList represents a list of endpoint slices
  struct EndpointSliceList
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # items is the list of endpoint slices
    property items : Array(EndpointSlice)?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard list metadata.
    property metadata : ListMeta?
  end

  # ForNode provides information about which nodes should consume this endpoint.
  struct ForNode
    include Kubernetes::Serializable

    # name represents the name of the node.
    property name : String?
  end

  # ForZone provides information about which zones should consume this endpoint.
  struct ForZone
    include Kubernetes::Serializable

    # name represents the name of the zone.
    property name : String?
  end

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

  # UserSubject holds detailed information for user-kind subject.
  struct UserSubject
    include Kubernetes::Serializable

    # `name` is the username that matches, or "*" to match all usernames. Required.
    property name : String?
  end

  # HTTPIngressPath associates a path with a backend. Incoming urls matching the path are forwarded to the backend.
  struct HTTPIngressPath
    include Kubernetes::Serializable

    # backend defines the referenced service endpoint to which the traffic will be forwarded to.
    property backend : IngressBackend?
    # path is matched against the path of an incoming request. Currently it can contain characters disallowed from the conventional "path" part of a URL as defined by RFC 3986. Paths must begin with a '/' and must be present when using PathType with value "Exact" or "Prefix".
    property path : String?
    # pathType determines the interpretation of the path matching. PathType can be one of the following values: * Exact: Matches the URL path exactly. * Prefix: Matches based on a URL path prefix split by '/'. Matching is
    # done on a path element by element basis. A path element refers is the
    # list of labels in the path split by the '/' separator. A request is a
    # match for path p if every p is an element-wise prefix of p of the
    # request path. Note that if the last element of the path is a substring
    # of the last element in request path, it is not a match (e.g. /foo/bar
    # matches /foo/bar/baz, but does not match /foo/barbaz).
    # * ImplementationSpecific: Interpretation of the Path matching is up to
    # the IngressClass. Implementations can treat this as a separate PathType
    # or treat it identically to Prefix or Exact path types.
    # Implementations are required to support all path types.
    @[JSON::Field(key: "pathType")]
    @[YAML::Field(key: "pathType")]
    property path_type : String?
  end

  # HTTPIngressRuleValue is a list of http selectors pointing to backends. In the example: http://<host>/<path>?<searchpart> -> backend where where parts of the url correspond to RFC 3986, this resource will be used to match against everything after the last '/' and before the first '?' or '#'.
  struct HTTPIngressRuleValue
    include Kubernetes::Serializable

    # paths is a collection of paths that map requests to backends.
    property paths : Array(HTTPIngressPath)?
  end

  # IPAddress represents a single IP of a single IP Family. The object is designed to be used by APIs that operate on IP addresses. The object is used by the Service core API for allocation of IP addresses. An IP address can be represented in different formats, to guarantee the uniqueness of the IP, the name of the object is the IP address in canonical format, four decimal digits separated by dots suppressing leading zeros for IPv4 and the representation defined by RFC 5952 for IPv6. Valid: 192.168.1.5 or 2001:db8::1 or 2001:db8:aaaa:bbbb:cccc:dddd:eeee:1 Invalid: 10.01.2.3 or 2001:db8:0:0:0::1
  struct IPAddress
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ObjectMeta?
    # spec is the desired state of the IPAddress. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status
    property spec : IPAddressSpec?
  end

  # IPAddressList contains a list of IPAddress.
  struct IPAddressList
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # items is the list of IPAddresses.
    property items : Array(IPAddress)?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ListMeta?
  end

  # IPAddressSpec describe the attributes in an IP Address.
  struct IPAddressSpec
    include Kubernetes::Serializable

    # ParentRef references the resource that an IPAddress is attached to. An IPAddress must reference a parent object.
    @[JSON::Field(key: "parentRef")]
    @[YAML::Field(key: "parentRef")]
    property parent_ref : ParentReference?
  end

  # IPBlock describes a particular CIDR (Ex. "192.168.1.0/24","2001:db8::/64") that is allowed to the pods matched by a NetworkPolicySpec's podSelector. The except entry describes CIDRs that should not be included within this rule.
  struct IPBlock
    include Kubernetes::Serializable

    # cidr is a string representing the IPBlock Valid examples are "192.168.1.0/24" or "2001:db8::/64"
    property cidr : String?
    # except is a slice of CIDRs that should not be included within an IPBlock Valid examples are "192.168.1.0/24" or "2001:db8::/64" Except values will be rejected if they are outside the cidr range
    property except : Array(String)?
  end

  # Ingress is a collection of rules that allow inbound connections to reach the endpoints defined by a backend. An Ingress can be configured to give services externally-reachable urls, load balance traffic, terminate SSL, offer name based virtual hosting etc.
  struct Ingress
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ObjectMeta?
    # spec is the desired state of the Ingress. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status
    property spec : IngressSpec?
    # status is the current state of the Ingress. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status
    property status : IngressStatus?
  end

  # IngressBackend describes all endpoints for a given service and port.
  struct IngressBackend
    include Kubernetes::Serializable

    # resource is an ObjectRef to another Kubernetes resource in the namespace of the Ingress object. If resource is specified, a service.Name and service.Port must not be specified. This is a mutually exclusive setting with "Service".
    property resource : TypedLocalObjectReference?
    # service references a service as a backend. This is a mutually exclusive setting with "Resource".
    property service : IngressServiceBackend?
  end

  # IngressClass represents the class of the Ingress, referenced by the Ingress Spec. The `ingressclass.kubernetes.io/is-default-class` annotation can be used to indicate that an IngressClass should be considered default. When a single IngressClass resource has this annotation set to true, new Ingress resources without a class specified will be assigned this default class.
  struct IngressClass
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ObjectMeta?
    # spec is the desired state of the IngressClass. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status
    property spec : IngressClassSpec?
  end

  # IngressClassList is a collection of IngressClasses.
  struct IngressClassList
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # items is the list of IngressClasses.
    property items : Array(IngressClass)?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard list metadata.
    property metadata : ListMeta?
  end

  # IngressClassParametersReference identifies an API object. This can be used to specify a cluster or namespace-scoped resource.
  struct IngressClassParametersReference
    include Kubernetes::Serializable

    # apiGroup is the group for the resource being referenced. If APIGroup is not specified, the specified Kind must be in the core API group. For any other third-party types, APIGroup is required.
    @[JSON::Field(key: "apiGroup")]
    @[YAML::Field(key: "apiGroup")]
    property api_group : String?
    # kind is the type of resource being referenced.
    property kind : String?
    # name is the name of resource being referenced.
    property name : String?
    # namespace is the namespace of the resource being referenced. This field is required when scope is set to "Namespace" and must be unset when scope is set to "Cluster".
    property namespace : String?
    # scope represents if this refers to a cluster or namespace scoped resource. This may be set to "Cluster" (default) or "Namespace".
    property scope : String?
  end

  # IngressClassSpec provides information about the class of an Ingress.
  struct IngressClassSpec
    include Kubernetes::Serializable

    # controller refers to the name of the controller that should handle this class. This allows for different "flavors" that are controlled by the same controller. For example, you may have different parameters for the same implementing controller. This should be specified as a domain-prefixed path no more than 250 characters in length, e.g. "acme.io/ingress-controller". This field is immutable.
    property controller : String?
    # parameters is a link to a custom resource containing additional configuration for the controller. This is optional if the controller does not require extra parameters.
    property parameters : IngressClassParametersReference?
  end

  # IngressList is a collection of Ingress.
  struct IngressList
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # items is the list of Ingress.
    property items : Array(Ingress)?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ListMeta?
  end

  # IngressLoadBalancerIngress represents the status of a load-balancer ingress point.
  struct IngressLoadBalancerIngress
    include Kubernetes::Serializable

    # hostname is set for load-balancer ingress points that are DNS based.
    property hostname : String?
    # ip is set for load-balancer ingress points that are IP based.
    property ip : String?
    # ports provides information about the ports exposed by this LoadBalancer.
    property ports : Array(IngressPortStatus)?
  end

  # IngressLoadBalancerStatus represents the status of a load-balancer.
  struct IngressLoadBalancerStatus
    include Kubernetes::Serializable

    # ingress is a list containing ingress points for the load-balancer.
    property ingress : Array(IngressLoadBalancerIngress)?
  end

  # IngressPortStatus represents the error condition of a service port
  struct IngressPortStatus
    include Kubernetes::Serializable

    # error is to record the problem with the service port The format of the error shall comply with the following rules: - built-in error values shall be specified in this file and those shall use
    # CamelCase names
    # - cloud provider specific error values must have names that comply with the
    # format foo.example.com/CamelCase.
    property error : String?
    # port is the port number of the ingress port.
    property port : Int32?
    # protocol is the protocol of the ingress port. The supported values are: "TCP", "UDP", "SCTP"
    property protocol : String?
  end

  # IngressRule represents the rules mapping the paths under a specified host to the related backend services. Incoming requests are first evaluated for a host match, then routed to the backend associated with the matching IngressRuleValue.
  struct IngressRule
    include Kubernetes::Serializable

    # host is the fully qualified domain name of a network host, as defined by RFC 3986. Note the following deviations from the "host" part of the URI as defined in RFC 3986: 1. IPs are not allowed. Currently an IngressRuleValue can only apply to
    # the IP in the Spec of the parent Ingress.
    # 2. The `:` delimiter is not respected because ports are not allowed.
    # Currently the port of an Ingress is implicitly :80 for http and
    # :443 for https.
    # Both these may change in the future. Incoming requests are matched against the host before the IngressRuleValue. If the host is unspecified, the Ingress routes all traffic based on the specified IngressRuleValue.
    # host can be "precise" which is a domain name without the terminating dot of a network host (e.g. "foo.bar.com") or "wildcard", which is a domain name prefixed with a single wildcard label (e.g. "*.foo.com"). The wildcard character '*' must appear by itself as the first DNS label and matches only a single label. You cannot have a wildcard label by itself (e.g. Host == "*"). Requests will be matched against the Host field in the following way: 1. If host is precise, the request matches this rule if the http host header is equal to Host. 2. If host is a wildcard, then the request matches this rule if the http host header is to equal to the suffix (removing the first label) of the wildcard rule.
    property host : String?
    property http : HTTPIngressRuleValue?
  end

  # IngressServiceBackend references a Kubernetes Service as a Backend.
  struct IngressServiceBackend
    include Kubernetes::Serializable

    # name is the referenced service. The service must exist in the same namespace as the Ingress object.
    property name : String?
    # port of the referenced service. A port name or port number is required for a IngressServiceBackend.
    property port : ServiceBackendPort?
  end

  # IngressSpec describes the Ingress the user wishes to exist.
  struct IngressSpec
    include Kubernetes::Serializable

    # defaultBackend is the backend that should handle requests that don't match any rule. If Rules are not specified, DefaultBackend must be specified. If DefaultBackend is not set, the handling of requests that do not match any of the rules will be up to the Ingress controller.
    @[JSON::Field(key: "defaultBackend")]
    @[YAML::Field(key: "defaultBackend")]
    property default_backend : IngressBackend?
    # ingressClassName is the name of an IngressClass cluster resource. Ingress controller implementations use this field to know whether they should be serving this Ingress resource, by a transitive connection (controller -> IngressClass -> Ingress resource). Although the `kubernetes.io/ingress.class` annotation (simple constant name) was never formally defined, it was widely supported by Ingress controllers to create a direct binding between Ingress controller and Ingress resources. Newly created Ingress resources should prefer using the field. However, even though the annotation is officially deprecated, for backwards compatibility reasons, ingress controllers should still honor that annotation if present.
    @[JSON::Field(key: "ingressClassName")]
    @[YAML::Field(key: "ingressClassName")]
    property ingress_class_name : String?
    # rules is a list of host rules used to configure the Ingress. If unspecified, or no rule matches, all traffic is sent to the default backend.
    property rules : Array(IngressRule)?
    # tls represents the TLS configuration. Currently the Ingress only supports a single TLS port, 443. If multiple members of this list specify different hosts, they will be multiplexed on the same port according to the hostname specified through the SNI TLS extension, if the ingress controller fulfilling the ingress supports SNI.
    property tls : Array(IngressTLS)?
  end

  # IngressStatus describe the current state of the Ingress.
  struct IngressStatus
    include Kubernetes::Serializable

    # loadBalancer contains the current status of the load-balancer.
    @[JSON::Field(key: "loadBalancer")]
    @[YAML::Field(key: "loadBalancer")]
    property load_balancer : IngressLoadBalancerStatus?
  end

  # IngressTLS describes the transport layer security associated with an ingress.
  struct IngressTLS
    include Kubernetes::Serializable

    # hosts is a list of hosts included in the TLS certificate. The values in this list must match the name/s used in the tlsSecret. Defaults to the wildcard host setting for the loadbalancer controller fulfilling this Ingress, if left unspecified.
    property hosts : Array(String)?
    # secretName is the name of the secret used to terminate TLS traffic on port 443. Field is left optional to allow TLS routing based on SNI hostname alone. If the SNI host in a listener conflicts with the "Host" header field used by an IngressRule, the SNI host is used for termination and value of the "Host" header is used for routing.
    @[JSON::Field(key: "secretName")]
    @[YAML::Field(key: "secretName")]
    property secret_name : String?
  end

  # NetworkPolicy describes what network traffic is allowed for a set of Pods
  struct NetworkPolicy
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ObjectMeta?
    # spec represents the specification of the desired behavior for this NetworkPolicy.
    property spec : NetworkPolicySpec?
  end

  # NetworkPolicyEgressRule describes a particular set of traffic that is allowed out of pods matched by a NetworkPolicySpec's podSelector. The traffic must match both ports and to. This type is beta-level in 1.8
  struct NetworkPolicyEgressRule
    include Kubernetes::Serializable

    # ports is a list of destination ports for outgoing traffic. Each item in this list is combined using a logical OR. If this field is empty or missing, this rule matches all ports (traffic not restricted by port). If this field is present and contains at least one item, then this rule allows traffic only if the traffic matches at least one port in the list.
    property ports : Array(NetworkPolicyPort)?
    # to is a list of destinations for outgoing traffic of pods selected for this rule. Items in this list are combined using a logical OR operation. If this field is empty or missing, this rule matches all destinations (traffic not restricted by destination). If this field is present and contains at least one item, this rule allows traffic only if the traffic matches at least one item in the to list.
    property to : Array(NetworkPolicyPeer)?
  end

  # NetworkPolicyIngressRule describes a particular set of traffic that is allowed to the pods matched by a NetworkPolicySpec's podSelector. The traffic must match both ports and from.
  struct NetworkPolicyIngressRule
    include Kubernetes::Serializable

    # from is a list of sources which should be able to access the pods selected for this rule. Items in this list are combined using a logical OR operation. If this field is empty or missing, this rule matches all sources (traffic not restricted by source). If this field is present and contains at least one item, this rule allows traffic only if the traffic matches at least one item in the from list.
    property from : Array(NetworkPolicyPeer)?
    # ports is a list of ports which should be made accessible on the pods selected for this rule. Each item in this list is combined using a logical OR. If this field is empty or missing, this rule matches all ports (traffic not restricted by port). If this field is present and contains at least one item, then this rule allows traffic only if the traffic matches at least one port in the list.
    property ports : Array(NetworkPolicyPort)?
  end

  # NetworkPolicyList is a list of NetworkPolicy objects.
  struct NetworkPolicyList
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # items is a list of schema objects.
    property items : Array(NetworkPolicy)?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard list metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ListMeta?
  end

  # NetworkPolicyPeer describes a peer to allow traffic to/from. Only certain combinations of fields are allowed
  struct NetworkPolicyPeer
    include Kubernetes::Serializable

    # ipBlock defines policy on a particular IPBlock. If this field is set then neither of the other fields can be.
    @[JSON::Field(key: "ipBlock")]
    @[YAML::Field(key: "ipBlock")]
    property ip_block : IPBlock?
    # namespaceSelector selects namespaces using cluster-scoped labels. This field follows standard label selector semantics; if present but empty, it selects all namespaces.
    # If podSelector is also set, then the NetworkPolicyPeer as a whole selects the pods matching podSelector in the namespaces selected by namespaceSelector. Otherwise it selects all pods in the namespaces selected by namespaceSelector.
    @[JSON::Field(key: "namespaceSelector")]
    @[YAML::Field(key: "namespaceSelector")]
    property namespace_selector : LabelSelector?
    # podSelector is a label selector which selects pods. This field follows standard label selector semantics; if present but empty, it selects all pods.
    # If namespaceSelector is also set, then the NetworkPolicyPeer as a whole selects the pods matching podSelector in the Namespaces selected by NamespaceSelector. Otherwise it selects the pods matching podSelector in the policy's own namespace.
    @[JSON::Field(key: "podSelector")]
    @[YAML::Field(key: "podSelector")]
    property pod_selector : LabelSelector?
  end

  # NetworkPolicyPort describes a port to allow traffic on
  struct NetworkPolicyPort
    include Kubernetes::Serializable

    # endPort indicates that the range of ports from port to endPort if set, inclusive, should be allowed by the policy. This field cannot be defined if the port field is not defined or if the port field is defined as a named (string) port. The endPort must be equal or greater than port.
    @[JSON::Field(key: "endPort")]
    @[YAML::Field(key: "endPort")]
    property end_port : Int32?
    # port represents the port on the given protocol. This can either be a numerical or named port on a pod. If this field is not provided, this matches all port names and numbers. If present, only traffic on the specified protocol AND port will be matched.
    property port : IntOrString?
    # protocol represents the protocol (TCP, UDP, or SCTP) which traffic must match. If not specified, this field defaults to TCP.
    property protocol : String?
  end

  # NetworkPolicySpec provides the specification of a NetworkPolicy
  struct NetworkPolicySpec
    include Kubernetes::Serializable

    # egress is a list of egress rules to be applied to the selected pods. Outgoing traffic is allowed if there are no NetworkPolicies selecting the pod (and cluster policy otherwise allows the traffic), OR if the traffic matches at least one egress rule across all of the NetworkPolicy objects whose podSelector matches the pod. If this field is empty then this NetworkPolicy limits all outgoing traffic (and serves solely to ensure that the pods it selects are isolated by default). This field is beta-level in 1.8
    property egress : Array(NetworkPolicyEgressRule)?
    # ingress is a list of ingress rules to be applied to the selected pods. Traffic is allowed to a pod if there are no NetworkPolicies selecting the pod (and cluster policy otherwise allows the traffic), OR if the traffic source is the pod's local node, OR if the traffic matches at least one ingress rule across all of the NetworkPolicy objects whose podSelector matches the pod. If this field is empty then this NetworkPolicy does not allow any traffic (and serves solely to ensure that the pods it selects are isolated by default)
    property ingress : Array(NetworkPolicyIngressRule)?
    # podSelector selects the pods to which this NetworkPolicy object applies. The array of rules is applied to any pods selected by this field. An empty selector matches all pods in the policy's namespace. Multiple network policies can select the same set of pods. In this case, the ingress rules for each are combined additively. This field is optional. If it is not specified, it defaults to an empty selector.
    @[JSON::Field(key: "podSelector")]
    @[YAML::Field(key: "podSelector")]
    property pod_selector : LabelSelector?
    # policyTypes is a list of rule types that the NetworkPolicy relates to. Valid options are ["Ingress"], ["Egress"], or ["Ingress", "Egress"]. If this field is not specified, it will default based on the existence of ingress or egress rules; policies that contain an egress section are assumed to affect egress, and all policies (whether or not they contain an ingress section) are assumed to affect ingress. If you want to write an egress-only policy, you must explicitly specify policyTypes [ "Egress" ]. Likewise, if you want to write a policy that specifies that no egress is allowed, you must specify a policyTypes value that include "Egress" (since such a policy would not include an egress section and would otherwise default to just [ "Ingress" ]). This field is beta-level in 1.8
    @[JSON::Field(key: "policyTypes")]
    @[YAML::Field(key: "policyTypes")]
    property policy_types : Array(String)?
  end

  # ParentReference describes a reference to a parent object.
  struct ParentReference
    include Kubernetes::Serializable

    # Group is the group of the object being referenced.
    property group : String?
    # Name is the name of the object being referenced.
    property name : String?
    # Namespace is the namespace of the object being referenced.
    property namespace : String?
    # Resource is the resource of the object being referenced.
    property resource : String?
  end

  # ServiceBackendPort is the service port being referenced.
  struct ServiceBackendPort
    include Kubernetes::Serializable

    # name is the name of the port on the Service. This is a mutually exclusive setting with "Number".
    property name : String?
    # number is the numerical port number (e.g. 80) on the Service. This is a mutually exclusive setting with "Name".
    property number : Int32?
  end

  # ServiceCIDR defines a range of IP addresses using CIDR format (e.g. 192.168.0.0/24 or 2001:db2::/64). This range is used to allocate ClusterIPs to Service objects.
  struct ServiceCIDR
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ObjectMeta?
    # spec is the desired state of the ServiceCIDR. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status
    property spec : ServiceCIDRSpec?
    # status represents the current state of the ServiceCIDR. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status
    property status : ServiceCIDRStatus?
  end

  # ServiceCIDRList contains a list of ServiceCIDR objects.
  struct ServiceCIDRList
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # items is the list of ServiceCIDRs.
    property items : Array(ServiceCIDR)?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ListMeta?
  end

  # ServiceCIDRSpec define the CIDRs the user wants to use for allocating ClusterIPs for Services.
  struct ServiceCIDRSpec
    include Kubernetes::Serializable

    # CIDRs defines the IP blocks in CIDR notation (e.g. "192.168.0.0/24" or "2001:db8::/64") from which to assign service cluster IPs. Max of two CIDRs is allowed, one of each IP family. This field is immutable.
    property cidrs : Array(String)?
  end

  # ServiceCIDRStatus describes the current state of the ServiceCIDR.
  struct ServiceCIDRStatus
    include Kubernetes::Serializable

    # conditions holds an array of metav1.Condition that describe the state of the ServiceCIDR. Current service state
    property conditions : Array(Condition)?
  end

  # Overhead structure represents the resource overhead associated with running a pod.
  struct Overhead
    include Kubernetes::Serializable

    # podFixed represents the fixed resource overhead associated with running a pod.
    @[JSON::Field(key: "podFixed")]
    @[YAML::Field(key: "podFixed")]
    property pod_fixed : Hash(String, String)?
  end

  # RuntimeClass defines a class of container runtime supported in the cluster. The RuntimeClass is used to determine which container runtime is used to run all containers in a pod. RuntimeClasses are manually defined by a user or cluster provisioner, and referenced in the PodSpec. The Kubelet is responsible for resolving the RuntimeClassName reference before running the pod.  For more details, see https://kubernetes.io/docs/concepts/containers/runtime-class/
  struct RuntimeClass
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # handler specifies the underlying runtime and configuration that the CRI implementation will use to handle pods of this class. The possible values are specific to the node & CRI configuration.  It is assumed that all handlers are available on every node, and handlers of the same name are equivalent on every node. For example, a handler called "runc" might specify that the runc OCI runtime (using native Linux containers) will be used to run the containers in a pod. The Handler must be lowercase, conform to the DNS Label (RFC 1123) requirements, and is immutable.
    property handler : String?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ObjectMeta?
    # overhead represents the resource overhead associated with running a pod for a given RuntimeClass. For more details, see
    # https://kubernetes.io/docs/concepts/scheduling-eviction/pod-overhead/
    property overhead : Overhead?
    # scheduling holds the scheduling constraints to ensure that pods running with this RuntimeClass are scheduled to nodes that support it. If scheduling is nil, this RuntimeClass is assumed to be supported by all nodes.
    property scheduling : Scheduling?
  end

  # RuntimeClassList is a list of RuntimeClass objects.
  struct RuntimeClassList
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # items is a list of schema objects.
    property items : Array(RuntimeClass)?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard list metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ListMeta?
  end

  # Scheduling specifies the scheduling constraints for nodes supporting a RuntimeClass.
  struct Scheduling
    include Kubernetes::Serializable

    # nodeSelector lists labels that must be present on nodes that support this RuntimeClass. Pods using this RuntimeClass can only be scheduled to a node matched by this selector. The RuntimeClass nodeSelector is merged with a pod's existing nodeSelector. Any conflicts will cause the pod to be rejected in admission.
    @[JSON::Field(key: "nodeSelector")]
    @[YAML::Field(key: "nodeSelector")]
    property node_selector : Hash(String, String)?
    # tolerations are appended (excluding duplicates) to pods running with this RuntimeClass during admission, effectively unioning the set of nodes tolerated by the pod and the RuntimeClass.
    property tolerations : Array(Toleration)?
  end

  # Eviction evicts a pod from its node subject to certain policies and safety constraints. This is a subresource of Pod.  A request to cause such an eviction is created by POSTing to .../pods/<pod name>/evictions.
  struct Eviction
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # DeleteOptions may be provided
    @[JSON::Field(key: "deleteOptions")]
    @[YAML::Field(key: "deleteOptions")]
    property delete_options : DeleteOptions?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # ObjectMeta describes the pod that is being evicted.
    property metadata : ObjectMeta?
  end

  # PodDisruptionBudget is an object to define the max disruption that can be caused to a collection of pods
  struct PodDisruptionBudget
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ObjectMeta?
    # Specification of the desired behavior of the PodDisruptionBudget.
    property spec : PodDisruptionBudgetSpec?
    # Most recently observed status of the PodDisruptionBudget.
    property status : PodDisruptionBudgetStatus?
  end

  # PodDisruptionBudgetList is a collection of PodDisruptionBudgets.
  struct PodDisruptionBudgetList
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Items is a list of PodDisruptionBudgets
    property items : Array(PodDisruptionBudget)?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ListMeta?
  end

  # PodDisruptionBudgetSpec is a description of a PodDisruptionBudget.
  struct PodDisruptionBudgetSpec
    include Kubernetes::Serializable

    # An eviction is allowed if at most "maxUnavailable" pods selected by "selector" are unavailable after the eviction, i.e. even in absence of the evicted pod. For example, one can prevent all voluntary evictions by specifying 0. This is a mutually exclusive setting with "minAvailable".
    @[JSON::Field(key: "maxUnavailable")]
    @[YAML::Field(key: "maxUnavailable")]
    property max_unavailable : IntOrString?
    # An eviction is allowed if at least "minAvailable" pods selected by "selector" will still be available after the eviction, i.e. even in the absence of the evicted pod.  So for example you can prevent all voluntary evictions by specifying "100%".
    @[JSON::Field(key: "minAvailable")]
    @[YAML::Field(key: "minAvailable")]
    property min_available : IntOrString?
    # Label query over pods whose evictions are managed by the disruption budget. A null selector will match no pods, while an empty ({}) selector will select all pods within the namespace.
    property selector : LabelSelector?
    # UnhealthyPodEvictionPolicy defines the criteria for when unhealthy pods should be considered for eviction. Current implementation considers healthy pods, as pods that have status.conditions item with type="Ready",status="True".
    # Valid policies are IfHealthyBudget and AlwaysAllow. If no policy is specified, the default behavior will be used, which corresponds to the IfHealthyBudget policy.
    # IfHealthyBudget policy means that running pods (status.phase="Running"), but not yet healthy can be evicted only if the guarded application is not disrupted (status.currentHealthy is at least equal to status.desiredHealthy). Healthy pods will be subject to the PDB for eviction.
    # AlwaysAllow policy means that all running pods (status.phase="Running"), but not yet healthy are considered disrupted and can be evicted regardless of whether the criteria in a PDB is met. This means perspective running pods of a disrupted application might not get a chance to become healthy. Healthy pods will be subject to the PDB for eviction.
    # Additional policies may be added in the future. Clients making eviction decisions should disallow eviction of unhealthy pods if they encounter an unrecognized policy in this field.
    @[JSON::Field(key: "unhealthyPodEvictionPolicy")]
    @[YAML::Field(key: "unhealthyPodEvictionPolicy")]
    property unhealthy_pod_eviction_policy : String?
  end

  # PodDisruptionBudgetStatus represents information about the status of a PodDisruptionBudget. Status may trail the actual state of a system.
  struct PodDisruptionBudgetStatus
    include Kubernetes::Serializable

    # Conditions contain conditions for PDB. The disruption controller sets the DisruptionAllowed condition. The following are known values for the reason field (additional reasons could be added in the future): - SyncFailed: The controller encountered an error and wasn't able to compute
    # the number of allowed disruptions. Therefore no disruptions are
    # allowed and the status of the condition will be False.
    # - InsufficientPods: The number of pods are either at or below the number
    # required by the PodDisruptionBudget. No disruptions are
    # allowed and the status of the condition will be False.
    # - SufficientPods: There are more pods than required by the PodDisruptionBudget.
    # The condition will be True, and the number of allowed
    # disruptions are provided by the disruptionsAllowed property.
    property conditions : Array(Condition)?
    # current number of healthy pods
    @[JSON::Field(key: "currentHealthy")]
    @[YAML::Field(key: "currentHealthy")]
    property current_healthy : Int32?
    # minimum desired number of healthy pods
    @[JSON::Field(key: "desiredHealthy")]
    @[YAML::Field(key: "desiredHealthy")]
    property desired_healthy : Int32?
    # DisruptedPods contains information about pods whose eviction was processed by the API server eviction subresource handler but has not yet been observed by the PodDisruptionBudget controller. A pod will be in this map from the time when the API server processed the eviction request to the time when the pod is seen by PDB controller as having been marked for deletion (or after a timeout). The key in the map is the name of the pod and the value is the time when the API server processed the eviction request. If the deletion didn't occur and a pod is still there it will be removed from the list automatically by PodDisruptionBudget controller after some time. If everything goes smooth this map should be empty for the most of the time. Large number of entries in the map may indicate problems with pod deletions.
    @[JSON::Field(key: "disruptedPods")]
    @[YAML::Field(key: "disruptedPods")]
    property disrupted_pods : Hash(String, Time)?
    # Number of pod disruptions that are currently allowed.
    @[JSON::Field(key: "disruptionsAllowed")]
    @[YAML::Field(key: "disruptionsAllowed")]
    property disruptions_allowed : Int32?
    # total number of pods counted by this disruption budget
    @[JSON::Field(key: "expectedPods")]
    @[YAML::Field(key: "expectedPods")]
    property expected_pods : Int32?
    # Most recent generation observed when updating this PDB status. DisruptionsAllowed and other status information is valid only if observedGeneration equals to PDB's object generation.
    @[JSON::Field(key: "observedGeneration")]
    @[YAML::Field(key: "observedGeneration")]
    property observed_generation : Int64?
  end

  # AggregationRule describes how to locate ClusterRoles to aggregate into the ClusterRole
  struct AggregationRule
    include Kubernetes::Serializable

    # ClusterRoleSelectors holds a list of selectors which will be used to find ClusterRoles and create the rules. If any of the selectors match, then the ClusterRole's permissions will be added
    @[JSON::Field(key: "clusterRoleSelectors")]
    @[YAML::Field(key: "clusterRoleSelectors")]
    property cluster_role_selectors : Array(LabelSelector)?
  end

  # ClusterRole is a cluster level, logical grouping of PolicyRules that can be referenced as a unit by a RoleBinding or ClusterRoleBinding.
  struct ClusterRole
    include Kubernetes::Serializable

    # AggregationRule is an optional field that describes how to build the Rules for this ClusterRole. If AggregationRule is set, then the Rules are controller managed and direct changes to Rules will be stomped by the controller.
    @[JSON::Field(key: "aggregationRule")]
    @[YAML::Field(key: "aggregationRule")]
    property aggregation_rule : AggregationRule?
    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
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
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard object's metadata.
    property metadata : ObjectMeta?
    # RoleRef can only reference a ClusterRole in the global namespace. If the RoleRef cannot be resolved, the Authorizer must return an error. This field is immutable.
    @[JSON::Field(key: "roleRef")]
    @[YAML::Field(key: "roleRef")]
    property role_ref : RoleRef?
    # Subjects holds references to the objects the role applies to.
    property subjects : Array(Subject)?
  end

  # ClusterRoleBindingList is a collection of ClusterRoleBindings
  struct ClusterRoleBindingList
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
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
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
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
    @[JSON::Field(key: "apiGroups")]
    @[YAML::Field(key: "apiGroups")]
    property api_groups : Array(String)?
    # NonResourceURLs is a set of partial urls that a user should have access to.  *s are allowed, but only as the full, final step in the path Since non-resource URLs are not namespaced, this field is only applicable for ClusterRoles referenced from a ClusterRoleBinding. Rules can either apply to API resources (such as "pods" or "secrets") or non-resource URL paths (such as "/api"),  but not both.
    @[JSON::Field(key: "nonResourceURLs")]
    @[YAML::Field(key: "nonResourceURLs")]
    property non_resource_ur_ls : Array(String)?
    # ResourceNames is an optional white list of names that the rule applies to.  An empty set means that everything is allowed.
    @[JSON::Field(key: "resourceNames")]
    @[YAML::Field(key: "resourceNames")]
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
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
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
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard object's metadata.
    property metadata : ObjectMeta?
    # RoleRef can reference a Role in the current namespace or a ClusterRole in the global namespace. If the RoleRef cannot be resolved, the Authorizer must return an error. This field is immutable.
    @[JSON::Field(key: "roleRef")]
    @[YAML::Field(key: "roleRef")]
    property role_ref : RoleRef?
    # Subjects holds references to the objects the role applies to.
    property subjects : Array(Subject)?
  end

  # RoleBindingList is a collection of RoleBindings
  struct RoleBindingList
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
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
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
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
    @[JSON::Field(key: "apiGroup")]
    @[YAML::Field(key: "apiGroup")]
    property api_group : String?
    # Kind is the type of resource being referenced
    property kind : String?
    # Name is the name of resource being referenced
    property name : String?
  end

  # AllocatedDeviceStatus contains the status of an allocated device, if the driver chooses to report it. This may include driver-specific information.
  # The combination of Driver, Pool, Device, and ShareID must match the corresponding key in Status.Allocation.Devices.
  struct AllocatedDeviceStatus
    include Kubernetes::Serializable

    # Conditions contains the latest observation of the device's state. If the device has been configured according to the class and claim config references, the `Ready` condition should be True.
    # Must not contain more than 8 entries.
    property conditions : Array(Condition)?
    # Data contains arbitrary driver-specific data.
    # The length of the raw data must be smaller or equal to 10 Ki.
    property data : Hash(String, JSON::Any)?
    # Device references one device instance via its name in the driver's resource pool. It must be a DNS label.
    property device : String?
    # Driver specifies the name of the DRA driver whose kubelet plugin should be invoked to process the allocation once the claim is needed on a node.
    # Must be a DNS subdomain and should end with a DNS domain owned by the vendor of the driver.
    property driver : String?
    # NetworkData contains network-related information specific to the device.
    @[JSON::Field(key: "networkData")]
    @[YAML::Field(key: "networkData")]
    property network_data : NetworkDeviceData?
    # This name together with the driver name and the device name field identify which device was allocated (`<driver name>/<pool name>/<device name>`).
    # Must not be longer than 253 characters and may contain one or more DNS sub-domains separated by slashes.
    property pool : String?
    # ShareID uniquely identifies an individual allocation share of the device.
    @[JSON::Field(key: "shareID")]
    @[YAML::Field(key: "shareID")]
    property share_id : String?
  end

  # AllocationResult contains attributes of an allocated resource.
  struct AllocationResult
    include Kubernetes::Serializable

    # AllocationTimestamp stores the time when the resources were allocated. This field is not guaranteed to be set, in which case that time is unknown.
    # This is an alpha field and requires enabling the DRADeviceBindingConditions and DRAResourceClaimDeviceStatus feature gate.
    @[JSON::Field(key: "allocationTimestamp")]
    @[YAML::Field(key: "allocationTimestamp")]
    property allocation_timestamp : Time?
    # Devices is the result of allocating devices.
    property devices : DeviceAllocationResult?
    # NodeSelector defines where the allocated resources are available. If unset, they are available everywhere.
    @[JSON::Field(key: "nodeSelector")]
    @[YAML::Field(key: "nodeSelector")]
    property node_selector : NodeSelector?
  end

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
    # - allowMultipleAllocations (bool): the allowMultipleAllocations property of the device
    # (v1.34+ with the DRAConsumableCapacity feature enabled).
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

  # CapacityRequestPolicy defines how requests consume device capacity.
  # Must not set more than one ValidRequestValues.
  struct CapacityRequestPolicy
    include Kubernetes::Serializable

    # Default specifies how much of this capacity is consumed by a request that does not contain an entry for it in DeviceRequest's Capacity.
    property default : String?
    # ValidRange defines an acceptable quantity value range in consuming requests.
    # If this field is set, Default must be defined and it must fall within the defined ValidRange.
    # If the requested amount does not fall within the defined range, the request violates the policy, and this device cannot be allocated.
    # If the request doesn't contain this capacity entry, Default value is used.
    @[JSON::Field(key: "validRange")]
    @[YAML::Field(key: "validRange")]
    property valid_range : CapacityRequestPolicyRange?
    # ValidValues defines a set of acceptable quantity values in consuming requests.
    # Must not contain more than 10 entries. Must be sorted in ascending order.
    # If this field is set, Default must be defined and it must be included in ValidValues list.
    # If the requested amount does not match any valid value but smaller than some valid values, the scheduler calculates the smallest valid value that is greater than or equal to the request. That is: min(ceil(requestedValue) ∈ validValues), where requestedValue ≤ max(validValues).
    # If the requested amount exceeds all valid values, the request violates the policy, and this device cannot be allocated.
    @[JSON::Field(key: "validValues")]
    @[YAML::Field(key: "validValues")]
    property valid_values : Array(String)?
  end

  # CapacityRequestPolicyRange defines a valid range for consumable capacity values.
  # - If the requested amount is less than Min, it is rounded up to the Min value.
  # - If Step is set and the requested amount is between Min and Max but not aligned with Step,
  # it will be rounded up to the next value equal to Min + (n * Step).
  # - If Step is not set, the requested amount is used as-is if it falls within the range Min to Max (if set).
  # - If the requested or rounded amount exceeds Max (if set), the request does not satisfy the policy,
  # and the device cannot be allocated.
  struct CapacityRequestPolicyRange
    include Kubernetes::Serializable

    # Max defines the upper limit for capacity that can be requested.
    # Max must be less than or equal to the capacity value. Min and requestPolicy.default must be less than or equal to the maximum.
    property max : String?
    # Min specifies the minimum capacity allowed for a consumption request.
    # Min must be greater than or equal to zero, and less than or equal to the capacity value. requestPolicy.default must be more than or equal to the minimum.
    property min : String?
    # Step defines the step size between valid capacity amounts within the range.
    # Max (if set) and requestPolicy.default must be a multiple of Step. Min + Step must be less than or equal to the capacity value.
    property step : String?
  end

  # CapacityRequirements defines the capacity requirements for a specific device request.
  struct CapacityRequirements
    include Kubernetes::Serializable

    # Requests represent individual device resource requests for distinct resources, all of which must be provided by the device.
    # This value is used as an additional filtering condition against the available capacity on the device. This is semantically equivalent to a CEL selector with `device.capacity[<domain>].<name>.compareTo(quantity(<request quantity>)) >= 0`. For example, device.capacity['test-driver.cdi.k8s.io'].counters.compareTo(quantity('2')) >= 0.
    # When a requestPolicy is defined, the requested amount is adjusted upward to the nearest valid value based on the policy. If the requested amount cannot be adjusted to a valid value—because it exceeds what the requestPolicy allows— the device is considered ineligible for allocation.
    # For any capacity that is not explicitly requested: - If no requestPolicy is set, the default consumed capacity is equal to the full device capacity
    # (i.e., the whole device is claimed).
    # - If a requestPolicy is set, the default consumed capacity is determined according to that policy.
    # If the device allows multiple allocation, the aggregated amount across all requests must not exceed the capacity value. The consumed capacity, which may be adjusted based on the requestPolicy if defined, is recorded in the resource claim’s status.devices[*].consumedCapacity field.
    property requests : Hash(String, String)?
  end

  # Counter describes a quantity associated with a device.
  struct Counter
    include Kubernetes::Serializable

    # Value defines how much of a certain device counter is available.
    property value : String?
  end

  # CounterSet defines a named set of counters that are available to be used by devices defined in the ResourceSlice.
  # The counters are not allocatable by themselves, but can be referenced by devices. When a device is allocated, the portion of counters it uses will no longer be available for use by other devices.
  struct CounterSet
    include Kubernetes::Serializable

    # Counters defines the set of counters for this CounterSet The name of each counter must be unique in that set and must be a DNS label.
    # The maximum number of counters in all sets is 32.
    property counters : Hash(String, Counter)?
    # Name defines the name of the counter set. It must be a DNS label.
    property name : String?
  end

  # Device represents one individual hardware instance that can be selected based on its attributes. Besides the name, exactly one field must be set.
  struct Device
    include Kubernetes::Serializable

    # AllNodes indicates that all nodes have access to the device.
    # Must only be set if Spec.PerDeviceNodeSelection is set to true. At most one of NodeName, NodeSelector and AllNodes can be set.
    @[JSON::Field(key: "allNodes")]
    @[YAML::Field(key: "allNodes")]
    property all_nodes : Bool?
    # AllowMultipleAllocations marks whether the device is allowed to be allocated to multiple DeviceRequests.
    # If AllowMultipleAllocations is set to true, the device can be allocated more than once, and all of its capacity is consumable, regardless of whether the requestPolicy is defined or not.
    @[JSON::Field(key: "allowMultipleAllocations")]
    @[YAML::Field(key: "allowMultipleAllocations")]
    property allow_multiple_allocations : Bool?
    # Attributes defines the set of attributes for this device. The name of each attribute must be unique in that set.
    # The maximum number of attributes and capacities combined is 32.
    property attributes : Hash(String, DeviceAttribute)?
    # BindingConditions defines the conditions for proceeding with binding. All of these conditions must be set in the per-device status conditions with a value of True to proceed with binding the pod to the node while scheduling the pod.
    # The maximum number of binding conditions is 4.
    # The conditions must be a valid condition type string.
    # This is an alpha field and requires enabling the DRADeviceBindingConditions and DRAResourceClaimDeviceStatus feature gates.
    @[JSON::Field(key: "bindingConditions")]
    @[YAML::Field(key: "bindingConditions")]
    property binding_conditions : Array(String)?
    # BindingFailureConditions defines the conditions for binding failure. They may be set in the per-device status conditions. If any is set to "True", a binding failure occurred.
    # The maximum number of binding failure conditions is 4.
    # The conditions must be a valid condition type string.
    # This is an alpha field and requires enabling the DRADeviceBindingConditions and DRAResourceClaimDeviceStatus feature gates.
    @[JSON::Field(key: "bindingFailureConditions")]
    @[YAML::Field(key: "bindingFailureConditions")]
    property binding_failure_conditions : Array(String)?
    # BindsToNode indicates if the usage of an allocation involving this device has to be limited to exactly the node that was chosen when allocating the claim. If set to true, the scheduler will set the ResourceClaim.Status.Allocation.NodeSelector to match the node where the allocation was made.
    # This is an alpha field and requires enabling the DRADeviceBindingConditions and DRAResourceClaimDeviceStatus feature gates.
    @[JSON::Field(key: "bindsToNode")]
    @[YAML::Field(key: "bindsToNode")]
    property binds_to_node : Bool?
    # Capacity defines the set of capacities for this device. The name of each capacity must be unique in that set.
    # The maximum number of attributes and capacities combined is 32.
    property capacity : Hash(String, DeviceCapacity)?
    # ConsumesCounters defines a list of references to sharedCounters and the set of counters that the device will consume from those counter sets.
    # There can only be a single entry per counterSet.
    # The total number of device counter consumption entries must be <= 32. In addition, the total number in the entire ResourceSlice must be <= 1024 (for example, 64 devices with 16 counters each).
    @[JSON::Field(key: "consumesCounters")]
    @[YAML::Field(key: "consumesCounters")]
    property consumes_counters : Array(DeviceCounterConsumption)?
    # Name is unique identifier among all devices managed by the driver in the pool. It must be a DNS label.
    property name : String?
    # NodeName identifies the node where the device is available.
    # Must only be set if Spec.PerDeviceNodeSelection is set to true. At most one of NodeName, NodeSelector and AllNodes can be set.
    @[JSON::Field(key: "nodeName")]
    @[YAML::Field(key: "nodeName")]
    property node_name : String?
    # NodeSelector defines the nodes where the device is available.
    # Must use exactly one term.
    # Must only be set if Spec.PerDeviceNodeSelection is set to true. At most one of NodeName, NodeSelector and AllNodes can be set.
    @[JSON::Field(key: "nodeSelector")]
    @[YAML::Field(key: "nodeSelector")]
    property node_selector : NodeSelector?
    # If specified, these are the driver-defined taints.
    # The maximum number of taints is 4.
    # This is an alpha field and requires enabling the DRADeviceTaints feature gate.
    property taints : Array(DeviceTaint)?
  end

  # DeviceAllocationConfiguration gets embedded in an AllocationResult.
  struct DeviceAllocationConfiguration
    include Kubernetes::Serializable

    # Opaque provides driver-specific configuration parameters.
    property opaque : OpaqueDeviceConfiguration?
    # Requests lists the names of requests where the configuration applies. If empty, its applies to all requests.
    # References to subrequests must include the name of the main request and may include the subrequest using the format <main request>[/<subrequest>]. If just the main request is given, the configuration applies to all subrequests.
    property requests : Array(String)?
    # Source records whether the configuration comes from a class and thus is not something that a normal user would have been able to set or from a claim.
    property source : String?
  end

  # DeviceAllocationResult is the result of allocating devices.
  struct DeviceAllocationResult
    include Kubernetes::Serializable

    # This field is a combination of all the claim and class configuration parameters. Drivers can distinguish between those based on a flag.
    # This includes configuration parameters for drivers which have no allocated devices in the result because it is up to the drivers which configuration parameters they support. They can silently ignore unknown configuration parameters.
    property config : Array(DeviceAllocationConfiguration)?
    # Results lists all allocated devices.
    property results : Array(DeviceRequestAllocationResult)?
  end

  # DeviceAttribute must have exactly one field set.
  struct DeviceAttribute
    include Kubernetes::Serializable

    # BoolValue is a true/false value.
    property bool : Bool?
    # IntValue is a number.
    property int : Int64?
    # StringValue is a string. Must not be longer than 64 characters.
    property string : String?
    # VersionValue is a semantic version according to semver.org spec 2.0.0. Must not be longer than 64 characters.
    property version : String?
  end

  # DeviceCapacity describes a quantity associated with a device.
  struct DeviceCapacity
    include Kubernetes::Serializable

    # RequestPolicy defines how this DeviceCapacity must be consumed when the device is allowed to be shared by multiple allocations.
    # The Device must have allowMultipleAllocations set to true in order to set a requestPolicy.
    # If unset, capacity requests are unconstrained: requests can consume any amount of capacity, as long as the total consumed across all allocations does not exceed the device's defined capacity. If request is also unset, default is the full capacity value.
    @[JSON::Field(key: "requestPolicy")]
    @[YAML::Field(key: "requestPolicy")]
    property request_policy : CapacityRequestPolicy?
    # Value defines how much of a certain capacity that device has.
    # This field reflects the fixed total capacity and does not change. The consumed amount is tracked separately by scheduler and does not affect this value.
    property value : String?
  end

  # DeviceClaim defines how to request devices with a ResourceClaim.
  struct DeviceClaim
    include Kubernetes::Serializable

    # This field holds configuration for multiple potential drivers which could satisfy requests in this claim. It is ignored while allocating the claim.
    property config : Array(DeviceClaimConfiguration)?
    # These constraints must be satisfied by the set of devices that get allocated for the claim.
    property constraints : Array(DeviceConstraint)?
    # Requests represent individual requests for distinct devices which must all be satisfied. If empty, nothing needs to be allocated.
    property requests : Array(DeviceRequest)?
  end

  # DeviceClaimConfiguration is used for configuration parameters in DeviceClaim.
  struct DeviceClaimConfiguration
    include Kubernetes::Serializable

    # Opaque provides driver-specific configuration parameters.
    property opaque : OpaqueDeviceConfiguration?
    # Requests lists the names of requests where the configuration applies. If empty, it applies to all requests.
    # References to subrequests must include the name of the main request and may include the subrequest using the format <main request>[/<subrequest>]. If just the main request is given, the configuration applies to all subrequests.
    property requests : Array(String)?
  end

  # DeviceClass is a vendor- or admin-provided resource that contains device configuration and selectors. It can be referenced in the device requests of a claim to apply these presets. Cluster scoped.
  # This is an alpha type and requires enabling the DynamicResourceAllocation feature gate.
  struct DeviceClass
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard object metadata
    property metadata : ObjectMeta?
    # Spec defines what can be allocated and how to configure it.
    # This is mutable. Consumers have to be prepared for classes changing at any time, either because they get updated or replaced. Claim allocations are done once based on whatever was set in classes at the time of allocation.
    # Changing the spec automatically increments the metadata.generation number.
    property spec : DeviceClassSpec?
  end

  # DeviceClassConfiguration is used in DeviceClass.
  struct DeviceClassConfiguration
    include Kubernetes::Serializable

    # Opaque provides driver-specific configuration parameters.
    property opaque : OpaqueDeviceConfiguration?
  end

  # DeviceClassList is a collection of classes.
  struct DeviceClassList
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Items is the list of resource classes.
    property items : Array(DeviceClass)?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard list metadata
    property metadata : ListMeta?
  end

  # DeviceClassSpec is used in a [DeviceClass] to define what can be allocated and how to configure it.
  struct DeviceClassSpec
    include Kubernetes::Serializable

    # Config defines configuration parameters that apply to each device that is claimed via this class. Some classses may potentially be satisfied by multiple drivers, so each instance of a vendor configuration applies to exactly one driver.
    # They are passed to the driver, but are not considered while allocating the claim.
    property config : Array(DeviceClassConfiguration)?
    # ExtendedResourceName is the extended resource name for the devices of this class. The devices of this class can be used to satisfy a pod's extended resource requests. It has the same format as the name of a pod's extended resource. It should be unique among all the device classes in a cluster. If two device classes have the same name, then the class created later is picked to satisfy a pod's extended resource requests. If two classes are created at the same time, then the name of the class lexicographically sorted first is picked.
    # This is an alpha field.
    @[JSON::Field(key: "extendedResourceName")]
    @[YAML::Field(key: "extendedResourceName")]
    property extended_resource_name : String?
    # Each selector must be satisfied by a device which is claimed via this class.
    property selectors : Array(DeviceSelector)?
  end

  # DeviceConstraint must have exactly one field set besides Requests.
  struct DeviceConstraint
    include Kubernetes::Serializable

    # DistinctAttribute requires that all devices in question have this attribute and that its type and value are unique across those devices.
    # This acts as the inverse of MatchAttribute.
    # This constraint is used to avoid allocating multiple requests to the same device by ensuring attribute-level differentiation.
    # This is useful for scenarios where resource requests must be fulfilled by separate physical devices. For example, a container requests two network interfaces that must be allocated from two different physical NICs.
    @[JSON::Field(key: "distinctAttribute")]
    @[YAML::Field(key: "distinctAttribute")]
    property distinct_attribute : String?
    # MatchAttribute requires that all devices in question have this attribute and that its type and value are the same across those devices.
    # For example, if you specified "dra.example.com/numa" (a hypothetical example!), then only devices in the same NUMA node will be chosen. A device which does not have that attribute will not be chosen. All devices should use a value of the same type for this attribute because that is part of its specification, but if one device doesn't, then it also will not be chosen.
    # Must include the domain qualifier.
    @[JSON::Field(key: "matchAttribute")]
    @[YAML::Field(key: "matchAttribute")]
    property match_attribute : String?
    # Requests is a list of the one or more requests in this claim which must co-satisfy this constraint. If a request is fulfilled by multiple devices, then all of the devices must satisfy the constraint. If this is not specified, this constraint applies to all requests in this claim.
    # References to subrequests must include the name of the main request and may include the subrequest using the format <main request>[/<subrequest>]. If just the main request is given, the constraint applies to all subrequests.
    property requests : Array(String)?
  end

  # DeviceCounterConsumption defines a set of counters that a device will consume from a CounterSet.
  struct DeviceCounterConsumption
    include Kubernetes::Serializable

    # CounterSet is the name of the set from which the counters defined will be consumed.
    @[JSON::Field(key: "counterSet")]
    @[YAML::Field(key: "counterSet")]
    property counter_set : String?
    # Counters defines the counters that will be consumed by the device.
    # The maximum number counters in a device is 32. In addition, the maximum number of all counters in all devices is 1024 (for example, 64 devices with 16 counters each).
    property counters : Hash(String, Counter)?
  end

  # DeviceRequest is a request for devices required for a claim. This is typically a request for a single resource like a device, but can also ask for several identical devices. With FirstAvailable it is also possible to provide a prioritized list of requests.
  struct DeviceRequest
    include Kubernetes::Serializable

    # Exactly specifies the details for a single request that must be met exactly for the request to be satisfied.
    # One of Exactly or FirstAvailable must be set.
    property exactly : ExactDeviceRequest?
    # FirstAvailable contains subrequests, of which exactly one will be selected by the scheduler. It tries to satisfy them in the order in which they are listed here. So if there are two entries in the list, the scheduler will only check the second one if it determines that the first one can not be used.
    # DRA does not yet implement scoring, so the scheduler will select the first set of devices that satisfies all the requests in the claim. And if the requirements can be satisfied on more than one node, other scheduling features will determine which node is chosen. This means that the set of devices allocated to a claim might not be the optimal set available to the cluster. Scoring will be implemented later.
    @[JSON::Field(key: "firstAvailable")]
    @[YAML::Field(key: "firstAvailable")]
    property first_available : Array(DeviceSubRequest)?
    # Name can be used to reference this request in a pod.spec.containers[].resources.claims entry and in a constraint of the claim.
    # References using the name in the DeviceRequest will uniquely identify a request when the Exactly field is set. When the FirstAvailable field is set, a reference to the name of the DeviceRequest will match whatever subrequest is chosen by the scheduler.
    # Must be a DNS label.
    property name : String?
  end

  # DeviceRequestAllocationResult contains the allocation result for one request.
  struct DeviceRequestAllocationResult
    include Kubernetes::Serializable

    # AdminAccess indicates that this device was allocated for administrative access. See the corresponding request field for a definition of mode.
    # This is an alpha field and requires enabling the DRAAdminAccess feature gate. Admin access is disabled if this field is unset or set to false, otherwise it is enabled.
    @[JSON::Field(key: "adminAccess")]
    @[YAML::Field(key: "adminAccess")]
    property admin_access : Bool?
    # BindingConditions contains a copy of the BindingConditions from the corresponding ResourceSlice at the time of allocation.
    # This is an alpha field and requires enabling the DRADeviceBindingConditions and DRAResourceClaimDeviceStatus feature gates.
    @[JSON::Field(key: "bindingConditions")]
    @[YAML::Field(key: "bindingConditions")]
    property binding_conditions : Array(String)?
    # BindingFailureConditions contains a copy of the BindingFailureConditions from the corresponding ResourceSlice at the time of allocation.
    # This is an alpha field and requires enabling the DRADeviceBindingConditions and DRAResourceClaimDeviceStatus feature gates.
    @[JSON::Field(key: "bindingFailureConditions")]
    @[YAML::Field(key: "bindingFailureConditions")]
    property binding_failure_conditions : Array(String)?
    # ConsumedCapacity tracks the amount of capacity consumed per device as part of the claim request. The consumed amount may differ from the requested amount: it is rounded up to the nearest valid value based on the device’s requestPolicy if applicable (i.e., may not be less than the requested amount).
    # The total consumed capacity for each device must not exceed the DeviceCapacity's Value.
    # This field is populated only for devices that allow multiple allocations. All capacity entries are included, even if the consumed amount is zero.
    @[JSON::Field(key: "consumedCapacity")]
    @[YAML::Field(key: "consumedCapacity")]
    property consumed_capacity : Hash(String, String)?
    # Device references one device instance via its name in the driver's resource pool. It must be a DNS label.
    property device : String?
    # Driver specifies the name of the DRA driver whose kubelet plugin should be invoked to process the allocation once the claim is needed on a node.
    # Must be a DNS subdomain and should end with a DNS domain owned by the vendor of the driver.
    property driver : String?
    # This name together with the driver name and the device name field identify which device was allocated (`<driver name>/<pool name>/<device name>`).
    # Must not be longer than 253 characters and may contain one or more DNS sub-domains separated by slashes.
    property pool : String?
    # Request is the name of the request in the claim which caused this device to be allocated. If it references a subrequest in the firstAvailable list on a DeviceRequest, this field must include both the name of the main request and the subrequest using the format <main request>/<subrequest>.
    # Multiple devices may have been allocated per request.
    property request : String?
    # ShareID uniquely identifies an individual allocation share of the device, used when the device supports multiple simultaneous allocations. It serves as an additional map key to differentiate concurrent shares of the same device.
    @[JSON::Field(key: "shareID")]
    @[YAML::Field(key: "shareID")]
    property share_id : String?
    # A copy of all tolerations specified in the request at the time when the device got allocated.
    # The maximum number of tolerations is 16.
    # This is an alpha field and requires enabling the DRADeviceTaints feature gate.
    property tolerations : Array(DeviceToleration)?
  end

  # DeviceSelector must have exactly one field set.
  struct DeviceSelector
    include Kubernetes::Serializable

    # CEL contains a CEL expression for selecting a device.
    property cel : CELDeviceSelector?
  end

  # DeviceSubRequest describes a request for device provided in the claim.spec.devices.requests[].firstAvailable array. Each is typically a request for a single resource like a device, but can also ask for several identical devices.
  # DeviceSubRequest is similar to ExactDeviceRequest, but doesn't expose the AdminAccess field as that one is only supported when requesting a specific device.
  struct DeviceSubRequest
    include Kubernetes::Serializable

    # AllocationMode and its related fields define how devices are allocated to satisfy this subrequest. Supported values are:
    # - ExactCount: This request is for a specific number of devices.
    # This is the default. The exact number is provided in the
    # count field.
    # - All: This subrequest is for all of the matching devices in a pool.
    # Allocation will fail if some devices are already allocated,
    # unless adminAccess is requested.
    # If AllocationMode is not specified, the default mode is ExactCount. If the mode is ExactCount and count is not specified, the default count is one. Any other subrequests must specify this field.
    # More modes may get added in the future. Clients must refuse to handle requests with unknown modes.
    @[JSON::Field(key: "allocationMode")]
    @[YAML::Field(key: "allocationMode")]
    property allocation_mode : String?
    # Capacity define resource requirements against each capacity.
    # If this field is unset and the device supports multiple allocations, the default value will be applied to each capacity according to requestPolicy. For the capacity that has no requestPolicy, default is the full capacity value.
    # Applies to each device allocation. If Count > 1, the request fails if there aren't enough devices that meet the requirements. If AllocationMode is set to All, the request fails if there are devices that otherwise match the request, and have this capacity, with a value >= the requested amount, but which cannot be allocated to this request.
    property capacity : CapacityRequirements?
    # Count is used only when the count mode is "ExactCount". Must be greater than zero. If AllocationMode is ExactCount and this field is not specified, the default is one.
    property count : Int64?
    # DeviceClassName references a specific DeviceClass, which can define additional configuration and selectors to be inherited by this subrequest.
    # A class is required. Which classes are available depends on the cluster.
    # Administrators may use this to restrict which devices may get requested by only installing classes with selectors for permitted devices. If users are free to request anything without restrictions, then administrators can create an empty DeviceClass for users to reference.
    @[JSON::Field(key: "deviceClassName")]
    @[YAML::Field(key: "deviceClassName")]
    property device_class_name : String?
    # Name can be used to reference this subrequest in the list of constraints or the list of configurations for the claim. References must use the format <main request>/<subrequest>.
    # Must be a DNS label.
    property name : String?
    # Selectors define criteria which must be satisfied by a specific device in order for that device to be considered for this subrequest. All selectors must be satisfied for a device to be considered.
    property selectors : Array(DeviceSelector)?
    # If specified, the request's tolerations.
    # Tolerations for NoSchedule are required to allocate a device which has a taint with that effect. The same applies to NoExecute.
    # In addition, should any of the allocated devices get tainted with NoExecute after allocation and that effect is not tolerated, then all pods consuming the ResourceClaim get deleted to evict them. The scheduler will not let new pods reserve the claim while it has these tainted devices. Once all pods are evicted, the claim will get deallocated.
    # The maximum number of tolerations is 16.
    # This is an alpha field and requires enabling the DRADeviceTaints feature gate.
    property tolerations : Array(DeviceToleration)?
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

  # The ResourceClaim this DeviceToleration is attached to tolerates any taint that matches the triple <key,value,effect> using the matching operator <operator>.
  struct DeviceToleration
    include Kubernetes::Serializable

    # Effect indicates the taint effect to match. Empty means match all taint effects. When specified, allowed values are NoSchedule and NoExecute.
    property effect : String?
    # Key is the taint key that the toleration applies to. Empty means match all taint keys. If the key is empty, operator must be Exists; this combination means to match all values and all keys. Must be a label name.
    property key : String?
    # Operator represents a key's relationship to the value. Valid operators are Exists and Equal. Defaults to Equal. Exists is equivalent to wildcard for value, so that a ResourceClaim can tolerate all taints of a particular category.
    property operator : String?
    # TolerationSeconds represents the period of time the toleration (which must be of effect NoExecute, otherwise this field is ignored) tolerates the taint. By default, it is not set, which means tolerate the taint forever (do not evict). Zero and negative values will be treated as 0 (evict immediately) by the system. If larger than zero, the time when the pod needs to be evicted is calculated as <time when taint was adedd> + <toleration seconds>.
    @[JSON::Field(key: "tolerationSeconds")]
    @[YAML::Field(key: "tolerationSeconds")]
    property toleration_seconds : Int64?
    # Value is the taint value the toleration matches to. If the operator is Exists, the value must be empty, otherwise just a regular string. Must be a label value.
    property value : String?
  end

  # ExactDeviceRequest is a request for one or more identical devices.
  struct ExactDeviceRequest
    include Kubernetes::Serializable

    # AdminAccess indicates that this is a claim for administrative access to the device(s). Claims with AdminAccess are expected to be used for monitoring or other management services for a device.  They ignore all ordinary claims to the device with respect to access modes and any resource allocations.
    # This is an alpha field and requires enabling the DRAAdminAccess feature gate. Admin access is disabled if this field is unset or set to false, otherwise it is enabled.
    @[JSON::Field(key: "adminAccess")]
    @[YAML::Field(key: "adminAccess")]
    property admin_access : Bool?
    # AllocationMode and its related fields define how devices are allocated to satisfy this request. Supported values are:
    # - ExactCount: This request is for a specific number of devices.
    # This is the default. The exact number is provided in the
    # count field.
    # - All: This request is for all of the matching devices in a pool.
    # At least one device must exist on the node for the allocation to succeed.
    # Allocation will fail if some devices are already allocated,
    # unless adminAccess is requested.
    # If AllocationMode is not specified, the default mode is ExactCount. If the mode is ExactCount and count is not specified, the default count is one. Any other requests must specify this field.
    # More modes may get added in the future. Clients must refuse to handle requests with unknown modes.
    @[JSON::Field(key: "allocationMode")]
    @[YAML::Field(key: "allocationMode")]
    property allocation_mode : String?
    # Capacity define resource requirements against each capacity.
    # If this field is unset and the device supports multiple allocations, the default value will be applied to each capacity according to requestPolicy. For the capacity that has no requestPolicy, default is the full capacity value.
    # Applies to each device allocation. If Count > 1, the request fails if there aren't enough devices that meet the requirements. If AllocationMode is set to All, the request fails if there are devices that otherwise match the request, and have this capacity, with a value >= the requested amount, but which cannot be allocated to this request.
    property capacity : CapacityRequirements?
    # Count is used only when the count mode is "ExactCount". Must be greater than zero. If AllocationMode is ExactCount and this field is not specified, the default is one.
    property count : Int64?
    # DeviceClassName references a specific DeviceClass, which can define additional configuration and selectors to be inherited by this request.
    # A DeviceClassName is required.
    # Administrators may use this to restrict which devices may get requested by only installing classes with selectors for permitted devices. If users are free to request anything without restrictions, then administrators can create an empty DeviceClass for users to reference.
    @[JSON::Field(key: "deviceClassName")]
    @[YAML::Field(key: "deviceClassName")]
    property device_class_name : String?
    # Selectors define criteria which must be satisfied by a specific device in order for that device to be considered for this request. All selectors must be satisfied for a device to be considered.
    property selectors : Array(DeviceSelector)?
    # If specified, the request's tolerations.
    # Tolerations for NoSchedule are required to allocate a device which has a taint with that effect. The same applies to NoExecute.
    # In addition, should any of the allocated devices get tainted with NoExecute after allocation and that effect is not tolerated, then all pods consuming the ResourceClaim get deleted to evict them. The scheduler will not let new pods reserve the claim while it has these tainted devices. Once all pods are evicted, the claim will get deallocated.
    # The maximum number of tolerations is 16.
    # This is an alpha field and requires enabling the DRADeviceTaints feature gate.
    property tolerations : Array(DeviceToleration)?
  end

  # NetworkDeviceData provides network-related details for the allocated device. This information may be filled by drivers or other components to configure or identify the device within a network context.
  struct NetworkDeviceData
    include Kubernetes::Serializable

    # HardwareAddress represents the hardware address (e.g. MAC Address) of the device's network interface.
    # Must not be longer than 128 characters.
    @[JSON::Field(key: "hardwareAddress")]
    @[YAML::Field(key: "hardwareAddress")]
    property hardware_address : String?
    # InterfaceName specifies the name of the network interface associated with the allocated device. This might be the name of a physical or virtual network interface being configured in the pod.
    # Must not be longer than 256 characters.
    @[JSON::Field(key: "interfaceName")]
    @[YAML::Field(key: "interfaceName")]
    property interface_name : String?
    # IPs lists the network addresses assigned to the device's network interface. This can include both IPv4 and IPv6 addresses. The IPs are in the CIDR notation, which includes both the address and the associated subnet mask. e.g.: "192.0.2.5/24" for IPv4 and "2001:db8::5/64" for IPv6.
    property ips : Array(String)?
  end

  # OpaqueDeviceConfiguration contains configuration parameters for a driver in a format defined by the driver vendor.
  struct OpaqueDeviceConfiguration
    include Kubernetes::Serializable

    # Driver is used to determine which kubelet plugin needs to be passed these configuration parameters.
    # An admission policy provided by the driver developer could use this to decide whether it needs to validate them.
    # Must be a DNS subdomain and should end with a DNS domain owned by the vendor of the driver.
    property driver : String?
    # Parameters can contain arbitrary data. It is the responsibility of the driver developer to handle validation and versioning. Typically this includes self-identification and a version ("kind" + "apiVersion" for Kubernetes types), with conversion between different versions.
    # The length of the raw data must be smaller or equal to 10 Ki.
    property parameters : Hash(String, JSON::Any)?
  end

  # ResourceClaimConsumerReference contains enough information to let you locate the consumer of a ResourceClaim. The user must be a resource in the same namespace as the ResourceClaim.
  struct ResourceClaimConsumerReference
    include Kubernetes::Serializable

    # APIGroup is the group for the resource being referenced. It is empty for the core API. This matches the group in the APIVersion that is used when creating the resources.
    @[JSON::Field(key: "apiGroup")]
    @[YAML::Field(key: "apiGroup")]
    property api_group : String?
    # Name is the name of resource being referenced.
    property name : String?
    # Resource is the type of resource being referenced, for example "pods".
    property resource : String?
    # UID identifies exactly one incarnation of the resource.
    property uid : String?
  end

  # ResourceClaimList is a collection of claims.
  struct ResourceClaimList
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Items is the list of resource claims.
    property items : Array(ResourceClaim)?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard list metadata
    property metadata : ListMeta?
  end

  # ResourceClaimSpec defines what is being requested in a ResourceClaim and how to configure it.
  struct ResourceClaimSpec
    include Kubernetes::Serializable

    # Devices defines how to request devices.
    property devices : DeviceClaim?
  end

  # ResourceClaimStatus tracks whether the resource has been allocated and what the result of that was.
  struct ResourceClaimStatus
    include Kubernetes::Serializable

    # Allocation is set once the claim has been allocated successfully.
    property allocation : AllocationResult?
    # Devices contains the status of each device allocated for this claim, as reported by the driver. This can include driver-specific information. Entries are owned by their respective drivers.
    property devices : Array(AllocatedDeviceStatus)?
    # ReservedFor indicates which entities are currently allowed to use the claim. A Pod which references a ResourceClaim which is not reserved for that Pod will not be started. A claim that is in use or might be in use because it has been reserved must not get deallocated.
    # In a cluster with multiple scheduler instances, two pods might get scheduled concurrently by different schedulers. When they reference the same ResourceClaim which already has reached its maximum number of consumers, only one pod can be scheduled.
    # Both schedulers try to add their pod to the claim.status.reservedFor field, but only the update that reaches the API server first gets stored. The other one fails with an error and the scheduler which issued it knows that it must put the pod back into the queue, waiting for the ResourceClaim to become usable again.
    # There can be at most 256 such reservations. This may get increased in the future, but not reduced.
    @[JSON::Field(key: "reservedFor")]
    @[YAML::Field(key: "reservedFor")]
    property reserved_for : Array(ResourceClaimConsumerReference)?
  end

  # ResourceClaimTemplate is used to produce ResourceClaim objects.
  # This is an alpha type and requires enabling the DynamicResourceAllocation feature gate.
  struct ResourceClaimTemplate
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard object metadata
    property metadata : ObjectMeta?
    # Describes the ResourceClaim that is to be generated.
    # This field is immutable. A ResourceClaim will get created by the control plane for a Pod when needed and then not get updated anymore.
    property spec : ResourceClaimTemplateSpec?
  end

  # ResourceClaimTemplateList is a collection of claim templates.
  struct ResourceClaimTemplateList
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Items is the list of resource claim templates.
    property items : Array(ResourceClaimTemplate)?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard list metadata
    property metadata : ListMeta?
  end

  # ResourceClaimTemplateSpec contains the metadata and fields for a ResourceClaim.
  struct ResourceClaimTemplateSpec
    include Kubernetes::Serializable

    # ObjectMeta may contain labels and annotations that will be copied into the ResourceClaim when creating it. No other fields are allowed and will be rejected during validation.
    property metadata : ObjectMeta?
    # Spec for the ResourceClaim. The entire content is copied unchanged into the ResourceClaim that gets created from this template. The same fields as in a ResourceClaim are also valid here.
    property spec : ResourceClaimSpec?
  end

  # ResourcePool describes the pool that ResourceSlices belong to.
  struct ResourcePool
    include Kubernetes::Serializable

    # Generation tracks the change in a pool over time. Whenever a driver changes something about one or more of the resources in a pool, it must change the generation in all ResourceSlices which are part of that pool. Consumers of ResourceSlices should only consider resources from the pool with the highest generation number. The generation may be reset by drivers, which should be fine for consumers, assuming that all ResourceSlices in a pool are updated to match or deleted.
    # Combined with ResourceSliceCount, this mechanism enables consumers to detect pools which are comprised of multiple ResourceSlices and are in an incomplete state.
    property generation : Int64?
    # Name is used to identify the pool. For node-local devices, this is often the node name, but this is not required.
    # It must not be longer than 253 characters and must consist of one or more DNS sub-domains separated by slashes. This field is immutable.
    property name : String?
    # ResourceSliceCount is the total number of ResourceSlices in the pool at this generation number. Must be greater than zero.
    # Consumers can use this to check whether they have seen all ResourceSlices belonging to the same pool.
    @[JSON::Field(key: "resourceSliceCount")]
    @[YAML::Field(key: "resourceSliceCount")]
    property resource_slice_count : Int64?
  end

  # ResourceSlice represents one or more resources in a pool of similar resources, managed by a common driver. A pool may span more than one ResourceSlice, and exactly how many ResourceSlices comprise a pool is determined by the driver.
  # At the moment, the only supported resources are devices with attributes and capacities. Each device in a given pool, regardless of how many ResourceSlices, must have a unique name. The ResourceSlice in which a device gets published may change over time. The unique identifier for a device is the tuple <driver name>, <pool name>, <device name>.
  # Whenever a driver needs to update a pool, it increments the pool.Spec.Pool.Generation number and updates all ResourceSlices with that new number and new resource definitions. A consumer must only use ResourceSlices with the highest generation number and ignore all others.
  # When allocating all resources in a pool matching certain criteria or when looking for the best solution among several different alternatives, a consumer should check the number of ResourceSlices in a pool (included in each ResourceSlice) to determine whether its view of a pool is complete and if not, should wait until the driver has completed updating the pool.
  # For resources that are not local to a node, the node name is not set. Instead, the driver may use a node selector to specify where the devices are available.
  # This is an alpha type and requires enabling the DynamicResourceAllocation feature gate.
  struct ResourceSlice
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard object metadata
    property metadata : ObjectMeta?
    # Contains the information published by the driver.
    # Changing the spec automatically increments the metadata.generation number.
    property spec : ResourceSliceSpec?
  end

  # ResourceSliceList is a collection of ResourceSlices.
  struct ResourceSliceList
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Items is the list of resource ResourceSlices.
    property items : Array(ResourceSlice)?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard list metadata
    property metadata : ListMeta?
  end

  # ResourceSliceSpec contains the information published by the driver in one ResourceSlice.
  struct ResourceSliceSpec
    include Kubernetes::Serializable

    # AllNodes indicates that all nodes have access to the resources in the pool.
    # Exactly one of NodeName, NodeSelector, AllNodes, and PerDeviceNodeSelection must be set.
    @[JSON::Field(key: "allNodes")]
    @[YAML::Field(key: "allNodes")]
    property all_nodes : Bool?
    # Devices lists some or all of the devices in this pool.
    # Must not have more than 128 entries.
    property devices : Array(Device)?
    # Driver identifies the DRA driver providing the capacity information. A field selector can be used to list only ResourceSlice objects with a certain driver name.
    # Must be a DNS subdomain and should end with a DNS domain owned by the vendor of the driver. This field is immutable.
    property driver : String?
    # NodeName identifies the node which provides the resources in this pool. A field selector can be used to list only ResourceSlice objects belonging to a certain node.
    # This field can be used to limit access from nodes to ResourceSlices with the same node name. It also indicates to autoscalers that adding new nodes of the same type as some old node might also make new resources available.
    # Exactly one of NodeName, NodeSelector, AllNodes, and PerDeviceNodeSelection must be set. This field is immutable.
    @[JSON::Field(key: "nodeName")]
    @[YAML::Field(key: "nodeName")]
    property node_name : String?
    # NodeSelector defines which nodes have access to the resources in the pool, when that pool is not limited to a single node.
    # Must use exactly one term.
    # Exactly one of NodeName, NodeSelector, AllNodes, and PerDeviceNodeSelection must be set.
    @[JSON::Field(key: "nodeSelector")]
    @[YAML::Field(key: "nodeSelector")]
    property node_selector : NodeSelector?
    # PerDeviceNodeSelection defines whether the access from nodes to resources in the pool is set on the ResourceSlice level or on each device. If it is set to true, every device defined the ResourceSlice must specify this individually.
    # Exactly one of NodeName, NodeSelector, AllNodes, and PerDeviceNodeSelection must be set.
    @[JSON::Field(key: "perDeviceNodeSelection")]
    @[YAML::Field(key: "perDeviceNodeSelection")]
    property per_device_node_selection : Bool?
    # Pool describes the pool that this ResourceSlice belongs to.
    property pool : ResourcePool?
    # SharedCounters defines a list of counter sets, each of which has a name and a list of counters available.
    # The names of the SharedCounters must be unique in the ResourceSlice.
    # The maximum number of counters in all sets is 32.
    @[JSON::Field(key: "sharedCounters")]
    @[YAML::Field(key: "sharedCounters")]
    property shared_counters : Array(CounterSet)?
  end

  # PriorityClass defines mapping from a priority class name to the priority integer value. The value can be any valid integer.
  struct PriorityClass
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # description is an arbitrary string that usually provides guidelines on when this priority class should be used.
    property description : String?
    # globalDefault specifies whether this PriorityClass should be considered as the default priority for pods that do not have any priority class. Only one PriorityClass can be marked as `globalDefault`. However, if more than one PriorityClasses exists with their `globalDefault` field set to true, the smallest value of such global default PriorityClasses will be used as the default priority.
    @[JSON::Field(key: "globalDefault")]
    @[YAML::Field(key: "globalDefault")]
    property global_default : Bool?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ObjectMeta?
    # preemptionPolicy is the Policy for preempting pods with lower priority. One of Never, PreemptLowerPriority. Defaults to PreemptLowerPriority if unset.
    @[JSON::Field(key: "preemptionPolicy")]
    @[YAML::Field(key: "preemptionPolicy")]
    property preemption_policy : String?
    # value represents the integer value of this priority class. This is the actual priority that pods receive when they have the name of this class in their pod spec.
    property value : Int32?
  end

  # PriorityClassList is a collection of priority classes.
  struct PriorityClassList
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # items is the list of PriorityClasses
    property items : Array(PriorityClass)?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard list metadata More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ListMeta?
  end

  # CSIDriver captures information about a Container Storage Interface (CSI) volume driver deployed on the cluster. Kubernetes attach detach controller uses this object to determine whether attach is required. Kubelet uses this object to determine whether pod information needs to be passed on mount. CSIDriver objects are non-namespaced.
  struct CSIDriver
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard object metadata. metadata.Name indicates the name of the CSI driver that this object refers to; it MUST be the same name returned by the CSI GetPluginName() call for that driver. The driver name must be 63 characters or less, beginning and ending with an alphanumeric character ([a-z0-9A-Z]) with dashes (-), dots (.), and alphanumerics between. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ObjectMeta?
    # spec represents the specification of the CSI Driver.
    property spec : CSIDriverSpec?
  end

  # CSIDriverList is a collection of CSIDriver objects.
  struct CSIDriverList
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # items is the list of CSIDriver
    property items : Array(CSIDriver)?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard list metadata More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ListMeta?
  end

  # CSIDriverSpec is the specification of a CSIDriver.
  struct CSIDriverSpec
    include Kubernetes::Serializable

    # attachRequired indicates this CSI volume driver requires an attach operation (because it implements the CSI ControllerPublishVolume() method), and that the Kubernetes attach detach controller should call the attach volume interface which checks the volumeattachment status and waits until the volume is attached before proceeding to mounting. The CSI external-attacher coordinates with CSI volume driver and updates the volumeattachment status when the attach operation is complete. If the value is specified to false, the attach operation will be skipped. Otherwise the attach operation will be called.
    # This field is immutable.
    @[JSON::Field(key: "attachRequired")]
    @[YAML::Field(key: "attachRequired")]
    property attach_required : Bool?
    # fsGroupPolicy defines if the underlying volume supports changing ownership and permission of the volume before being mounted. Refer to the specific FSGroupPolicy values for additional details.
    # This field was immutable in Kubernetes < 1.29 and now is mutable.
    # Defaults to ReadWriteOnceWithFSType, which will examine each volume to determine if Kubernetes should modify ownership and permissions of the volume. With the default policy the defined fsGroup will only be applied if a fstype is defined and the volume's access mode contains ReadWriteOnce.
    @[JSON::Field(key: "fsGroupPolicy")]
    @[YAML::Field(key: "fsGroupPolicy")]
    property fs_group_policy : String?
    # nodeAllocatableUpdatePeriodSeconds specifies the interval between periodic updates of the CSINode allocatable capacity for this driver. When set, both periodic updates and updates triggered by capacity-related failures are enabled. If not set, no updates occur (neither periodic nor upon detecting capacity-related failures), and the allocatable.count remains static. The minimum allowed value for this field is 10 seconds.
    # This is a beta feature and requires the MutableCSINodeAllocatableCount feature gate to be enabled.
    # This field is mutable.
    @[JSON::Field(key: "nodeAllocatableUpdatePeriodSeconds")]
    @[YAML::Field(key: "nodeAllocatableUpdatePeriodSeconds")]
    property node_allocatable_update_period_seconds : Int64?
    # podInfoOnMount indicates this CSI volume driver requires additional pod information (like podName, podUID, etc.) during mount operations, if set to true. If set to false, pod information will not be passed on mount. Default is false.
    # The CSI driver specifies podInfoOnMount as part of driver deployment. If true, Kubelet will pass pod information as VolumeContext in the CSI NodePublishVolume() calls. The CSI driver is responsible for parsing and validating the information passed in as VolumeContext.
    # The following VolumeContext will be passed if podInfoOnMount is set to true. This list might grow, but the prefix will be used. "csi.storage.k8s.io/pod.name": pod.Name "csi.storage.k8s.io/pod.namespace": pod.Namespace "csi.storage.k8s.io/pod.uid": string(pod.UID) "csi.storage.k8s.io/ephemeral": "true" if the volume is an ephemeral inline volume
    # defined by a CSIVolumeSource, otherwise "false"
    # "csi.storage.k8s.io/ephemeral" is a new feature in Kubernetes 1.16. It is only required for drivers which support both the "Persistent" and "Ephemeral" VolumeLifecycleMode. Other drivers can leave pod info disabled and/or ignore this field. As Kubernetes 1.15 doesn't support this field, drivers can only support one mode when deployed on such a cluster and the deployment determines which mode that is, for example via a command line parameter of the driver.
    # This field was immutable in Kubernetes < 1.29 and now is mutable.
    @[JSON::Field(key: "podInfoOnMount")]
    @[YAML::Field(key: "podInfoOnMount")]
    property pod_info_on_mount : Bool?
    # requiresRepublish indicates the CSI driver wants `NodePublishVolume` being periodically called to reflect any possible change in the mounted volume. This field defaults to false.
    # Note: After a successful initial NodePublishVolume call, subsequent calls to NodePublishVolume should only update the contents of the volume. New mount points will not be seen by a running container.
    @[JSON::Field(key: "requiresRepublish")]
    @[YAML::Field(key: "requiresRepublish")]
    property requires_republish : Bool?
    # seLinuxMount specifies if the CSI driver supports "-o context" mount option.
    # When "true", the CSI driver must ensure that all volumes provided by this CSI driver can be mounted separately with different `-o context` options. This is typical for storage backends that provide volumes as filesystems on block devices or as independent shared volumes. Kubernetes will call NodeStage / NodePublish with "-o context=xyz" mount option when mounting a ReadWriteOncePod volume used in Pod that has explicitly set SELinux context. In the future, it may be expanded to other volume AccessModes. In any case, Kubernetes will ensure that the volume is mounted only with a single SELinux context.
    # When "false", Kubernetes won't pass any special SELinux mount options to the driver. This is typical for volumes that represent subdirectories of a bigger shared filesystem.
    # Default is "false".
    @[JSON::Field(key: "seLinuxMount")]
    @[YAML::Field(key: "seLinuxMount")]
    property se_linux_mount : Bool?
    # storageCapacity indicates that the CSI volume driver wants pod scheduling to consider the storage capacity that the driver deployment will report by creating CSIStorageCapacity objects with capacity information, if set to true.
    # The check can be enabled immediately when deploying a driver. In that case, provisioning new volumes with late binding will pause until the driver deployment has published some suitable CSIStorageCapacity object.
    # Alternatively, the driver can be deployed with the field unset or false and it can be flipped later when storage capacity information has been published.
    # This field was immutable in Kubernetes <= 1.22 and now is mutable.
    @[JSON::Field(key: "storageCapacity")]
    @[YAML::Field(key: "storageCapacity")]
    property storage_capacity : Bool?
    # tokenRequests indicates the CSI driver needs pods' service account tokens it is mounting volume for to do necessary authentication. Kubelet will pass the tokens in VolumeContext in the CSI NodePublishVolume calls. The CSI driver should parse and validate the following VolumeContext: "csi.storage.k8s.io/serviceAccount.tokens": {
    # "<audience>": {
    # "token": <token>,
    # "expirationTimestamp": <expiration timestamp in RFC3339>,
    # },
    # ...
    # }
    # Note: Audience in each TokenRequest should be different and at most one token is empty string. To receive a new token after expiry, RequiresRepublish can be used to trigger NodePublishVolume periodically.
    @[JSON::Field(key: "tokenRequests")]
    @[YAML::Field(key: "tokenRequests")]
    property token_requests : Array(TokenRequest)?
    # volumeLifecycleModes defines what kind of volumes this CSI volume driver supports. The default if the list is empty is "Persistent", which is the usage defined by the CSI specification and implemented in Kubernetes via the usual PV/PVC mechanism.
    # The other mode is "Ephemeral". In this mode, volumes are defined inline inside the pod spec with CSIVolumeSource and their lifecycle is tied to the lifecycle of that pod. A driver has to be aware of this because it is only going to get a NodePublishVolume call for such a volume.
    # For more information about implementing this mode, see https://kubernetes-csi.github.io/docs/ephemeral-local-volumes.html A driver can support one or more of these modes and more modes may be added in the future.
    # This field is beta. This field is immutable.
    @[JSON::Field(key: "volumeLifecycleModes")]
    @[YAML::Field(key: "volumeLifecycleModes")]
    property volume_lifecycle_modes : Array(String)?
  end

  # CSINode holds information about all CSI drivers installed on a node. CSI drivers do not need to create the CSINode object directly. As long as they use the node-driver-registrar sidecar container, the kubelet will automatically populate the CSINode object for the CSI driver as part of kubelet plugin registration. CSINode has the same name as a node. If the object is missing, it means either there are no CSI Drivers available on the node, or the Kubelet version is low enough that it doesn't create this object. CSINode has an OwnerReference that points to the corresponding node object.
  struct CSINode
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard object's metadata. metadata.name must be the Kubernetes node name.
    property metadata : ObjectMeta?
    # spec is the specification of CSINode
    property spec : CSINodeSpec?
  end

  # CSINodeDriver holds information about the specification of one CSI driver installed on a node
  struct CSINodeDriver
    include Kubernetes::Serializable

    # allocatable represents the volume resources of a node that are available for scheduling. This field is beta.
    property allocatable : VolumeNodeResources?
    # name represents the name of the CSI driver that this object refers to. This MUST be the same name returned by the CSI GetPluginName() call for that driver.
    property name : String?
    # nodeID of the node from the driver point of view. This field enables Kubernetes to communicate with storage systems that do not share the same nomenclature for nodes. For example, Kubernetes may refer to a given node as "node1", but the storage system may refer to the same node as "nodeA". When Kubernetes issues a command to the storage system to attach a volume to a specific node, it can use this field to refer to the node name using the ID that the storage system will understand, e.g. "nodeA" instead of "node1". This field is required.
    @[JSON::Field(key: "nodeID")]
    @[YAML::Field(key: "nodeID")]
    property node_id : String?
    # topologyKeys is the list of keys supported by the driver. When a driver is initialized on a cluster, it provides a set of topology keys that it understands (e.g. "company.com/zone", "company.com/region"). When a driver is initialized on a node, it provides the same topology keys along with values. Kubelet will expose these topology keys as labels on its own node object. When Kubernetes does topology aware provisioning, it can use this list to determine which labels it should retrieve from the node object and pass back to the driver. It is possible for different nodes to use different topology keys. This can be empty if driver does not support topology.
    @[JSON::Field(key: "topologyKeys")]
    @[YAML::Field(key: "topologyKeys")]
    property topology_keys : Array(String)?
  end

  # CSINodeList is a collection of CSINode objects.
  struct CSINodeList
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # items is the list of CSINode
    property items : Array(CSINode)?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard list metadata More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ListMeta?
  end

  # CSINodeSpec holds information about the specification of all CSI drivers installed on a node
  struct CSINodeSpec
    include Kubernetes::Serializable

    # drivers is a list of information of all CSI Drivers existing on a node. If all drivers in the list are uninstalled, this can become empty.
    property drivers : Array(CSINodeDriver)?
  end

  # CSIStorageCapacity stores the result of one CSI GetCapacity call. For a given StorageClass, this describes the available capacity in a particular topology segment.  This can be used when considering where to instantiate new PersistentVolumes.
  # For example this can express things like: - StorageClass "standard" has "1234 GiB" available in "topology.kubernetes.io/zone=us-east1" - StorageClass "localssd" has "10 GiB" available in "kubernetes.io/hostname=knode-abc123"
  # The following three cases all imply that no capacity is available for a certain combination: - no object exists with suitable topology and storage class name - such an object exists, but the capacity is unset - such an object exists, but the capacity is zero
  # The producer of these objects can decide which approach is more suitable.
  # They are consumed by the kube-scheduler when a CSI driver opts into capacity-aware scheduling with CSIDriverSpec.StorageCapacity. The scheduler compares the MaximumVolumeSize against the requested size of pending volumes to filter out unsuitable nodes. If MaximumVolumeSize is unset, it falls back to a comparison against the less precise Capacity. If that is also unset, the scheduler assumes that capacity is insufficient and tries some other node.
  struct CSIStorageCapacity
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # capacity is the value reported by the CSI driver in its GetCapacityResponse for a GetCapacityRequest with topology and parameters that match the previous fields.
    # The semantic is currently (CSI spec 1.2) defined as: The available capacity, in bytes, of the storage that can be used to provision volumes. If not set, that information is currently unavailable.
    property capacity : String?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # maximumVolumeSize is the value reported by the CSI driver in its GetCapacityResponse for a GetCapacityRequest with topology and parameters that match the previous fields.
    # This is defined since CSI spec 1.4.0 as the largest size that may be used in a CreateVolumeRequest.capacity_range.required_bytes field to create a volume with the same parameters as those in GetCapacityRequest. The corresponding value in the Kubernetes API is ResourceRequirements.Requests in a volume claim.
    @[JSON::Field(key: "maximumVolumeSize")]
    @[YAML::Field(key: "maximumVolumeSize")]
    property maximum_volume_size : String?
    # Standard object's metadata. The name has no particular meaning. It must be a DNS subdomain (dots allowed, 253 characters). To ensure that there are no conflicts with other CSI drivers on the cluster, the recommendation is to use csisc-<uuid>, a generated name, or a reverse-domain name which ends with the unique CSI driver name.
    # Objects are namespaced.
    # More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ObjectMeta?
    # nodeTopology defines which nodes have access to the storage for which capacity was reported. If not set, the storage is not accessible from any node in the cluster. If empty, the storage is accessible from all nodes. This field is immutable.
    @[JSON::Field(key: "nodeTopology")]
    @[YAML::Field(key: "nodeTopology")]
    property node_topology : LabelSelector?
    # storageClassName represents the name of the StorageClass that the reported capacity applies to. It must meet the same requirements as the name of a StorageClass object (non-empty, DNS subdomain). If that object no longer exists, the CSIStorageCapacity object is obsolete and should be removed by its creator. This field is immutable.
    @[JSON::Field(key: "storageClassName")]
    @[YAML::Field(key: "storageClassName")]
    property storage_class_name : String?
  end

  # CSIStorageCapacityList is a collection of CSIStorageCapacity objects.
  struct CSIStorageCapacityList
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # items is the list of CSIStorageCapacity objects.
    property items : Array(CSIStorageCapacity)?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard list metadata More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ListMeta?
  end

  # StorageClass describes the parameters for a class of storage for which PersistentVolumes can be dynamically provisioned.
  # StorageClasses are non-namespaced; the name of the storage class according to etcd is in ObjectMeta.Name.
  struct StorageClass
    include Kubernetes::Serializable

    # allowVolumeExpansion shows whether the storage class allow volume expand.
    @[JSON::Field(key: "allowVolumeExpansion")]
    @[YAML::Field(key: "allowVolumeExpansion")]
    property allow_volume_expansion : Bool?
    # allowedTopologies restrict the node topologies where volumes can be dynamically provisioned. Each volume plugin defines its own supported topology specifications. An empty TopologySelectorTerm list means there is no topology restriction. This field is only honored by servers that enable the VolumeScheduling feature.
    @[JSON::Field(key: "allowedTopologies")]
    @[YAML::Field(key: "allowedTopologies")]
    property allowed_topologies : Array(TopologySelectorTerm)?
    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ObjectMeta?
    # mountOptions controls the mountOptions for dynamically provisioned PersistentVolumes of this storage class. e.g. ["ro", "soft"]. Not validated - mount of the PVs will simply fail if one is invalid.
    @[JSON::Field(key: "mountOptions")]
    @[YAML::Field(key: "mountOptions")]
    property mount_options : Array(String)?
    # parameters holds the parameters for the provisioner that should create volumes of this storage class.
    property parameters : Hash(String, String)?
    # provisioner indicates the type of the provisioner.
    property provisioner : String?
    # reclaimPolicy controls the reclaimPolicy for dynamically provisioned PersistentVolumes of this storage class. Defaults to Delete.
    @[JSON::Field(key: "reclaimPolicy")]
    @[YAML::Field(key: "reclaimPolicy")]
    property reclaim_policy : String?
    # volumeBindingMode indicates how PersistentVolumeClaims should be provisioned and bound.  When unset, VolumeBindingImmediate is used. This field is only honored by servers that enable the VolumeScheduling feature.
    @[JSON::Field(key: "volumeBindingMode")]
    @[YAML::Field(key: "volumeBindingMode")]
    property volume_binding_mode : String?
  end

  # StorageClassList is a collection of storage classes.
  struct StorageClassList
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # items is the list of StorageClasses
    property items : Array(StorageClass)?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard list metadata More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ListMeta?
  end

  # VolumeAttachment captures the intent to attach or detach the specified volume to/from the specified node.
  # VolumeAttachment objects are non-namespaced.
  struct VolumeAttachment
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard object metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ObjectMeta?
    # spec represents specification of the desired attach/detach volume behavior. Populated by the Kubernetes system.
    property spec : VolumeAttachmentSpec?
    # status represents status of the VolumeAttachment request. Populated by the entity completing the attach or detach operation, i.e. the external-attacher.
    property status : VolumeAttachmentStatus?
  end

  # VolumeAttachmentList is a collection of VolumeAttachment objects.
  struct VolumeAttachmentList
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # items is the list of VolumeAttachments
    property items : Array(VolumeAttachment)?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard list metadata More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ListMeta?
  end

  # VolumeAttachmentSource represents a volume that should be attached. Right now only PersistentVolumes can be attached via external attacher, in the future we may allow also inline volumes in pods. Exactly one member can be set.
  struct VolumeAttachmentSource
    include Kubernetes::Serializable

    # inlineVolumeSpec contains all the information necessary to attach a persistent volume defined by a pod's inline VolumeSource. This field is populated only for the CSIMigration feature. It contains translated fields from a pod's inline VolumeSource to a PersistentVolumeSpec. This field is beta-level and is only honored by servers that enabled the CSIMigration feature.
    @[JSON::Field(key: "inlineVolumeSpec")]
    @[YAML::Field(key: "inlineVolumeSpec")]
    property inline_volume_spec : PersistentVolumeSpec?
    # persistentVolumeName represents the name of the persistent volume to attach.
    @[JSON::Field(key: "persistentVolumeName")]
    @[YAML::Field(key: "persistentVolumeName")]
    property persistent_volume_name : String?
  end

  # VolumeAttachmentSpec is the specification of a VolumeAttachment request.
  struct VolumeAttachmentSpec
    include Kubernetes::Serializable

    # attacher indicates the name of the volume driver that MUST handle this request. This is the name returned by GetPluginName().
    property attacher : String?
    # nodeName represents the node that the volume should be attached to.
    @[JSON::Field(key: "nodeName")]
    @[YAML::Field(key: "nodeName")]
    property node_name : String?
    # source represents the volume that should be attached.
    property source : VolumeAttachmentSource?
  end

  # VolumeAttachmentStatus is the status of a VolumeAttachment request.
  struct VolumeAttachmentStatus
    include Kubernetes::Serializable

    # attachError represents the last error encountered during attach operation, if any. This field must only be set by the entity completing the attach operation, i.e. the external-attacher.
    @[JSON::Field(key: "attachError")]
    @[YAML::Field(key: "attachError")]
    property attach_error : VolumeError?
    # attached indicates the volume is successfully attached. This field must only be set by the entity completing the attach operation, i.e. the external-attacher.
    property attached : Bool?
    # attachmentMetadata is populated with any information returned by the attach operation, upon successful attach, that must be passed into subsequent WaitForAttach or Mount calls. This field must only be set by the entity completing the attach operation, i.e. the external-attacher.
    @[JSON::Field(key: "attachmentMetadata")]
    @[YAML::Field(key: "attachmentMetadata")]
    property attachment_metadata : Hash(String, String)?
    # detachError represents the last error encountered during detach operation, if any. This field must only be set by the entity completing the detach operation, i.e. the external-attacher.
    @[JSON::Field(key: "detachError")]
    @[YAML::Field(key: "detachError")]
    property detach_error : VolumeError?
  end

  # VolumeAttributesClass represents a specification of mutable volume attributes defined by the CSI driver. The class can be specified during dynamic provisioning of PersistentVolumeClaims, and changed in the PersistentVolumeClaim spec after provisioning.
  struct VolumeAttributesClass
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Name of the CSI driver This field is immutable.
    @[JSON::Field(key: "driverName")]
    @[YAML::Field(key: "driverName")]
    property driver_name : String?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ObjectMeta?
    # parameters hold volume attributes defined by the CSI driver. These values are opaque to the Kubernetes and are passed directly to the CSI driver. The underlying storage provider supports changing these attributes on an existing volume, however the parameters field itself is immutable. To invoke a volume update, a new VolumeAttributesClass should be created with new parameters, and the PersistentVolumeClaim should be updated to reference the new VolumeAttributesClass.
    # This field is required and must contain at least one key/value pair. The keys cannot be empty, and the maximum number of parameters is 512, with a cumulative max size of 256K. If the CSI driver rejects invalid parameters, the target PersistentVolumeClaim will be set to an "Infeasible" state in the modifyVolumeStatus field.
    property parameters : Hash(String, String)?
  end

  # VolumeAttributesClassList is a collection of VolumeAttributesClass objects.
  struct VolumeAttributesClassList
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # items is the list of VolumeAttributesClass objects.
    property items : Array(VolumeAttributesClass)?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard list metadata More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ListMeta?
  end

  # VolumeError captures an error encountered during a volume operation.
  struct VolumeError
    include Kubernetes::Serializable

    # errorCode is a numeric gRPC code representing the error encountered during Attach or Detach operations.
    # This is an optional, beta field that requires the MutableCSINodeAllocatableCount feature gate being enabled to be set.
    @[JSON::Field(key: "errorCode")]
    @[YAML::Field(key: "errorCode")]
    property error_code : Int32?
    # message represents the error encountered during Attach or Detach operation. This string may be logged, so it should not contain sensitive information.
    property message : String?
    # time represents the time the error was encountered.
    property time : Time?
  end

  # VolumeNodeResources is a set of resource limits for scheduling of volumes.
  struct VolumeNodeResources
    include Kubernetes::Serializable

    # count indicates the maximum number of unique volumes managed by the CSI driver that can be used on a node. A volume that is both attached and mounted on a node is considered to be used once, not twice. The same rule applies for a unique volume that is shared among multiple pods on the same node. If this field is not specified, then the supported number of volumes on this node is unbounded.
    property count : Int32?
  end

  # CustomResourceColumnDefinition specifies a column for server side printing.
  struct CustomResourceColumnDefinition
    include Kubernetes::Serializable

    # description is a human readable description of this column.
    property description : String?
    # format is an optional OpenAPI type definition for this column. The 'name' format is applied to the primary identifier column to assist in clients identifying column is the resource name. See https://github.com/OAI/OpenAPI-Specification/blob/master/versions/2.0.md#data-types for details.
    property format : String?
    # jsonPath is a simple JSON path (i.e. with array notation) which is evaluated against each custom resource to produce the value for this column.
    @[JSON::Field(key: "jsonPath")]
    @[YAML::Field(key: "jsonPath")]
    property json_path : String?
    # name is a human readable name for the column.
    property name : String?
    # priority is an integer defining the relative importance of this column compared to others. Lower numbers are considered higher priority. Columns that may be omitted in limited space scenarios should be given a priority greater than 0.
    property priority : Int32?
    # type is an OpenAPI type definition for this column. See https://github.com/OAI/OpenAPI-Specification/blob/master/versions/2.0.md#data-types for details.
    property type : String?
  end

  # CustomResourceConversion describes how to convert different versions of a CR.
  struct CustomResourceConversion
    include Kubernetes::Serializable

    # strategy specifies how custom resources are converted between versions. Allowed values are: - `"None"`: The converter only change the apiVersion and would not touch any other field in the custom resource. - `"Webhook"`: API Server will call to an external webhook to do the conversion. Additional information
    # is needed for this option. This requires spec.preserveUnknownFields to be false, and spec.conversion.webhook to be set.
    property strategy : String?
    # webhook describes how to call the conversion webhook. Required when `strategy` is set to `"Webhook"`.
    property webhook : WebhookConversion?
  end

  # CustomResourceDefinition represents a resource that should be exposed on the API server.  Its name MUST be in the format <.spec.name>.<.spec.group>.
  struct CustomResourceDefinition
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard object's metadata More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ObjectMeta?
    # spec describes how the user wants the resources to appear
    property spec : CustomResourceDefinitionSpec?
    # status indicates the actual state of the CustomResourceDefinition
    property status : CustomResourceDefinitionStatus?
  end

  # CustomResourceDefinitionCondition contains details for the current condition of this pod.
  struct CustomResourceDefinitionCondition
    include Kubernetes::Serializable

    # lastTransitionTime last time the condition transitioned from one status to another.
    @[JSON::Field(key: "lastTransitionTime")]
    @[YAML::Field(key: "lastTransitionTime")]
    property last_transition_time : Time?
    # message is a human-readable message indicating details about last transition.
    property message : String?
    # reason is a unique, one-word, CamelCase reason for the condition's last transition.
    property reason : String?
    # status is the status of the condition. Can be True, False, Unknown.
    property status : String?
    # type is the type of the condition. Types include Established, NamesAccepted and Terminating.
    property type : String?
  end

  # CustomResourceDefinitionList is a list of CustomResourceDefinition objects.
  struct CustomResourceDefinitionList
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # items list individual CustomResourceDefinition objects
    property items : Array(CustomResourceDefinition)?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard object's metadata More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ListMeta?
  end

  # CustomResourceDefinitionNames indicates the names to serve this CustomResourceDefinition
  struct CustomResourceDefinitionNames
    include Kubernetes::Serializable

    # categories is a list of grouped resources this custom resource belongs to (e.g. 'all'). This is published in API discovery documents, and used by clients to support invocations like `kubectl get all`.
    property categories : Array(String)?
    # kind is the serialized kind of the resource. It is normally CamelCase and singular. Custom resource instances will use this value as the `kind` attribute in API calls.
    property kind : String?
    # listKind is the serialized kind of the list for this resource. Defaults to "`kind`List".
    @[JSON::Field(key: "listKind")]
    @[YAML::Field(key: "listKind")]
    property list_kind : String?
    # plural is the plural name of the resource to serve. The custom resources are served under `/apis/<group>/<version>/.../<plural>`. Must match the name of the CustomResourceDefinition (in the form `<names.plural>.<group>`). Must be all lowercase.
    property plural : String?
    # shortNames are short names for the resource, exposed in API discovery documents, and used by clients to support invocations like `kubectl get <shortname>`. It must be all lowercase.
    @[JSON::Field(key: "shortNames")]
    @[YAML::Field(key: "shortNames")]
    property short_names : Array(String)?
    # singular is the singular name of the resource. It must be all lowercase. Defaults to lowercased `kind`.
    property singular : String?
  end

  # CustomResourceDefinitionSpec describes how a user wants their resource to appear
  struct CustomResourceDefinitionSpec
    include Kubernetes::Serializable

    # conversion defines conversion settings for the CRD.
    property conversion : CustomResourceConversion?
    # group is the API group of the defined custom resource. The custom resources are served under `/apis/<group>/...`. Must match the name of the CustomResourceDefinition (in the form `<names.plural>.<group>`).
    property group : String?
    # names specify the resource and kind names for the custom resource.
    property names : CustomResourceDefinitionNames?
    # preserveUnknownFields indicates that object fields which are not specified in the OpenAPI schema should be preserved when persisting to storage. apiVersion, kind, metadata and known fields inside metadata are always preserved. This field is deprecated in favor of setting `x-preserve-unknown-fields` to true in `spec.versions[*].schema.openAPIV3Schema`. See https://kubernetes.io/docs/tasks/extend-kubernetes/custom-resources/custom-resource-definitions/#field-pruning for details.
    @[JSON::Field(key: "preserveUnknownFields")]
    @[YAML::Field(key: "preserveUnknownFields")]
    property preserve_unknown_fields : Bool?
    # scope indicates whether the defined custom resource is cluster- or namespace-scoped. Allowed values are `Cluster` and `Namespaced`.
    property scope : String?
    # versions is the list of all API versions of the defined custom resource. Version names are used to compute the order in which served versions are listed in API discovery. If the version string is "kube-like", it will sort above non "kube-like" version strings, which are ordered lexicographically. "Kube-like" versions start with a "v", then are followed by a number (the major version), then optionally the string "alpha" or "beta" and another number (the minor version). These are sorted first by GA > beta > alpha (where GA is a version with no suffix such as beta or alpha), and then by comparing major version, then minor version. An example sorted list of versions: v10, v2, v1, v11beta2, v10beta3, v3beta1, v12alpha1, v11alpha2, foo1, foo10.
    property versions : Array(CustomResourceDefinitionVersion)?
  end

  # CustomResourceDefinitionStatus indicates the state of the CustomResourceDefinition
  struct CustomResourceDefinitionStatus
    include Kubernetes::Serializable

    # acceptedNames are the names that are actually being used to serve discovery. They may be different than the names in spec.
    @[JSON::Field(key: "acceptedNames")]
    @[YAML::Field(key: "acceptedNames")]
    property accepted_names : CustomResourceDefinitionNames?
    # conditions indicate state for particular aspects of a CustomResourceDefinition
    property conditions : Array(CustomResourceDefinitionCondition)?
    # storedVersions lists all versions of CustomResources that were ever persisted. Tracking these versions allows a migration path for stored versions in etcd. The field is mutable so a migration controller can finish a migration to another version (ensuring no old objects are left in storage), and then remove the rest of the versions from this list. Versions may not be removed from `spec.versions` while they exist in this list.
    @[JSON::Field(key: "storedVersions")]
    @[YAML::Field(key: "storedVersions")]
    property stored_versions : Array(String)?
  end

  # CustomResourceDefinitionVersion describes a version for CRD.
  struct CustomResourceDefinitionVersion
    include Kubernetes::Serializable

    # additionalPrinterColumns specifies additional columns returned in Table output. See https://kubernetes.io/docs/reference/using-api/api-concepts/#receiving-resources-as-tables for details. If no columns are specified, a single column displaying the age of the custom resource is used.
    @[JSON::Field(key: "additionalPrinterColumns")]
    @[YAML::Field(key: "additionalPrinterColumns")]
    property additional_printer_columns : Array(CustomResourceColumnDefinition)?
    # deprecated indicates this version of the custom resource API is deprecated. When set to true, API requests to this version receive a warning header in the server response. Defaults to false.
    property deprecated : Bool?
    # deprecationWarning overrides the default warning returned to API clients. May only be set when `deprecated` is true. The default warning indicates this version is deprecated and recommends use of the newest served version of equal or greater stability, if one exists.
    @[JSON::Field(key: "deprecationWarning")]
    @[YAML::Field(key: "deprecationWarning")]
    property deprecation_warning : String?
    # name is the version name, e.g. “v1”, “v2beta1”, etc. The custom resources are served under this version at `/apis/<group>/<version>/...` if `served` is true.
    property name : String?
    # schema describes the schema used for validation, pruning, and defaulting of this version of the custom resource.
    property schema : CustomResourceValidation?
    # selectableFields specifies paths to fields that may be used as field selectors. A maximum of 8 selectable fields are allowed. See https://kubernetes.io/docs/concepts/overview/working-with-objects/field-selectors
    @[JSON::Field(key: "selectableFields")]
    @[YAML::Field(key: "selectableFields")]
    property selectable_fields : Array(SelectableField)?
    # served is a flag enabling/disabling this version from being served via REST APIs
    property served : Bool?
    # storage indicates this version should be used when persisting custom resources to storage. There must be exactly one version with storage=true.
    property storage : Bool?
    # subresources specify what subresources this version of the defined custom resource have.
    property subresources : CustomResourceSubresources?
  end

  # CustomResourceSubresourceScale defines how to serve the scale subresource for CustomResources.
  struct CustomResourceSubresourceScale
    include Kubernetes::Serializable

    # labelSelectorPath defines the JSON path inside of a custom resource that corresponds to Scale `status.selector`. Only JSON paths without the array notation are allowed. Must be a JSON Path under `.status` or `.spec`. Must be set to work with HorizontalPodAutoscaler. The field pointed by this JSON path must be a string field (not a complex selector struct) which contains a serialized label selector in string form. More info: https://kubernetes.io/docs/tasks/access-kubernetes-api/custom-resources/custom-resource-definitions#scale-subresource If there is no value under the given path in the custom resource, the `status.selector` value in the `/scale` subresource will default to the empty string.
    @[JSON::Field(key: "labelSelectorPath")]
    @[YAML::Field(key: "labelSelectorPath")]
    property label_selector_path : String?
    # specReplicasPath defines the JSON path inside of a custom resource that corresponds to Scale `spec.replicas`. Only JSON paths without the array notation are allowed. Must be a JSON Path under `.spec`. If there is no value under the given path in the custom resource, the `/scale` subresource will return an error on GET.
    @[JSON::Field(key: "specReplicasPath")]
    @[YAML::Field(key: "specReplicasPath")]
    property spec_replicas_path : String?
    # statusReplicasPath defines the JSON path inside of a custom resource that corresponds to Scale `status.replicas`. Only JSON paths without the array notation are allowed. Must be a JSON Path under `.status`. If there is no value under the given path in the custom resource, the `status.replicas` value in the `/scale` subresource will default to 0.
    @[JSON::Field(key: "statusReplicasPath")]
    @[YAML::Field(key: "statusReplicasPath")]
    property status_replicas_path : String?
  end

  # CustomResourceSubresources defines the status and scale subresources for CustomResources.
  struct CustomResourceSubresources
    include Kubernetes::Serializable

    # scale indicates the custom resource should serve a `/scale` subresource that returns an `autoscaling/v1` Scale object.
    property scale : CustomResourceSubresourceScale?
    # status indicates the custom resource should serve a `/status` subresource. When enabled: 1. requests to the custom resource primary endpoint ignore changes to the `status` stanza of the object. 2. requests to the custom resource `/status` subresource ignore changes to anything other than the `status` stanza of the object.
    property status : Hash(String, JSON::Any)?
  end

  # CustomResourceValidation is a list of validation methods for CustomResources.
  struct CustomResourceValidation
    include Kubernetes::Serializable

    # openAPIV3Schema is the OpenAPI v3 schema to use for validation and pruning.
    @[JSON::Field(key: "openAPIV3Schema")]
    @[YAML::Field(key: "openAPIV3Schema")]
    property open_apiv3_schema : JSONSchemaProps?
  end

  # ExternalDocumentation allows referencing an external resource for extended documentation.
  struct ExternalDocumentation
    include Kubernetes::Serializable

    property description : String?
    property url : String?
  end

  # JSONSchemaProps is a JSON-Schema following Specification Draft 4 (http://json-schema.org/).
  class JSONSchemaProps
    include Kubernetes::Serializable

    @[JSON::Field(key: "$ref")]
    @[YAML::Field(key: "$ref")]
    property ref_ref : String?
    @[JSON::Field(key: "$schema")]
    @[YAML::Field(key: "$schema")]
    property ref_schema : String?
    # JSONSchemaPropsOrBool represents JSONSchemaProps or a boolean value. Defaults to true for the boolean property.
    @[JSON::Field(key: "additionalItems")]
    @[YAML::Field(key: "additionalItems")]
    property additional_items : Hash(String, JSON::Any)?
    # JSONSchemaPropsOrBool represents JSONSchemaProps or a boolean value. Defaults to true for the boolean property.
    @[JSON::Field(key: "additionalProperties")]
    @[YAML::Field(key: "additionalProperties")]
    property additional_properties : Hash(String, JSON::Any)?
    @[JSON::Field(key: "allOf")]
    @[YAML::Field(key: "allOf")]
    property all_of : Array(JSONSchemaProps)?
    @[JSON::Field(key: "anyOf")]
    @[YAML::Field(key: "anyOf")]
    property any_of : Array(JSONSchemaProps)?
    # default is a default value for undefined object fields. Defaulting is a beta feature under the CustomResourceDefaulting feature gate. Defaulting requires spec.preserveUnknownFields to be false.
    property default : Hash(String, JSON::Any)?
    property definitions : Hash(String, JSONSchemaProps)?
    property dependencies : Hash(String, Hash(String, JSON::Any))?
    property description : String?
    property enum : Array(Hash(String, JSON::Any))?
    # JSON represents any valid JSON value. These types are supported: bool, int64, float64, string, []interface{}, map[string]interface{} and nil.
    property example : Hash(String, JSON::Any)?
    @[JSON::Field(key: "exclusiveMaximum")]
    @[YAML::Field(key: "exclusiveMaximum")]
    property exclusive_maximum : Bool?
    @[JSON::Field(key: "exclusiveMinimum")]
    @[YAML::Field(key: "exclusiveMinimum")]
    property exclusive_minimum : Bool?
    @[JSON::Field(key: "externalDocs")]
    @[YAML::Field(key: "externalDocs")]
    property external_docs : ExternalDocumentation?
    # format is an OpenAPI v3 format string. Unknown formats are ignored. The following formats are validated:
    # - bsonobjectid: a bson object ID, i.e. a 24 characters hex string - uri: an URI as parsed by Golang net/url.ParseRequestURI - email: an email address as parsed by Golang net/mail.ParseAddress - hostname: a valid representation for an Internet host name, as defined by RFC 1034, section 3.1 [RFC1034]. - ipv4: an IPv4 IP as parsed by Golang net.ParseIP - ipv6: an IPv6 IP as parsed by Golang net.ParseIP - cidr: a CIDR as parsed by Golang net.ParseCIDR - mac: a MAC address as parsed by Golang net.ParseMAC - uuid: an UUID that allows uppercase defined by the regex (?i)^[0-9a-f]{8}-?[0-9a-f]{4}-?[0-9a-f]{4}-?[0-9a-f]{4}-?[0-9a-f]{12}$ - uuid3: an UUID3 that allows uppercase defined by the regex (?i)^[0-9a-f]{8}-?[0-9a-f]{4}-?3[0-9a-f]{3}-?[0-9a-f]{4}-?[0-9a-f]{12}$ - uuid4: an UUID4 that allows uppercase defined by the regex (?i)^[0-9a-f]{8}-?[0-9a-f]{4}-?4[0-9a-f]{3}-?[89ab][0-9a-f]{3}-?[0-9a-f]{12}$ - uuid5: an UUID5 that allows uppercase defined by the regex (?i)^[0-9a-f]{8}-?[0-9a-f]{4}-?5[0-9a-f]{3}-?[89ab][0-9a-f]{3}-?[0-9a-f]{12}$ - isbn: an ISBN10 or ISBN13 number string like "0321751043" or "978-0321751041" - isbn10: an ISBN10 number string like "0321751043" - isbn13: an ISBN13 number string like "978-0321751041" - creditcard: a credit card number defined by the regex ^(?:4[0-9]{12}(?:[0-9]{3})?|5[1-5][0-9]{14}|6(?:011|5[0-9][0-9])[0-9]{12}|3[47][0-9]{13}|3(?:0[0-5]|[68][0-9])[0-9]{11}|(?:2131|1800|35\\d{3})\\d{11})$ with any non digit characters mixed in - ssn: a U.S. social security number following the regex ^\\d{3}[- ]?\\d{2}[- ]?\\d{4}$ - hexcolor: an hexadecimal color code like "#FFFFFF: following the regex ^#?([0-9a-fA-F]{3}|[0-9a-fA-F]{6})$ - rgbcolor: an RGB color code like rgb like "rgb(255,255,2559" - byte: base64 encoded binary data - password: any kind of string - date: a date string like "2006-01-02" as defined by full-date in RFC3339 - duration: a duration string like "22 ns" as parsed by Golang time.ParseDuration or compatible with Scala duration format - datetime: a date time string like "2014-12-15T19:30:20.000Z" as defined by date-time in RFC3339.
    property format : String?
    property id : String?
    # JSONSchemaPropsOrArray represents a value that can either be a JSONSchemaProps or an array of JSONSchemaProps. Mainly here for serialization purposes.
    property items : Hash(String, JSON::Any)?
    @[JSON::Field(key: "maxItems")]
    @[YAML::Field(key: "maxItems")]
    property max_items : Int64?
    @[JSON::Field(key: "maxLength")]
    @[YAML::Field(key: "maxLength")]
    property max_length : Int64?
    @[JSON::Field(key: "maxProperties")]
    @[YAML::Field(key: "maxProperties")]
    property max_properties : Int64?
    property maximum : Float64?
    @[JSON::Field(key: "minItems")]
    @[YAML::Field(key: "minItems")]
    property min_items : Int64?
    @[JSON::Field(key: "minLength")]
    @[YAML::Field(key: "minLength")]
    property min_length : Int64?
    @[JSON::Field(key: "minProperties")]
    @[YAML::Field(key: "minProperties")]
    property min_properties : Int64?
    property minimum : Float64?
    @[JSON::Field(key: "multipleOf")]
    @[YAML::Field(key: "multipleOf")]
    property multiple_of : Float64?
    property not : JSONSchemaProps?
    property nullable : Bool?
    @[JSON::Field(key: "oneOf")]
    @[YAML::Field(key: "oneOf")]
    property one_of : Array(JSONSchemaProps)?
    property pattern : String?
    @[JSON::Field(key: "patternProperties")]
    @[YAML::Field(key: "patternProperties")]
    property pattern_properties : Hash(String, JSONSchemaProps)?
    property properties : Hash(String, JSONSchemaProps)?
    property required : Array(String)?
    property title : String?
    property type : String?
    @[JSON::Field(key: "uniqueItems")]
    @[YAML::Field(key: "uniqueItems")]
    property unique_items : Bool?
    # x-kubernetes-embedded-resource defines that the value is an embedded Kubernetes runtime.Object, with TypeMeta and ObjectMeta. The type must be object. It is allowed to further restrict the embedded object. kind, apiVersion and metadata are validated automatically. x-kubernetes-preserve-unknown-fields is allowed to be true, but does not have to be if the object is fully specified (up to kind, apiVersion, metadata).
    @[JSON::Field(key: "x-kubernetes-embedded-resource")]
    @[YAML::Field(key: "x-kubernetes-embedded-resource")]
    property x_kubernetes_embedded_resource : Bool?
    # x-kubernetes-int-or-string specifies that this value is either an integer or a string. If this is true, an empty type is allowed and type as child of anyOf is permitted if following one of the following patterns:
    # 1) anyOf:
    # - type: integer
    # - type: string
    # 2) allOf:
    # - anyOf:
    # - type: integer
    # - type: string
    # - ... zero or more
    @[JSON::Field(key: "x-kubernetes-int-or-string")]
    @[YAML::Field(key: "x-kubernetes-int-or-string")]
    property x_kubernetes_int_or_string : Bool?
    # x-kubernetes-list-map-keys annotates an array with the x-kubernetes-list-type `map` by specifying the keys used as the index of the map.
    # This tag MUST only be used on lists that have the "x-kubernetes-list-type" extension set to "map". Also, the values specified for this attribute must be a scalar typed field of the child structure (no nesting is supported).
    # The properties specified must either be required or have a default value, to ensure those properties are present for all list items.
    @[JSON::Field(key: "x-kubernetes-list-map-keys")]
    @[YAML::Field(key: "x-kubernetes-list-map-keys")]
    property x_kubernetes_list_map_keys : Array(String)?
    # x-kubernetes-list-type annotates an array to further describe its topology. This extension must only be used on lists and may have 3 possible values:
    # 1) `atomic`: the list is treated as a single entity, like a scalar.
    # Atomic lists will be entirely replaced when updated. This extension
    # may be used on any type of list (struct, scalar, ...).
    # 2) `set`:
    # Sets are lists that must not have multiple items with the same value. Each
    # value must be a scalar, an object with x-kubernetes-map-type `atomic` or an
    # array with x-kubernetes-list-type `atomic`.
    # 3) `map`:
    # These lists are like maps in that their elements have a non-index key
    # used to identify them. Order is preserved upon merge. The map tag
    # must only be used on a list with elements of type object.
    # Defaults to atomic for arrays.
    @[JSON::Field(key: "x-kubernetes-list-type")]
    @[YAML::Field(key: "x-kubernetes-list-type")]
    property x_kubernetes_list_type : String?
    # x-kubernetes-map-type annotates an object to further describe its topology. This extension must only be used when type is object and may have 2 possible values:
    # 1) `granular`:
    # These maps are actual maps (key-value pairs) and each fields are independent
    # from each other (they can each be manipulated by separate actors). This is
    # the default behaviour for all maps.
    # 2) `atomic`: the list is treated as a single entity, like a scalar.
    # Atomic maps will be entirely replaced when updated.
    @[JSON::Field(key: "x-kubernetes-map-type")]
    @[YAML::Field(key: "x-kubernetes-map-type")]
    property x_kubernetes_map_type : String?
    # x-kubernetes-preserve-unknown-fields stops the API server decoding step from pruning fields which are not specified in the validation schema. This affects fields recursively, but switches back to normal pruning behaviour if nested properties or additionalProperties are specified in the schema. This can either be true or undefined. False is forbidden.
    @[JSON::Field(key: "x-kubernetes-preserve-unknown-fields")]
    @[YAML::Field(key: "x-kubernetes-preserve-unknown-fields")]
    property x_kubernetes_preserve_unknown_fields : Bool?
    # x-kubernetes-validations describes a list of validation rules written in the CEL expression language.
    @[JSON::Field(key: "x-kubernetes-validations")]
    @[YAML::Field(key: "x-kubernetes-validations")]
    property x_kubernetes_validations : Array(ValidationRule)?
  end

  # SelectableField specifies the JSON path of a field that may be used with field selectors.
  struct SelectableField
    include Kubernetes::Serializable

    # jsonPath is a simple JSON path which is evaluated against each custom resource to produce a field selector value. Only JSON paths without the array notation are allowed. Must point to a field of type string, boolean or integer. Types with enum values and strings with formats are allowed. If jsonPath refers to absent field in a resource, the jsonPath evaluates to an empty string. Must not point to metdata fields. Required.
    @[JSON::Field(key: "jsonPath")]
    @[YAML::Field(key: "jsonPath")]
    property json_path : String?
  end

  # ValidationRule describes a validation rule written in the CEL expression language.
  struct ValidationRule
    include Kubernetes::Serializable

    # fieldPath represents the field path returned when the validation fails. It must be a relative JSON path (i.e. with array notation) scoped to the location of this x-kubernetes-validations extension in the schema and refer to an existing field. e.g. when validation checks if a specific attribute `foo` under a map `testMap`, the fieldPath could be set to `.testMap.foo` If the validation checks two lists must have unique attributes, the fieldPath could be set to either of the list: e.g. `.testList` It does not support list numeric index. It supports child operation to refer to an existing field currently. Refer to [JSONPath support in Kubernetes](https://kubernetes.io/docs/reference/kubectl/jsonpath/) for more info. Numeric index of array is not supported. For field name which contains special characters, use `['specialName']` to refer the field name. e.g. for attribute `foo.34$` appears in a list `testList`, the fieldPath could be set to `.testList['foo.34$']`
    @[JSON::Field(key: "fieldPath")]
    @[YAML::Field(key: "fieldPath")]
    property field_path : String?
    # Message represents the message displayed when validation fails. The message is required if the Rule contains line breaks. The message must not contain line breaks. If unset, the message is "failed rule: {Rule}". e.g. "must be a URL with the host matching spec.host"
    property message : String?
    # MessageExpression declares a CEL expression that evaluates to the validation failure message that is returned when this rule fails. Since messageExpression is used as a failure message, it must evaluate to a string. If both message and messageExpression are present on a rule, then messageExpression will be used if validation fails. If messageExpression results in a runtime error, the runtime error is logged, and the validation failure message is produced as if the messageExpression field were unset. If messageExpression evaluates to an empty string, a string with only spaces, or a string that contains line breaks, then the validation failure message will also be produced as if the messageExpression field were unset, and the fact that messageExpression produced an empty string/string with only spaces/string with line breaks will be logged. messageExpression has access to all the same variables as the rule; the only difference is the return type. Example: "x must be less than max ("+string(self.max)+")"
    @[JSON::Field(key: "messageExpression")]
    @[YAML::Field(key: "messageExpression")]
    property message_expression : String?
    # optionalOldSelf is used to opt a transition rule into evaluation even when the object is first created, or if the old object is missing the value.
    # When enabled `oldSelf` will be a CEL optional whose value will be `None` if there is no old value, or when the object is initially created.
    # You may check for presence of oldSelf using `oldSelf.hasValue()` and unwrap it after checking using `oldSelf.value()`. Check the CEL documentation for Optional types for more information: https://pkg.go.dev/github.com/google/cel-go/cel#OptionalTypes
    # May not be set unless `oldSelf` is used in `rule`.
    @[JSON::Field(key: "optionalOldSelf")]
    @[YAML::Field(key: "optionalOldSelf")]
    property optional_old_self : Bool?
    # reason provides a machine-readable validation failure reason that is returned to the caller when a request fails this validation rule. The HTTP status code returned to the caller will match the reason of the reason of the first failed validation rule. The currently supported reasons are: "FieldValueInvalid", "FieldValueForbidden", "FieldValueRequired", "FieldValueDuplicate". If not set, default to use "FieldValueInvalid". All future added reasons must be accepted by clients when reading this value and unknown reasons should be treated as FieldValueInvalid.
    property reason : String?
    # Rule represents the expression which will be evaluated by CEL. ref: https://github.com/google/cel-spec The Rule is scoped to the location of the x-kubernetes-validations extension in the schema. The `self` variable in the CEL expression is bound to the scoped value. Example: - Rule scoped to the root of a resource with a status subresource: {"rule": "self.status.actual <= self.spec.maxDesired"}
    # If the Rule is scoped to an object with properties, the accessible properties of the object are field selectable via `self.field` and field presence can be checked via `has(self.field)`. Null valued fields are treated as absent fields in CEL expressions. If the Rule is scoped to an object with additionalProperties (i.e. a map) the value of the map are accessible via `self[mapKey]`, map containment can be checked via `mapKey in self` and all entries of the map are accessible via CEL macros and functions such as `self.all(...)`. If the Rule is scoped to an array, the elements of the array are accessible via `self[i]` and also by macros and functions. If the Rule is scoped to a scalar, `self` is bound to the scalar value. Examples: - Rule scoped to a map of objects: {"rule": "self.components['Widget'].priority < 10"} - Rule scoped to a list of integers: {"rule": "self.values.all(value, value >= 0 && value < 100)"} - Rule scoped to a string value: {"rule": "self.startsWith('kube')"}
    # The `apiVersion`, `kind`, `metadata.name` and `metadata.generateName` are always accessible from the root of the object and from any x-kubernetes-embedded-resource annotated objects. No other metadata properties are accessible.
    # Unknown data preserved in custom resources via x-kubernetes-preserve-unknown-fields is not accessible in CEL expressions. This includes: - Unknown field values that are preserved by object schemas with x-kubernetes-preserve-unknown-fields. - Object properties where the property schema is of an "unknown type". An "unknown type" is recursively defined as:
    # - A schema with no type and x-kubernetes-preserve-unknown-fields set to true
    # - An array where the items schema is of an "unknown type"
    # - An object where the additionalProperties schema is of an "unknown type"
    # Only property names of the form `[a-zA-Z_.-/][a-zA-Z0-9_.-/]*` are accessible. Accessible property names are escaped according to the following rules when accessed in the expression: - '__' escapes to '__underscores__' - '.' escapes to '__dot__' - '-' escapes to '__dash__' - '/' escapes to '__slash__' - Property names that exactly match a CEL RESERVED keyword escape to '__{keyword}__'. The keywords are:
    # "true", "false", "null", "in", "as", "break", "const", "continue", "else", "for", "function", "if",
    # "import", "let", "loop", "package", "namespace", "return".
    # Examples:
    # - Rule accessing a property named "namespace": {"rule": "self.__namespace__ > 0"}
    # - Rule accessing a property named "x-prop": {"rule": "self.x__dash__prop > 0"}
    # - Rule accessing a property named "redact__d": {"rule": "self.redact__underscores__d > 0"}
    # Equality on arrays with x-kubernetes-list-type of 'set' or 'map' ignores element order, i.e. [1, 2] == [2, 1]. Concatenation on arrays with x-kubernetes-list-type use the semantics of the list type:
    # - 'set': `X + Y` performs a union where the array positions of all elements in `X` are preserved and
    # non-intersecting elements in `Y` are appended, retaining their partial order.
    # - 'map': `X + Y` performs a merge where the array positions of all keys in `X` are preserved but the values
    # are overwritten by values in `Y` when the key sets of `X` and `Y` intersect. Elements in `Y` with
    # non-intersecting keys are appended, retaining their partial order.
    # If `rule` makes use of the `oldSelf` variable it is implicitly a `transition rule`.
    # By default, the `oldSelf` variable is the same type as `self`. When `optionalOldSelf` is true, the `oldSelf` variable is a CEL optional
    # variable whose value() is the same type as `self`.
    # See the documentation for the `optionalOldSelf` field for details.
    # Transition rules by default are applied only on UPDATE requests and are skipped if an old value could not be found. You can opt a transition rule into unconditional evaluation by setting `optionalOldSelf` to true.
    property rule : String?
  end

  # WebhookConversion describes how to call a conversion webhook
  struct WebhookConversion
    include Kubernetes::Serializable

    # clientConfig is the instructions for how to call the webhook if strategy is `Webhook`.
    @[JSON::Field(key: "clientConfig")]
    @[YAML::Field(key: "clientConfig")]
    property client_config : WebhookClientConfig?
    # conversionReviewVersions is an ordered list of preferred `ConversionReview` versions the Webhook expects. The API server will use the first version in the list which it supports. If none of the versions specified in this list are supported by API server, conversion will fail for the custom resource. If a persisted Webhook configuration specifies allowed versions and does not include any versions known to the API Server, calls to the webhook will fail.
    @[JSON::Field(key: "conversionReviewVersions")]
    @[YAML::Field(key: "conversionReviewVersions")]
    property conversion_review_versions : Array(String)?
  end

  # APIGroup contains the name, the supported versions, and the preferred version of a group.
  struct APIGroup
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # name is the name of the group.
    property name : String?
    # preferredVersion is the version preferred by the API server, which probably is the storage version.
    @[JSON::Field(key: "preferredVersion")]
    @[YAML::Field(key: "preferredVersion")]
    property preferred_version : GroupVersionForDiscovery?
    # a map of client CIDR to server address that is serving this group. This is to help clients reach servers in the most network-efficient way possible. Clients can use the appropriate server address as per the CIDR that they match. In case of multiple matches, clients should use the longest matching CIDR. The server returns only those CIDRs that it thinks that the client can match. For example: the master will return an internal IP CIDR only, if the client reaches the server using an internal IP. Server looks at X-Forwarded-For header or X-Real-Ip header or request.RemoteAddr (in that order) to get the client IP.
    @[JSON::Field(key: "serverAddressByClientCIDRs")]
    @[YAML::Field(key: "serverAddressByClientCIDRs")]
    property server_address_by_client_cid_rs : Array(ServerAddressByClientCIDR)?
    # versions are the versions supported in this group.
    property versions : Array(GroupVersionForDiscovery)?
  end

  # APIGroupList is a list of APIGroup, to allow clients to discover the API at /apis.
  struct APIGroupList
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # groups is a list of APIGroup.
    property groups : Array(APIGroup)?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
  end

  # APIResource specifies the name of a resource and whether it is namespaced.
  struct APIResource
    include Kubernetes::Serializable

    # categories is a list of the grouped resources this resource belongs to (e.g. 'all')
    property categories : Array(String)?
    # group is the preferred group of the resource.  Empty implies the group of the containing resource list. For subresources, this may have a different value, for example: Scale".
    property group : String?
    # kind is the kind for the resource (e.g. 'Foo' is the kind for a resource 'foo')
    property kind : String?
    # name is the plural name of the resource.
    property name : String?
    # namespaced indicates if a resource is namespaced or not.
    property namespaced : Bool?
    # shortNames is a list of suggested short names of the resource.
    @[JSON::Field(key: "shortNames")]
    @[YAML::Field(key: "shortNames")]
    property short_names : Array(String)?
    # singularName is the singular name of the resource.  This allows clients to handle plural and singular opaquely. The singularName is more correct for reporting status on a single item and both singular and plural are allowed from the kubectl CLI interface.
    @[JSON::Field(key: "singularName")]
    @[YAML::Field(key: "singularName")]
    property singular_name : String?
    # The hash value of the storage version, the version this resource is converted to when written to the data store. Value must be treated as opaque by clients. Only equality comparison on the value is valid. This is an alpha feature and may change or be removed in the future. The field is populated by the apiserver only if the StorageVersionHash feature gate is enabled. This field will remain optional even if it graduates.
    @[JSON::Field(key: "storageVersionHash")]
    @[YAML::Field(key: "storageVersionHash")]
    property storage_version_hash : String?
    # verbs is a list of supported kube verbs (this includes get, list, watch, create, update, patch, delete, deletecollection, and proxy)
    property verbs : Array(String)?
    # version is the preferred version of the resource.  Empty implies the version of the containing resource list For subresources, this may have a different value, for example: v1 (while inside a v1beta1 version of the core resource's group)".
    property version : String?
  end

  # APIResourceList is a list of APIResource, it is used to expose the name of the resources supported in a specific group and version, and if the resource is namespaced.
  struct APIResourceList
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # groupVersion is the group and version this APIResourceList is for.
    @[JSON::Field(key: "groupVersion")]
    @[YAML::Field(key: "groupVersion")]
    property group_version : String?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # resources contains the name of the resources and if they are namespaced.
    property resources : Array(APIResource)?
  end

  # APIVersions lists the versions that are available, to allow clients to discover the API at /api, which is the root path of the legacy v1 API.
  struct APIVersions
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # a map of client CIDR to server address that is serving this group. This is to help clients reach servers in the most network-efficient way possible. Clients can use the appropriate server address as per the CIDR that they match. In case of multiple matches, clients should use the longest matching CIDR. The server returns only those CIDRs that it thinks that the client can match. For example: the master will return an internal IP CIDR only, if the client reaches the server using an internal IP. Server looks at X-Forwarded-For header or X-Real-Ip header or request.RemoteAddr (in that order) to get the client IP.
    @[JSON::Field(key: "serverAddressByClientCIDRs")]
    @[YAML::Field(key: "serverAddressByClientCIDRs")]
    property server_address_by_client_cid_rs : Array(ServerAddressByClientCIDR)?
    # versions are the api versions that are available.
    property versions : Array(String)?
  end

  # Condition contains details for one aspect of the current state of this API Resource.
  struct Condition
    include Kubernetes::Serializable

    # lastTransitionTime is the last time the condition transitioned from one status to another. This should be when the underlying condition changed.  If that is not known, then using the time when the API field changed is acceptable.
    @[JSON::Field(key: "lastTransitionTime")]
    @[YAML::Field(key: "lastTransitionTime")]
    property last_transition_time : Time?
    # message is a human readable message indicating details about the transition. This may be an empty string.
    property message : String?
    # observedGeneration represents the .metadata.generation that the condition was set based upon. For instance, if .metadata.generation is currently 12, but the .status.conditions[x].observedGeneration is 9, the condition is out of date with respect to the current state of the instance.
    @[JSON::Field(key: "observedGeneration")]
    @[YAML::Field(key: "observedGeneration")]
    property observed_generation : Int64?
    # reason contains a programmatic identifier indicating the reason for the condition's last transition. Producers of specific condition types may define expected values and meanings for this field, and whether the values are considered a guaranteed API. The value should be a CamelCase string. This field may not be empty.
    property reason : String?
    # status of the condition, one of True, False, Unknown.
    property status : String?
    # type of condition in CamelCase or in foo.example.com/CamelCase.
    property type : String?
  end

  # DeleteOptions may be provided when deleting an API object.
  struct DeleteOptions
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # When present, indicates that modifications should not be persisted. An invalid or unrecognized dryRun directive will result in an error response and no further processing of the request. Valid values are: - All: all dry run stages will be processed
    @[JSON::Field(key: "dryRun")]
    @[YAML::Field(key: "dryRun")]
    property dry_run : Array(String)?
    # The duration in seconds before the object should be deleted. Value must be non-negative integer. The value zero indicates delete immediately. If this value is nil, the default grace period for the specified type will be used. Defaults to a per object value if not specified. zero means delete immediately.
    @[JSON::Field(key: "gracePeriodSeconds")]
    @[YAML::Field(key: "gracePeriodSeconds")]
    property grace_period_seconds : Int64?
    # if set to true, it will trigger an unsafe deletion of the resource in case the normal deletion flow fails with a corrupt object error. A resource is considered corrupt if it can not be retrieved from the underlying storage successfully because of a) its data can not be transformed e.g. decryption failure, or b) it fails to decode into an object. NOTE: unsafe deletion ignores finalizer constraints, skips precondition checks, and removes the object from the storage. WARNING: This may potentially break the cluster if the workload associated with the resource being unsafe-deleted relies on normal deletion flow. Use only if you REALLY know what you are doing. The default value is false, and the user must opt in to enable it
    @[JSON::Field(key: "ignoreStoreReadErrorWithClusterBreakingPotential")]
    @[YAML::Field(key: "ignoreStoreReadErrorWithClusterBreakingPotential")]
    property ignore_store_read_error_with_cluster_breaking_potential : Bool?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Deprecated: please use the PropagationPolicy, this field will be deprecated in 1.7. Should the dependent objects be orphaned. If true/false, the "orphan" finalizer will be added to/removed from the object's finalizers list. Either this field or PropagationPolicy may be set, but not both.
    @[JSON::Field(key: "orphanDependents")]
    @[YAML::Field(key: "orphanDependents")]
    property orphan_dependents : Bool?
    # Must be fulfilled before a deletion is carried out. If not possible, a 409 Conflict status will be returned.
    property preconditions : Preconditions?
    # Whether and how garbage collection will be performed. Either this field or OrphanDependents may be set, but not both. The default policy is decided by the existing finalizer set in the metadata.finalizers and the resource-specific default policy. Acceptable values are: 'Orphan' - orphan the dependents; 'Background' - allow the garbage collector to delete the dependents in the background; 'Foreground' - a cascading policy that deletes all dependents in the foreground.
    @[JSON::Field(key: "propagationPolicy")]
    @[YAML::Field(key: "propagationPolicy")]
    property propagation_policy : String?
  end

  # FieldSelectorRequirement is a selector that contains values, a key, and an operator that relates the key and values.
  struct FieldSelectorRequirement
    include Kubernetes::Serializable

    # key is the field selector key that the requirement applies to.
    property key : String?
    # operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. The list of operators may grow in the future.
    property operator : String?
    # values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty.
    property values : Array(String)?
  end

  # GroupVersion contains the "group/version" and "version" string of a version. It is made a struct to keep extensibility.
  struct GroupVersionForDiscovery
    include Kubernetes::Serializable

    # groupVersion specifies the API group and version in the form "group/version"
    @[JSON::Field(key: "groupVersion")]
    @[YAML::Field(key: "groupVersion")]
    property group_version : String?
    # version specifies the version in the form of "version". This is to save the clients the trouble of splitting the GroupVersion.
    property version : String?
  end

  # A label selector is a label query over a set of resources. The result of matchLabels and matchExpressions are ANDed. An empty label selector matches all objects. A null label selector matches no objects.
  struct LabelSelector
    include Kubernetes::Serializable

    # matchExpressions is a list of label selector requirements. The requirements are ANDed.
    @[JSON::Field(key: "matchExpressions")]
    @[YAML::Field(key: "matchExpressions")]
    property match_expressions : Array(LabelSelectorRequirement)?
    # matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is "key", the operator is "In", and the values array contains only "value". The requirements are ANDed.
    @[JSON::Field(key: "matchLabels")]
    @[YAML::Field(key: "matchLabels")]
    property match_labels : Hash(String, String)?
  end

  # A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values.
  struct LabelSelectorRequirement
    include Kubernetes::Serializable

    # key is the label key that the selector applies to.
    property key : String?
    # operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist.
    property operator : String?
    # values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch.
    property values : Array(String)?
  end

  # ListMeta describes metadata that synthetic resources must have, including lists and various status objects. A resource may have only one of {ObjectMeta, ListMeta}.
  struct ListMeta
    include Kubernetes::Serializable

    # continue may be set if the user set a limit on the number of items returned, and indicates that the server has more data available. The value is opaque and may be used to issue another request to the endpoint that served this list to retrieve the next set of available objects. Continuing a consistent list may not be possible if the server configuration has changed or more than a few minutes have passed. The resourceVersion field returned when using this continue value will be identical to the value in the first response, unless you have received this token from an error message.
    property continue : String?
    # remainingItemCount is the number of subsequent items in the list which are not included in this list response. If the list request contained label or field selectors, then the number of remaining items is unknown and the field will be left unset and omitted during serialization. If the list is complete (either because it is not chunking or because this is the last chunk), then there are no more remaining items and this field will be left unset and omitted during serialization. Servers older than v1.15 do not set this field. The intended use of the remainingItemCount is *estimating* the size of a collection. Clients should not rely on the remainingItemCount to be set or to be exact.
    @[JSON::Field(key: "remainingItemCount")]
    @[YAML::Field(key: "remainingItemCount")]
    property remaining_item_count : Int64?
    # String that identifies the server's internal version of this object that can be used by clients to determine when objects have changed. Value must be treated as opaque by clients and passed unmodified back to the server. Populated by the system. Read-only. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#concurrency-control-and-consistency
    @[JSON::Field(key: "resourceVersion")]
    @[YAML::Field(key: "resourceVersion")]
    property resource_version : String?
    # Deprecated: selfLink is a legacy read-only field that is no longer populated by the system.
    @[JSON::Field(key: "selfLink")]
    @[YAML::Field(key: "selfLink")]
    property self_link : String?
  end

  # ManagedFieldsEntry is a workflow-id, a FieldSet and the group version of the resource that the fieldset applies to.
  struct ManagedFieldsEntry
    include Kubernetes::Serializable

    # APIVersion defines the version of this resource that this field set applies to. The format is "group/version" just like the top-level APIVersion field. It is necessary to track the version of a field set because it cannot be automatically converted.
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # FieldsType is the discriminator for the different fields format and version. There is currently only one possible value: "FieldsV1"
    @[JSON::Field(key: "fieldsType")]
    @[YAML::Field(key: "fieldsType")]
    property fields_type : String?
    # FieldsV1 holds the first JSON version format as described in the "FieldsV1" type.
    @[JSON::Field(key: "fieldsV1")]
    @[YAML::Field(key: "fieldsV1")]
    property fields_v1 : Hash(String, JSON::Any)?
    # Manager is an identifier of the workflow managing these fields.
    property manager : String?
    # Operation is the type of operation which lead to this ManagedFieldsEntry being created. The only valid values for this field are 'Apply' and 'Update'.
    property operation : String?
    # Subresource is the name of the subresource used to update that object, or empty string if the object was updated through the main resource. The value of this field is used to distinguish between managers, even if they share the same name. For example, a status update will be distinct from a regular update using the same manager name. Note that the APIVersion field is not related to the Subresource field and it always corresponds to the version of the main resource.
    property subresource : String?
    # Time is the timestamp of when the ManagedFields entry was added. The timestamp will also be updated if a field is added, the manager changes any of the owned fields value or removes a field. The timestamp does not update when a field is removed from the entry because another manager took it over.
    property time : Time?
  end

  # ObjectMeta is metadata that all persisted resources must have, which includes all objects users must create.
  struct ObjectMeta
    include Kubernetes::Serializable

    # Annotations is an unstructured key value map stored with a resource that may be set by external tools to store and retrieve arbitrary metadata. They are not queryable and should be preserved when modifying objects. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations
    property annotations : Hash(String, String)?
    # CreationTimestamp is a timestamp representing the server time when this object was created. It is not guaranteed to be set in happens-before order across separate operations. Clients may not set this value. It is represented in RFC3339 form and is in UTC.
    # Populated by the system. Read-only. Null for lists. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    @[JSON::Field(key: "creationTimestamp")]
    @[YAML::Field(key: "creationTimestamp")]
    property creation_timestamp : Time?
    # Number of seconds allowed for this object to gracefully terminate before it will be removed from the system. Only set when deletionTimestamp is also set. May only be shortened. Read-only.
    @[JSON::Field(key: "deletionGracePeriodSeconds")]
    @[YAML::Field(key: "deletionGracePeriodSeconds")]
    property deletion_grace_period_seconds : Int64?
    # DeletionTimestamp is RFC 3339 date and time at which this resource will be deleted. This field is set by the server when a graceful deletion is requested by the user, and is not directly settable by a client. The resource is expected to be deleted (no longer visible from resource lists, and not reachable by name) after the time in this field, once the finalizers list is empty. As long as the finalizers list contains items, deletion is blocked. Once the deletionTimestamp is set, this value may not be unset or be set further into the future, although it may be shortened or the resource may be deleted prior to this time. For example, a user may request that a pod is deleted in 30 seconds. The Kubelet will react by sending a graceful termination signal to the containers in the pod. After that 30 seconds, the Kubelet will send a hard termination signal (SIGKILL) to the container and after cleanup, remove the pod from the API. In the presence of network partitions, this object may still exist after this timestamp, until an administrator or automated process can determine the resource is fully terminated. If not set, graceful deletion of the object has not been requested.
    # Populated by the system when a graceful deletion is requested. Read-only. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    @[JSON::Field(key: "deletionTimestamp")]
    @[YAML::Field(key: "deletionTimestamp")]
    property deletion_timestamp : Time?
    # Must be empty before the object is deleted from the registry. Each entry is an identifier for the responsible component that will remove the entry from the list. If the deletionTimestamp of the object is non-nil, entries in this list can only be removed. Finalizers may be processed and removed in any order.  Order is NOT enforced because it introduces significant risk of stuck finalizers. finalizers is a shared field, any actor with permission can reorder it. If the finalizer list is processed in order, then this can lead to a situation in which the component responsible for the first finalizer in the list is waiting for a signal (field value, external system, or other) produced by a component responsible for a finalizer later in the list, resulting in a deadlock. Without enforced ordering finalizers are free to order amongst themselves and are not vulnerable to ordering changes in the list.
    property finalizers : Array(String)?
    # GenerateName is an optional prefix, used by the server, to generate a unique name ONLY IF the Name field has not been provided. If this field is used, the name returned to the client will be different than the name passed. This value will also be combined with a unique suffix. The provided value has the same validation rules as the Name field, and may be truncated by the length of the suffix required to make the value unique on the server.
    # If this field is specified and the generated name exists, the server will return a 409.
    # Applied only if Name is not specified. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#idempotency
    @[JSON::Field(key: "generateName")]
    @[YAML::Field(key: "generateName")]
    property generate_name : String?
    # A sequence number representing a specific generation of the desired state. Populated by the system. Read-only.
    property generation : Int64?
    # Map of string keys and values that can be used to organize and categorize (scope and select) objects. May match selectors of replication controllers and services. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels
    property labels : Hash(String, String)?
    # ManagedFields maps workflow-id and version to the set of fields that are managed by that workflow. This is mostly for internal housekeeping, and users typically shouldn't need to set or understand this field. A workflow can be the user's name, a controller's name, or the name of a specific apply path like "ci-cd". The set of fields is always in the version that the workflow used when modifying the object.
    @[JSON::Field(key: "managedFields")]
    @[YAML::Field(key: "managedFields")]
    property managed_fields : Array(ManagedFieldsEntry)?
    # Name must be unique within a namespace. Is required when creating resources, although some resources may allow a client to request the generation of an appropriate name automatically. Name is primarily intended for creation idempotence and configuration definition. Cannot be updated. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names#names
    property name : String?
    # Namespace defines the space within which each name must be unique. An empty namespace is equivalent to the "default" namespace, but "default" is the canonical representation. Not all objects are required to be scoped to a namespace - the value of this field for those objects will be empty.
    # Must be a DNS_LABEL. Cannot be updated. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces
    property namespace : String?
    # List of objects depended by this object. If ALL objects in the list have been deleted, this object will be garbage collected. If this object is managed by a controller, then an entry in this list will point to this controller, with the controller field set to true. There cannot be more than one managing controller.
    @[JSON::Field(key: "ownerReferences")]
    @[YAML::Field(key: "ownerReferences")]
    property owner_references : Array(OwnerReference)?
    # An opaque value that represents the internal version of this object that can be used by clients to determine when objects have changed. May be used for optimistic concurrency, change detection, and the watch operation on a resource or set of resources. Clients must treat these values as opaque and passed unmodified back to the server. They may only be valid for a particular resource or set of resources.
    # Populated by the system. Read-only. Value must be treated as opaque by clients and . More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#concurrency-control-and-consistency
    @[JSON::Field(key: "resourceVersion")]
    @[YAML::Field(key: "resourceVersion")]
    property resource_version : String?
    # Deprecated: selfLink is a legacy read-only field that is no longer populated by the system.
    @[JSON::Field(key: "selfLink")]
    @[YAML::Field(key: "selfLink")]
    property self_link : String?
    # UID is the unique in time and space value for this object. It is typically generated by the server on successful creation of a resource and is not allowed to change on PUT operations.
    # Populated by the system. Read-only. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names#uids
    property uid : String?
  end

  # OwnerReference contains enough information to let you identify an owning object. An owning object must be in the same namespace as the dependent, or be cluster-scoped, so there is no namespace field.
  struct OwnerReference
    include Kubernetes::Serializable

    # API version of the referent.
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # If true, AND if the owner has the "foregroundDeletion" finalizer, then the owner cannot be deleted from the key-value store until this reference is removed. See https://kubernetes.io/docs/concepts/architecture/garbage-collection/#foreground-deletion for how the garbage collector interacts with this field and enforces the foreground deletion. Defaults to false. To set this field, a user needs "delete" permission of the owner, otherwise 422 (Unprocessable Entity) will be returned.
    @[JSON::Field(key: "blockOwnerDeletion")]
    @[YAML::Field(key: "blockOwnerDeletion")]
    property block_owner_deletion : Bool?
    # If true, this reference points to the managing controller.
    property controller : Bool?
    # Kind of the referent. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names#names
    property name : String?
    # UID of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names#uids
    property uid : String?
  end

  # Preconditions must be fulfilled before an operation (update, delete, etc.) is carried out.
  struct Preconditions
    include Kubernetes::Serializable

    # Specifies the target ResourceVersion
    @[JSON::Field(key: "resourceVersion")]
    @[YAML::Field(key: "resourceVersion")]
    property resource_version : String?
    # Specifies the target UID.
    property uid : String?
  end

  # ServerAddressByClientCIDR helps the client to determine the server address that they should use, depending on the clientCIDR that they match.
  struct ServerAddressByClientCIDR
    include Kubernetes::Serializable

    # The CIDR with which clients can match their IP to figure out the server address that they should use.
    @[JSON::Field(key: "clientCIDR")]
    @[YAML::Field(key: "clientCIDR")]
    property client_cidr : String?
    # Address of this server, suitable for a client that matches the above CIDR. This can be a hostname, hostname:port, IP or IP:port.
    @[JSON::Field(key: "serverAddress")]
    @[YAML::Field(key: "serverAddress")]
    property server_address : String?
  end

  # Status is a return value for calls that don't return other objects.
  struct Status
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Suggested HTTP return code for this status, 0 if not set.
    property code : Int32?
    # Extended data associated with the reason.  Each reason may define its own extended details. This field is optional and the data returned is not guaranteed to conform to any schema except that defined by the reason type.
    property details : StatusDetails?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # A human-readable description of the status of this operation.
    property message : String?
    # Standard list metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property metadata : ListMeta?
    # A machine-readable description of why this operation is in the "Failure" status. If this value is empty there is no information available. A Reason clarifies an HTTP status code but does not override it.
    property reason : String?
    # Status of the operation. One of: "Success" or "Failure". More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status
    property status : String?
  end

  # StatusCause provides more information about an api.Status failure, including cases when multiple errors are encountered.
  struct StatusCause
    include Kubernetes::Serializable

    # The field of the resource that has caused this error, as named by its JSON serialization. May include dot and postfix notation for nested attributes. Arrays are zero-indexed.  Fields may appear more than once in an array of causes due to fields having multiple errors. Optional.
    # Examples:
    # "name" - the field "name" on the current resource
    # "items[0].name" - the field "name" on the first array entry in "items"
    property field : String?
    # A human-readable description of the cause of the error.  This field may be presented as-is to a reader.
    property message : String?
    # A machine-readable description of the cause of the error. If this value is empty there is no information available.
    property reason : String?
  end

  # StatusDetails is a set of additional properties that MAY be set by the server to provide additional information about a response. The Reason field of a Status object defines what attributes will be set. Clients must ignore fields that do not match the defined type of each attribute, and should assume that any attribute may be empty, invalid, or under defined.
  struct StatusDetails
    include Kubernetes::Serializable

    # The Causes array includes more details associated with the StatusReason failure. Not all StatusReasons may provide detailed causes.
    property causes : Array(StatusCause)?
    # The group attribute of the resource associated with the status StatusReason.
    property group : String?
    # The kind attribute of the resource associated with the status StatusReason. On some operations may differ from the requested resource Kind. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # The name attribute of the resource associated with the status StatusReason (when there is a single name which can be described).
    property name : String?
    # If specified, the time in seconds before the operation should be retried. Some errors may indicate the client must take an alternate action - for those errors this field may indicate how long to wait before taking the alternate action.
    @[JSON::Field(key: "retryAfterSeconds")]
    @[YAML::Field(key: "retryAfterSeconds")]
    property retry_after_seconds : Int32?
    # UID of the resource. (when there is a single resource which can be described). More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names#uids
    property uid : String?
  end

  # Event represents a single event to a watched resource.
  struct WatchEvent
    include Kubernetes::Serializable

    # Object is:
    # * If Type is Added or Modified: the new state of the object.
    # * If Type is Deleted: the state of the object immediately before deletion.
    # * If Type is Error: *Status is recommended; other types may make sense
    # depending on context.
    property object : Hash(String, JSON::Any)?
    property type : String?
  end

  # APIService represents a server for a particular GroupVersion. Name must be "version.group".
  struct APIService
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
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
    @[JSON::Field(key: "lastTransitionTime")]
    @[YAML::Field(key: "lastTransitionTime")]
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
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
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
    @[JSON::Field(key: "caBundle")]
    @[YAML::Field(key: "caBundle")]
    property ca_bundle : String?
    # Group is the API group name this server hosts
    property group : String?
    # GroupPriorityMinimum is the priority this group should have at least. Higher priority means that the group is preferred by clients over lower priority ones. Note that other versions of this group might specify even higher GroupPriorityMinimum values such that the whole group gets a higher priority. The primary sort is based on GroupPriorityMinimum, ordered highest number to lowest (20 before 10). The secondary sort is based on the alphabetical comparison of the name of the object.  (v1.bar before v1.foo) We'd recommend something like: *.k8s.io (except extensions) at 18000 and PaaSes (OpenShift, Deis) are recommended to be in the 2000s
    @[JSON::Field(key: "groupPriorityMinimum")]
    @[YAML::Field(key: "groupPriorityMinimum")]
    property group_priority_minimum : Int32?
    # InsecureSkipTLSVerify disables TLS certificate verification when communicating with this server. This is strongly discouraged.  You should use the CABundle instead.
    @[JSON::Field(key: "insecureSkipTLSVerify")]
    @[YAML::Field(key: "insecureSkipTLSVerify")]
    property insecure_skip_tls_verify : Bool?
    # Service is a reference to the service for this API server.  It must communicate on port 443. If the Service is nil, that means the handling for the API groupversion is handled locally on this server. The call will simply delegate to the normal handler chain to be fulfilled.
    property service : ServiceReference?
    # Version is the API version this server hosts.  For example, "v1"
    property version : String?
    # VersionPriority controls the ordering of this API version inside of its group.  Must be greater than zero. The primary sort is based on VersionPriority, ordered highest to lowest (20 before 10). Since it's inside of a group, the number can be small, probably in the 10s. In case of equal version priorities, the version string will be used to compute the order inside a group. If the version string is "kube-like", it will sort above non "kube-like" version strings, which are ordered lexicographically. "Kube-like" versions start with a "v", then are followed by a number (the major version), then optionally the string "alpha" or "beta" and another number (the minor version). These are sorted first by GA > beta > alpha (where GA is a version with no suffix such as beta or alpha), and then by comparing major version, then minor version. An example sorted list of versions: v10, v2, v1, v11beta2, v10beta3, v3beta1, v12alpha1, v11alpha2, foo1, foo10.
    @[JSON::Field(key: "versionPriority")]
    @[YAML::Field(key: "versionPriority")]
    property version_priority : Int32?
  end

  # APIServiceStatus contains derived information about an API server
  struct APIServiceStatus
    include Kubernetes::Serializable

    # Current service state of apiService.
    property conditions : Array(APIServiceCondition)?
  end
end
