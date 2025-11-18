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
  # BoundObjectReference is a reference to an object that a token is bound to.
  struct BoundObjectReference
    include Kubernetes::Serializable

    # API version of the referent.
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
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
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
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
    @[::JSON::Field(key: "userInfo")]
    @[::YAML::Field(key: "userInfo")]
    property user_info : UserInfo?
  end

  # TokenRequest requests a token for a given service account.
  struct TokenRequest
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ObjectMeta?
    # Spec holds information about the request being evaluated
    property spec : TokenRequestSpec?
    # Status is filled in by the server and indicates whether the token can be authenticated.
    property status : TokenRequestStatus?
  end

  # TokenRequestSpec contains client provided parameters of a token request.
  struct TokenRequestSpec
    include Kubernetes::Serializable

    # Audiences are the intendend audiences of the token. A recipient of a token must identify themself with an identifier in the list of audiences of the token, and otherwise should reject the token. A token issued for multiple audiences may be used to authenticate against any of the audiences listed but implies a high degree of trust between the target audiences.
    property audiences : Array(String)?
    # BoundObjectRef is a reference to an object that the token will be bound to. The token will only be valid for as long as the bound object exists. NOTE: The API server's TokenReview endpoint will validate the BoundObjectRef, but other audiences may not. Keep ExpirationSeconds small if you want prompt revocation.
    @[::JSON::Field(key: "boundObjectRef")]
    @[::YAML::Field(key: "boundObjectRef")]
    property bound_object_ref : BoundObjectReference?
    # ExpirationSeconds is the requested duration of validity of the request. The token issuer may return a token with a different validity duration so a client needs to check the 'expiration' field in a response.
    @[::JSON::Field(key: "expirationSeconds")]
    @[::YAML::Field(key: "expirationSeconds")]
    property expiration_seconds : Int64?
  end

  # TokenRequestStatus is the result of a token request.
  struct TokenRequestStatus
    include Kubernetes::Serializable

    # ExpirationTimestamp is the time of expiration of the returned token.
    @[::JSON::Field(key: "expirationTimestamp")]
    @[::YAML::Field(key: "expirationTimestamp")]
    property expiration_timestamp : Time?
    # Token is the opaque bearer token.
    property token : String?
  end

  # TokenReview attempts to authenticate a token to a known user. Note: TokenReview requests may be cached by the webhook token authenticator plugin in the kube-apiserver.
  struct TokenReview
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
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
end
