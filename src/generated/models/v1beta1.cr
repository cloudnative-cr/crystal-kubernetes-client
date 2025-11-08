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
  # ApplyConfiguration defines the desired configuration values of an object.
  struct ApplyConfiguration
    include Kubernetes::Serializable

    # expression will be evaluated by CEL to create an apply configuration. ref: https://github.com/google/cel-spec
    # Apply configurations are declared in CEL using object initialization. For example, this CEL expression returns an apply configuration to set a single field:
    # Object{
    # spec: Object.spec{
    # serviceAccountName: "example"
    # }
    # }
    # Apply configurations may not modify atomic structs, maps or arrays due to the risk of accidental deletion of values not included in the apply configuration.
    # CEL expressions have access to the object types needed to create apply configurations:
    # - 'Object' - CEL type of the resource object. - 'Object.<fieldName>' - CEL type of object field (such as 'Object.spec') - 'Object.<fieldName1>.<fieldName2>...<fieldNameN>` - CEL type of nested field (such as 'Object.spec.containers')
    # CEL expressions have access to the contents of the API request, organized into CEL variables as well as some other useful variables:
    # - 'object' - The object from the incoming request. The value is null for DELETE requests. - 'oldObject' - The existing object. The value is null for CREATE requests. - 'request' - Attributes of the API request([ref](/pkg/apis/admission/types.go#AdmissionRequest)). - 'params' - Parameter resource referred to by the policy binding being evaluated. Only populated if the policy has a ParamKind. - 'namespaceObject' - The namespace object that the incoming object belongs to. The value is null for cluster-scoped resources. - 'variables' - Map of composited variables, from its name to its lazily evaluated value.
    # For example, a variable named 'foo' can be accessed as 'variables.foo'.
    # - 'authorizer' - A CEL Authorizer. May be used to perform authorization checks for the principal (user or service account) of the request.
    # See https://pkg.go.dev/k8s.io/apiserver/pkg/cel/library#Authz
    # - 'authorizer.requestResource' - A CEL ResourceCheck constructed from the 'authorizer' and configured with the
    # request resource.
    # The `apiVersion`, `kind`, `metadata.name` and `metadata.generateName` are always accessible from the root of the object. No other metadata properties are accessible.
    # Only property names of the form `[a-zA-Z_.-/][a-zA-Z0-9_.-/]*` are accessible. Required.
    property expression : String?
  end

  # JSONPatch defines a JSON Patch.
  struct JSONPatch
    include Kubernetes::Serializable

    # expression will be evaluated by CEL to create a [JSON patch](https://jsonpatch.com/). ref: https://github.com/google/cel-spec
    # expression must return an array of JSONPatch values.
    # For example, this CEL expression returns a JSON patch to conditionally modify a value:
    # [
    # JSONPatch{op: "test", path: "/spec/example", value: "Red"},
    # JSONPatch{op: "replace", path: "/spec/example", value: "Green"}
    # ]
    # To define an object for the patch value, use Object types. For example:
    # [
    # JSONPatch{
    # op: "add",
    # path: "/spec/selector",
    # value: Object.spec.selector{matchLabels: {"environment": "test"}}
    # }
    # ]
    # To use strings containing '/' and '~' as JSONPatch path keys, use "jsonpatch.escapeKey". For example:
    # [
    # JSONPatch{
    # op: "add",
    # path: "/metadata/labels/" + jsonpatch.escapeKey("example.com/environment"),
    # value: "test"
    # },
    # ]
    # CEL expressions have access to the types needed to create JSON patches and objects:
    # - 'JSONPatch' - CEL type of JSON Patch operations. JSONPatch has the fields 'op', 'from', 'path' and 'value'.
    # See [JSON patch](https://jsonpatch.com/) for more details. The 'value' field may be set to any of: string,
    # integer, array, map or object.  If set, the 'path' and 'from' fields must be set to a
    # [JSON pointer](https://datatracker.ietf.org/doc/html/rfc6901/) string, where the 'jsonpatch.escapeKey()' CEL
    # function may be used to escape path keys containing '/' and '~'.
    # - 'Object' - CEL type of the resource object. - 'Object.<fieldName>' - CEL type of object field (such as 'Object.spec') - 'Object.<fieldName1>.<fieldName2>...<fieldNameN>` - CEL type of nested field (such as 'Object.spec.containers')
    # CEL expressions have access to the contents of the API request, organized into CEL variables as well as some other useful variables:
    # - 'object' - The object from the incoming request. The value is null for DELETE requests. - 'oldObject' - The existing object. The value is null for CREATE requests. - 'request' - Attributes of the API request([ref](/pkg/apis/admission/types.go#AdmissionRequest)). - 'params' - Parameter resource referred to by the policy binding being evaluated. Only populated if the policy has a ParamKind. - 'namespaceObject' - The namespace object that the incoming object belongs to. The value is null for cluster-scoped resources. - 'variables' - Map of composited variables, from its name to its lazily evaluated value.
    # For example, a variable named 'foo' can be accessed as 'variables.foo'.
    # - 'authorizer' - A CEL Authorizer. May be used to perform authorization checks for the principal (user or service account) of the request.
    # See https://pkg.go.dev/k8s.io/apiserver/pkg/cel/library#Authz
    # - 'authorizer.requestResource' - A CEL ResourceCheck constructed from the 'authorizer' and configured with the
    # request resource.
    # CEL expressions have access to [Kubernetes CEL function libraries](https://kubernetes.io/docs/reference/using-api/cel/#cel-options-language-features-and-libraries) as well as:
    # - 'jsonpatch.escapeKey' - Performs JSONPatch key escaping. '~' and  '/' are escaped as '~0' and `~1' respectively).
    # Only property names of the form `[a-zA-Z_.-/][a-zA-Z0-9_.-/]*` are accessible. Required.
    property expression : String?
  end

  # MatchCondition represents a condition which must be fulfilled for a request to be sent to a webhook.
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

  # MutatingAdmissionPolicy describes the definition of an admission mutation policy that mutates the object coming into admission chain.
  struct MutatingAdmissionPolicy
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard object metadata; More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata.
    property metadata : ObjectMeta?
    # Specification of the desired behavior of the MutatingAdmissionPolicy.
    property spec : MutatingAdmissionPolicySpec?
  end

  # MutatingAdmissionPolicyBinding binds the MutatingAdmissionPolicy with parametrized resources. MutatingAdmissionPolicyBinding and the optional parameter resource together define how cluster administrators configure policies for clusters.
  # For a given admission request, each binding will cause its policy to be evaluated N times, where N is 1 for policies/bindings that don't use params, otherwise N is the number of parameters selected by the binding. Each evaluation is constrained by a [runtime cost budget](https://kubernetes.io/docs/reference/using-api/cel/#runtime-cost-budget).
  # Adding/removing policies, bindings, or params can not affect whether a given (policy, binding, param) combination is within its own CEL budget.
  struct MutatingAdmissionPolicyBinding
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard object metadata; More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata.
    property metadata : ObjectMeta?
    # Specification of the desired behavior of the MutatingAdmissionPolicyBinding.
    property spec : MutatingAdmissionPolicyBindingSpec?
  end

  # MutatingAdmissionPolicyBindingList is a list of MutatingAdmissionPolicyBinding.
  struct MutatingAdmissionPolicyBindingList
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # List of PolicyBinding.
    property items : Array(MutatingAdmissionPolicyBinding)?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard list metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property metadata : ListMeta?
  end

  # MutatingAdmissionPolicyBindingSpec is the specification of the MutatingAdmissionPolicyBinding.
  struct MutatingAdmissionPolicyBindingSpec
    include Kubernetes::Serializable

    # matchResources limits what resources match this binding and may be mutated by it. Note that if matchResources matches a resource, the resource must also match a policy's matchConstraints and matchConditions before the resource may be mutated. When matchResources is unset, it does not constrain resource matching, and only the policy's matchConstraints and matchConditions must match for the resource to be mutated. Additionally, matchResources.resourceRules are optional and do not constraint matching when unset. Note that this is differs from MutatingAdmissionPolicy matchConstraints, where resourceRules are required. The CREATE, UPDATE and CONNECT operations are allowed.  The DELETE operation may not be matched. '*' matches CREATE, UPDATE and CONNECT.
    @[JSON::Field(key: "matchResources")]
    @[YAML::Field(key: "matchResources")]
    property match_resources : MatchResources?
    # paramRef specifies the parameter resource used to configure the admission control policy. It should point to a resource of the type specified in spec.ParamKind of the bound MutatingAdmissionPolicy. If the policy specifies a ParamKind and the resource referred to by ParamRef does not exist, this binding is considered mis-configured and the FailurePolicy of the MutatingAdmissionPolicy applied. If the policy does not specify a ParamKind then this field is ignored, and the rules are evaluated without a param.
    @[JSON::Field(key: "paramRef")]
    @[YAML::Field(key: "paramRef")]
    property param_ref : ParamRef?
    # policyName references a MutatingAdmissionPolicy name which the MutatingAdmissionPolicyBinding binds to. If the referenced resource does not exist, this binding is considered invalid and will be ignored Required.
    @[JSON::Field(key: "policyName")]
    @[YAML::Field(key: "policyName")]
    property policy_name : String?
  end

  # MutatingAdmissionPolicyList is a list of MutatingAdmissionPolicy.
  struct MutatingAdmissionPolicyList
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # List of ValidatingAdmissionPolicy.
    property items : Array(MutatingAdmissionPolicy)?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard list metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property metadata : ListMeta?
  end

  # MutatingAdmissionPolicySpec is the specification of the desired behavior of the admission policy.
  struct MutatingAdmissionPolicySpec
    include Kubernetes::Serializable

    # failurePolicy defines how to handle failures for the admission policy. Failures can occur from CEL expression parse errors, type check errors, runtime errors and invalid or mis-configured policy definitions or bindings.
    # A policy is invalid if paramKind refers to a non-existent Kind. A binding is invalid if paramRef.name refers to a non-existent resource.
    # failurePolicy does not define how validations that evaluate to false are handled.
    # Allowed values are Ignore or Fail. Defaults to Fail.
    @[JSON::Field(key: "failurePolicy")]
    @[YAML::Field(key: "failurePolicy")]
    property failure_policy : String?
    # matchConditions is a list of conditions that must be met for a request to be validated. Match conditions filter requests that have already been matched by the matchConstraints. An empty list of matchConditions matches all requests. There are a maximum of 64 match conditions allowed.
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
    # matchConstraints specifies what resources this policy is designed to validate. The MutatingAdmissionPolicy cares about a request if it matches _all_ Constraints. However, in order to prevent clusters from being put into an unstable state that cannot be recovered from via the API MutatingAdmissionPolicy cannot match MutatingAdmissionPolicy and MutatingAdmissionPolicyBinding. The CREATE, UPDATE and CONNECT operations are allowed.  The DELETE operation may not be matched. '*' matches CREATE, UPDATE and CONNECT. Required.
    @[JSON::Field(key: "matchConstraints")]
    @[YAML::Field(key: "matchConstraints")]
    property match_constraints : MatchResources?
    # mutations contain operations to perform on matching objects. mutations may not be empty; a minimum of one mutation is required. mutations are evaluated in order, and are reinvoked according to the reinvocationPolicy. The mutations of a policy are invoked for each binding of this policy and reinvocation of mutations occurs on a per binding basis.
    property mutations : Array(Mutation)?
    # paramKind specifies the kind of resources used to parameterize this policy. If absent, there are no parameters for this policy and the param CEL variable will not be provided to validation expressions. If paramKind refers to a non-existent kind, this policy definition is mis-configured and the FailurePolicy is applied. If paramKind is specified but paramRef is unset in MutatingAdmissionPolicyBinding, the params variable will be null.
    @[JSON::Field(key: "paramKind")]
    @[YAML::Field(key: "paramKind")]
    property param_kind : ParamKind?
    # reinvocationPolicy indicates whether mutations may be called multiple times per MutatingAdmissionPolicyBinding as part of a single admission evaluation. Allowed values are "Never" and "IfNeeded".
    # Never: These mutations will not be called more than once per binding in a single admission evaluation.
    # IfNeeded: These mutations may be invoked more than once per binding for a single admission request and there is no guarantee of order with respect to other admission plugins, admission webhooks, bindings of this policy and admission policies.  Mutations are only reinvoked when mutations change the object after this mutation is invoked. Required.
    @[JSON::Field(key: "reinvocationPolicy")]
    @[YAML::Field(key: "reinvocationPolicy")]
    property reinvocation_policy : String?
    # variables contain definitions of variables that can be used in composition of other expressions. Each variable is defined as a named CEL expression. The variables defined here will be available under `variables` in other expressions of the policy except matchConditions because matchConditions are evaluated before the rest of the policy.
    # The expression of a variable can refer to other variables defined earlier in the list but not those after. Thus, variables must be sorted by the order of first appearance and acyclic.
    property variables : Array(Variable)?
  end

  # Mutation specifies the CEL expression which is used to apply the Mutation.
  struct Mutation
    include Kubernetes::Serializable

    # applyConfiguration defines the desired configuration values of an object. The configuration is applied to the admission object using [structured merge diff](https://github.com/kubernetes-sigs/structured-merge-diff). A CEL expression is used to create apply configuration.
    @[JSON::Field(key: "applyConfiguration")]
    @[YAML::Field(key: "applyConfiguration")]
    property apply_configuration : ApplyConfiguration?
    # jsonPatch defines a [JSON patch](https://jsonpatch.com/) operation to perform a mutation to the object. A CEL expression is used to create the JSON patch.
    @[JSON::Field(key: "jsonPatch")]
    @[YAML::Field(key: "jsonPatch")]
    property json_patch : JSONPatch?
    # patchType indicates the patch strategy used. Allowed values are "ApplyConfiguration" and "JSONPatch". Required.
    @[JSON::Field(key: "patchType")]
    @[YAML::Field(key: "patchType")]
    property patch_type : String?
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

  # Variable is the definition of a variable that is used for composition. A variable is defined as a named expression.
  struct Variable
    include Kubernetes::Serializable

    # Expression is the expression that will be evaluated as the value of the variable. The CEL expression has access to the same identifiers as the CEL expressions in Validation.
    property expression : String?
    # Name is the name of the variable. The name must be a valid CEL identifier and unique among all variables. The variable can be accessed in other expressions through `variables` For example, if name is "foo", the variable will be available as `variables.foo`
    property name : String?
  end

  # ClusterTrustBundle is a cluster-scoped container for X.509 trust anchors (root certificates).
  # ClusterTrustBundle objects are considered to be readable by any authenticated user in the cluster, because they can be mounted by pods using the `clusterTrustBundle` projection.  All service accounts have read access to ClusterTrustBundles by default.  Users who only have namespace-level access to a cluster can read ClusterTrustBundles by impersonating a serviceaccount that they have access to.
  # It can be optionally associated with a particular assigner, in which case it contains one valid set of trust anchors for that signer. Signers may have multiple associated ClusterTrustBundles; each is an independent set of trust anchors for that signer. Admission control is used to enforce that only users with permissions on the signer can create or modify the corresponding bundle.
  struct ClusterTrustBundle
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # metadata contains the object metadata.
    property metadata : ObjectMeta?
    # spec contains the signer (if any) and trust anchors.
    property spec : ClusterTrustBundleSpec?
  end

  # ClusterTrustBundleList is a collection of ClusterTrustBundle objects
  struct ClusterTrustBundleList
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # items is a collection of ClusterTrustBundle objects
    property items : Array(ClusterTrustBundle)?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # metadata contains the list metadata.
    property metadata : ListMeta?
  end

  # ClusterTrustBundleSpec contains the signer and trust anchors.
  struct ClusterTrustBundleSpec
    include Kubernetes::Serializable

    # signerName indicates the associated signer, if any.
    # In order to create or update a ClusterTrustBundle that sets signerName, you must have the following cluster-scoped permission: group=certificates.k8s.io resource=signers resourceName=<the signer name> verb=attest.
    # If signerName is not empty, then the ClusterTrustBundle object must be named with the signer name as a prefix (translating slashes to colons). For example, for the signer name `example.com/foo`, valid ClusterTrustBundle object names include `example.com:foo:abc` and `example.com:foo:v1`.
    # If signerName is empty, then the ClusterTrustBundle object's name must not have such a prefix.
    # List/watch requests for ClusterTrustBundles can filter on this field using a `spec.signerName=NAME` field selector.
    @[JSON::Field(key: "signerName")]
    @[YAML::Field(key: "signerName")]
    property signer_name : String?
    # trustBundle contains the individual X.509 trust anchors for this bundle, as PEM bundle of PEM-wrapped, DER-formatted X.509 certificates.
    # The data must consist only of PEM certificate blocks that parse as valid X.509 certificates.  Each certificate must include a basic constraints extension with the CA bit set.  The API server will reject objects that contain duplicate certificates, or that use PEM block headers.
    # Users of ClusterTrustBundles, including Kubelet, are free to reorder and deduplicate certificate blocks in this file according to their own logic, as well as to drop PEM block headers and inter-block data.
    @[JSON::Field(key: "trustBundle")]
    @[YAML::Field(key: "trustBundle")]
    property trust_bundle : String?
  end

  # LeaseCandidate defines a candidate for a Lease object. Candidates are created such that coordinated leader election will pick the best leader from the list of candidates.
  struct LeaseCandidate
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
    property spec : LeaseCandidateSpec?
  end

  # LeaseCandidateList is a list of Lease objects.
  struct LeaseCandidateList
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # items is a list of schema objects.
    property items : Array(LeaseCandidate)?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard list metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ListMeta?
  end

  # LeaseCandidateSpec is a specification of a Lease.
  struct LeaseCandidateSpec
    include Kubernetes::Serializable

    # BinaryVersion is the binary version. It must be in a semver format without leading `v`. This field is required.
    @[JSON::Field(key: "binaryVersion")]
    @[YAML::Field(key: "binaryVersion")]
    property binary_version : String?
    # EmulationVersion is the emulation version. It must be in a semver format without leading `v`. EmulationVersion must be less than or equal to BinaryVersion. This field is required when strategy is "OldestEmulationVersion"
    @[JSON::Field(key: "emulationVersion")]
    @[YAML::Field(key: "emulationVersion")]
    property emulation_version : String?
    # LeaseName is the name of the lease for which this candidate is contending. The limits on this field are the same as on Lease.name. Multiple lease candidates may reference the same Lease.name. This field is immutable.
    @[JSON::Field(key: "leaseName")]
    @[YAML::Field(key: "leaseName")]
    property lease_name : String?
    # PingTime is the last time that the server has requested the LeaseCandidate to renew. It is only done during leader election to check if any LeaseCandidates have become ineligible. When PingTime is updated, the LeaseCandidate will respond by updating RenewTime.
    @[JSON::Field(key: "pingTime")]
    @[YAML::Field(key: "pingTime")]
    property ping_time : Time?
    # RenewTime is the time that the LeaseCandidate was last updated. Any time a Lease needs to do leader election, the PingTime field is updated to signal to the LeaseCandidate that they should update the RenewTime. Old LeaseCandidate objects are also garbage collected if it has been hours since the last renew. The PingTime field is updated regularly to prevent garbage collection for still active LeaseCandidates.
    @[JSON::Field(key: "renewTime")]
    @[YAML::Field(key: "renewTime")]
    property renew_time : Time?
    # Strategy is the strategy that coordinated leader election will use for picking the leader. If multiple candidates for the same Lease return different strategies, the strategy provided by the candidate with the latest BinaryVersion will be used. If there is still conflict, this is a user error and coordinated leader election will not operate the Lease until resolved.
    property strategy : String?
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

  # BasicDevice defines one device instance.
  struct BasicDevice
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
    # BindingFailureConditions defines the conditions for binding failure. They may be set in the per-device status conditions. If any is true, a binding failure occurred.
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
    # The maximum number of counters is 32.
    property counters : Hash(String, Counter)?
    # Name defines the name of the counter set. It must be a DNS label.
    property name : String?
  end

  # Device represents one individual hardware instance that can be selected based on its attributes. Besides the name, exactly one field must be set.
  struct Device
    include Kubernetes::Serializable

    # Basic defines one device instance.
    property basic : BasicDevice?
    # Name is unique identifier among all devices managed by the driver in the pool. It must be a DNS label.
    property name : String?
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

  # DeviceRequest is a request for devices required for a claim. This is typically a request for a single resource like a device, but can also ask for several identical devices.
  struct DeviceRequest
    include Kubernetes::Serializable

    # AdminAccess indicates that this is a claim for administrative access to the device(s). Claims with AdminAccess are expected to be used for monitoring or other management services for a device.  They ignore all ordinary claims to the device with respect to access modes and any resource allocations.
    # This field can only be set when deviceClassName is set and no subrequests are specified in the firstAvailable list.
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
    # This field can only be set when deviceClassName is set and no subrequests are specified in the firstAvailable list.
    # More modes may get added in the future. Clients must refuse to handle requests with unknown modes.
    @[JSON::Field(key: "allocationMode")]
    @[YAML::Field(key: "allocationMode")]
    property allocation_mode : String?
    # Capacity define resource requirements against each capacity.
    # If this field is unset and the device supports multiple allocations, the default value will be applied to each capacity according to requestPolicy. For the capacity that has no requestPolicy, default is the full capacity value.
    # Applies to each device allocation. If Count > 1, the request fails if there aren't enough devices that meet the requirements. If AllocationMode is set to All, the request fails if there are devices that otherwise match the request, and have this capacity, with a value >= the requested amount, but which cannot be allocated to this request.
    property capacity : CapacityRequirements?
    # Count is used only when the count mode is "ExactCount". Must be greater than zero. If AllocationMode is ExactCount and this field is not specified, the default is one.
    # This field can only be set when deviceClassName is set and no subrequests are specified in the firstAvailable list.
    property count : Int64?
    # DeviceClassName references a specific DeviceClass, which can define additional configuration and selectors to be inherited by this request.
    # A class is required if no subrequests are specified in the firstAvailable list and no class can be set if subrequests are specified in the firstAvailable list. Which classes are available depends on the cluster.
    # Administrators may use this to restrict which devices may get requested by only installing classes with selectors for permitted devices. If users are free to request anything without restrictions, then administrators can create an empty DeviceClass for users to reference.
    @[JSON::Field(key: "deviceClassName")]
    @[YAML::Field(key: "deviceClassName")]
    property device_class_name : String?
    # FirstAvailable contains subrequests, of which exactly one will be satisfied by the scheduler to satisfy this request. It tries to satisfy them in the order in which they are listed here. So if there are two entries in the list, the scheduler will only check the second one if it determines that the first one cannot be used.
    # This field may only be set in the entries of DeviceClaim.Requests.
    # DRA does not yet implement scoring, so the scheduler will select the first set of devices that satisfies all the requests in the claim. And if the requirements can be satisfied on more than one node, other scheduling features will determine which node is chosen. This means that the set of devices allocated to a claim might not be the optimal set available to the cluster. Scoring will be implemented later.
    @[JSON::Field(key: "firstAvailable")]
    @[YAML::Field(key: "firstAvailable")]
    property first_available : Array(DeviceSubRequest)?
    # Name can be used to reference this request in a pod.spec.containers[].resources.claims entry and in a constraint of the claim.
    # Must be a DNS label and unique among all DeviceRequests in a ResourceClaim.
    property name : String?
    # Selectors define criteria which must be satisfied by a specific device in order for that device to be considered for this request. All selectors must be satisfied for a device to be considered.
    # This field can only be set when deviceClassName is set and no subrequests are specified in the firstAvailable list.
    property selectors : Array(DeviceSelector)?
    # If specified, the request's tolerations.
    # Tolerations for NoSchedule are required to allocate a device which has a taint with that effect. The same applies to NoExecute.
    # In addition, should any of the allocated devices get tainted with NoExecute after allocation and that effect is not tolerated, then all pods consuming the ResourceClaim get deleted to evict them. The scheduler will not let new pods reserve the claim while it has these tainted devices. Once all pods are evicted, the claim will get deallocated.
    # The maximum number of tolerations is 16.
    # This field can only be set when deviceClassName is set and no subrequests are specified in the firstAvailable list.
    # This is an alpha field and requires enabling the DRADeviceTaints feature gate.
    property tolerations : Array(DeviceToleration)?
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
  # DeviceSubRequest is similar to Request, but doesn't expose the AdminAccess or FirstAvailable fields, as those can only be set on the top-level request. AdminAccess is not supported for requests with a prioritized list, and recursive FirstAvailable fields are not supported.
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
    # Must not contain more than 16 entries.
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

  # ResourceClaim describes a request for access to resources in the cluster, for use by workloads. For example, if a workload needs an accelerator device with specific properties, this is how that request is expressed. The status stanza tracks whether this claim has been satisfied and what specific resources have been allocated.
  # This is an alpha type and requires enabling the DynamicResourceAllocation feature gate.
  struct ResourceClaim
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[JSON::Field(key: "apiVersion")]
    @[YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard object metadata
    property metadata : ObjectMeta?
    # Spec describes what is being requested and how to configure it. The spec is immutable.
    property spec : ResourceClaimSpec?
    # Status describes whether the claim is ready to use and what has been allocated.
    property status : ResourceClaimStatus?
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
    # The maximum number of SharedCounters is 32.
    @[JSON::Field(key: "sharedCounters")]
    @[YAML::Field(key: "sharedCounters")]
    property shared_counters : Array(CounterSet)?
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
end
