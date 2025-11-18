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
end
