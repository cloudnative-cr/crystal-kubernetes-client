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
    # observedGeneration represents the .metadata.generation that the condition was set based upon. For instance, if .metadata.generation is currently 12, but the .status.conditions[x].observedGeneration is 9, the condition is out of date with respect to the current state of the instance.
    @[JSON::Field(key: "observedGeneration")]
    @[YAML::Field(key: "observedGeneration")]
    property observed_generation : Int64?
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
    # The generation observed by the CRD controller.
    @[JSON::Field(key: "observedGeneration")]
    @[YAML::Field(key: "observedGeneration")]
    property observed_generation : Int64?
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
    property status : CustomResourceSubresourceStatus?
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
    @[JSON::Field(key: "additionalItems")]
    @[YAML::Field(key: "additionalItems")]
    property additional_items : JSONSchemaPropsOrBool?
    @[JSON::Field(key: "additionalProperties")]
    @[YAML::Field(key: "additionalProperties")]
    property additional_properties : JSONSchemaPropsOrBool?
    @[JSON::Field(key: "allOf")]
    @[YAML::Field(key: "allOf")]
    property all_of : Array(JSONSchemaProps)?
    @[JSON::Field(key: "anyOf")]
    @[YAML::Field(key: "anyOf")]
    property any_of : Array(JSONSchemaProps)?
    # default is a default value for undefined object fields. Defaulting is a beta feature under the CustomResourceDefaulting feature gate. Defaulting requires spec.preserveUnknownFields to be false.
    property default : JSON?
    property definitions : Hash(String, JSONSchemaProps)?
    property dependencies : Hash(String, JSONSchemaPropsOrStringArray)?
    property description : String?
    property enum : Array(JSON)?
    property example : JSON?
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
    property items : JSONSchemaPropsOrArray?
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

  # ServiceReference holds a reference to Service.legacy.k8s.io
  struct ServiceReference
    include Kubernetes::Serializable

    # name is the name of the service. Required
    property name : String?
    # namespace is the namespace of the service. Required
    property namespace : String?
    # path is an optional URL path at which the webhook will be contacted.
    property path : String?
    # port is an optional service port at which the webhook will be contacted. `port` should be a valid port number (1-65535, inclusive). Defaults to 443 for backward compatibility.
    property port : Int32?
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

  # WebhookClientConfig contains the information to make a TLS connection with the webhook.
  struct WebhookClientConfig
    include Kubernetes::Serializable

    # caBundle is a PEM encoded CA bundle which will be used to validate the webhook's server certificate. If unspecified, system trust roots on the apiserver are used.
    @[JSON::Field(key: "caBundle")]
    @[YAML::Field(key: "caBundle")]
    property ca_bundle : String?
    # service is a reference to the service for this webhook. Either service or url must be specified.
    # If the webhook is running within the cluster, then you should use `service`.
    property service : ServiceReference?
    # url gives the location of the webhook, in standard URL form (`scheme://host:port/path`). Exactly one of `url` or `service` must be specified.
    # The `host` should not refer to a service running in the cluster; use the `service` field instead. The host might be resolved via external DNS in some apiservers (e.g., `kube-apiserver` cannot resolve in-cluster DNS as that would be a layering violation). `host` may also be an IP address.
    # Please note that using `localhost` or `127.0.0.1` as a `host` is risky unless you take great care to run this webhook on all hosts which run an apiserver which might need to make calls to this webhook. Such installs are likely to be non-portable, i.e., not easy to turn up in a new cluster.
    # The scheme must be "https"; the URL must begin with "https://".
    # A path is optional, and if present may be any string permissible in a URL. You may use the path to pass an arbitrary string to the webhook, for example, a cluster identifier.
    # Attempting to use a user or basic auth e.g. "user:password@" is not allowed. Fragments ("#...") and query parameters ("?...") are not allowed, either.
    property url : String?
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
end
