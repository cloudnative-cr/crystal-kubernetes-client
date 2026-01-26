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
  # Represents a Persistent Disk resource in AWS.
  # An AWS EBS disk must exist before mounting to a container. The disk must also be in the same AWS zone as the kubelet. An AWS EBS disk can only be mounted as read/write once. AWS EBS volumes support ownership management and SELinux relabeling.
  struct AWSElasticBlockStoreVolumeSource
    include Kubernetes::Serializable

    # fsType is the filesystem type of the volume that you want to mount. Tip: Ensure that the filesystem type is supported by the host operating system. Examples: "ext4", "xfs", "ntfs". Implicitly inferred to be "ext4" if unspecified. More info: https://kubernetes.io/docs/concepts/storage/volumes#awselasticblockstore
    @[::JSON::Field(key: "fsType")]
    @[::YAML::Field(key: "fsType")]
    property fs_type : String?
    # partition is the partition in the volume that you want to mount. If omitted, the default is to mount by volume name. Examples: For volume /dev/sda1, you specify the partition as "1". Similarly, the volume partition for /dev/sda is "0" (or you can leave the property empty).
    property partition : Int32?
    # readOnly value true will force the readOnly setting in VolumeMounts. More info: https://kubernetes.io/docs/concepts/storage/volumes#awselasticblockstore
    @[::JSON::Field(key: "readOnly")]
    @[::YAML::Field(key: "readOnly")]
    property read_only : Bool?
    # volumeID is unique ID of the persistent disk resource in AWS (Amazon EBS volume). More info: https://kubernetes.io/docs/concepts/storage/volumes#awselasticblockstore
    @[::JSON::Field(key: "volumeID")]
    @[::YAML::Field(key: "volumeID")]
    property volume_id : String?
  end

  # Affinity is a group of affinity scheduling rules.
  struct Affinity
    include Kubernetes::Serializable

    # Describes node affinity scheduling rules for the pod.
    @[::JSON::Field(key: "nodeAffinity")]
    @[::YAML::Field(key: "nodeAffinity")]
    property node_affinity : NodeAffinity?
    # Describes pod affinity scheduling rules (e.g. co-locate this pod in the same node, zone, etc. as some other pod(s)).
    @[::JSON::Field(key: "podAffinity")]
    @[::YAML::Field(key: "podAffinity")]
    property pod_affinity : PodAffinity?
    # Describes pod anti-affinity scheduling rules (e.g. avoid putting this pod in the same node, zone, etc. as some other pod(s)).
    @[::JSON::Field(key: "podAntiAffinity")]
    @[::YAML::Field(key: "podAntiAffinity")]
    property pod_anti_affinity : PodAntiAffinity?
  end

  # AppArmorProfile defines a pod or container's AppArmor settings.
  struct AppArmorProfile
    include Kubernetes::Serializable

    # localhostProfile indicates a profile loaded on the node that should be used. The profile must be preconfigured on the node to work. Must match the loaded name of the profile. Must be set if and only if type is "Localhost".
    @[::JSON::Field(key: "localhostProfile")]
    @[::YAML::Field(key: "localhostProfile")]
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
    @[::JSON::Field(key: "devicePath")]
    @[::YAML::Field(key: "devicePath")]
    property device_path : String?
    # Name of the attached volume
    property name : String?
  end

  # AzureDisk represents an Azure Data Disk mount on the host and bind mount to the pod.
  struct AzureDiskVolumeSource
    include Kubernetes::Serializable

    # cachingMode is the Host Caching mode: None, Read Only, Read Write.
    @[::JSON::Field(key: "cachingMode")]
    @[::YAML::Field(key: "cachingMode")]
    property caching_mode : String?
    # diskName is the Name of the data disk in the blob storage
    @[::JSON::Field(key: "diskName")]
    @[::YAML::Field(key: "diskName")]
    property disk_name : String?
    # diskURI is the URI of data disk in the blob storage
    @[::JSON::Field(key: "diskURI")]
    @[::YAML::Field(key: "diskURI")]
    property disk_uri : String?
    # fsType is Filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. "ext4", "xfs", "ntfs". Implicitly inferred to be "ext4" if unspecified.
    @[::JSON::Field(key: "fsType")]
    @[::YAML::Field(key: "fsType")]
    property fs_type : String?
    # kind expected values are Shared: multiple blob disks per storage account  Dedicated: single blob disk per storage account  Managed: azure managed data disk (only in managed availability set). defaults to shared
    property kind : String?
    # readOnly Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts.
    @[::JSON::Field(key: "readOnly")]
    @[::YAML::Field(key: "readOnly")]
    property read_only : Bool?
  end

  # AzureFile represents an Azure File Service mount on the host and bind mount to the pod.
  struct AzureFilePersistentVolumeSource
    include Kubernetes::Serializable

    # readOnly defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts.
    @[::JSON::Field(key: "readOnly")]
    @[::YAML::Field(key: "readOnly")]
    property read_only : Bool?
    # secretName is the name of secret that contains Azure Storage Account Name and Key
    @[::JSON::Field(key: "secretName")]
    @[::YAML::Field(key: "secretName")]
    property secret_name : String?
    # secretNamespace is the namespace of the secret that contains Azure Storage Account Name and Key default is the same as the Pod
    @[::JSON::Field(key: "secretNamespace")]
    @[::YAML::Field(key: "secretNamespace")]
    property secret_namespace : String?
    # shareName is the azure Share Name
    @[::JSON::Field(key: "shareName")]
    @[::YAML::Field(key: "shareName")]
    property share_name : String?
  end

  # AzureFile represents an Azure File Service mount on the host and bind mount to the pod.
  struct AzureFileVolumeSource
    include Kubernetes::Serializable

    # readOnly defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts.
    @[::JSON::Field(key: "readOnly")]
    @[::YAML::Field(key: "readOnly")]
    property read_only : Bool?
    # secretName is the  name of secret that contains Azure Storage Account Name and Key
    @[::JSON::Field(key: "secretName")]
    @[::YAML::Field(key: "secretName")]
    property secret_name : String?
    # shareName is the azure share Name
    @[::JSON::Field(key: "shareName")]
    @[::YAML::Field(key: "shareName")]
    property share_name : String?
  end

  # Binding ties one object to another; for example, a pod is bound to a node by a scheduler.
  struct Binding
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
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
    @[::JSON::Field(key: "controllerExpandSecretRef")]
    @[::YAML::Field(key: "controllerExpandSecretRef")]
    property controller_expand_secret_ref : SecretReference?
    # controllerPublishSecretRef is a reference to the secret object containing sensitive information to pass to the CSI driver to complete the CSI ControllerPublishVolume and ControllerUnpublishVolume calls. This field is optional, and may be empty if no secret is required. If the secret object contains more than one secret, all secrets are passed.
    @[::JSON::Field(key: "controllerPublishSecretRef")]
    @[::YAML::Field(key: "controllerPublishSecretRef")]
    property controller_publish_secret_ref : SecretReference?
    # driver is the name of the driver to use for this volume. Required.
    property driver : String?
    # fsType to mount. Must be a filesystem type supported by the host operating system. Ex. "ext4", "xfs", "ntfs".
    @[::JSON::Field(key: "fsType")]
    @[::YAML::Field(key: "fsType")]
    property fs_type : String?
    # nodeExpandSecretRef is a reference to the secret object containing sensitive information to pass to the CSI driver to complete the CSI NodeExpandVolume call. This field is optional, may be omitted if no secret is required. If the secret object contains more than one secret, all secrets are passed.
    @[::JSON::Field(key: "nodeExpandSecretRef")]
    @[::YAML::Field(key: "nodeExpandSecretRef")]
    property node_expand_secret_ref : SecretReference?
    # nodePublishSecretRef is a reference to the secret object containing sensitive information to pass to the CSI driver to complete the CSI NodePublishVolume and NodeUnpublishVolume calls. This field is optional, and may be empty if no secret is required. If the secret object contains more than one secret, all secrets are passed.
    @[::JSON::Field(key: "nodePublishSecretRef")]
    @[::YAML::Field(key: "nodePublishSecretRef")]
    property node_publish_secret_ref : SecretReference?
    # nodeStageSecretRef is a reference to the secret object containing sensitive information to pass to the CSI driver to complete the CSI NodeStageVolume and NodeStageVolume and NodeUnstageVolume calls. This field is optional, and may be empty if no secret is required. If the secret object contains more than one secret, all secrets are passed.
    @[::JSON::Field(key: "nodeStageSecretRef")]
    @[::YAML::Field(key: "nodeStageSecretRef")]
    property node_stage_secret_ref : SecretReference?
    # readOnly value to pass to ControllerPublishVolumeRequest. Defaults to false (read/write).
    @[::JSON::Field(key: "readOnly")]
    @[::YAML::Field(key: "readOnly")]
    property read_only : Bool?
    # volumeAttributes of the volume to publish.
    @[::JSON::Field(key: "volumeAttributes")]
    @[::YAML::Field(key: "volumeAttributes")]
    property volume_attributes : Hash(String, String)?
    # volumeHandle is the unique volume name returned by the CSI volume plugin’s CreateVolume to refer to the volume on all subsequent calls. Required.
    @[::JSON::Field(key: "volumeHandle")]
    @[::YAML::Field(key: "volumeHandle")]
    property volume_handle : String?
  end

  # Represents a source location of a volume to mount, managed by an external CSI driver
  struct CSIVolumeSource
    include Kubernetes::Serializable

    # driver is the name of the CSI driver that handles this volume. Consult with your admin for the correct name as registered in the cluster.
    property driver : String?
    # fsType to mount. Ex. "ext4", "xfs", "ntfs". If not provided, the empty value is passed to the associated CSI driver which will determine the default filesystem to apply.
    @[::JSON::Field(key: "fsType")]
    @[::YAML::Field(key: "fsType")]
    property fs_type : String?
    # nodePublishSecretRef is a reference to the secret object containing sensitive information to pass to the CSI driver to complete the CSI NodePublishVolume and NodeUnpublishVolume calls. This field is optional, and  may be empty if no secret is required. If the secret object contains more than one secret, all secret references are passed.
    @[::JSON::Field(key: "nodePublishSecretRef")]
    @[::YAML::Field(key: "nodePublishSecretRef")]
    property node_publish_secret_ref : LocalObjectReference?
    # readOnly specifies a read-only configuration for the volume. Defaults to false (read/write).
    @[::JSON::Field(key: "readOnly")]
    @[::YAML::Field(key: "readOnly")]
    property read_only : Bool?
    # volumeAttributes stores driver-specific properties that are passed to the CSI driver. Consult your driver's documentation for supported values.
    @[::JSON::Field(key: "volumeAttributes")]
    @[::YAML::Field(key: "volumeAttributes")]
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
    @[::JSON::Field(key: "readOnly")]
    @[::YAML::Field(key: "readOnly")]
    property read_only : Bool?
    # secretFile is Optional: SecretFile is the path to key ring for User, default is /etc/ceph/user.secret More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it
    @[::JSON::Field(key: "secretFile")]
    @[::YAML::Field(key: "secretFile")]
    property secret_file : String?
    # secretRef is Optional: SecretRef is reference to the authentication secret for User, default is empty. More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it
    @[::JSON::Field(key: "secretRef")]
    @[::YAML::Field(key: "secretRef")]
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
    @[::JSON::Field(key: "readOnly")]
    @[::YAML::Field(key: "readOnly")]
    property read_only : Bool?
    # secretFile is Optional: SecretFile is the path to key ring for User, default is /etc/ceph/user.secret More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it
    @[::JSON::Field(key: "secretFile")]
    @[::YAML::Field(key: "secretFile")]
    property secret_file : String?
    # secretRef is Optional: SecretRef is reference to the authentication secret for User, default is empty. More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it
    @[::JSON::Field(key: "secretRef")]
    @[::YAML::Field(key: "secretRef")]
    property secret_ref : LocalObjectReference?
    # user is optional: User is the rados user name, default is admin More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it
    property user : String?
  end

  # Represents a cinder volume resource in Openstack. A Cinder volume must exist before mounting to a container. The volume must also be in the same region as the kubelet. Cinder volumes support ownership management and SELinux relabeling.
  struct CinderPersistentVolumeSource
    include Kubernetes::Serializable

    # fsType Filesystem type to mount. Must be a filesystem type supported by the host operating system. Examples: "ext4", "xfs", "ntfs". Implicitly inferred to be "ext4" if unspecified. More info: https://examples.k8s.io/mysql-cinder-pd/README.md
    @[::JSON::Field(key: "fsType")]
    @[::YAML::Field(key: "fsType")]
    property fs_type : String?
    # readOnly is Optional: Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts. More info: https://examples.k8s.io/mysql-cinder-pd/README.md
    @[::JSON::Field(key: "readOnly")]
    @[::YAML::Field(key: "readOnly")]
    property read_only : Bool?
    # secretRef is Optional: points to a secret object containing parameters used to connect to OpenStack.
    @[::JSON::Field(key: "secretRef")]
    @[::YAML::Field(key: "secretRef")]
    property secret_ref : SecretReference?
    # volumeID used to identify the volume in cinder. More info: https://examples.k8s.io/mysql-cinder-pd/README.md
    @[::JSON::Field(key: "volumeID")]
    @[::YAML::Field(key: "volumeID")]
    property volume_id : String?
  end

  # Represents a cinder volume resource in Openstack. A Cinder volume must exist before mounting to a container. The volume must also be in the same region as the kubelet. Cinder volumes support ownership management and SELinux relabeling.
  struct CinderVolumeSource
    include Kubernetes::Serializable

    # fsType is the filesystem type to mount. Must be a filesystem type supported by the host operating system. Examples: "ext4", "xfs", "ntfs". Implicitly inferred to be "ext4" if unspecified. More info: https://examples.k8s.io/mysql-cinder-pd/README.md
    @[::JSON::Field(key: "fsType")]
    @[::YAML::Field(key: "fsType")]
    property fs_type : String?
    # readOnly defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts. More info: https://examples.k8s.io/mysql-cinder-pd/README.md
    @[::JSON::Field(key: "readOnly")]
    @[::YAML::Field(key: "readOnly")]
    property read_only : Bool?
    # secretRef is optional: points to a secret object containing parameters used to connect to OpenStack.
    @[::JSON::Field(key: "secretRef")]
    @[::YAML::Field(key: "secretRef")]
    property secret_ref : LocalObjectReference?
    # volumeID used to identify the volume in cinder. More info: https://examples.k8s.io/mysql-cinder-pd/README.md
    @[::JSON::Field(key: "volumeID")]
    @[::YAML::Field(key: "volumeID")]
    property volume_id : String?
  end

  # ClientIPConfig represents the configurations of Client IP based session affinity.
  struct ClientIPConfig
    include Kubernetes::Serializable

    # timeoutSeconds specifies the seconds of ClientIP type session sticky time. The value must be >0 && <=86400(for 1 day) if ServiceAffinity == "ClientIP". Default value is 10800(for 3 hours).
    @[::JSON::Field(key: "timeoutSeconds")]
    @[::YAML::Field(key: "timeoutSeconds")]
    property timeout_seconds : Int32?
  end

  # ClusterTrustBundleProjection describes how to select a set of ClusterTrustBundle objects and project their contents into the pod filesystem.
  struct ClusterTrustBundleProjection
    include Kubernetes::Serializable

    # Select all ClusterTrustBundles that match this label selector.  Only has effect if signerName is set.  Mutually-exclusive with name.  If unset, interpreted as "match nothing".  If set but empty, interpreted as "match everything".
    @[::JSON::Field(key: "labelSelector")]
    @[::YAML::Field(key: "labelSelector")]
    property label_selector : LabelSelector?
    # Select a single ClusterTrustBundle by object name.  Mutually-exclusive with signerName and labelSelector.
    property name : String?
    # If true, don't block pod startup if the referenced ClusterTrustBundle(s) aren't available.  If using name, then the named ClusterTrustBundle is allowed not to exist.  If using signerName, then the combination of signerName and labelSelector is allowed to match zero ClusterTrustBundles.
    property optional : Bool?
    # Relative path from the volume root to write the bundle.
    property path : String?
    # Select all ClusterTrustBundles that match this signer name. Mutually-exclusive with name.  The contents of all selected ClusterTrustBundles will be unified and deduplicated.
    @[::JSON::Field(key: "signerName")]
    @[::YAML::Field(key: "signerName")]
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
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
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
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
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
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
    property api_version : String?
    # BinaryData contains the binary data. Each key must consist of alphanumeric characters, '-', '_' or '.'. BinaryData can contain byte sequences that are not in the UTF-8 range. The keys stored in BinaryData must not overlap with the ones in the Data field, this is enforced during validation process. Using this field will require 1.10+ apiserver and kubelet.
    @[::JSON::Field(key: "binaryData")]
    @[::YAML::Field(key: "binaryData")]
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
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
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
    @[::JSON::Field(key: "kubeletConfigKey")]
    @[::YAML::Field(key: "kubeletConfigKey")]
    property kubelet_config_key : String?
    # Name is the metadata.name of the referenced ConfigMap. This field is required in all cases.
    property name : String?
    # Namespace is the metadata.namespace of the referenced ConfigMap. This field is required in all cases.
    property namespace : String?
    # ResourceVersion is the metadata.ResourceVersion of the referenced ConfigMap. This field is forbidden in Node.Spec, and required in Node.Status.
    @[::JSON::Field(key: "resourceVersion")]
    @[::YAML::Field(key: "resourceVersion")]
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
    @[::JSON::Field(key: "defaultMode")]
    @[::YAML::Field(key: "defaultMode")]
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
    @[::JSON::Field(key: "envFrom")]
    @[::YAML::Field(key: "envFrom")]
    property env_from : Array(EnvFromSource)?
    # Container image name. More info: https://kubernetes.io/docs/concepts/containers/images This field is optional to allow higher level config management to default or override container images in workload controllers like Deployments and StatefulSets.
    property image : String?
    # Image pull policy. One of Always, Never, IfNotPresent. Defaults to Always if :latest tag is specified, or IfNotPresent otherwise. Cannot be updated. More info: https://kubernetes.io/docs/concepts/containers/images#updating-images
    @[::JSON::Field(key: "imagePullPolicy")]
    @[::YAML::Field(key: "imagePullPolicy")]
    property image_pull_policy : String?
    # Actions that the management system should take in response to container lifecycle events. Cannot be updated.
    property lifecycle : Lifecycle?
    # Periodic probe of container liveness. Container will be restarted if the probe fails. Cannot be updated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
    @[::JSON::Field(key: "livenessProbe")]
    @[::YAML::Field(key: "livenessProbe")]
    property liveness_probe : Probe?
    # Name of the container specified as a DNS_LABEL. Each container in a pod must have a unique name (DNS_LABEL). Cannot be updated.
    property name : String?
    # List of ports to expose from the container. Not specifying a port here DOES NOT prevent that port from being exposed. Any port which is listening on the default "0.0.0.0" address inside a container will be accessible from the network. Modifying this array with strategic merge patch may corrupt the data. For more information See https://github.com/kubernetes/kubernetes/issues/108255. Cannot be updated.
    property ports : Array(ContainerPort)?
    # Periodic probe of container service readiness. Container will be removed from service endpoints if the probe fails. Cannot be updated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
    @[::JSON::Field(key: "readinessProbe")]
    @[::YAML::Field(key: "readinessProbe")]
    property readiness_probe : Probe?
    # Resources resize policy for the container. This field cannot be set on ephemeral containers.
    @[::JSON::Field(key: "resizePolicy")]
    @[::YAML::Field(key: "resizePolicy")]
    property resize_policy : Array(ContainerResizePolicy)?
    # Compute Resources required by this container. Cannot be updated. More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
    property resources : ResourceRequirements?
    # RestartPolicy defines the restart behavior of individual containers in a pod. This overrides the pod-level restart policy. When this field is not specified, the restart behavior is defined by the Pod's restart policy and the container type. Additionally, setting the RestartPolicy as "Always" for the init container will have the following effect: this init container will be continually restarted on exit until all regular containers have terminated. Once all regular containers have completed, all init containers with restartPolicy "Always" will be shut down. This lifecycle differs from normal init containers and is often referred to as a "sidecar" container. Although this init container still starts in the init container sequence, it does not wait for the container to complete before proceeding to the next init container. Instead, the next init container starts immediately after this init container is started, or after any startupProbe has successfully completed.
    @[::JSON::Field(key: "restartPolicy")]
    @[::YAML::Field(key: "restartPolicy")]
    property restart_policy : String?
    # Represents a list of rules to be checked to determine if the container should be restarted on exit. The rules are evaluated in order. Once a rule matches a container exit condition, the remaining rules are ignored. If no rule matches the container exit condition, the Container-level restart policy determines the whether the container is restarted or not. Constraints on the rules: - At most 20 rules are allowed. - Rules can have the same action. - Identical rules are not forbidden in validations. When rules are specified, container MUST set RestartPolicy explicitly even it if matches the Pod's RestartPolicy.
    @[::JSON::Field(key: "restartPolicyRules")]
    @[::YAML::Field(key: "restartPolicyRules")]
    property restart_policy_rules : Array(ContainerRestartRule)?
    # SecurityContext defines the security options the container should be run with. If set, the fields of SecurityContext override the equivalent fields of PodSecurityContext. More info: https://kubernetes.io/docs/tasks/configure-pod-container/security-context/
    @[::JSON::Field(key: "securityContext")]
    @[::YAML::Field(key: "securityContext")]
    property security_context : SecurityContext?
    # StartupProbe indicates that the Pod has successfully initialized. If specified, no other probes are executed until this completes successfully. If this probe fails, the Pod will be restarted, just as if the livenessProbe failed. This can be used to provide different probe parameters at the beginning of a Pod's lifecycle, when it might take a long time to load data or warm a cache, than during steady-state operation. This cannot be updated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
    @[::JSON::Field(key: "startupProbe")]
    @[::YAML::Field(key: "startupProbe")]
    property startup_probe : Probe?
    # Whether this container should allocate a buffer for stdin in the container runtime. If this is not set, reads from stdin in the container will always result in EOF. Default is false.
    property stdin : Bool?
    # Whether the container runtime should close the stdin channel after it has been opened by a single attach. When stdin is true the stdin stream will remain open across multiple attach sessions. If stdinOnce is set to true, stdin is opened on container start, is empty until the first client attaches to stdin, and then remains open and accepts data until the client disconnects, at which time stdin is closed and remains closed until the container is restarted. If this flag is false, a container processes that reads from stdin will never receive an EOF. Default is false
    @[::JSON::Field(key: "stdinOnce")]
    @[::YAML::Field(key: "stdinOnce")]
    property stdin_once : Bool?
    # Optional: Path at which the file to which the container's termination message will be written is mounted into the container's filesystem. Message written is intended to be brief final status, such as an assertion failure message. Will be truncated by the node if greater than 4096 bytes. The total message length across all containers will be limited to 12kb. Defaults to /dev/termination-log. Cannot be updated.
    @[::JSON::Field(key: "terminationMessagePath")]
    @[::YAML::Field(key: "terminationMessagePath")]
    property termination_message_path : String?
    # Indicate how the termination message should be populated. File will use the contents of terminationMessagePath to populate the container status message on both success and failure. FallbackToLogsOnError will use the last chunk of container log output if the termination message file is empty and the container exited with an error. The log output is limited to 2048 bytes or 80 lines, whichever is smaller. Defaults to File. Cannot be updated.
    @[::JSON::Field(key: "terminationMessagePolicy")]
    @[::YAML::Field(key: "terminationMessagePolicy")]
    property termination_message_policy : String?
    # Whether this container should allocate a TTY for itself, also requires 'stdin' to be true. Default is false.
    property tty : Bool?
    # volumeDevices is the list of block devices to be used by the container.
    @[::JSON::Field(key: "volumeDevices")]
    @[::YAML::Field(key: "volumeDevices")]
    property volume_devices : Array(VolumeDevice)?
    # Pod volumes to mount into the container's filesystem. Cannot be updated.
    @[::JSON::Field(key: "volumeMounts")]
    @[::YAML::Field(key: "volumeMounts")]
    property volume_mounts : Array(VolumeMount)?
    # Container's working directory. If not specified, the container runtime's default will be used, which might be configured in the container image. Cannot be updated.
    @[::JSON::Field(key: "workingDir")]
    @[::YAML::Field(key: "workingDir")]
    property working_dir : String?
  end

  # ContainerExtendedResourceRequest has the mapping of container name, extended resource name to the device request name.
  struct ContainerExtendedResourceRequest
    include Kubernetes::Serializable

    # The name of the container requesting resources.
    @[::JSON::Field(key: "containerName")]
    @[::YAML::Field(key: "containerName")]
    property container_name : String?
    # The name of the request in the special ResourceClaim which corresponds to the extended resource.
    @[::JSON::Field(key: "requestName")]
    @[::YAML::Field(key: "requestName")]
    property request_name : String?
    # The name of the extended resource in that container which gets backed by DRA.
    @[::JSON::Field(key: "resourceName")]
    @[::YAML::Field(key: "resourceName")]
    property resource_name : String?
  end

  # Describe a container image
  struct ContainerImage
    include Kubernetes::Serializable

    # Names by which this image is known. e.g. ["kubernetes.example/hyperkube:v1.0.7", "cloud-vendor.registry.example/cloud-vendor/hyperkube:v1.0.7"]
    property names : Array(String)?
    # The size of the image in bytes.
    @[::JSON::Field(key: "sizeBytes")]
    @[::YAML::Field(key: "sizeBytes")]
    property size_bytes : Int64?
  end

  # ContainerPort represents a network port in a single container.
  struct ContainerPort
    include Kubernetes::Serializable

    # Number of port to expose on the pod's IP address. This must be a valid port number, 0 < x < 65536.
    @[::JSON::Field(key: "containerPort")]
    @[::YAML::Field(key: "containerPort")]
    property container_port : Int32?
    # What host IP to bind the external port to.
    @[::JSON::Field(key: "hostIP")]
    @[::YAML::Field(key: "hostIP")]
    property host_ip : String?
    # Number of port to expose on the host. If specified, this must be a valid port number, 0 < x < 65536. If HostNetwork is specified, this must match ContainerPort. Most containers do not need this.
    @[::JSON::Field(key: "hostPort")]
    @[::YAML::Field(key: "hostPort")]
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
    @[::JSON::Field(key: "resourceName")]
    @[::YAML::Field(key: "resourceName")]
    property resource_name : String?
    # Restart policy to apply when specified resource is resized. If not specified, it defaults to NotRequired.
    @[::JSON::Field(key: "restartPolicy")]
    @[::YAML::Field(key: "restartPolicy")]
    property restart_policy : String?
  end

  # ContainerRestartRule describes how a container exit is handled.
  struct ContainerRestartRule
    include Kubernetes::Serializable

    # Specifies the action taken on a container exit if the requirements are satisfied. The only possible value is "Restart" to restart the container.
    property action : String?
    # Represents the exit codes to check on container exits.
    @[::JSON::Field(key: "exitCodes")]
    @[::YAML::Field(key: "exitCodes")]
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
    @[::JSON::Field(key: "startedAt")]
    @[::YAML::Field(key: "startedAt")]
    property started_at : Time?
  end

  # ContainerStateTerminated is a terminated state of a container.
  struct ContainerStateTerminated
    include Kubernetes::Serializable

    # Container's ID in the format '<type>://<container_id>'
    @[::JSON::Field(key: "containerID")]
    @[::YAML::Field(key: "containerID")]
    property container_id : String?
    # Exit status from the last termination of the container
    @[::JSON::Field(key: "exitCode")]
    @[::YAML::Field(key: "exitCode")]
    property exit_code : Int32?
    # Time at which the container last terminated
    @[::JSON::Field(key: "finishedAt")]
    @[::YAML::Field(key: "finishedAt")]
    property finished_at : Time?
    # Message regarding the last termination of the container
    property message : String?
    # (brief) reason from the last termination of the container
    property reason : String?
    # Signal from the last termination of the container
    property signal : Int32?
    # Time at which previous execution of the container started
    @[::JSON::Field(key: "startedAt")]
    @[::YAML::Field(key: "startedAt")]
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
    @[::JSON::Field(key: "allocatedResources")]
    @[::YAML::Field(key: "allocatedResources")]
    property allocated_resources : Hash(String, Quantity)?
    # AllocatedResourcesStatus represents the status of various resources allocated for this Pod.
    @[::JSON::Field(key: "allocatedResourcesStatus")]
    @[::YAML::Field(key: "allocatedResourcesStatus")]
    property allocated_resources_status : Array(ResourceStatus)?
    # ContainerID is the ID of the container in the format '<type>://<container_id>'. Where type is a container runtime identifier, returned from Version call of CRI API (for example "containerd").
    @[::JSON::Field(key: "containerID")]
    @[::YAML::Field(key: "containerID")]
    property container_id : String?
    # Image is the name of container image that the container is running. The container image may not match the image used in the PodSpec, as it may have been resolved by the runtime. More info: https://kubernetes.io/docs/concepts/containers/images.
    property image : String?
    # ImageID is the image ID of the container's image. The image ID may not match the image ID of the image used in the PodSpec, as it may have been resolved by the runtime.
    @[::JSON::Field(key: "imageID")]
    @[::YAML::Field(key: "imageID")]
    property image_id : String?
    # LastTerminationState holds the last termination state of the container to help debug container crashes and restarts. This field is not populated if the container is still running and RestartCount is 0.
    @[::JSON::Field(key: "lastState")]
    @[::YAML::Field(key: "lastState")]
    property last_state : ContainerState?
    # Name is a DNS_LABEL representing the unique name of the container. Each container in a pod must have a unique name across all container types. Cannot be updated.
    property name : String?
    # Ready specifies whether the container is currently passing its readiness check. The value will change as readiness probes keep executing. If no readiness probes are specified, this field defaults to true once the container is fully started (see Started field).
    # The value is typically used to determine whether a container is ready to accept traffic.
    property ready : Bool?
    # Resources represents the compute resource requests and limits that have been successfully enacted on the running container after it has been started or has been successfully resized.
    property resources : ResourceRequirements?
    # RestartCount holds the number of times the container has been restarted. Kubelet makes an effort to always increment the value, but there are cases when the state may be lost due to node restarts and then the value may be reset to 0. The value is never negative.
    @[::JSON::Field(key: "restartCount")]
    @[::YAML::Field(key: "restartCount")]
    property restart_count : Int32?
    # Started indicates whether the container has finished its postStart lifecycle hook and passed its startup probe. Initialized as false, becomes true after startupProbe is considered successful. Resets to false when the container is restarted, or if kubelet loses state temporarily. In both cases, startup probes will run again. Is always true when no startupProbe is defined and container is running and has passed the postStart lifecycle hook. The null value must be treated the same as false.
    property started : Bool?
    # State holds details about the container's current condition.
    property state : ContainerState?
    # StopSignal reports the effective stop signal for this container
    @[::JSON::Field(key: "stopSignal")]
    @[::YAML::Field(key: "stopSignal")]
    property stop_signal : String?
    # User represents user identity information initially attached to the first process of the container
    property user : ContainerUser?
    # Status of volume mounts.
    @[::JSON::Field(key: "volumeMounts")]
    @[::YAML::Field(key: "volumeMounts")]
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
    @[::JSON::Field(key: "Port")]
    @[::YAML::Field(key: "Port")]
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
    @[::JSON::Field(key: "fieldRef")]
    @[::YAML::Field(key: "fieldRef")]
    property field_ref : ObjectFieldSelector?
    # Optional: mode bits used to set permissions on this file, must be an octal value between 0000 and 0777 or a decimal value between 0 and 511. YAML accepts both octal and decimal values, JSON requires decimal values for mode bits. If not specified, the volume defaultMode will be used. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set.
    property mode : Int32?
    # Required: Path is  the relative path name of the file to be created. Must not be absolute or contain the '..' path. Must be utf-8 encoded. The first item of the relative path must not start with '..'
    property path : String?
    # Selects a resource of the container: only resources limits and requests (limits.cpu, limits.memory, requests.cpu and requests.memory) are currently supported.
    @[::JSON::Field(key: "resourceFieldRef")]
    @[::YAML::Field(key: "resourceFieldRef")]
    property resource_field_ref : ResourceFieldSelector?
  end

  # DownwardAPIVolumeSource represents a volume containing downward API info. Downward API volumes support ownership management and SELinux relabeling.
  struct DownwardAPIVolumeSource
    include Kubernetes::Serializable

    # Optional: mode bits to use on created files by default. Must be a Optional: mode bits used to set permissions on created files by default. Must be an octal value between 0000 and 0777 or a decimal value between 0 and 511. YAML accepts both octal and decimal values, JSON requires decimal values for mode bits. Defaults to 0644. Directories within the path are not affected by this setting. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set.
    @[::JSON::Field(key: "defaultMode")]
    @[::YAML::Field(key: "defaultMode")]
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
    @[::JSON::Field(key: "sizeLimit")]
    @[::YAML::Field(key: "sizeLimit")]
    property size_limit : Quantity?
  end

  # EndpointAddress is a tuple that describes single IP address. Deprecated: This API is deprecated in v1.33+.
  struct EndpointAddress
    include Kubernetes::Serializable

    # The Hostname of this endpoint
    property hostname : String?
    # The IP of this endpoint. May not be loopback (127.0.0.0/8 or ::1), link-local (169.254.0.0/16 or fe80::/10), or link-local multicast (224.0.0.0/24 or ff02::/16).
    property ip : String?
    # Optional: Node hosting this endpoint. This can be used to determine endpoints local to a node.
    @[::JSON::Field(key: "nodeName")]
    @[::YAML::Field(key: "nodeName")]
    property node_name : String?
    # Reference to object providing the endpoint.
    @[::JSON::Field(key: "targetRef")]
    @[::YAML::Field(key: "targetRef")]
    property target_ref : ObjectReference?
  end

  # EndpointPort is a tuple that describes a single port. Deprecated: This API is deprecated in v1.33+.
  struct EndpointPort
    include Kubernetes::Serializable

    # The application protocol for this port. This is used as a hint for implementations to offer richer behavior for protocols that they understand. This field follows standard Kubernetes label syntax. Valid values are either:
    # * Un-prefixed protocol names - reserved for IANA standard service names (as per RFC-6335 and https://www.iana.org/assignments/service-names).
    # * Kubernetes-defined prefixed names:
    # * 'kubernetes.io/h2c' - HTTP/2 prior knowledge over cleartext as described in https://www.rfc-editor.org/rfc/rfc9113.html#name-starting-http-2-with-prior-
    # * 'kubernetes.io/ws'  - WebSocket over cleartext as described in https://www.rfc-editor.org/rfc/rfc6455
    # * 'kubernetes.io/wss' - WebSocket over TLS as described in https://www.rfc-editor.org/rfc/rfc6455
    # * Other protocols should use implementation-defined prefixed names such as mycompany.com/my-custom-protocol.
    @[::JSON::Field(key: "appProtocol")]
    @[::YAML::Field(key: "appProtocol")]
    property app_protocol : String?
    # The name of this port.  This must match the 'name' field in the corresponding ServicePort. Must be a DNS_LABEL. Optional only if one port is defined.
    property name : String?
    # The port number of the endpoint.
    property port : Int32?
    # The IP protocol for this port. Must be UDP, TCP, or SCTP. Default is TCP.
    property protocol : String?
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
    @[::JSON::Field(key: "notReadyAddresses")]
    @[::YAML::Field(key: "notReadyAddresses")]
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
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
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
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
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
    @[::JSON::Field(key: "configMapRef")]
    @[::YAML::Field(key: "configMapRef")]
    property config_map_ref : ConfigMapEnvSource?
    # Optional text to prepend to the name of each environment variable. May consist of any printable ASCII characters except '='.
    property prefix : String?
    # The Secret to select from
    @[::JSON::Field(key: "secretRef")]
    @[::YAML::Field(key: "secretRef")]
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
    @[::JSON::Field(key: "valueFrom")]
    @[::YAML::Field(key: "valueFrom")]
    property value_from : EnvVarSource?
  end

  # EnvVarSource represents a source for the value of an EnvVar.
  struct EnvVarSource
    include Kubernetes::Serializable

    # Selects a key of a ConfigMap.
    @[::JSON::Field(key: "configMapKeyRef")]
    @[::YAML::Field(key: "configMapKeyRef")]
    property config_map_key_ref : ConfigMapKeySelector?
    # Selects a field of the pod: supports metadata.name, metadata.namespace, `metadata.labels['<KEY>']`, `metadata.annotations['<KEY>']`, spec.nodeName, spec.serviceAccountName, status.hostIP, status.podIP, status.podIPs.
    @[::JSON::Field(key: "fieldRef")]
    @[::YAML::Field(key: "fieldRef")]
    property field_ref : ObjectFieldSelector?
    # FileKeyRef selects a key of the env file. Requires the EnvFiles feature gate to be enabled.
    @[::JSON::Field(key: "fileKeyRef")]
    @[::YAML::Field(key: "fileKeyRef")]
    property file_key_ref : FileKeySelector?
    # Selects a resource of the container: only resources limits and requests (limits.cpu, limits.memory, limits.ephemeral-storage, requests.cpu, requests.memory and requests.ephemeral-storage) are currently supported.
    @[::JSON::Field(key: "resourceFieldRef")]
    @[::YAML::Field(key: "resourceFieldRef")]
    property resource_field_ref : ResourceFieldSelector?
    # Selects a key of a secret in the pod's namespace
    @[::JSON::Field(key: "secretKeyRef")]
    @[::YAML::Field(key: "secretKeyRef")]
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
    @[::JSON::Field(key: "envFrom")]
    @[::YAML::Field(key: "envFrom")]
    property env_from : Array(EnvFromSource)?
    # Container image name. More info: https://kubernetes.io/docs/concepts/containers/images
    property image : String?
    # Image pull policy. One of Always, Never, IfNotPresent. Defaults to Always if :latest tag is specified, or IfNotPresent otherwise. Cannot be updated. More info: https://kubernetes.io/docs/concepts/containers/images#updating-images
    @[::JSON::Field(key: "imagePullPolicy")]
    @[::YAML::Field(key: "imagePullPolicy")]
    property image_pull_policy : String?
    # Lifecycle is not allowed for ephemeral containers.
    property lifecycle : Lifecycle?
    # Probes are not allowed for ephemeral containers.
    @[::JSON::Field(key: "livenessProbe")]
    @[::YAML::Field(key: "livenessProbe")]
    property liveness_probe : Probe?
    # Name of the ephemeral container specified as a DNS_LABEL. This name must be unique among all containers, init containers and ephemeral containers.
    property name : String?
    # Ports are not allowed for ephemeral containers.
    property ports : Array(ContainerPort)?
    # Probes are not allowed for ephemeral containers.
    @[::JSON::Field(key: "readinessProbe")]
    @[::YAML::Field(key: "readinessProbe")]
    property readiness_probe : Probe?
    # Resources resize policy for the container.
    @[::JSON::Field(key: "resizePolicy")]
    @[::YAML::Field(key: "resizePolicy")]
    property resize_policy : Array(ContainerResizePolicy)?
    # Resources are not allowed for ephemeral containers. Ephemeral containers use spare resources already allocated to the pod.
    property resources : ResourceRequirements?
    # Restart policy for the container to manage the restart behavior of each container within a pod. You cannot set this field on ephemeral containers.
    @[::JSON::Field(key: "restartPolicy")]
    @[::YAML::Field(key: "restartPolicy")]
    property restart_policy : String?
    # Represents a list of rules to be checked to determine if the container should be restarted on exit. You cannot set this field on ephemeral containers.
    @[::JSON::Field(key: "restartPolicyRules")]
    @[::YAML::Field(key: "restartPolicyRules")]
    property restart_policy_rules : Array(ContainerRestartRule)?
    # Optional: SecurityContext defines the security options the ephemeral container should be run with. If set, the fields of SecurityContext override the equivalent fields of PodSecurityContext.
    @[::JSON::Field(key: "securityContext")]
    @[::YAML::Field(key: "securityContext")]
    property security_context : SecurityContext?
    # Probes are not allowed for ephemeral containers.
    @[::JSON::Field(key: "startupProbe")]
    @[::YAML::Field(key: "startupProbe")]
    property startup_probe : Probe?
    # Whether this container should allocate a buffer for stdin in the container runtime. If this is not set, reads from stdin in the container will always result in EOF. Default is false.
    property stdin : Bool?
    # Whether the container runtime should close the stdin channel after it has been opened by a single attach. When stdin is true the stdin stream will remain open across multiple attach sessions. If stdinOnce is set to true, stdin is opened on container start, is empty until the first client attaches to stdin, and then remains open and accepts data until the client disconnects, at which time stdin is closed and remains closed until the container is restarted. If this flag is false, a container processes that reads from stdin will never receive an EOF. Default is false
    @[::JSON::Field(key: "stdinOnce")]
    @[::YAML::Field(key: "stdinOnce")]
    property stdin_once : Bool?
    # If set, the name of the container from PodSpec that this ephemeral container targets. The ephemeral container will be run in the namespaces (IPC, PID, etc) of this container. If not set then the ephemeral container uses the namespaces configured in the Pod spec.
    # The container runtime must implement support for this feature. If the runtime does not support namespace targeting then the result of setting this field is undefined.
    @[::JSON::Field(key: "targetContainerName")]
    @[::YAML::Field(key: "targetContainerName")]
    property target_container_name : String?
    # Optional: Path at which the file to which the container's termination message will be written is mounted into the container's filesystem. Message written is intended to be brief final status, such as an assertion failure message. Will be truncated by the node if greater than 4096 bytes. The total message length across all containers will be limited to 12kb. Defaults to /dev/termination-log. Cannot be updated.
    @[::JSON::Field(key: "terminationMessagePath")]
    @[::YAML::Field(key: "terminationMessagePath")]
    property termination_message_path : String?
    # Indicate how the termination message should be populated. File will use the contents of terminationMessagePath to populate the container status message on both success and failure. FallbackToLogsOnError will use the last chunk of container log output if the termination message file is empty and the container exited with an error. The log output is limited to 2048 bytes or 80 lines, whichever is smaller. Defaults to File. Cannot be updated.
    @[::JSON::Field(key: "terminationMessagePolicy")]
    @[::YAML::Field(key: "terminationMessagePolicy")]
    property termination_message_policy : String?
    # Whether this container should allocate a TTY for itself, also requires 'stdin' to be true. Default is false.
    property tty : Bool?
    # volumeDevices is the list of block devices to be used by the container.
    @[::JSON::Field(key: "volumeDevices")]
    @[::YAML::Field(key: "volumeDevices")]
    property volume_devices : Array(VolumeDevice)?
    # Pod volumes to mount into the container's filesystem. Subpath mounts are not allowed for ephemeral containers. Cannot be updated.
    @[::JSON::Field(key: "volumeMounts")]
    @[::YAML::Field(key: "volumeMounts")]
    property volume_mounts : Array(VolumeMount)?
    # Container's working directory. If not specified, the container runtime's default will be used, which might be configured in the container image. Cannot be updated.
    @[::JSON::Field(key: "workingDir")]
    @[::YAML::Field(key: "workingDir")]
    property working_dir : String?
  end

  # Represents an ephemeral volume that is handled by a normal storage driver.
  struct EphemeralVolumeSource
    include Kubernetes::Serializable

    # Will be used to create a stand-alone PVC to provision the volume. The pod in which this EphemeralVolumeSource is embedded will be the owner of the PVC, i.e. the PVC will be deleted together with the pod.  The name of the PVC will be `<pod name>-<volume name>` where `<volume name>` is the name from the `PodSpec.Volumes` array entry. Pod validation will reject the pod if the concatenated name is not valid for a PVC (for example, too long).
    # An existing PVC with that name that is not owned by the pod will *not* be used for the pod to avoid using an unrelated volume by mistake. Starting the pod is then blocked until the unrelated PVC is removed. If such a pre-created PVC is meant to be used by the pod, the PVC has to updated with an owner reference to the pod once the pod exists. Normally this should not be necessary, but it may be useful when manually reconstructing a broken cluster.
    # This field is read-only and no changes will be made by Kubernetes to the PVC after it has been created.
    # Required, must not be nil.
    @[::JSON::Field(key: "volumeClaimTemplate")]
    @[::YAML::Field(key: "volumeClaimTemplate")]
    property volume_claim_template : PersistentVolumeClaimTemplate?
  end

  # Event is a report of an event somewhere in the cluster.  Events have a limited retention time and triggers and messages may evolve with time.  Event consumers should not rely on the timing of an event with a given Reason reflecting a consistent underlying trigger, or the continued existence of events with that Reason.  Events should be treated as informative, best-effort, supplemental data.
  struct Event
    include Kubernetes::Serializable

    # What action was taken/failed regarding to the Regarding object.
    property action : String?
    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
    property api_version : String?
    # The number of times this event has occurred.
    property count : Int32?
    # Time when this Event was first observed.
    @[::JSON::Field(key: "eventTime")]
    @[::YAML::Field(key: "eventTime")]
    property event_time : MicroTime?
    # The time at which the event was first recorded. (Time of server receipt is in TypeMeta.)
    @[::JSON::Field(key: "firstTimestamp")]
    @[::YAML::Field(key: "firstTimestamp")]
    property first_timestamp : Time?
    # The object that this event is about.
    @[::JSON::Field(key: "involvedObject")]
    @[::YAML::Field(key: "involvedObject")]
    property involved_object : ObjectReference?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # The time at which the most recent occurrence of this event was recorded.
    @[::JSON::Field(key: "lastTimestamp")]
    @[::YAML::Field(key: "lastTimestamp")]
    property last_timestamp : Time?
    # A human-readable description of the status of this operation.
    property message : String?
    # Standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ObjectMeta?
    # This should be a short, machine understandable string that gives the reason for the transition into the object's current status.
    property reason : String?
    # Optional secondary object for more complex actions.
    property related : ObjectReference?
    # Name of the controller that emitted this Event, e.g. `kubernetes.io/kubelet`.
    @[::JSON::Field(key: "reportingComponent")]
    @[::YAML::Field(key: "reportingComponent")]
    property reporting_component : String?
    # ID of the controller instance, e.g. `kubelet-xyzf`.
    @[::JSON::Field(key: "reportingInstance")]
    @[::YAML::Field(key: "reportingInstance")]
    property reporting_instance : String?
    # Data about the Event series this event represents or nil if it's a singleton Event.
    property series : EventSeries?
    # The component reporting this event. Should be a short machine understandable string.
    property source : EventSource?
    # Type of this event (Normal, Warning), new types could be added in the future
    property type : String?
  end

  # EventList is a list of events.
  struct EventList
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
    property api_version : String?
    # List of events
    property items : Array(Event)?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard list metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property metadata : ListMeta?
  end

  # EventSeries contain information on series of events, i.e. thing that was/is happening continuously for some time.
  struct EventSeries
    include Kubernetes::Serializable

    # Number of occurrences in this series up to the last heartbeat time
    property count : Int32?
    # Time of the last occurrence observed
    @[::JSON::Field(key: "lastObservedTime")]
    @[::YAML::Field(key: "lastObservedTime")]
    property last_observed_time : MicroTime?
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
    @[::JSON::Field(key: "fsType")]
    @[::YAML::Field(key: "fsType")]
    property fs_type : String?
    # lun is Optional: FC target lun number
    property lun : Int32?
    # readOnly is Optional: Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts.
    @[::JSON::Field(key: "readOnly")]
    @[::YAML::Field(key: "readOnly")]
    property read_only : Bool?
    # targetWWNs is Optional: FC target worldwide names (WWNs)
    @[::JSON::Field(key: "targetWWNs")]
    @[::YAML::Field(key: "targetWWNs")]
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
    @[::JSON::Field(key: "volumeName")]
    @[::YAML::Field(key: "volumeName")]
    property volume_name : String?
  end

  # FlexPersistentVolumeSource represents a generic persistent volume resource that is provisioned/attached using an exec based plugin.
  struct FlexPersistentVolumeSource
    include Kubernetes::Serializable

    # driver is the name of the driver to use for this volume.
    property driver : String?
    # fsType is the Filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. "ext4", "xfs", "ntfs". The default filesystem depends on FlexVolume script.
    @[::JSON::Field(key: "fsType")]
    @[::YAML::Field(key: "fsType")]
    property fs_type : String?
    # options is Optional: this field holds extra command options if any.
    property options : Hash(String, String)?
    # readOnly is Optional: defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts.
    @[::JSON::Field(key: "readOnly")]
    @[::YAML::Field(key: "readOnly")]
    property read_only : Bool?
    # secretRef is Optional: SecretRef is reference to the secret object containing sensitive information to pass to the plugin scripts. This may be empty if no secret object is specified. If the secret object contains more than one secret, all secrets are passed to the plugin scripts.
    @[::JSON::Field(key: "secretRef")]
    @[::YAML::Field(key: "secretRef")]
    property secret_ref : SecretReference?
  end

  # FlexVolume represents a generic volume resource that is provisioned/attached using an exec based plugin.
  struct FlexVolumeSource
    include Kubernetes::Serializable

    # driver is the name of the driver to use for this volume.
    property driver : String?
    # fsType is the filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. "ext4", "xfs", "ntfs". The default filesystem depends on FlexVolume script.
    @[::JSON::Field(key: "fsType")]
    @[::YAML::Field(key: "fsType")]
    property fs_type : String?
    # options is Optional: this field holds extra command options if any.
    property options : Hash(String, String)?
    # readOnly is Optional: defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts.
    @[::JSON::Field(key: "readOnly")]
    @[::YAML::Field(key: "readOnly")]
    property read_only : Bool?
    # secretRef is Optional: secretRef is reference to the secret object containing sensitive information to pass to the plugin scripts. This may be empty if no secret object is specified. If the secret object contains more than one secret, all secrets are passed to the plugin scripts.
    @[::JSON::Field(key: "secretRef")]
    @[::YAML::Field(key: "secretRef")]
    property secret_ref : LocalObjectReference?
  end

  # Represents a Flocker volume mounted by the Flocker agent. One and only one of datasetName and datasetUUID should be set. Flocker volumes do not support ownership management or SELinux relabeling.
  struct FlockerVolumeSource
    include Kubernetes::Serializable

    # datasetName is Name of the dataset stored as metadata -> name on the dataset for Flocker should be considered as deprecated
    @[::JSON::Field(key: "datasetName")]
    @[::YAML::Field(key: "datasetName")]
    property dataset_name : String?
    # datasetUUID is the UUID of the dataset. This is unique identifier of a Flocker dataset
    @[::JSON::Field(key: "datasetUUID")]
    @[::YAML::Field(key: "datasetUUID")]
    property dataset_uuid : String?
  end

  # Represents a Persistent Disk resource in Google Compute Engine.
  # A GCE PD must exist before mounting to a container. The disk must also be in the same GCE project and zone as the kubelet. A GCE PD can only be mounted as read/write once or read-only many times. GCE PDs support ownership management and SELinux relabeling.
  struct GCEPersistentDiskVolumeSource
    include Kubernetes::Serializable

    # fsType is filesystem type of the volume that you want to mount. Tip: Ensure that the filesystem type is supported by the host operating system. Examples: "ext4", "xfs", "ntfs". Implicitly inferred to be "ext4" if unspecified. More info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk
    @[::JSON::Field(key: "fsType")]
    @[::YAML::Field(key: "fsType")]
    property fs_type : String?
    # partition is the partition in the volume that you want to mount. If omitted, the default is to mount by volume name. Examples: For volume /dev/sda1, you specify the partition as "1". Similarly, the volume partition for /dev/sda is "0" (or you can leave the property empty). More info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk
    property partition : Int32?
    # pdName is unique name of the PD resource in GCE. Used to identify the disk in GCE. More info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk
    @[::JSON::Field(key: "pdName")]
    @[::YAML::Field(key: "pdName")]
    property pd_name : String?
    # readOnly here will force the ReadOnly setting in VolumeMounts. Defaults to false. More info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk
    @[::JSON::Field(key: "readOnly")]
    @[::YAML::Field(key: "readOnly")]
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
    @[::JSON::Field(key: "endpointsNamespace")]
    @[::YAML::Field(key: "endpointsNamespace")]
    property endpoints_namespace : String?
    # path is the Glusterfs volume path. More info: https://examples.k8s.io/volumes/glusterfs/README.md#create-a-pod
    property path : String?
    # readOnly here will force the Glusterfs volume to be mounted with read-only permissions. Defaults to false. More info: https://examples.k8s.io/volumes/glusterfs/README.md#create-a-pod
    @[::JSON::Field(key: "readOnly")]
    @[::YAML::Field(key: "readOnly")]
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
    @[::JSON::Field(key: "readOnly")]
    @[::YAML::Field(key: "readOnly")]
    property read_only : Bool?
  end

  # HTTPGetAction describes an action based on HTTP Get requests.
  struct HTTPGetAction
    include Kubernetes::Serializable

    # Host name to connect to, defaults to the pod IP. You probably want to set "Host" in httpHeaders instead.
    property host : String?
    # Custom headers to set in the request. HTTP allows repeated headers.
    @[::JSON::Field(key: "httpHeaders")]
    @[::YAML::Field(key: "httpHeaders")]
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
    @[::JSON::Field(key: "chapAuthDiscovery")]
    @[::YAML::Field(key: "chapAuthDiscovery")]
    property chap_auth_discovery : Bool?
    # chapAuthSession defines whether support iSCSI Session CHAP authentication
    @[::JSON::Field(key: "chapAuthSession")]
    @[::YAML::Field(key: "chapAuthSession")]
    property chap_auth_session : Bool?
    # fsType is the filesystem type of the volume that you want to mount. Tip: Ensure that the filesystem type is supported by the host operating system. Examples: "ext4", "xfs", "ntfs". Implicitly inferred to be "ext4" if unspecified. More info: https://kubernetes.io/docs/concepts/storage/volumes#iscsi
    @[::JSON::Field(key: "fsType")]
    @[::YAML::Field(key: "fsType")]
    property fs_type : String?
    # initiatorName is the custom iSCSI Initiator Name. If initiatorName is specified with iscsiInterface simultaneously, new iSCSI interface <target portal>:<volume name> will be created for the connection.
    @[::JSON::Field(key: "initiatorName")]
    @[::YAML::Field(key: "initiatorName")]
    property initiator_name : String?
    # iqn is Target iSCSI Qualified Name.
    property iqn : String?
    # iscsiInterface is the interface Name that uses an iSCSI transport. Defaults to 'default' (tcp).
    @[::JSON::Field(key: "iscsiInterface")]
    @[::YAML::Field(key: "iscsiInterface")]
    property iscsi_interface : String?
    # lun is iSCSI Target Lun number.
    property lun : Int32?
    # portals is the iSCSI Target Portal List. The Portal is either an IP or ip_addr:port if the port is other than default (typically TCP ports 860 and 3260).
    property portals : Array(String)?
    # readOnly here will force the ReadOnly setting in VolumeMounts. Defaults to false.
    @[::JSON::Field(key: "readOnly")]
    @[::YAML::Field(key: "readOnly")]
    property read_only : Bool?
    # secretRef is the CHAP Secret for iSCSI target and initiator authentication
    @[::JSON::Field(key: "secretRef")]
    @[::YAML::Field(key: "secretRef")]
    property secret_ref : SecretReference?
    # targetPortal is iSCSI Target Portal. The Portal is either an IP or ip_addr:port if the port is other than default (typically TCP ports 860 and 3260).
    @[::JSON::Field(key: "targetPortal")]
    @[::YAML::Field(key: "targetPortal")]
    property target_portal : String?
  end

  # Represents an ISCSI disk. ISCSI volumes can only be mounted as read/write once. ISCSI volumes support ownership management and SELinux relabeling.
  struct ISCSIVolumeSource
    include Kubernetes::Serializable

    # chapAuthDiscovery defines whether support iSCSI Discovery CHAP authentication
    @[::JSON::Field(key: "chapAuthDiscovery")]
    @[::YAML::Field(key: "chapAuthDiscovery")]
    property chap_auth_discovery : Bool?
    # chapAuthSession defines whether support iSCSI Session CHAP authentication
    @[::JSON::Field(key: "chapAuthSession")]
    @[::YAML::Field(key: "chapAuthSession")]
    property chap_auth_session : Bool?
    # fsType is the filesystem type of the volume that you want to mount. Tip: Ensure that the filesystem type is supported by the host operating system. Examples: "ext4", "xfs", "ntfs". Implicitly inferred to be "ext4" if unspecified. More info: https://kubernetes.io/docs/concepts/storage/volumes#iscsi
    @[::JSON::Field(key: "fsType")]
    @[::YAML::Field(key: "fsType")]
    property fs_type : String?
    # initiatorName is the custom iSCSI Initiator Name. If initiatorName is specified with iscsiInterface simultaneously, new iSCSI interface <target portal>:<volume name> will be created for the connection.
    @[::JSON::Field(key: "initiatorName")]
    @[::YAML::Field(key: "initiatorName")]
    property initiator_name : String?
    # iqn is the target iSCSI Qualified Name.
    property iqn : String?
    # iscsiInterface is the interface Name that uses an iSCSI transport. Defaults to 'default' (tcp).
    @[::JSON::Field(key: "iscsiInterface")]
    @[::YAML::Field(key: "iscsiInterface")]
    property iscsi_interface : String?
    # lun represents iSCSI Target Lun number.
    property lun : Int32?
    # portals is the iSCSI Target Portal List. The portal is either an IP or ip_addr:port if the port is other than default (typically TCP ports 860 and 3260).
    property portals : Array(String)?
    # readOnly here will force the ReadOnly setting in VolumeMounts. Defaults to false.
    @[::JSON::Field(key: "readOnly")]
    @[::YAML::Field(key: "readOnly")]
    property read_only : Bool?
    # secretRef is the CHAP Secret for iSCSI target and initiator authentication
    @[::JSON::Field(key: "secretRef")]
    @[::YAML::Field(key: "secretRef")]
    property secret_ref : LocalObjectReference?
    # targetPortal is iSCSI Target Portal. The Portal is either an IP or ip_addr:port if the port is other than default (typically TCP ports 860 and 3260).
    @[::JSON::Field(key: "targetPortal")]
    @[::YAML::Field(key: "targetPortal")]
    property target_portal : String?
  end

  # ImageVolumeSource represents a image volume resource.
  struct ImageVolumeSource
    include Kubernetes::Serializable

    # Policy for pulling OCI objects. Possible values are: Always: the kubelet always attempts to pull the reference. Container creation will fail If the pull fails. Never: the kubelet never pulls the reference and only uses a local image or artifact. Container creation will fail if the reference isn't present. IfNotPresent: the kubelet pulls if the reference isn't already present on disk. Container creation will fail if the reference isn't present and the pull fails. Defaults to Always if :latest tag is specified, or IfNotPresent otherwise.
    @[::JSON::Field(key: "pullPolicy")]
    @[::YAML::Field(key: "pullPolicy")]
    property pull_policy : String?
    # Required: Image or artifact reference to be used. Behaves in the same way as pod.spec.containers[*].image. Pull secrets will be assembled in the same way as for the container image by looking up node credentials, SA image pull secrets, and pod spec image pull secrets. More info: https://kubernetes.io/docs/concepts/containers/images This field is optional to allow higher level config management to default or override container images in workload controllers like Deployments and StatefulSets.
    property reference : String?
  end

  # ImageVolumeStatus represents the image-based volume status.
  struct ImageVolumeStatus
    include Kubernetes::Serializable

    # ImageRef is the digest of the image used for this volume. It should have a value that's similar to the pod's status.containerStatuses[i].imageID. The ImageRef length should not exceed 256 characters.
    @[::JSON::Field(key: "imageRef")]
    @[::YAML::Field(key: "imageRef")]
    property image_ref : String?
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
    @[::JSON::Field(key: "postStart")]
    @[::YAML::Field(key: "postStart")]
    property post_start : LifecycleHandler?
    # PreStop is called immediately before a container is terminated due to an API request or management event such as liveness/startup probe failure, preemption, resource contention, etc. The handler is not called if the container crashes or exits. The Pod's termination grace period countdown begins before the PreStop hook is executed. Regardless of the outcome of the handler, the container will eventually terminate within the Pod's termination grace period (unless delayed by finalizers). Other management of the container blocks until the hook completes or until the termination grace period is reached. More info: https://kubernetes.io/docs/concepts/containers/container-lifecycle-hooks/#container-hooks
    @[::JSON::Field(key: "preStop")]
    @[::YAML::Field(key: "preStop")]
    property pre_stop : LifecycleHandler?
    # StopSignal defines which signal will be sent to a container when it is being stopped. If not specified, the default is defined by the container runtime in use. StopSignal can only be set for Pods with a non-empty .spec.os.name
    @[::JSON::Field(key: "stopSignal")]
    @[::YAML::Field(key: "stopSignal")]
    property stop_signal : String?
  end

  # LifecycleHandler defines a specific action that should be taken in a lifecycle hook. One and only one of the fields, except TCPSocket must be specified.
  struct LifecycleHandler
    include Kubernetes::Serializable

    # Exec specifies a command to execute in the container.
    property exec : ExecAction?
    # HTTPGet specifies an HTTP GET request to perform.
    @[::JSON::Field(key: "httpGet")]
    @[::YAML::Field(key: "httpGet")]
    property http_get : HTTPGetAction?
    # Sleep represents a duration that the container should sleep.
    property sleep : SleepAction?
    # Deprecated. TCPSocket is NOT supported as a LifecycleHandler and kept for backward compatibility. There is no validation of this field and lifecycle hooks will fail at runtime when it is specified.
    @[::JSON::Field(key: "tcpSocket")]
    @[::YAML::Field(key: "tcpSocket")]
    property tcp_socket : TCPSocketAction?
  end

  # LimitRange sets resource usage limits for each kind of resource in a Namespace.
  struct LimitRange
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
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
    property default : Hash(String, Quantity)?
    # DefaultRequest is the default resource requirement request value by resource name if resource request is omitted.
    @[::JSON::Field(key: "defaultRequest")]
    @[::YAML::Field(key: "defaultRequest")]
    property default_request : Hash(String, Quantity)?
    # Max usage constraints on this kind by resource name.
    property max : Hash(String, Quantity)?
    # MaxLimitRequestRatio if specified, the named resource must have a request and limit that are both non-zero where limit divided by request is less than or equal to the enumerated value; this represents the max burst for the named resource.
    @[::JSON::Field(key: "maxLimitRequestRatio")]
    @[::YAML::Field(key: "maxLimitRequestRatio")]
    property max_limit_request_ratio : Hash(String, Quantity)?
    # Min usage constraints on this kind by resource name.
    property min : Hash(String, Quantity)?
    # Type of resource that this limit applies to.
    property type : String?
  end

  # LimitRangeList is a list of LimitRange items.
  struct LimitRangeList
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
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
    @[::JSON::Field(key: "supplementalGroups")]
    @[::YAML::Field(key: "supplementalGroups")]
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
    @[::JSON::Field(key: "ipMode")]
    @[::YAML::Field(key: "ipMode")]
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
    @[::JSON::Field(key: "fsType")]
    @[::YAML::Field(key: "fsType")]
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
    @[::JSON::Field(key: "targetVolumeAttributesClassName")]
    @[::YAML::Field(key: "targetVolumeAttributesClassName")]
    property target_volume_attributes_class_name : String?
  end

  # Represents an NFS mount that lasts the lifetime of a pod. NFS volumes do not support ownership management or SELinux relabeling.
  struct NFSVolumeSource
    include Kubernetes::Serializable

    # path that is exported by the NFS server. More info: https://kubernetes.io/docs/concepts/storage/volumes#nfs
    property path : String?
    # readOnly here will force the NFS export to be mounted with read-only permissions. Defaults to false. More info: https://kubernetes.io/docs/concepts/storage/volumes#nfs
    @[::JSON::Field(key: "readOnly")]
    @[::YAML::Field(key: "readOnly")]
    property read_only : Bool?
    # server is the hostname or IP address of the NFS server. More info: https://kubernetes.io/docs/concepts/storage/volumes#nfs
    property server : String?
  end

  # Namespace provides a scope for Names. Use of multiple namespaces is optional.
  struct Namespace
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
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
    @[::JSON::Field(key: "lastTransitionTime")]
    @[::YAML::Field(key: "lastTransitionTime")]
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
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
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
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
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
    @[::JSON::Field(key: "preferredDuringSchedulingIgnoredDuringExecution")]
    @[::YAML::Field(key: "preferredDuringSchedulingIgnoredDuringExecution")]
    property preferred_during_scheduling_ignored_during_execution : Array(PreferredSchedulingTerm)?
    # If the affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to an update), the system may or may not try to eventually evict the pod from its node.
    @[::JSON::Field(key: "requiredDuringSchedulingIgnoredDuringExecution")]
    @[::YAML::Field(key: "requiredDuringSchedulingIgnoredDuringExecution")]
    property required_during_scheduling_ignored_during_execution : NodeSelector?
  end

  # NodeCondition contains condition information for a node.
  struct NodeCondition
    include Kubernetes::Serializable

    # Last time we got an update on a given condition.
    @[::JSON::Field(key: "lastHeartbeatTime")]
    @[::YAML::Field(key: "lastHeartbeatTime")]
    property last_heartbeat_time : Time?
    # Last time the condition transit from one status to another.
    @[::JSON::Field(key: "lastTransitionTime")]
    @[::YAML::Field(key: "lastTransitionTime")]
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
    @[::JSON::Field(key: "configMap")]
    @[::YAML::Field(key: "configMap")]
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
    @[::JSON::Field(key: "lastKnownGood")]
    @[::YAML::Field(key: "lastKnownGood")]
    property last_known_good : NodeConfigSource?
  end

  # NodeDaemonEndpoints lists ports opened by daemons running on the Node.
  struct NodeDaemonEndpoints
    include Kubernetes::Serializable

    # Endpoint on which Kubelet is listening.
    @[::JSON::Field(key: "kubeletEndpoint")]
    @[::YAML::Field(key: "kubeletEndpoint")]
    property kubelet_endpoint : DaemonEndpoint?
  end

  # NodeFeatures describes the set of features implemented by the CRI implementation. The features contained in the NodeFeatures should depend only on the cri implementation independent of runtime handlers.
  struct NodeFeatures
    include Kubernetes::Serializable

    # SupplementalGroupsPolicy is set to true if the runtime supports SupplementalGroupsPolicy and ContainerUser.
    @[::JSON::Field(key: "supplementalGroupsPolicy")]
    @[::YAML::Field(key: "supplementalGroupsPolicy")]
    property supplemental_groups_policy : Bool?
  end

  # NodeList is the whole list of all Nodes which have been registered with master.
  struct NodeList
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
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
    @[::JSON::Field(key: "recursiveReadOnlyMounts")]
    @[::YAML::Field(key: "recursiveReadOnlyMounts")]
    property recursive_read_only_mounts : Bool?
    # UserNamespaces is set to true if the runtime handler supports UserNamespaces, including for volumes.
    @[::JSON::Field(key: "userNamespaces")]
    @[::YAML::Field(key: "userNamespaces")]
    property user_namespaces : Bool?
  end

  # A node selector represents the union of the results of one or more label queries over a set of nodes; that is, it represents the OR of the selectors represented by the node selector terms.
  struct NodeSelector
    include Kubernetes::Serializable

    # Required. A list of node selector terms. The terms are ORed.
    @[::JSON::Field(key: "nodeSelectorTerms")]
    @[::YAML::Field(key: "nodeSelectorTerms")]
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
    @[::JSON::Field(key: "matchExpressions")]
    @[::YAML::Field(key: "matchExpressions")]
    property match_expressions : Array(NodeSelectorRequirement)?
    # A list of node selector requirements by node's fields.
    @[::JSON::Field(key: "matchFields")]
    @[::YAML::Field(key: "matchFields")]
    property match_fields : Array(NodeSelectorRequirement)?
  end

  # NodeSpec describes the attributes that a node is created with.
  struct NodeSpec
    include Kubernetes::Serializable

    # Deprecated: Previously used to specify the source of the node's configuration for the DynamicKubeletConfig feature. This feature is removed.
    @[::JSON::Field(key: "configSource")]
    @[::YAML::Field(key: "configSource")]
    property config_source : NodeConfigSource?
    # Deprecated. Not all kubelets will set this field. Remove field after 1.13. see: https://issues.k8s.io/61966
    @[::JSON::Field(key: "externalID")]
    @[::YAML::Field(key: "externalID")]
    property external_id : String?
    # PodCIDR represents the pod IP range assigned to the node.
    @[::JSON::Field(key: "podCIDR")]
    @[::YAML::Field(key: "podCIDR")]
    property pod_cidr : String?
    # podCIDRs represents the IP ranges assigned to the node for usage by Pods on that node. If this field is specified, the 0th entry must match the podCIDR field. It may contain at most 1 value for each of IPv4 and IPv6.
    @[::JSON::Field(key: "podCIDRs")]
    @[::YAML::Field(key: "podCIDRs")]
    property pod_cid_rs : Array(String)?
    # ID of the node assigned by the cloud provider in the format: <ProviderName>://<ProviderSpecificNodeID>
    @[::JSON::Field(key: "providerID")]
    @[::YAML::Field(key: "providerID")]
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
    property allocatable : Hash(String, Quantity)?
    # Capacity represents the total resources of a node. More info: https://kubernetes.io/docs/reference/node/node-status/#capacity
    property capacity : Hash(String, Quantity)?
    # Conditions is an array of current observed node conditions. More info: https://kubernetes.io/docs/reference/node/node-status/#condition
    property conditions : Array(NodeCondition)?
    # Status of the config assigned to the node via the dynamic Kubelet config feature.
    property config : NodeConfigStatus?
    # Endpoints of daemons running on the Node.
    @[::JSON::Field(key: "daemonEndpoints")]
    @[::YAML::Field(key: "daemonEndpoints")]
    property daemon_endpoints : NodeDaemonEndpoints?
    # DeclaredFeatures represents the features related to feature gates that are declared by the node.
    @[::JSON::Field(key: "declaredFeatures")]
    @[::YAML::Field(key: "declaredFeatures")]
    property declared_features : Array(String)?
    # Features describes the set of features implemented by the CRI implementation.
    property features : NodeFeatures?
    # List of container images on this node
    property images : Array(ContainerImage)?
    # Set of ids/uuids to uniquely identify the node. More info: https://kubernetes.io/docs/reference/node/node-status/#info
    @[::JSON::Field(key: "nodeInfo")]
    @[::YAML::Field(key: "nodeInfo")]
    property node_info : NodeSystemInfo?
    # NodePhase is the recently observed lifecycle phase of the node. More info: https://kubernetes.io/docs/concepts/nodes/node/#phase The field is never populated, and now is deprecated.
    property phase : String?
    # The available runtime handlers.
    @[::JSON::Field(key: "runtimeHandlers")]
    @[::YAML::Field(key: "runtimeHandlers")]
    property runtime_handlers : Array(NodeRuntimeHandler)?
    # List of volumes that are attached to the node.
    @[::JSON::Field(key: "volumesAttached")]
    @[::YAML::Field(key: "volumesAttached")]
    property volumes_attached : Array(AttachedVolume)?
    # List of attachable volumes in use (mounted) by the node.
    @[::JSON::Field(key: "volumesInUse")]
    @[::YAML::Field(key: "volumesInUse")]
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
    @[::JSON::Field(key: "bootID")]
    @[::YAML::Field(key: "bootID")]
    property boot_id : String?
    # ContainerRuntime Version reported by the node through runtime remote API (e.g. containerd://1.4.2).
    @[::JSON::Field(key: "containerRuntimeVersion")]
    @[::YAML::Field(key: "containerRuntimeVersion")]
    property container_runtime_version : String?
    # Kernel Version reported by the node from 'uname -r' (e.g. 3.16.0-0.bpo.4-amd64).
    @[::JSON::Field(key: "kernelVersion")]
    @[::YAML::Field(key: "kernelVersion")]
    property kernel_version : String?
    # Deprecated: KubeProxy Version reported by the node.
    @[::JSON::Field(key: "kubeProxyVersion")]
    @[::YAML::Field(key: "kubeProxyVersion")]
    property kube_proxy_version : String?
    # Kubelet Version reported by the node.
    @[::JSON::Field(key: "kubeletVersion")]
    @[::YAML::Field(key: "kubeletVersion")]
    property kubelet_version : String?
    # MachineID reported by the node. For unique machine identification in the cluster this field is preferred. Learn more from man(5) machine-id: http://man7.org/linux/man-pages/man5/machine-id.5.html
    @[::JSON::Field(key: "machineID")]
    @[::YAML::Field(key: "machineID")]
    property machine_id : String?
    # The Operating System reported by the node
    @[::JSON::Field(key: "operatingSystem")]
    @[::YAML::Field(key: "operatingSystem")]
    property operating_system : String?
    # OS Image reported by the node from /etc/os-release (e.g. Debian GNU/Linux 7 (wheezy)).
    @[::JSON::Field(key: "osImage")]
    @[::YAML::Field(key: "osImage")]
    property os_image : String?
    # Swap Info reported by the node.
    property swap : NodeSwapStatus?
    # SystemUUID reported by the node. For unique machine identification MachineID is preferred. This field is specific to Red Hat hosts https://access.redhat.com/documentation/en-us/red_hat_subscription_management/1/html/rhsm/uuid
    @[::JSON::Field(key: "systemUUID")]
    @[::YAML::Field(key: "systemUUID")]
    property system_uuid : String?
  end

  # ObjectFieldSelector selects an APIVersioned field of an object.
  struct ObjectFieldSelector
    include Kubernetes::Serializable

    # Version of the schema the FieldPath is written in terms of, defaults to "v1".
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Path of the field to select in the specified API version.
    @[::JSON::Field(key: "fieldPath")]
    @[::YAML::Field(key: "fieldPath")]
    property field_path : String?
  end

  # ObjectReference contains enough information to let you inspect or modify the referred object.
  struct ObjectReference
    include Kubernetes::Serializable

    # API version of the referent.
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
    property api_version : String?
    # If referring to a piece of an object instead of an entire object, this string should contain a valid JSON/Go field access statement, such as desiredState.manifest.containers[2]. For example, if the object reference is to a container within a pod, this would take on a value like: "spec.containers{name}" (where "name" refers to the name of the container that triggered the event) or if no container name is specified "spec.containers[2]" (container with index 2 in this pod). This syntax is chosen only to have some well-defined way of referencing a part of an object.
    @[::JSON::Field(key: "fieldPath")]
    @[::YAML::Field(key: "fieldPath")]
    property field_path : String?
    # Kind of the referent. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
    property name : String?
    # Namespace of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/
    property namespace : String?
    # Specific resourceVersion to which this reference is made, if any. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#concurrency-control-and-consistency
    @[::JSON::Field(key: "resourceVersion")]
    @[::YAML::Field(key: "resourceVersion")]
    property resource_version : String?
    # UID of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#uids
    property uid : String?
  end

  # PersistentVolume (PV) is a storage resource provisioned by an administrator. It is analogous to a node. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes
  struct PersistentVolume
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
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
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
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
    @[::JSON::Field(key: "lastProbeTime")]
    @[::YAML::Field(key: "lastProbeTime")]
    property last_probe_time : Time?
    # lastTransitionTime is the time the condition transitioned from one status to another.
    @[::JSON::Field(key: "lastTransitionTime")]
    @[::YAML::Field(key: "lastTransitionTime")]
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
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
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
    @[::JSON::Field(key: "accessModes")]
    @[::YAML::Field(key: "accessModes")]
    property access_modes : Array(String)?
    # dataSource field can be used to specify either: * An existing VolumeSnapshot object (snapshot.storage.k8s.io/VolumeSnapshot) * An existing PVC (PersistentVolumeClaim) If the provisioner or an external controller can support the specified data source, it will create a new volume based on the contents of the specified data source. When the AnyVolumeDataSource feature gate is enabled, dataSource contents will be copied to dataSourceRef, and dataSourceRef contents will be copied to dataSource when dataSourceRef.namespace is not specified. If the namespace is specified, then dataSourceRef will not be copied to dataSource.
    @[::JSON::Field(key: "dataSource")]
    @[::YAML::Field(key: "dataSource")]
    property data_source : TypedLocalObjectReference?
    # dataSourceRef specifies the object from which to populate the volume with data, if a non-empty volume is desired. This may be any object from a non-empty API group (non core object) or a PersistentVolumeClaim object. When this field is specified, volume binding will only succeed if the type of the specified object matches some installed volume populator or dynamic provisioner. This field will replace the functionality of the dataSource field and as such if both fields are non-empty, they must have the same value. For backwards compatibility, when namespace isn't specified in dataSourceRef, both fields (dataSource and dataSourceRef) will be set to the same value automatically if one of them is empty and the other is non-empty. When namespace is specified in dataSourceRef, dataSource isn't set to the same value and must be empty. There are three important differences between dataSource and dataSourceRef: * While dataSource only allows two specific types of objects, dataSourceRef
    # allows any non-core object, as well as PersistentVolumeClaim objects.
    # * While dataSource ignores disallowed values (dropping them), dataSourceRef
    # preserves all values, and generates an error if a disallowed value is
    # specified.
    # * While dataSource only allows local objects, dataSourceRef allows objects
    # in any namespaces.
    # (Beta) Using this field requires the AnyVolumeDataSource feature gate to be enabled. (Alpha) Using the namespace field of dataSourceRef requires the CrossNamespaceVolumeDataSource feature gate to be enabled.
    @[::JSON::Field(key: "dataSourceRef")]
    @[::YAML::Field(key: "dataSourceRef")]
    property data_source_ref : TypedObjectReference?
    # resources represents the minimum resources the volume should have. Users are allowed to specify resource requirements that are lower than previous value but must still be higher than capacity recorded in the status field of the claim. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#resources
    property resources : VolumeResourceRequirements?
    # selector is a label query over volumes to consider for binding.
    property selector : LabelSelector?
    # storageClassName is the name of the StorageClass required by the claim. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#class-1
    @[::JSON::Field(key: "storageClassName")]
    @[::YAML::Field(key: "storageClassName")]
    property storage_class_name : String?
    # volumeAttributesClassName may be used to set the VolumeAttributesClass used by this claim. If specified, the CSI driver will create or update the volume with the attributes defined in the corresponding VolumeAttributesClass. This has a different purpose than storageClassName, it can be changed after the claim is created. An empty string or nil value indicates that no VolumeAttributesClass will be applied to the claim. If the claim enters an Infeasible error state, this field can be reset to its previous value (including nil) to cancel the modification. If the resource referred to by volumeAttributesClass does not exist, this PersistentVolumeClaim will be set to a Pending state, as reflected by the modifyVolumeStatus field, until such as a resource exists. More info: https://kubernetes.io/docs/concepts/storage/volume-attributes-classes/
    @[::JSON::Field(key: "volumeAttributesClassName")]
    @[::YAML::Field(key: "volumeAttributesClassName")]
    property volume_attributes_class_name : String?
    # volumeMode defines what type of volume is required by the claim. Value of Filesystem is implied when not included in claim spec.
    @[::JSON::Field(key: "volumeMode")]
    @[::YAML::Field(key: "volumeMode")]
    property volume_mode : String?
    # volumeName is the binding reference to the PersistentVolume backing this claim.
    @[::JSON::Field(key: "volumeName")]
    @[::YAML::Field(key: "volumeName")]
    property volume_name : String?
  end

  # PersistentVolumeClaimStatus is the current status of a persistent volume claim.
  struct PersistentVolumeClaimStatus
    include Kubernetes::Serializable

    # accessModes contains the actual access modes the volume backing the PVC has. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes-1
    @[::JSON::Field(key: "accessModes")]
    @[::YAML::Field(key: "accessModes")]
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
    @[::JSON::Field(key: "allocatedResourceStatuses")]
    @[::YAML::Field(key: "allocatedResourceStatuses")]
    property allocated_resource_statuses : Hash(String, String)?
    # allocatedResources tracks the resources allocated to a PVC including its capacity. Key names follow standard Kubernetes label syntax. Valid values are either:
    # * Un-prefixed keys:
    # - storage - the capacity of the volume.
    # * Custom resources must use implementation-defined prefixed names such as "example.com/my-custom-resource"
    # Apart from above values - keys that are unprefixed or have kubernetes.io prefix are considered reserved and hence may not be used.
    # Capacity reported here may be larger than the actual capacity when a volume expansion operation is requested. For storage quota, the larger value from allocatedResources and PVC.spec.resources is used. If allocatedResources is not set, PVC.spec.resources alone is used for quota calculation. If a volume expansion capacity request is lowered, allocatedResources is only lowered if there are no expansion operations in progress and if the actual volume capacity is equal or lower than the requested capacity.
    # A controller that receives PVC update with previously unknown resourceName should ignore the update for the purpose it was designed. For example - a controller that only is responsible for resizing capacity of the volume, should ignore PVC updates that change other valid resources associated with PVC.
    @[::JSON::Field(key: "allocatedResources")]
    @[::YAML::Field(key: "allocatedResources")]
    property allocated_resources : Hash(String, Quantity)?
    # capacity represents the actual resources of the underlying volume.
    property capacity : Hash(String, Quantity)?
    # conditions is the current Condition of persistent volume claim. If underlying persistent volume is being resized then the Condition will be set to 'Resizing'.
    property conditions : Array(PersistentVolumeClaimCondition)?
    # currentVolumeAttributesClassName is the current name of the VolumeAttributesClass the PVC is using. When unset, there is no VolumeAttributeClass applied to this PersistentVolumeClaim
    @[::JSON::Field(key: "currentVolumeAttributesClassName")]
    @[::YAML::Field(key: "currentVolumeAttributesClassName")]
    property current_volume_attributes_class_name : String?
    # ModifyVolumeStatus represents the status object of ControllerModifyVolume operation. When this is unset, there is no ModifyVolume operation being attempted.
    @[::JSON::Field(key: "modifyVolumeStatus")]
    @[::YAML::Field(key: "modifyVolumeStatus")]
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
    @[::JSON::Field(key: "claimName")]
    @[::YAML::Field(key: "claimName")]
    property claim_name : String?
    # readOnly Will force the ReadOnly setting in VolumeMounts. Default false.
    @[::JSON::Field(key: "readOnly")]
    @[::YAML::Field(key: "readOnly")]
    property read_only : Bool?
  end

  # PersistentVolumeList is a list of PersistentVolume items.
  struct PersistentVolumeList
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
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
    @[::JSON::Field(key: "accessModes")]
    @[::YAML::Field(key: "accessModes")]
    property access_modes : Array(String)?
    # awsElasticBlockStore represents an AWS Disk resource that is attached to a kubelet's host machine and then exposed to the pod. Deprecated: AWSElasticBlockStore is deprecated. All operations for the in-tree awsElasticBlockStore type are redirected to the ebs.csi.aws.com CSI driver. More info: https://kubernetes.io/docs/concepts/storage/volumes#awselasticblockstore
    @[::JSON::Field(key: "awsElasticBlockStore")]
    @[::YAML::Field(key: "awsElasticBlockStore")]
    property aws_elastic_block_store : AWSElasticBlockStoreVolumeSource?
    # azureDisk represents an Azure Data Disk mount on the host and bind mount to the pod. Deprecated: AzureDisk is deprecated. All operations for the in-tree azureDisk type are redirected to the disk.csi.azure.com CSI driver.
    @[::JSON::Field(key: "azureDisk")]
    @[::YAML::Field(key: "azureDisk")]
    property azure_disk : AzureDiskVolumeSource?
    # azureFile represents an Azure File Service mount on the host and bind mount to the pod. Deprecated: AzureFile is deprecated. All operations for the in-tree azureFile type are redirected to the file.csi.azure.com CSI driver.
    @[::JSON::Field(key: "azureFile")]
    @[::YAML::Field(key: "azureFile")]
    property azure_file : AzureFilePersistentVolumeSource?
    # capacity is the description of the persistent volume's resources and capacity. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#capacity
    property capacity : Hash(String, Quantity)?
    # cephFS represents a Ceph FS mount on the host that shares a pod's lifetime. Deprecated: CephFS is deprecated and the in-tree cephfs type is no longer supported.
    property cephfs : CephFSPersistentVolumeSource?
    # cinder represents a cinder volume attached and mounted on kubelets host machine. Deprecated: Cinder is deprecated. All operations for the in-tree cinder type are redirected to the cinder.csi.openstack.org CSI driver. More info: https://examples.k8s.io/mysql-cinder-pd/README.md
    property cinder : CinderPersistentVolumeSource?
    # claimRef is part of a bi-directional binding between PersistentVolume and PersistentVolumeClaim. Expected to be non-nil when bound. claim.VolumeName is the authoritative bind between PV and PVC. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#binding
    @[::JSON::Field(key: "claimRef")]
    @[::YAML::Field(key: "claimRef")]
    property claim_ref : ObjectReference?
    # csi represents storage that is handled by an external CSI driver.
    property csi : CSIPersistentVolumeSource?
    # fc represents a Fibre Channel resource that is attached to a kubelet's host machine and then exposed to the pod.
    property fc : FCVolumeSource?
    # flexVolume represents a generic volume resource that is provisioned/attached using an exec based plugin. Deprecated: FlexVolume is deprecated. Consider using a CSIDriver instead.
    @[::JSON::Field(key: "flexVolume")]
    @[::YAML::Field(key: "flexVolume")]
    property flex_volume : FlexPersistentVolumeSource?
    # flocker represents a Flocker volume attached to a kubelet's host machine and exposed to the pod for its usage. This depends on the Flocker control service being running. Deprecated: Flocker is deprecated and the in-tree flocker type is no longer supported.
    property flocker : FlockerVolumeSource?
    # gcePersistentDisk represents a GCE Disk resource that is attached to a kubelet's host machine and then exposed to the pod. Provisioned by an admin. Deprecated: GCEPersistentDisk is deprecated. All operations for the in-tree gcePersistentDisk type are redirected to the pd.csi.storage.gke.io CSI driver. More info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk
    @[::JSON::Field(key: "gcePersistentDisk")]
    @[::YAML::Field(key: "gcePersistentDisk")]
    property gce_persistent_disk : GCEPersistentDiskVolumeSource?
    # glusterfs represents a Glusterfs volume that is attached to a host and exposed to the pod. Provisioned by an admin. Deprecated: Glusterfs is deprecated and the in-tree glusterfs type is no longer supported. More info: https://examples.k8s.io/volumes/glusterfs/README.md
    property glusterfs : GlusterfsPersistentVolumeSource?
    # hostPath represents a directory on the host. Provisioned by a developer or tester. This is useful for single-node development and testing only! On-host storage is not supported in any way and WILL NOT WORK in a multi-node cluster. More info: https://kubernetes.io/docs/concepts/storage/volumes#hostpath
    @[::JSON::Field(key: "hostPath")]
    @[::YAML::Field(key: "hostPath")]
    property host_path : HostPathVolumeSource?
    # iscsi represents an ISCSI Disk resource that is attached to a kubelet's host machine and then exposed to the pod. Provisioned by an admin.
    property iscsi : ISCSIPersistentVolumeSource?
    # local represents directly-attached storage with node affinity
    property local : LocalVolumeSource?
    # mountOptions is the list of mount options, e.g. ["ro", "soft"]. Not validated - mount will simply fail if one is invalid. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes/#mount-options
    @[::JSON::Field(key: "mountOptions")]
    @[::YAML::Field(key: "mountOptions")]
    property mount_options : Array(String)?
    # nfs represents an NFS mount on the host. Provisioned by an admin. More info: https://kubernetes.io/docs/concepts/storage/volumes#nfs
    property nfs : NFSVolumeSource?
    # nodeAffinity defines constraints that limit what nodes this volume can be accessed from. This field influences the scheduling of pods that use this volume. This field is mutable if MutablePVNodeAffinity feature gate is enabled.
    @[::JSON::Field(key: "nodeAffinity")]
    @[::YAML::Field(key: "nodeAffinity")]
    property node_affinity : VolumeNodeAffinity?
    # persistentVolumeReclaimPolicy defines what happens to a persistent volume when released from its claim. Valid options are Retain (default for manually created PersistentVolumes), Delete (default for dynamically provisioned PersistentVolumes), and Recycle (deprecated). Recycle must be supported by the volume plugin underlying this PersistentVolume. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#reclaiming
    @[::JSON::Field(key: "persistentVolumeReclaimPolicy")]
    @[::YAML::Field(key: "persistentVolumeReclaimPolicy")]
    property persistent_volume_reclaim_policy : String?
    # photonPersistentDisk represents a PhotonController persistent disk attached and mounted on kubelets host machine. Deprecated: PhotonPersistentDisk is deprecated and the in-tree photonPersistentDisk type is no longer supported.
    @[::JSON::Field(key: "photonPersistentDisk")]
    @[::YAML::Field(key: "photonPersistentDisk")]
    property photon_persistent_disk : PhotonPersistentDiskVolumeSource?
    # portworxVolume represents a portworx volume attached and mounted on kubelets host machine. Deprecated: PortworxVolume is deprecated. All operations for the in-tree portworxVolume type are redirected to the pxd.portworx.com CSI driver.
    @[::JSON::Field(key: "portworxVolume")]
    @[::YAML::Field(key: "portworxVolume")]
    property portworx_volume : PortworxVolumeSource?
    # quobyte represents a Quobyte mount on the host that shares a pod's lifetime. Deprecated: Quobyte is deprecated and the in-tree quobyte type is no longer supported.
    property quobyte : QuobyteVolumeSource?
    # rbd represents a Rados Block Device mount on the host that shares a pod's lifetime. Deprecated: RBD is deprecated and the in-tree rbd type is no longer supported. More info: https://examples.k8s.io/volumes/rbd/README.md
    property rbd : RBDPersistentVolumeSource?
    # scaleIO represents a ScaleIO persistent volume attached and mounted on Kubernetes nodes. Deprecated: ScaleIO is deprecated and the in-tree scaleIO type is no longer supported.
    @[::JSON::Field(key: "scaleIO")]
    @[::YAML::Field(key: "scaleIO")]
    property scale_io : ScaleIOPersistentVolumeSource?
    # storageClassName is the name of StorageClass to which this persistent volume belongs. Empty value means that this volume does not belong to any StorageClass.
    @[::JSON::Field(key: "storageClassName")]
    @[::YAML::Field(key: "storageClassName")]
    property storage_class_name : String?
    # storageOS represents a StorageOS volume that is attached to the kubelet's host machine and mounted into the pod. Deprecated: StorageOS is deprecated and the in-tree storageos type is no longer supported. More info: https://examples.k8s.io/volumes/storageos/README.md
    property storageos : StorageOSPersistentVolumeSource?
    # Name of VolumeAttributesClass to which this persistent volume belongs. Empty value is not allowed. When this field is not set, it indicates that this volume does not belong to any VolumeAttributesClass. This field is mutable and can be changed by the CSI driver after a volume has been updated successfully to a new class. For an unbound PersistentVolume, the volumeAttributesClassName will be matched with unbound PersistentVolumeClaims during the binding process.
    @[::JSON::Field(key: "volumeAttributesClassName")]
    @[::YAML::Field(key: "volumeAttributesClassName")]
    property volume_attributes_class_name : String?
    # volumeMode defines if a volume is intended to be used with a formatted filesystem or to remain in raw block state. Value of Filesystem is implied when not included in spec.
    @[::JSON::Field(key: "volumeMode")]
    @[::YAML::Field(key: "volumeMode")]
    property volume_mode : String?
    # vsphereVolume represents a vSphere volume attached and mounted on kubelets host machine. Deprecated: VsphereVolume is deprecated. All operations for the in-tree vsphereVolume type are redirected to the csi.vsphere.vmware.com CSI driver.
    @[::JSON::Field(key: "vsphereVolume")]
    @[::YAML::Field(key: "vsphereVolume")]
    property vsphere_volume : VsphereVirtualDiskVolumeSource?
  end

  # PersistentVolumeStatus is the current status of a persistent volume.
  struct PersistentVolumeStatus
    include Kubernetes::Serializable

    # lastPhaseTransitionTime is the time the phase transitioned from one to another and automatically resets to current time everytime a volume phase transitions.
    @[::JSON::Field(key: "lastPhaseTransitionTime")]
    @[::YAML::Field(key: "lastPhaseTransitionTime")]
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
    @[::JSON::Field(key: "fsType")]
    @[::YAML::Field(key: "fsType")]
    property fs_type : String?
    # pdID is the ID that identifies Photon Controller persistent disk
    @[::JSON::Field(key: "pdID")]
    @[::YAML::Field(key: "pdID")]
    property pd_id : String?
  end

  # Pod is a collection of containers that can run on a host. This resource is created by clients and scheduled onto hosts.
  struct Pod
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
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
    @[::JSON::Field(key: "preferredDuringSchedulingIgnoredDuringExecution")]
    @[::YAML::Field(key: "preferredDuringSchedulingIgnoredDuringExecution")]
    property preferred_during_scheduling_ignored_during_execution : Array(WeightedPodAffinityTerm)?
    # If the affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to a pod label update), the system may or may not try to eventually evict the pod from its node. When there are multiple elements, the lists of nodes corresponding to each podAffinityTerm are intersected, i.e. all terms must be satisfied.
    @[::JSON::Field(key: "requiredDuringSchedulingIgnoredDuringExecution")]
    @[::YAML::Field(key: "requiredDuringSchedulingIgnoredDuringExecution")]
    property required_during_scheduling_ignored_during_execution : Array(PodAffinityTerm)?
  end

  # Defines a set of pods (namely those matching the labelSelector relative to the given namespace(s)) that this pod should be co-located (affinity) or not co-located (anti-affinity) with, where co-located is defined as running on a node whose value of the label with key <topologyKey> matches that of any node on which a pod of the set of pods is running
  struct PodAffinityTerm
    include Kubernetes::Serializable

    # A label query over a set of resources, in this case pods. If it's null, this PodAffinityTerm matches with no Pods.
    @[::JSON::Field(key: "labelSelector")]
    @[::YAML::Field(key: "labelSelector")]
    property label_selector : LabelSelector?
    # MatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration. The keys are used to lookup values from the incoming pod labels, those key-value labels are merged with `labelSelector` as `key in (value)` to select the group of existing pods which pods will be taken into consideration for the incoming pod's pod (anti) affinity. Keys that don't exist in the incoming pod labels will be ignored. The default value is empty. The same key is forbidden to exist in both matchLabelKeys and labelSelector. Also, matchLabelKeys cannot be set when labelSelector isn't set.
    @[::JSON::Field(key: "matchLabelKeys")]
    @[::YAML::Field(key: "matchLabelKeys")]
    property match_label_keys : Array(String)?
    # MismatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration. The keys are used to lookup values from the incoming pod labels, those key-value labels are merged with `labelSelector` as `key notin (value)` to select the group of existing pods which pods will be taken into consideration for the incoming pod's pod (anti) affinity. Keys that don't exist in the incoming pod labels will be ignored. The default value is empty. The same key is forbidden to exist in both mismatchLabelKeys and labelSelector. Also, mismatchLabelKeys cannot be set when labelSelector isn't set.
    @[::JSON::Field(key: "mismatchLabelKeys")]
    @[::YAML::Field(key: "mismatchLabelKeys")]
    property mismatch_label_keys : Array(String)?
    # A label query over the set of namespaces that the term applies to. The term is applied to the union of the namespaces selected by this field and the ones listed in the namespaces field. null selector and null or empty namespaces list means "this pod's namespace". An empty selector ({}) matches all namespaces.
    @[::JSON::Field(key: "namespaceSelector")]
    @[::YAML::Field(key: "namespaceSelector")]
    property namespace_selector : LabelSelector?
    # namespaces specifies a static list of namespace names that the term applies to. The term is applied to the union of the namespaces listed in this field and the ones selected by namespaceSelector. null or empty namespaces list and null namespaceSelector means "this pod's namespace".
    property namespaces : Array(String)?
    # This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed.
    @[::JSON::Field(key: "topologyKey")]
    @[::YAML::Field(key: "topologyKey")]
    property topology_key : String?
  end

  # Pod anti affinity is a group of inter pod anti affinity scheduling rules.
  struct PodAntiAffinity
    include Kubernetes::Serializable

    # The scheduler will prefer to schedule pods to nodes that satisfy the anti-affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling anti-affinity expressions, etc.), compute a sum by iterating through the elements of this field and subtracting "weight" from the sum if the node has pods which matches the corresponding podAffinityTerm; the node(s) with the highest sum are the most preferred.
    @[::JSON::Field(key: "preferredDuringSchedulingIgnoredDuringExecution")]
    @[::YAML::Field(key: "preferredDuringSchedulingIgnoredDuringExecution")]
    property preferred_during_scheduling_ignored_during_execution : Array(WeightedPodAffinityTerm)?
    # If the anti-affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the anti-affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to a pod label update), the system may or may not try to eventually evict the pod from its node. When there are multiple elements, the lists of nodes corresponding to each podAffinityTerm are intersected, i.e. all terms must be satisfied.
    @[::JSON::Field(key: "requiredDuringSchedulingIgnoredDuringExecution")]
    @[::YAML::Field(key: "requiredDuringSchedulingIgnoredDuringExecution")]
    property required_during_scheduling_ignored_during_execution : Array(PodAffinityTerm)?
  end

  # PodCertificateProjection provides a private key and X.509 certificate in the pod filesystem.
  struct PodCertificateProjection
    include Kubernetes::Serializable

    # Write the certificate chain at this path in the projected volume.
    # Most applications should use credentialBundlePath.  When using keyPath and certificateChainPath, your application needs to check that the key and leaf certificate are consistent, because it is possible to read the files mid-rotation.
    @[::JSON::Field(key: "certificateChainPath")]
    @[::YAML::Field(key: "certificateChainPath")]
    property certificate_chain_path : String?
    # Write the credential bundle at this path in the projected volume.
    # The credential bundle is a single file that contains multiple PEM blocks. The first PEM block is a PRIVATE KEY block, containing a PKCS#8 private key.
    # The remaining blocks are CERTIFICATE blocks, containing the issued certificate chain from the signer (leaf and any intermediates).
    # Using credentialBundlePath lets your Pod's application code make a single atomic read that retrieves a consistent key and certificate chain.  If you project them to separate files, your application code will need to additionally check that the leaf certificate was issued to the key.
    @[::JSON::Field(key: "credentialBundlePath")]
    @[::YAML::Field(key: "credentialBundlePath")]
    property credential_bundle_path : String?
    # Write the key at this path in the projected volume.
    # Most applications should use credentialBundlePath.  When using keyPath and certificateChainPath, your application needs to check that the key and leaf certificate are consistent, because it is possible to read the files mid-rotation.
    @[::JSON::Field(key: "keyPath")]
    @[::YAML::Field(key: "keyPath")]
    property key_path : String?
    # The type of keypair Kubelet will generate for the pod.
    # Valid values are "RSA3072", "RSA4096", "ECDSAP256", "ECDSAP384", "ECDSAP521", and "ED25519".
    @[::JSON::Field(key: "keyType")]
    @[::YAML::Field(key: "keyType")]
    property key_type : String?
    # maxExpirationSeconds is the maximum lifetime permitted for the certificate.
    # Kubelet copies this value verbatim into the PodCertificateRequests it generates for this projection.
    # If omitted, kube-apiserver will set it to 86400(24 hours). kube-apiserver will reject values shorter than 3600 (1 hour).  The maximum allowable value is 7862400 (91 days).
    # The signer implementation is then free to issue a certificate with any lifetime *shorter* than MaxExpirationSeconds, but no shorter than 3600 seconds (1 hour).  This constraint is enforced by kube-apiserver. `kubernetes.io` signers will never issue certificates with a lifetime longer than 24 hours.
    @[::JSON::Field(key: "maxExpirationSeconds")]
    @[::YAML::Field(key: "maxExpirationSeconds")]
    property max_expiration_seconds : Int32?
    # Kubelet's generated CSRs will be addressed to this signer.
    @[::JSON::Field(key: "signerName")]
    @[::YAML::Field(key: "signerName")]
    property signer_name : String?
    # userAnnotations allow pod authors to pass additional information to the signer implementation.  Kubernetes does not restrict or validate this metadata in any way.
    # These values are copied verbatim into the `spec.unverifiedUserAnnotations` field of the PodCertificateRequest objects that Kubelet creates.
    # Entries are subject to the same validation as object metadata annotations, with the addition that all keys must be domain-prefixed. No restrictions are placed on values, except an overall size limitation on the entire field.
    # Signers should document the keys and values they support. Signers should deny requests that contain keys they do not recognize.
    @[::JSON::Field(key: "userAnnotations")]
    @[::YAML::Field(key: "userAnnotations")]
    property user_annotations : Hash(String, String)?
  end

  # PodCondition contains details for the current condition of this pod.
  struct PodCondition
    include Kubernetes::Serializable

    # Last time we probed the condition.
    @[::JSON::Field(key: "lastProbeTime")]
    @[::YAML::Field(key: "lastProbeTime")]
    property last_probe_time : Time?
    # Last time the condition transitioned from one status to another.
    @[::JSON::Field(key: "lastTransitionTime")]
    @[::YAML::Field(key: "lastTransitionTime")]
    property last_transition_time : Time?
    # Human-readable message indicating details about last transition.
    property message : String?
    # If set, this represents the .metadata.generation that the pod condition was set based upon. The PodObservedGenerationTracking feature gate must be enabled to use this field.
    @[::JSON::Field(key: "observedGeneration")]
    @[::YAML::Field(key: "observedGeneration")]
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
    @[::JSON::Field(key: "requestMappings")]
    @[::YAML::Field(key: "requestMappings")]
    property request_mappings : Array(ContainerExtendedResourceRequest)?
    # ResourceClaimName is the name of the ResourceClaim that was generated for the Pod in the namespace of the Pod.
    @[::JSON::Field(key: "resourceClaimName")]
    @[::YAML::Field(key: "resourceClaimName")]
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
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
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
    @[::JSON::Field(key: "conditionType")]
    @[::YAML::Field(key: "conditionType")]
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
    @[::JSON::Field(key: "resourceClaimName")]
    @[::YAML::Field(key: "resourceClaimName")]
    property resource_claim_name : String?
    # ResourceClaimTemplateName is the name of a ResourceClaimTemplate object in the same namespace as this pod.
    # The template will be used to create a new ResourceClaim, which will be bound to this pod. When this pod is deleted, the ResourceClaim will also be deleted. The pod name and resource name, along with a generated component, will be used to form a unique name for the ResourceClaim, which will be recorded in pod.status.resourceClaimStatuses.
    # This field is immutable and no changes will be made to the corresponding ResourceClaim by the control plane after creating the ResourceClaim.
    # Exactly one of ResourceClaimName and ResourceClaimTemplateName must be set.
    @[::JSON::Field(key: "resourceClaimTemplateName")]
    @[::YAML::Field(key: "resourceClaimTemplateName")]
    property resource_claim_template_name : String?
  end

  # PodResourceClaimStatus is stored in the PodStatus for each PodResourceClaim which references a ResourceClaimTemplate. It stores the generated name for the corresponding ResourceClaim.
  struct PodResourceClaimStatus
    include Kubernetes::Serializable

    # Name uniquely identifies this resource claim inside the pod. This must match the name of an entry in pod.spec.resourceClaims, which implies that the string must be a DNS_LABEL.
    property name : String?
    # ResourceClaimName is the name of the ResourceClaim that was generated for the Pod in the namespace of the Pod. If this is unset, then generating a ResourceClaim was not necessary. The pod.spec.resourceClaims entry can be ignored in this case.
    @[::JSON::Field(key: "resourceClaimName")]
    @[::YAML::Field(key: "resourceClaimName")]
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
    @[::JSON::Field(key: "appArmorProfile")]
    @[::YAML::Field(key: "appArmorProfile")]
    property app_armor_profile : AppArmorProfile?
    # A special supplemental group that applies to all containers in a pod. Some volume types allow the Kubelet to change the ownership of that volume to be owned by the pod:
    # 1. The owning GID will be the FSGroup 2. The setgid bit is set (new files created in the volume will be owned by FSGroup) 3. The permission bits are OR'd with rw-rw----
    # If unset, the Kubelet will not modify the ownership and permissions of any volume. Note that this field cannot be set when spec.os.name is windows.
    @[::JSON::Field(key: "fsGroup")]
    @[::YAML::Field(key: "fsGroup")]
    property fs_group : Int64?
    # fsGroupChangePolicy defines behavior of changing ownership and permission of the volume before being exposed inside Pod. This field will only apply to volume types which support fsGroup based ownership(and permissions). It will have no effect on ephemeral volume types such as: secret, configmaps and emptydir. Valid values are "OnRootMismatch" and "Always". If not specified, "Always" is used. Note that this field cannot be set when spec.os.name is windows.
    @[::JSON::Field(key: "fsGroupChangePolicy")]
    @[::YAML::Field(key: "fsGroupChangePolicy")]
    property fs_group_change_policy : String?
    # The GID to run the entrypoint of the container process. Uses runtime default if unset. May also be set in SecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence for that container. Note that this field cannot be set when spec.os.name is windows.
    @[::JSON::Field(key: "runAsGroup")]
    @[::YAML::Field(key: "runAsGroup")]
    property run_as_group : Int64?
    # Indicates that the container must run as a non-root user. If true, the Kubelet will validate the image at runtime to ensure that it does not run as UID 0 (root) and fail to start the container if it does. If unset or false, no such validation will be performed. May also be set in SecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence.
    @[::JSON::Field(key: "runAsNonRoot")]
    @[::YAML::Field(key: "runAsNonRoot")]
    property run_as_non_root : Bool?
    # The UID to run the entrypoint of the container process. Defaults to user specified in image metadata if unspecified. May also be set in SecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence for that container. Note that this field cannot be set when spec.os.name is windows.
    @[::JSON::Field(key: "runAsUser")]
    @[::YAML::Field(key: "runAsUser")]
    property run_as_user : Int64?
    # seLinuxChangePolicy defines how the container's SELinux label is applied to all volumes used by the Pod. It has no effect on nodes that do not support SELinux or to volumes does not support SELinux. Valid values are "MountOption" and "Recursive".
    # "Recursive" means relabeling of all files on all Pod volumes by the container runtime. This may be slow for large volumes, but allows mixing privileged and unprivileged Pods sharing the same volume on the same node.
    # "MountOption" mounts all eligible Pod volumes with `-o context` mount option. This requires all Pods that share the same volume to use the same SELinux label. It is not possible to share the same volume among privileged and unprivileged Pods. Eligible volumes are in-tree FibreChannel and iSCSI volumes, and all CSI volumes whose CSI driver announces SELinux support by setting spec.seLinuxMount: true in their CSIDriver instance. Other volumes are always re-labelled recursively. "MountOption" value is allowed only when SELinuxMount feature gate is enabled.
    # If not specified and SELinuxMount feature gate is enabled, "MountOption" is used. If not specified and SELinuxMount feature gate is disabled, "MountOption" is used for ReadWriteOncePod volumes and "Recursive" for all other volumes.
    # This field affects only Pods that have SELinux label set, either in PodSecurityContext or in SecurityContext of all containers.
    # All Pods that use the same volume should use the same seLinuxChangePolicy, otherwise some pods can get stuck in ContainerCreating state. Note that this field cannot be set when spec.os.name is windows.
    @[::JSON::Field(key: "seLinuxChangePolicy")]
    @[::YAML::Field(key: "seLinuxChangePolicy")]
    property se_linux_change_policy : String?
    # The SELinux context to be applied to all containers. If unspecified, the container runtime will allocate a random SELinux context for each container.  May also be set in SecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence for that container. Note that this field cannot be set when spec.os.name is windows.
    @[::JSON::Field(key: "seLinuxOptions")]
    @[::YAML::Field(key: "seLinuxOptions")]
    property se_linux_options : SELinuxOptions?
    # The seccomp options to use by the containers in this pod. Note that this field cannot be set when spec.os.name is windows.
    @[::JSON::Field(key: "seccompProfile")]
    @[::YAML::Field(key: "seccompProfile")]
    property seccomp_profile : SeccompProfile?
    # A list of groups applied to the first process run in each container, in addition to the container's primary GID and fsGroup (if specified).  If the SupplementalGroupsPolicy feature is enabled, the supplementalGroupsPolicy field determines whether these are in addition to or instead of any group memberships defined in the container image. If unspecified, no additional groups are added, though group memberships defined in the container image may still be used, depending on the supplementalGroupsPolicy field. Note that this field cannot be set when spec.os.name is windows.
    @[::JSON::Field(key: "supplementalGroups")]
    @[::YAML::Field(key: "supplementalGroups")]
    property supplemental_groups : Array(Int64)?
    # Defines how supplemental groups of the first container processes are calculated. Valid values are "Merge" and "Strict". If not specified, "Merge" is used. (Alpha) Using the field requires the SupplementalGroupsPolicy feature gate to be enabled and the container runtime must implement support for this feature. Note that this field cannot be set when spec.os.name is windows.
    @[::JSON::Field(key: "supplementalGroupsPolicy")]
    @[::YAML::Field(key: "supplementalGroupsPolicy")]
    property supplemental_groups_policy : String?
    # Sysctls hold a list of namespaced sysctls used for the pod. Pods with unsupported sysctls (by the container runtime) might fail to launch. Note that this field cannot be set when spec.os.name is windows.
    property sysctls : Array(Sysctl)?
    # The Windows specific settings applied to all containers. If unspecified, the options within a container's SecurityContext will be used. If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence. Note that this field cannot be set when spec.os.name is linux.
    @[::JSON::Field(key: "windowsOptions")]
    @[::YAML::Field(key: "windowsOptions")]
    property windows_options : WindowsSecurityContextOptions?
  end

  # PodSpec is a description of a pod.
  struct PodSpec
    include Kubernetes::Serializable

    # Optional duration in seconds the pod may be active on the node relative to StartTime before the system will actively try to mark it failed and kill associated containers. Value must be a positive integer.
    @[::JSON::Field(key: "activeDeadlineSeconds")]
    @[::YAML::Field(key: "activeDeadlineSeconds")]
    property active_deadline_seconds : Int64?
    # If specified, the pod's scheduling constraints
    property affinity : Affinity?
    # AutomountServiceAccountToken indicates whether a service account token should be automatically mounted.
    @[::JSON::Field(key: "automountServiceAccountToken")]
    @[::YAML::Field(key: "automountServiceAccountToken")]
    property automount_service_account_token : Bool?
    # List of containers belonging to the pod. Containers cannot currently be added or removed. There must be at least one container in a Pod. Cannot be updated.
    property containers : Array(Container)?
    # Specifies the DNS parameters of a pod. Parameters specified here will be merged to the generated DNS configuration based on DNSPolicy.
    @[::JSON::Field(key: "dnsConfig")]
    @[::YAML::Field(key: "dnsConfig")]
    property dns_config : PodDNSConfig?
    # Set DNS policy for the pod. Defaults to "ClusterFirst". Valid values are 'ClusterFirstWithHostNet', 'ClusterFirst', 'Default' or 'None'. DNS parameters given in DNSConfig will be merged with the policy selected with DNSPolicy. To have DNS options set along with hostNetwork, you have to specify DNS policy explicitly to 'ClusterFirstWithHostNet'.
    @[::JSON::Field(key: "dnsPolicy")]
    @[::YAML::Field(key: "dnsPolicy")]
    property dns_policy : String?
    # EnableServiceLinks indicates whether information about services should be injected into pod's environment variables, matching the syntax of Docker links. Optional: Defaults to true.
    @[::JSON::Field(key: "enableServiceLinks")]
    @[::YAML::Field(key: "enableServiceLinks")]
    property enable_service_links : Bool?
    # List of ephemeral containers run in this pod. Ephemeral containers may be run in an existing pod to perform user-initiated actions such as debugging. This list cannot be specified when creating a pod, and it cannot be modified by updating the pod spec. In order to add an ephemeral container to an existing pod, use the pod's ephemeralcontainers subresource.
    @[::JSON::Field(key: "ephemeralContainers")]
    @[::YAML::Field(key: "ephemeralContainers")]
    property ephemeral_containers : Array(EphemeralContainer)?
    # HostAliases is an optional list of hosts and IPs that will be injected into the pod's hosts file if specified.
    @[::JSON::Field(key: "hostAliases")]
    @[::YAML::Field(key: "hostAliases")]
    property host_aliases : Array(HostAlias)?
    # Use the host's ipc namespace. Optional: Default to false.
    @[::JSON::Field(key: "hostIPC")]
    @[::YAML::Field(key: "hostIPC")]
    property host_ipc : Bool?
    # Host networking requested for this pod. Use the host's network namespace. When using HostNetwork you should specify ports so the scheduler is aware. When `hostNetwork` is true, specified `hostPort` fields in port definitions must match `containerPort`, and unspecified `hostPort` fields in port definitions are defaulted to match `containerPort`. Default to false.
    @[::JSON::Field(key: "hostNetwork")]
    @[::YAML::Field(key: "hostNetwork")]
    property host_network : Bool?
    # Use the host's pid namespace. Optional: Default to false.
    @[::JSON::Field(key: "hostPID")]
    @[::YAML::Field(key: "hostPID")]
    property host_pid : Bool?
    # Use the host's user namespace. Optional: Default to true. If set to true or not present, the pod will be run in the host user namespace, useful for when the pod needs a feature only available to the host user namespace, such as loading a kernel module with CAP_SYS_MODULE. When set to false, a new userns is created for the pod. Setting false is useful for mitigating container breakout vulnerabilities even allowing users to run their containers as root without actually having root privileges on the host. This field is alpha-level and is only honored by servers that enable the UserNamespacesSupport feature.
    @[::JSON::Field(key: "hostUsers")]
    @[::YAML::Field(key: "hostUsers")]
    property host_users : Bool?
    # Specifies the hostname of the Pod If not specified, the pod's hostname will be set to a system-defined value.
    property hostname : String?
    # HostnameOverride specifies an explicit override for the pod's hostname as perceived by the pod. This field only specifies the pod's hostname and does not affect its DNS records. When this field is set to a non-empty string: - It takes precedence over the values set in `hostname` and `subdomain`. - The Pod's hostname will be set to this value. - `setHostnameAsFQDN` must be nil or set to false. - `hostNetwork` must be set to false.
    # This field must be a valid DNS subdomain as defined in RFC 1123 and contain at most 64 characters. Requires the HostnameOverride feature gate to be enabled.
    @[::JSON::Field(key: "hostnameOverride")]
    @[::YAML::Field(key: "hostnameOverride")]
    property hostname_override : String?
    # ImagePullSecrets is an optional list of references to secrets in the same namespace to use for pulling any of the images used by this PodSpec. If specified, these secrets will be passed to individual puller implementations for them to use. More info: https://kubernetes.io/docs/concepts/containers/images#specifying-imagepullsecrets-on-a-pod
    @[::JSON::Field(key: "imagePullSecrets")]
    @[::YAML::Field(key: "imagePullSecrets")]
    property image_pull_secrets : Array(LocalObjectReference)?
    # List of initialization containers belonging to the pod. Init containers are executed in order prior to containers being started. If any init container fails, the pod is considered to have failed and is handled according to its restartPolicy. The name for an init container or normal container must be unique among all containers. Init containers may not have Lifecycle actions, Readiness probes, Liveness probes, or Startup probes. The resourceRequirements of an init container are taken into account during scheduling by finding the highest request/limit for each resource type, and then using the max of that value or the sum of the normal containers. Limits are applied to init containers in a similar fashion. Init containers cannot currently be added or removed. Cannot be updated. More info: https://kubernetes.io/docs/concepts/workloads/pods/init-containers/
    @[::JSON::Field(key: "initContainers")]
    @[::YAML::Field(key: "initContainers")]
    property init_containers : Array(Container)?
    # NodeName indicates in which node this pod is scheduled. If empty, this pod is a candidate for scheduling by the scheduler defined in schedulerName. Once this field is set, the kubelet for this node becomes responsible for the lifecycle of this pod. This field should not be used to express a desire for the pod to be scheduled on a specific node. https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#nodename
    @[::JSON::Field(key: "nodeName")]
    @[::YAML::Field(key: "nodeName")]
    property node_name : String?
    # NodeSelector is a selector which must be true for the pod to fit on a node. Selector which must match a node's labels for the pod to be scheduled on that node. More info: https://kubernetes.io/docs/concepts/configuration/assign-pod-node/
    @[::JSON::Field(key: "nodeSelector")]
    @[::YAML::Field(key: "nodeSelector")]
    property node_selector : Hash(String, String)?
    # Specifies the OS of the containers in the pod. Some pod and container fields are restricted if this is set.
    # If the OS field is set to linux, the following fields must be unset: -securityContext.windowsOptions
    # If the OS field is set to windows, following fields must be unset: - spec.hostPID - spec.hostIPC - spec.hostUsers - spec.resources - spec.securityContext.appArmorProfile - spec.securityContext.seLinuxOptions - spec.securityContext.seccompProfile - spec.securityContext.fsGroup - spec.securityContext.fsGroupChangePolicy - spec.securityContext.sysctls - spec.shareProcessNamespace - spec.securityContext.runAsUser - spec.securityContext.runAsGroup - spec.securityContext.supplementalGroups - spec.securityContext.supplementalGroupsPolicy - spec.containers[*].securityContext.appArmorProfile - spec.containers[*].securityContext.seLinuxOptions - spec.containers[*].securityContext.seccompProfile - spec.containers[*].securityContext.capabilities - spec.containers[*].securityContext.readOnlyRootFilesystem - spec.containers[*].securityContext.privileged - spec.containers[*].securityContext.allowPrivilegeEscalation - spec.containers[*].securityContext.procMount - spec.containers[*].securityContext.runAsUser - spec.containers[*].securityContext.runAsGroup
    property os : PodOS?
    # Overhead represents the resource overhead associated with running a pod for a given RuntimeClass. This field will be autopopulated at admission time by the RuntimeClass admission controller. If the RuntimeClass admission controller is enabled, overhead must not be set in Pod create requests. The RuntimeClass admission controller will reject Pod create requests which have the overhead already set. If RuntimeClass is configured and selected in the PodSpec, Overhead will be set to the value defined in the corresponding RuntimeClass, otherwise it will remain unset and treated as zero. More info: https://git.k8s.io/enhancements/keps/sig-node/688-pod-overhead/README.md
    property overhead : Hash(String, Quantity)?
    # PreemptionPolicy is the Policy for preempting pods with lower priority. One of Never, PreemptLowerPriority. Defaults to PreemptLowerPriority if unset.
    @[::JSON::Field(key: "preemptionPolicy")]
    @[::YAML::Field(key: "preemptionPolicy")]
    property preemption_policy : String?
    # The priority value. Various system components use this field to find the priority of the pod. When Priority Admission Controller is enabled, it prevents users from setting this field. The admission controller populates this field from PriorityClassName. The higher the value, the higher the priority.
    property priority : Int32?
    # If specified, indicates the pod's priority. "system-node-critical" and "system-cluster-critical" are two special keywords which indicate the highest priorities with the former being the highest priority. Any other name must be defined by creating a PriorityClass object with that name. If not specified, the pod priority will be default or zero if there is no default.
    @[::JSON::Field(key: "priorityClassName")]
    @[::YAML::Field(key: "priorityClassName")]
    property priority_class_name : String?
    # If specified, all readiness gates will be evaluated for pod readiness. A pod is ready when all its containers are ready AND all conditions specified in the readiness gates have status equal to "True" More info: https://git.k8s.io/enhancements/keps/sig-network/580-pod-readiness-gates
    @[::JSON::Field(key: "readinessGates")]
    @[::YAML::Field(key: "readinessGates")]
    property readiness_gates : Array(PodReadinessGate)?
    # ResourceClaims defines which ResourceClaims must be allocated and reserved before the Pod is allowed to start. The resources will be made available to those containers which consume them by name.
    # This is a stable field but requires that the DynamicResourceAllocation feature gate is enabled.
    # This field is immutable.
    @[::JSON::Field(key: "resourceClaims")]
    @[::YAML::Field(key: "resourceClaims")]
    property resource_claims : Array(PodResourceClaim)?
    # Resources is the total amount of CPU and Memory resources required by all containers in the pod. It supports specifying Requests and Limits for "cpu", "memory" and "hugepages-" resource names only. ResourceClaims are not supported.
    # This field enables fine-grained control over resource allocation for the entire pod, allowing resource sharing among containers in a pod.
    # This is an alpha field and requires enabling the PodLevelResources feature gate.
    property resources : ResourceRequirements?
    # Restart policy for all containers within the pod. One of Always, OnFailure, Never. In some contexts, only a subset of those values may be permitted. Default to Always. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/#restart-policy
    @[::JSON::Field(key: "restartPolicy")]
    @[::YAML::Field(key: "restartPolicy")]
    property restart_policy : String?
    # RuntimeClassName refers to a RuntimeClass object in the node.k8s.io group, which should be used to run this pod.  If no RuntimeClass resource matches the named class, the pod will not be run. If unset or empty, the "legacy" RuntimeClass will be used, which is an implicit class with an empty definition that uses the default runtime handler. More info: https://git.k8s.io/enhancements/keps/sig-node/585-runtime-class
    @[::JSON::Field(key: "runtimeClassName")]
    @[::YAML::Field(key: "runtimeClassName")]
    property runtime_class_name : String?
    # If specified, the pod will be dispatched by specified scheduler. If not specified, the pod will be dispatched by default scheduler.
    @[::JSON::Field(key: "schedulerName")]
    @[::YAML::Field(key: "schedulerName")]
    property scheduler_name : String?
    # SchedulingGates is an opaque list of values that if specified will block scheduling the pod. If schedulingGates is not empty, the pod will stay in the SchedulingGated state and the scheduler will not attempt to schedule the pod.
    # SchedulingGates can only be set at pod creation time, and be removed only afterwards.
    @[::JSON::Field(key: "schedulingGates")]
    @[::YAML::Field(key: "schedulingGates")]
    property scheduling_gates : Array(PodSchedulingGate)?
    # SecurityContext holds pod-level security attributes and common container settings. Optional: Defaults to empty.  See type description for default values of each field.
    @[::JSON::Field(key: "securityContext")]
    @[::YAML::Field(key: "securityContext")]
    property security_context : PodSecurityContext?
    # DeprecatedServiceAccount is a deprecated alias for ServiceAccountName. Deprecated: Use serviceAccountName instead.
    @[::JSON::Field(key: "serviceAccount")]
    @[::YAML::Field(key: "serviceAccount")]
    property service_account : String?
    # ServiceAccountName is the name of the ServiceAccount to use to run this pod. More info: https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/
    @[::JSON::Field(key: "serviceAccountName")]
    @[::YAML::Field(key: "serviceAccountName")]
    property service_account_name : String?
    # If true the pod's hostname will be configured as the pod's FQDN, rather than the leaf name (the default). In Linux containers, this means setting the FQDN in the hostname field of the kernel (the nodename field of struct utsname). In Windows containers, this means setting the registry value of hostname for the registry key HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\Tcpip\\Parameters to FQDN. If a pod does not have FQDN, this has no effect. Default to false.
    @[::JSON::Field(key: "setHostnameAsFQDN")]
    @[::YAML::Field(key: "setHostnameAsFQDN")]
    property set_hostname_as_fqdn : Bool?
    # Share a single process namespace between all of the containers in a pod. When this is set containers will be able to view and signal processes from other containers in the same pod, and the first process in each container will not be assigned PID 1. HostPID and ShareProcessNamespace cannot both be set. Optional: Default to false.
    @[::JSON::Field(key: "shareProcessNamespace")]
    @[::YAML::Field(key: "shareProcessNamespace")]
    property share_process_namespace : Bool?
    # If specified, the fully qualified Pod hostname will be "<hostname>.<subdomain>.<pod namespace>.svc.<cluster domain>". If not specified, the pod will not have a domainname at all.
    property subdomain : String?
    # Optional duration in seconds the pod needs to terminate gracefully. May be decreased in delete request. Value must be non-negative integer. The value zero indicates stop immediately via the kill signal (no opportunity to shut down). If this value is nil, the default grace period will be used instead. The grace period is the duration in seconds after the processes running in the pod are sent a termination signal and the time when the processes are forcibly halted with a kill signal. Set this value longer than the expected cleanup time for your process. Defaults to 30 seconds.
    @[::JSON::Field(key: "terminationGracePeriodSeconds")]
    @[::YAML::Field(key: "terminationGracePeriodSeconds")]
    property termination_grace_period_seconds : Int64?
    # If specified, the pod's tolerations.
    property tolerations : Array(Toleration)?
    # TopologySpreadConstraints describes how a group of pods ought to spread across topology domains. Scheduler will schedule pods in a way which abides by the constraints. All topologySpreadConstraints are ANDed.
    @[::JSON::Field(key: "topologySpreadConstraints")]
    @[::YAML::Field(key: "topologySpreadConstraints")]
    property topology_spread_constraints : Array(TopologySpreadConstraint)?
    # List of volumes that can be mounted by containers belonging to the pod. More info: https://kubernetes.io/docs/concepts/storage/volumes
    property volumes : Array(Volume)?
    # WorkloadRef provides a reference to the Workload object that this Pod belongs to. This field is used by the scheduler to identify the PodGroup and apply the correct group scheduling policies. The Workload object referenced by this field may not exist at the time the Pod is created. This field is immutable, but a Workload object with the same name may be recreated with different policies. Doing this during pod scheduling may result in the placement not conforming to the expected policies.
    @[::JSON::Field(key: "workloadRef")]
    @[::YAML::Field(key: "workloadRef")]
    property workload_ref : WorkloadReference?
  end

  # PodStatus represents information about the status of a pod. Status may trail the actual state of a system, especially if the node that hosts the pod cannot contact the control plane.
  struct PodStatus
    include Kubernetes::Serializable

    # AllocatedResources is the total requests allocated for this pod by the node. If pod-level requests are not set, this will be the total requests aggregated across containers in the pod.
    @[::JSON::Field(key: "allocatedResources")]
    @[::YAML::Field(key: "allocatedResources")]
    property allocated_resources : Hash(String, Quantity)?
    # Current service state of pod. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#pod-conditions
    property conditions : Array(PodCondition)?
    # Statuses of containers in this pod. Each container in the pod should have at most one status in this list, and all statuses should be for containers in the pod. However this is not enforced. If a status for a non-existent container is present in the list, or the list has duplicate names, the behavior of various Kubernetes components is not defined and those statuses might be ignored. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#pod-and-container-status
    @[::JSON::Field(key: "containerStatuses")]
    @[::YAML::Field(key: "containerStatuses")]
    property container_statuses : Array(ContainerStatus)?
    # Statuses for any ephemeral containers that have run in this pod. Each ephemeral container in the pod should have at most one status in this list, and all statuses should be for containers in the pod. However this is not enforced. If a status for a non-existent container is present in the list, or the list has duplicate names, the behavior of various Kubernetes components is not defined and those statuses might be ignored. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#pod-and-container-status
    @[::JSON::Field(key: "ephemeralContainerStatuses")]
    @[::YAML::Field(key: "ephemeralContainerStatuses")]
    property ephemeral_container_statuses : Array(ContainerStatus)?
    # Status of extended resource claim backed by DRA.
    @[::JSON::Field(key: "extendedResourceClaimStatus")]
    @[::YAML::Field(key: "extendedResourceClaimStatus")]
    property extended_resource_claim_status : PodExtendedResourceClaimStatus?
    # hostIP holds the IP address of the host to which the pod is assigned. Empty if the pod has not started yet. A pod can be assigned to a node that has a problem in kubelet which in turns mean that HostIP will not be updated even if there is a node is assigned to pod
    @[::JSON::Field(key: "hostIP")]
    @[::YAML::Field(key: "hostIP")]
    property host_ip : String?
    # hostIPs holds the IP addresses allocated to the host. If this field is specified, the first entry must match the hostIP field. This list is empty if the pod has not started yet. A pod can be assigned to a node that has a problem in kubelet which in turns means that HostIPs will not be updated even if there is a node is assigned to this pod.
    @[::JSON::Field(key: "hostIPs")]
    @[::YAML::Field(key: "hostIPs")]
    property host_i_ps : Array(HostIP)?
    # Statuses of init containers in this pod. The most recent successful non-restartable init container will have ready = true, the most recently started container will have startTime set. Each init container in the pod should have at most one status in this list, and all statuses should be for containers in the pod. However this is not enforced. If a status for a non-existent container is present in the list, or the list has duplicate names, the behavior of various Kubernetes components is not defined and those statuses might be ignored. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/#pod-and-container-status
    @[::JSON::Field(key: "initContainerStatuses")]
    @[::YAML::Field(key: "initContainerStatuses")]
    property init_container_statuses : Array(ContainerStatus)?
    # A human readable message indicating details about why the pod is in this condition.
    property message : String?
    # nominatedNodeName is set only when this pod preempts other pods on the node, but it cannot be scheduled right away as preemption victims receive their graceful termination periods. This field does not guarantee that the pod will be scheduled on this node. Scheduler may decide to place the pod elsewhere if other nodes become available sooner. Scheduler may also decide to give the resources on this node to a higher priority pod that is created after preemption. As a result, this field may be different than PodSpec.nodeName when the pod is scheduled.
    @[::JSON::Field(key: "nominatedNodeName")]
    @[::YAML::Field(key: "nominatedNodeName")]
    property nominated_node_name : String?
    # If set, this represents the .metadata.generation that the pod status was set based upon. The PodObservedGenerationTracking feature gate must be enabled to use this field.
    @[::JSON::Field(key: "observedGeneration")]
    @[::YAML::Field(key: "observedGeneration")]
    property observed_generation : Int64?
    # The phase of a Pod is a simple, high-level summary of where the Pod is in its lifecycle. The conditions array, the reason and message fields, and the individual container status arrays contain more detail about the pod's status. There are five possible phase values:
    # Pending: The pod has been accepted by the Kubernetes system, but one or more of the container images has not been created. This includes time before being scheduled as well as time spent downloading images over the network, which could take a while. Running: The pod has been bound to a node, and all of the containers have been created. At least one container is still running, or is in the process of starting or restarting. Succeeded: All containers in the pod have terminated in success, and will not be restarted. Failed: All containers in the pod have terminated, and at least one container has terminated in failure. The container either exited with non-zero status or was terminated by the system. Unknown: For some reason the state of the pod could not be obtained, typically due to an error in communicating with the host of the pod.
    # More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#pod-phase
    property phase : String?
    # podIP address allocated to the pod. Routable at least within the cluster. Empty if not yet allocated.
    @[::JSON::Field(key: "podIP")]
    @[::YAML::Field(key: "podIP")]
    property pod_ip : String?
    # podIPs holds the IP addresses allocated to the pod. If this field is specified, the 0th entry must match the podIP field. Pods may be allocated at most 1 value for each of IPv4 and IPv6. This list is empty if no IPs have been allocated yet.
    @[::JSON::Field(key: "podIPs")]
    @[::YAML::Field(key: "podIPs")]
    property pod_i_ps : Array(PodIP)?
    # The Quality of Service (QOS) classification assigned to the pod based on resource requirements See PodQOSClass type for available QOS classes More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-qos/#quality-of-service-classes
    @[::JSON::Field(key: "qosClass")]
    @[::YAML::Field(key: "qosClass")]
    property qos_class : String?
    # A brief CamelCase message indicating details about why the pod is in this state. e.g. 'Evicted'
    property reason : String?
    # Status of resources resize desired for pod's containers. It is empty if no resources resize is pending. Any changes to container resources will automatically set this to "Proposed" Deprecated: Resize status is moved to two pod conditions PodResizePending and PodResizeInProgress. PodResizePending will track states where the spec has been resized, but the Kubelet has not yet allocated the resources. PodResizeInProgress will track in-progress resizes, and should be present whenever allocated resources != acknowledged resources.
    property resize : String?
    # Status of resource claims.
    @[::JSON::Field(key: "resourceClaimStatuses")]
    @[::YAML::Field(key: "resourceClaimStatuses")]
    property resource_claim_statuses : Array(PodResourceClaimStatus)?
    # Resources represents the compute resource requests and limits that have been applied at the pod level if pod-level requests or limits are set in PodSpec.Resources
    property resources : ResourceRequirements?
    # RFC 3339 date and time at which the object was acknowledged by the Kubelet. This is before the Kubelet pulled the container image(s) for the pod.
    @[::JSON::Field(key: "startTime")]
    @[::YAML::Field(key: "startTime")]
    property start_time : Time?
  end

  # PodTemplate describes a template for creating copies of a predefined pod.
  struct PodTemplate
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
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
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
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
    @[::JSON::Field(key: "fsType")]
    @[::YAML::Field(key: "fsType")]
    property fs_type : String?
    # readOnly defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts.
    @[::JSON::Field(key: "readOnly")]
    @[::YAML::Field(key: "readOnly")]
    property read_only : Bool?
    # volumeID uniquely identifies a Portworx volume
    @[::JSON::Field(key: "volumeID")]
    @[::YAML::Field(key: "volumeID")]
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
    @[::JSON::Field(key: "failureThreshold")]
    @[::YAML::Field(key: "failureThreshold")]
    property failure_threshold : Int32?
    # GRPC specifies a GRPC HealthCheckRequest.
    property grpc : GRPCAction?
    # HTTPGet specifies an HTTP GET request to perform.
    @[::JSON::Field(key: "httpGet")]
    @[::YAML::Field(key: "httpGet")]
    property http_get : HTTPGetAction?
    # Number of seconds after the container has started before liveness probes are initiated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
    @[::JSON::Field(key: "initialDelaySeconds")]
    @[::YAML::Field(key: "initialDelaySeconds")]
    property initial_delay_seconds : Int32?
    # How often (in seconds) to perform the probe. Default to 10 seconds. Minimum value is 1.
    @[::JSON::Field(key: "periodSeconds")]
    @[::YAML::Field(key: "periodSeconds")]
    property period_seconds : Int32?
    # Minimum consecutive successes for the probe to be considered successful after having failed. Defaults to 1. Must be 1 for liveness and startup. Minimum value is 1.
    @[::JSON::Field(key: "successThreshold")]
    @[::YAML::Field(key: "successThreshold")]
    property success_threshold : Int32?
    # TCPSocket specifies a connection to a TCP port.
    @[::JSON::Field(key: "tcpSocket")]
    @[::YAML::Field(key: "tcpSocket")]
    property tcp_socket : TCPSocketAction?
    # Optional duration in seconds the pod needs to terminate gracefully upon probe failure. The grace period is the duration in seconds after the processes running in the pod are sent a termination signal and the time when the processes are forcibly halted with a kill signal. Set this value longer than the expected cleanup time for your process. If this value is nil, the pod's terminationGracePeriodSeconds will be used. Otherwise, this value overrides the value provided by the pod spec. Value must be non-negative integer. The value zero indicates stop immediately via the kill signal (no opportunity to shut down). This is a beta field and requires enabling ProbeTerminationGracePeriod feature gate. Minimum value is 1. spec.terminationGracePeriodSeconds is used if unset.
    @[::JSON::Field(key: "terminationGracePeriodSeconds")]
    @[::YAML::Field(key: "terminationGracePeriodSeconds")]
    property termination_grace_period_seconds : Int64?
    # Number of seconds after which the probe times out. Defaults to 1 second. Minimum value is 1. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
    @[::JSON::Field(key: "timeoutSeconds")]
    @[::YAML::Field(key: "timeoutSeconds")]
    property timeout_seconds : Int32?
  end

  # Represents a projected volume source
  struct ProjectedVolumeSource
    include Kubernetes::Serializable

    # defaultMode are the mode bits used to set permissions on created files by default. Must be an octal value between 0000 and 0777 or a decimal value between 0 and 511. YAML accepts both octal and decimal values, JSON requires decimal values for mode bits. Directories within the path are not affected by this setting. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set.
    @[::JSON::Field(key: "defaultMode")]
    @[::YAML::Field(key: "defaultMode")]
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
    @[::JSON::Field(key: "readOnly")]
    @[::YAML::Field(key: "readOnly")]
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
    @[::JSON::Field(key: "fsType")]
    @[::YAML::Field(key: "fsType")]
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
    @[::JSON::Field(key: "readOnly")]
    @[::YAML::Field(key: "readOnly")]
    property read_only : Bool?
    # secretRef is name of the authentication secret for RBDUser. If provided overrides keyring. Default is nil. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it
    @[::JSON::Field(key: "secretRef")]
    @[::YAML::Field(key: "secretRef")]
    property secret_ref : SecretReference?
    # user is the rados user name. Default is admin. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it
    property user : String?
  end

  # Represents a Rados Block Device mount that lasts the lifetime of a pod. RBD volumes support ownership management and SELinux relabeling.
  struct RBDVolumeSource
    include Kubernetes::Serializable

    # fsType is the filesystem type of the volume that you want to mount. Tip: Ensure that the filesystem type is supported by the host operating system. Examples: "ext4", "xfs", "ntfs". Implicitly inferred to be "ext4" if unspecified. More info: https://kubernetes.io/docs/concepts/storage/volumes#rbd
    @[::JSON::Field(key: "fsType")]
    @[::YAML::Field(key: "fsType")]
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
    @[::JSON::Field(key: "readOnly")]
    @[::YAML::Field(key: "readOnly")]
    property read_only : Bool?
    # secretRef is name of the authentication secret for RBDUser. If provided overrides keyring. Default is nil. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it
    @[::JSON::Field(key: "secretRef")]
    @[::YAML::Field(key: "secretRef")]
    property secret_ref : LocalObjectReference?
    # user is the rados user name. Default is admin. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it
    property user : String?
  end

  # ReplicationController represents the configuration of a replication controller.
  struct ReplicationController
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
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
    @[::JSON::Field(key: "lastTransitionTime")]
    @[::YAML::Field(key: "lastTransitionTime")]
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
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
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
    @[::JSON::Field(key: "minReadySeconds")]
    @[::YAML::Field(key: "minReadySeconds")]
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
    @[::JSON::Field(key: "availableReplicas")]
    @[::YAML::Field(key: "availableReplicas")]
    property available_replicas : Int32?
    # Represents the latest available observations of a replication controller's current state.
    property conditions : Array(ReplicationControllerCondition)?
    # The number of pods that have labels matching the labels of the pod template of the replication controller.
    @[::JSON::Field(key: "fullyLabeledReplicas")]
    @[::YAML::Field(key: "fullyLabeledReplicas")]
    property fully_labeled_replicas : Int32?
    # ObservedGeneration reflects the generation of the most recently observed replication controller.
    @[::JSON::Field(key: "observedGeneration")]
    @[::YAML::Field(key: "observedGeneration")]
    property observed_generation : Int64?
    # The number of ready replicas for this replication controller.
    @[::JSON::Field(key: "readyReplicas")]
    @[::YAML::Field(key: "readyReplicas")]
    property ready_replicas : Int32?
    # Replicas is the most recently observed number of replicas. More info: https://kubernetes.io/docs/concepts/workloads/controllers/replicationcontroller#what-is-a-replicationcontroller
    property replicas : Int32?
  end

  # ResourceClaim references one entry in PodSpec.ResourceClaims.
  struct ResourceClaim
    include Kubernetes::Serializable

    # Name must match the name of one entry in pod.spec.resourceClaims of the Pod where this field is used. It makes that resource available inside a container.
    property name : String?
    # Request is the name chosen for a request in the referenced claim. If empty, everything from the claim is made available, otherwise only the result of this request.
    property request : String?
  end

  # ResourceFieldSelector represents container resources (cpu, memory) and their output format
  struct ResourceFieldSelector
    include Kubernetes::Serializable

    # Container name: required for volumes, optional for env vars
    @[::JSON::Field(key: "containerName")]
    @[::YAML::Field(key: "containerName")]
    property container_name : String?
    # Specifies the output format of the exposed resources, defaults to "1"
    property divisor : Quantity?
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
    @[::JSON::Field(key: "resourceID")]
    @[::YAML::Field(key: "resourceID")]
    property resource_id : String?
  end

  # ResourceQuota sets aggregate quota restrictions enforced per namespace
  struct ResourceQuota
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
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
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
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
    property hard : Hash(String, Quantity)?
    # scopeSelector is also a collection of filters like scopes that must match each object tracked by a quota but expressed using ScopeSelectorOperator in combination with possible values. For a resource to match, both scopes AND scopeSelector (if specified in spec), must be matched.
    @[::JSON::Field(key: "scopeSelector")]
    @[::YAML::Field(key: "scopeSelector")]
    property scope_selector : ScopeSelector?
    # A collection of filters that must match each object tracked by a quota. If not specified, the quota matches all objects.
    property scopes : Array(String)?
  end

  # ResourceQuotaStatus defines the enforced hard limits and observed use.
  struct ResourceQuotaStatus
    include Kubernetes::Serializable

    # Hard is the set of enforced hard limits for each named resource. More info: https://kubernetes.io/docs/concepts/policy/resource-quotas/
    property hard : Hash(String, Quantity)?
    # Used is the current observed total usage of the resource in the namespace.
    property used : Hash(String, Quantity)?
  end

  # ResourceRequirements describes the compute resource requirements.
  struct ResourceRequirements
    include Kubernetes::Serializable

    # Claims lists the names of resources, defined in spec.resourceClaims, that are used by this container.
    # This field depends on the DynamicResourceAllocation feature gate.
    # This field is immutable. It can only be set for containers.
    property claims : Array(ResourceClaim)?
    # Limits describes the maximum amount of compute resources allowed. More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
    property limits : Hash(String, Quantity)?
    # Requests describes the minimum amount of compute resources required. If Requests is omitted for a container, it defaults to Limits if that is explicitly specified, otherwise to an implementation-defined value. Requests cannot exceed Limits. More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
    property requests : Hash(String, Quantity)?
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
    @[::JSON::Field(key: "fsType")]
    @[::YAML::Field(key: "fsType")]
    property fs_type : String?
    # gateway is the host address of the ScaleIO API Gateway.
    property gateway : String?
    # protectionDomain is the name of the ScaleIO Protection Domain for the configured storage.
    @[::JSON::Field(key: "protectionDomain")]
    @[::YAML::Field(key: "protectionDomain")]
    property protection_domain : String?
    # readOnly defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts.
    @[::JSON::Field(key: "readOnly")]
    @[::YAML::Field(key: "readOnly")]
    property read_only : Bool?
    # secretRef references to the secret for ScaleIO user and other sensitive information. If this is not provided, Login operation will fail.
    @[::JSON::Field(key: "secretRef")]
    @[::YAML::Field(key: "secretRef")]
    property secret_ref : SecretReference?
    # sslEnabled is the flag to enable/disable SSL communication with Gateway, default false
    @[::JSON::Field(key: "sslEnabled")]
    @[::YAML::Field(key: "sslEnabled")]
    property ssl_enabled : Bool?
    # storageMode indicates whether the storage for a volume should be ThickProvisioned or ThinProvisioned. Default is ThinProvisioned.
    @[::JSON::Field(key: "storageMode")]
    @[::YAML::Field(key: "storageMode")]
    property storage_mode : String?
    # storagePool is the ScaleIO Storage Pool associated with the protection domain.
    @[::JSON::Field(key: "storagePool")]
    @[::YAML::Field(key: "storagePool")]
    property storage_pool : String?
    # system is the name of the storage system as configured in ScaleIO.
    property system : String?
    # volumeName is the name of a volume already created in the ScaleIO system that is associated with this volume source.
    @[::JSON::Field(key: "volumeName")]
    @[::YAML::Field(key: "volumeName")]
    property volume_name : String?
  end

  # ScaleIOVolumeSource represents a persistent ScaleIO volume
  struct ScaleIOVolumeSource
    include Kubernetes::Serializable

    # fsType is the filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. "ext4", "xfs", "ntfs". Default is "xfs".
    @[::JSON::Field(key: "fsType")]
    @[::YAML::Field(key: "fsType")]
    property fs_type : String?
    # gateway is the host address of the ScaleIO API Gateway.
    property gateway : String?
    # protectionDomain is the name of the ScaleIO Protection Domain for the configured storage.
    @[::JSON::Field(key: "protectionDomain")]
    @[::YAML::Field(key: "protectionDomain")]
    property protection_domain : String?
    # readOnly Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts.
    @[::JSON::Field(key: "readOnly")]
    @[::YAML::Field(key: "readOnly")]
    property read_only : Bool?
    # secretRef references to the secret for ScaleIO user and other sensitive information. If this is not provided, Login operation will fail.
    @[::JSON::Field(key: "secretRef")]
    @[::YAML::Field(key: "secretRef")]
    property secret_ref : LocalObjectReference?
    # sslEnabled Flag enable/disable SSL communication with Gateway, default false
    @[::JSON::Field(key: "sslEnabled")]
    @[::YAML::Field(key: "sslEnabled")]
    property ssl_enabled : Bool?
    # storageMode indicates whether the storage for a volume should be ThickProvisioned or ThinProvisioned. Default is ThinProvisioned.
    @[::JSON::Field(key: "storageMode")]
    @[::YAML::Field(key: "storageMode")]
    property storage_mode : String?
    # storagePool is the ScaleIO Storage Pool associated with the protection domain.
    @[::JSON::Field(key: "storagePool")]
    @[::YAML::Field(key: "storagePool")]
    property storage_pool : String?
    # system is the name of the storage system as configured in ScaleIO.
    property system : String?
    # volumeName is the name of a volume already created in the ScaleIO system that is associated with this volume source.
    @[::JSON::Field(key: "volumeName")]
    @[::YAML::Field(key: "volumeName")]
    property volume_name : String?
  end

  # A scope selector represents the AND of the selectors represented by the scoped-resource selector requirements.
  struct ScopeSelector
    include Kubernetes::Serializable

    # A list of scope selector requirements by scope of the resources.
    @[::JSON::Field(key: "matchExpressions")]
    @[::YAML::Field(key: "matchExpressions")]
    property match_expressions : Array(ScopedResourceSelectorRequirement)?
  end

  # A scoped-resource selector requirement is a selector that contains values, a scope name, and an operator that relates the scope name and values.
  struct ScopedResourceSelectorRequirement
    include Kubernetes::Serializable

    # Represents a scope's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist.
    property operator : String?
    # The name of the scope that the selector applies to.
    @[::JSON::Field(key: "scopeName")]
    @[::YAML::Field(key: "scopeName")]
    property scope_name : String?
    # An array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch.
    property values : Array(String)?
  end

  # SeccompProfile defines a pod/container's seccomp profile settings. Only one profile source may be set.
  struct SeccompProfile
    include Kubernetes::Serializable

    # localhostProfile indicates a profile defined in a file on the node should be used. The profile must be preconfigured on the node to work. Must be a descending path, relative to the kubelet's configured seccomp profile location. Must be set if type is "Localhost". Must NOT be set for any other type.
    @[::JSON::Field(key: "localhostProfile")]
    @[::YAML::Field(key: "localhostProfile")]
    property localhost_profile : String?
    # type indicates which kind of seccomp profile will be applied. Valid options are:
    # Localhost - a profile defined in a file on the node should be used. RuntimeDefault - the container runtime default profile should be used. Unconfined - no profile should be applied.
    property type : String?
  end

  # Secret holds secret data of a certain type. The total bytes of the values in the Data field must be less than MaxSecretSize bytes.
  struct Secret
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
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
    @[::JSON::Field(key: "stringData")]
    @[::YAML::Field(key: "stringData")]
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
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
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
    @[::JSON::Field(key: "defaultMode")]
    @[::YAML::Field(key: "defaultMode")]
    property default_mode : Int32?
    # items If unspecified, each key-value pair in the Data field of the referenced Secret will be projected into the volume as a file whose name is the key and content is the value. If specified, the listed keys will be projected into the specified paths, and unlisted keys will not be present. If a key is specified which is not present in the Secret, the volume setup will error unless it is marked optional. Paths must be relative and may not contain the '..' path or start with '..'.
    property items : Array(KeyToPath)?
    # optional field specify whether the Secret or its keys must be defined
    property optional : Bool?
    # secretName is the name of the secret in the pod's namespace to use. More info: https://kubernetes.io/docs/concepts/storage/volumes#secret
    @[::JSON::Field(key: "secretName")]
    @[::YAML::Field(key: "secretName")]
    property secret_name : String?
  end

  # SecurityContext holds security configuration that will be applied to a container. Some fields are present in both SecurityContext and PodSecurityContext.  When both are set, the values in SecurityContext take precedence.
  struct SecurityContext
    include Kubernetes::Serializable

    # AllowPrivilegeEscalation controls whether a process can gain more privileges than its parent process. This bool directly controls if the no_new_privs flag will be set on the container process. AllowPrivilegeEscalation is true always when the container is: 1) run as Privileged 2) has CAP_SYS_ADMIN Note that this field cannot be set when spec.os.name is windows.
    @[::JSON::Field(key: "allowPrivilegeEscalation")]
    @[::YAML::Field(key: "allowPrivilegeEscalation")]
    property allow_privilege_escalation : Bool?
    # appArmorProfile is the AppArmor options to use by this container. If set, this profile overrides the pod's appArmorProfile. Note that this field cannot be set when spec.os.name is windows.
    @[::JSON::Field(key: "appArmorProfile")]
    @[::YAML::Field(key: "appArmorProfile")]
    property app_armor_profile : AppArmorProfile?
    # The capabilities to add/drop when running containers. Defaults to the default set of capabilities granted by the container runtime. Note that this field cannot be set when spec.os.name is windows.
    property capabilities : Capabilities?
    # Run container in privileged mode. Processes in privileged containers are essentially equivalent to root on the host. Defaults to false. Note that this field cannot be set when spec.os.name is windows.
    property privileged : Bool?
    # procMount denotes the type of proc mount to use for the containers. The default value is Default which uses the container runtime defaults for readonly paths and masked paths. This requires the ProcMountType feature flag to be enabled. Note that this field cannot be set when spec.os.name is windows.
    @[::JSON::Field(key: "procMount")]
    @[::YAML::Field(key: "procMount")]
    property proc_mount : String?
    # Whether this container has a read-only root filesystem. Default is false. Note that this field cannot be set when spec.os.name is windows.
    @[::JSON::Field(key: "readOnlyRootFilesystem")]
    @[::YAML::Field(key: "readOnlyRootFilesystem")]
    property read_only_root_filesystem : Bool?
    # The GID to run the entrypoint of the container process. Uses runtime default if unset. May also be set in PodSecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence. Note that this field cannot be set when spec.os.name is windows.
    @[::JSON::Field(key: "runAsGroup")]
    @[::YAML::Field(key: "runAsGroup")]
    property run_as_group : Int64?
    # Indicates that the container must run as a non-root user. If true, the Kubelet will validate the image at runtime to ensure that it does not run as UID 0 (root) and fail to start the container if it does. If unset or false, no such validation will be performed. May also be set in PodSecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence.
    @[::JSON::Field(key: "runAsNonRoot")]
    @[::YAML::Field(key: "runAsNonRoot")]
    property run_as_non_root : Bool?
    # The UID to run the entrypoint of the container process. Defaults to user specified in image metadata if unspecified. May also be set in PodSecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence. Note that this field cannot be set when spec.os.name is windows.
    @[::JSON::Field(key: "runAsUser")]
    @[::YAML::Field(key: "runAsUser")]
    property run_as_user : Int64?
    # The SELinux context to be applied to the container. If unspecified, the container runtime will allocate a random SELinux context for each container.  May also be set in PodSecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence. Note that this field cannot be set when spec.os.name is windows.
    @[::JSON::Field(key: "seLinuxOptions")]
    @[::YAML::Field(key: "seLinuxOptions")]
    property se_linux_options : SELinuxOptions?
    # The seccomp options to use by this container. If seccomp options are provided at both the pod & container level, the container options override the pod options. Note that this field cannot be set when spec.os.name is windows.
    @[::JSON::Field(key: "seccompProfile")]
    @[::YAML::Field(key: "seccompProfile")]
    property seccomp_profile : SeccompProfile?
    # The Windows specific settings applied to all containers. If unspecified, the options from the PodSecurityContext will be used. If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence. Note that this field cannot be set when spec.os.name is linux.
    @[::JSON::Field(key: "windowsOptions")]
    @[::YAML::Field(key: "windowsOptions")]
    property windows_options : WindowsSecurityContextOptions?
  end

  # Service is a named abstraction of software service (for example, mysql) consisting of local port (for example 3306) that the proxy listens on, and the selector that determines which pods will answer requests sent through the proxy.
  struct Service
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
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
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
    property api_version : String?
    # AutomountServiceAccountToken indicates whether pods running as this service account should have an API token automatically mounted. Can be overridden at the pod level.
    @[::JSON::Field(key: "automountServiceAccountToken")]
    @[::YAML::Field(key: "automountServiceAccountToken")]
    property automount_service_account_token : Bool?
    # ImagePullSecrets is a list of references to secrets in the same namespace to use for pulling any images in pods that reference this ServiceAccount. ImagePullSecrets are distinct from Secrets because Secrets can be mounted in the pod, but ImagePullSecrets are only accessed by the kubelet. More info: https://kubernetes.io/docs/concepts/containers/images/#specifying-imagepullsecrets-on-a-pod
    @[::JSON::Field(key: "imagePullSecrets")]
    @[::YAML::Field(key: "imagePullSecrets")]
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
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
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
    @[::JSON::Field(key: "expirationSeconds")]
    @[::YAML::Field(key: "expirationSeconds")]
    property expiration_seconds : Int64?
    # path is the path relative to the mount point of the file to project the token into.
    property path : String?
  end

  # ServiceList holds a list of services.
  struct ServiceList
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
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
    @[::JSON::Field(key: "appProtocol")]
    @[::YAML::Field(key: "appProtocol")]
    property app_protocol : String?
    # The name of this port within the service. This must be a DNS_LABEL. All ports within a ServiceSpec must have unique names. When considering the endpoints for a Service, this must match the 'name' field in the EndpointPort. Optional if only one ServicePort is defined on this service.
    property name : String?
    # The port on each node on which this service is exposed when type is NodePort or LoadBalancer.  Usually assigned by the system. If a value is specified, in-range, and not in use it will be used, otherwise the operation will fail.  If not specified, a port will be allocated if this Service requires one.  If this field is specified when creating a Service which does not need it, creation will fail. This field will be wiped when updating a Service to no longer need it (e.g. changing type from NodePort to ClusterIP). More info: https://kubernetes.io/docs/concepts/services-networking/service/#type-nodeport
    @[::JSON::Field(key: "nodePort")]
    @[::YAML::Field(key: "nodePort")]
    property node_port : Int32?
    # The port that will be exposed by this service.
    property port : Int32?
    # The IP protocol for this port. Supports "TCP", "UDP", and "SCTP". Default is TCP.
    property protocol : String?
    # Number or name of the port to access on the pods targeted by the service. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME. If this is a string, it will be looked up as a named port in the target Pod's container ports. If this is not specified, the value of the 'port' field is used (an identity map). This field is ignored for services with clusterIP=None, and should be omitted or set equal to the 'port' field. More info: https://kubernetes.io/docs/concepts/services-networking/service/#defining-a-service
    @[::JSON::Field(key: "targetPort")]
    @[::YAML::Field(key: "targetPort")]
    property target_port : IntOrString?
  end

  # ServiceSpec describes the attributes that a user creates on a service.
  struct ServiceSpec
    include Kubernetes::Serializable

    # allocateLoadBalancerNodePorts defines if NodePorts will be automatically allocated for services with type LoadBalancer.  Default is "true". It may be set to "false" if the cluster load-balancer does not rely on NodePorts.  If the caller requests specific NodePorts (by specifying a value), those requests will be respected, regardless of this field. This field may only be set for services with type LoadBalancer and will be cleared if the type is changed to any other type.
    @[::JSON::Field(key: "allocateLoadBalancerNodePorts")]
    @[::YAML::Field(key: "allocateLoadBalancerNodePorts")]
    property allocate_load_balancer_node_ports : Bool?
    # clusterIP is the IP address of the service and is usually assigned randomly. If an address is specified manually, is in-range (as per system configuration), and is not in use, it will be allocated to the service; otherwise creation of the service will fail. This field may not be changed through updates unless the type field is also being changed to ExternalName (which requires this field to be blank) or the type field is being changed from ExternalName (in which case this field may optionally be specified, as describe above).  Valid values are "None", empty string (""), or a valid IP address. Setting this to "None" makes a "headless service" (no virtual IP), which is useful when direct endpoint connections are preferred and proxying is not required.  Only applies to types ClusterIP, NodePort, and LoadBalancer. If this field is specified when creating a Service of type ExternalName, creation will fail. This field will be wiped when updating a Service to type ExternalName. More info: https://kubernetes.io/docs/concepts/services-networking/service/#virtual-ips-and-service-proxies
    @[::JSON::Field(key: "clusterIP")]
    @[::YAML::Field(key: "clusterIP")]
    property cluster_ip : String?
    # ClusterIPs is a list of IP addresses assigned to this service, and are usually assigned randomly.  If an address is specified manually, is in-range (as per system configuration), and is not in use, it will be allocated to the service; otherwise creation of the service will fail. This field may not be changed through updates unless the type field is also being changed to ExternalName (which requires this field to be empty) or the type field is being changed from ExternalName (in which case this field may optionally be specified, as describe above).  Valid values are "None", empty string (""), or a valid IP address.  Setting this to "None" makes a "headless service" (no virtual IP), which is useful when direct endpoint connections are preferred and proxying is not required.  Only applies to types ClusterIP, NodePort, and LoadBalancer. If this field is specified when creating a Service of type ExternalName, creation will fail. This field will be wiped when updating a Service to type ExternalName.  If this field is not specified, it will be initialized from the clusterIP field.  If this field is specified, clients must ensure that clusterIPs[0] and clusterIP have the same value.
    # This field may hold a maximum of two entries (dual-stack IPs, in either order). These IPs must correspond to the values of the ipFamilies field. Both clusterIPs and ipFamilies are governed by the ipFamilyPolicy field. More info: https://kubernetes.io/docs/concepts/services-networking/service/#virtual-ips-and-service-proxies
    @[::JSON::Field(key: "clusterIPs")]
    @[::YAML::Field(key: "clusterIPs")]
    property cluster_i_ps : Array(String)?
    # externalIPs is a list of IP addresses for which nodes in the cluster will also accept traffic for this service.  These IPs are not managed by Kubernetes.  The user is responsible for ensuring that traffic arrives at a node with this IP.  A common example is external load-balancers that are not part of the Kubernetes system.
    @[::JSON::Field(key: "externalIPs")]
    @[::YAML::Field(key: "externalIPs")]
    property external_i_ps : Array(String)?
    # externalName is the external reference that discovery mechanisms will return as an alias for this service (e.g. a DNS CNAME record). No proxying will be involved.  Must be a lowercase RFC-1123 hostname (https://tools.ietf.org/html/rfc1123) and requires `type` to be "ExternalName".
    @[::JSON::Field(key: "externalName")]
    @[::YAML::Field(key: "externalName")]
    property external_name : String?
    # externalTrafficPolicy describes how nodes distribute service traffic they receive on one of the Service's "externally-facing" addresses (NodePorts, ExternalIPs, and LoadBalancer IPs). If set to "Local", the proxy will configure the service in a way that assumes that external load balancers will take care of balancing the service traffic between nodes, and so each node will deliver traffic only to the node-local endpoints of the service, without masquerading the client source IP. (Traffic mistakenly sent to a node with no endpoints will be dropped.) The default value, "Cluster", uses the standard behavior of routing to all endpoints evenly (possibly modified by topology and other features). Note that traffic sent to an External IP or LoadBalancer IP from within the cluster will always get "Cluster" semantics, but clients sending to a NodePort from within the cluster may need to take traffic policy into account when picking a node.
    @[::JSON::Field(key: "externalTrafficPolicy")]
    @[::YAML::Field(key: "externalTrafficPolicy")]
    property external_traffic_policy : String?
    # healthCheckNodePort specifies the healthcheck nodePort for the service. This only applies when type is set to LoadBalancer and externalTrafficPolicy is set to Local. If a value is specified, is in-range, and is not in use, it will be used.  If not specified, a value will be automatically allocated.  External systems (e.g. load-balancers) can use this port to determine if a given node holds endpoints for this service or not.  If this field is specified when creating a Service which does not need it, creation will fail. This field will be wiped when updating a Service to no longer need it (e.g. changing type). This field cannot be updated once set.
    @[::JSON::Field(key: "healthCheckNodePort")]
    @[::YAML::Field(key: "healthCheckNodePort")]
    property health_check_node_port : Int32?
    # InternalTrafficPolicy describes how nodes distribute service traffic they receive on the ClusterIP. If set to "Local", the proxy will assume that pods only want to talk to endpoints of the service on the same node as the pod, dropping the traffic if there are no local endpoints. The default value, "Cluster", uses the standard behavior of routing to all endpoints evenly (possibly modified by topology and other features).
    @[::JSON::Field(key: "internalTrafficPolicy")]
    @[::YAML::Field(key: "internalTrafficPolicy")]
    property internal_traffic_policy : String?
    # IPFamilies is a list of IP families (e.g. IPv4, IPv6) assigned to this service. This field is usually assigned automatically based on cluster configuration and the ipFamilyPolicy field. If this field is specified manually, the requested family is available in the cluster, and ipFamilyPolicy allows it, it will be used; otherwise creation of the service will fail. This field is conditionally mutable: it allows for adding or removing a secondary IP family, but it does not allow changing the primary IP family of the Service. Valid values are "IPv4" and "IPv6".  This field only applies to Services of types ClusterIP, NodePort, and LoadBalancer, and does apply to "headless" services. This field will be wiped when updating a Service to type ExternalName.
    # This field may hold a maximum of two entries (dual-stack families, in either order).  These families must correspond to the values of the clusterIPs field, if specified. Both clusterIPs and ipFamilies are governed by the ipFamilyPolicy field.
    @[::JSON::Field(key: "ipFamilies")]
    @[::YAML::Field(key: "ipFamilies")]
    property ip_families : Array(String)?
    # IPFamilyPolicy represents the dual-stack-ness requested or required by this Service. If there is no value provided, then this field will be set to SingleStack. Services can be "SingleStack" (a single IP family), "PreferDualStack" (two IP families on dual-stack configured clusters or a single IP family on single-stack clusters), or "RequireDualStack" (two IP families on dual-stack configured clusters, otherwise fail). The ipFamilies and clusterIPs fields depend on the value of this field. This field will be wiped when updating a service to type ExternalName.
    @[::JSON::Field(key: "ipFamilyPolicy")]
    @[::YAML::Field(key: "ipFamilyPolicy")]
    property ip_family_policy : String?
    # loadBalancerClass is the class of the load balancer implementation this Service belongs to. If specified, the value of this field must be a label-style identifier, with an optional prefix, e.g. "internal-vip" or "example.com/internal-vip". Unprefixed names are reserved for end-users. This field can only be set when the Service type is 'LoadBalancer'. If not set, the default load balancer implementation is used, today this is typically done through the cloud provider integration, but should apply for any default implementation. If set, it is assumed that a load balancer implementation is watching for Services with a matching class. Any default load balancer implementation (e.g. cloud providers) should ignore Services that set this field. This field can only be set when creating or updating a Service to type 'LoadBalancer'. Once set, it can not be changed. This field will be wiped when a service is updated to a non 'LoadBalancer' type.
    @[::JSON::Field(key: "loadBalancerClass")]
    @[::YAML::Field(key: "loadBalancerClass")]
    property load_balancer_class : String?
    # Only applies to Service Type: LoadBalancer. This feature depends on whether the underlying cloud-provider supports specifying the loadBalancerIP when a load balancer is created. This field will be ignored if the cloud-provider does not support the feature. Deprecated: This field was under-specified and its meaning varies across implementations. Using it is non-portable and it may not support dual-stack. Users are encouraged to use implementation-specific annotations when available.
    @[::JSON::Field(key: "loadBalancerIP")]
    @[::YAML::Field(key: "loadBalancerIP")]
    property load_balancer_ip : String?
    # If specified and supported by the platform, this will restrict traffic through the cloud-provider load-balancer will be restricted to the specified client IPs. This field will be ignored if the cloud-provider does not support the feature." More info: https://kubernetes.io/docs/tasks/access-application-cluster/create-external-load-balancer/
    @[::JSON::Field(key: "loadBalancerSourceRanges")]
    @[::YAML::Field(key: "loadBalancerSourceRanges")]
    property load_balancer_source_ranges : Array(String)?
    # The list of ports that are exposed by this service. More info: https://kubernetes.io/docs/concepts/services-networking/service/#virtual-ips-and-service-proxies
    property ports : Array(ServicePort)?
    # publishNotReadyAddresses indicates that any agent which deals with endpoints for this Service should disregard any indications of ready/not-ready. The primary use case for setting this field is for a StatefulSet's Headless Service to propagate SRV DNS records for its Pods for the purpose of peer discovery. The Kubernetes controllers that generate Endpoints and EndpointSlice resources for Services interpret this to mean that all endpoints are considered "ready" even if the Pods themselves are not. Agents which consume only Kubernetes generated endpoints through the Endpoints or EndpointSlice resources can safely assume this behavior.
    @[::JSON::Field(key: "publishNotReadyAddresses")]
    @[::YAML::Field(key: "publishNotReadyAddresses")]
    property publish_not_ready_addresses : Bool?
    # Route service traffic to pods with label keys and values matching this selector. If empty or not present, the service is assumed to have an external process managing its endpoints, which Kubernetes will not modify. Only applies to types ClusterIP, NodePort, and LoadBalancer. Ignored if type is ExternalName. More info: https://kubernetes.io/docs/concepts/services-networking/service/
    property selector : Hash(String, String)?
    # Supports "ClientIP" and "None". Used to maintain session affinity. Enable client IP based session affinity. Must be ClientIP or None. Defaults to None. More info: https://kubernetes.io/docs/concepts/services-networking/service/#virtual-ips-and-service-proxies
    @[::JSON::Field(key: "sessionAffinity")]
    @[::YAML::Field(key: "sessionAffinity")]
    property session_affinity : String?
    # sessionAffinityConfig contains the configurations of session affinity.
    @[::JSON::Field(key: "sessionAffinityConfig")]
    @[::YAML::Field(key: "sessionAffinityConfig")]
    property session_affinity_config : SessionAffinityConfig?
    # TrafficDistribution offers a way to express preferences for how traffic is distributed to Service endpoints. Implementations can use this field as a hint, but are not required to guarantee strict adherence. If the field is not set, the implementation will apply its default routing strategy. If set to "PreferClose", implementations should prioritize endpoints that are in the same zone.
    @[::JSON::Field(key: "trafficDistribution")]
    @[::YAML::Field(key: "trafficDistribution")]
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
    @[::JSON::Field(key: "loadBalancer")]
    @[::YAML::Field(key: "loadBalancer")]
    property load_balancer : LoadBalancerStatus?
  end

  # SessionAffinityConfig represents the configurations of session affinity.
  struct SessionAffinityConfig
    include Kubernetes::Serializable

    # clientIP contains the configurations of Client IP based session affinity.
    @[::JSON::Field(key: "clientIP")]
    @[::YAML::Field(key: "clientIP")]
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
    @[::JSON::Field(key: "fsType")]
    @[::YAML::Field(key: "fsType")]
    property fs_type : String?
    # readOnly defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts.
    @[::JSON::Field(key: "readOnly")]
    @[::YAML::Field(key: "readOnly")]
    property read_only : Bool?
    # secretRef specifies the secret to use for obtaining the StorageOS API credentials.  If not specified, default values will be attempted.
    @[::JSON::Field(key: "secretRef")]
    @[::YAML::Field(key: "secretRef")]
    property secret_ref : ObjectReference?
    # volumeName is the human-readable name of the StorageOS volume.  Volume names are only unique within a namespace.
    @[::JSON::Field(key: "volumeName")]
    @[::YAML::Field(key: "volumeName")]
    property volume_name : String?
    # volumeNamespace specifies the scope of the volume within StorageOS.  If no namespace is specified then the Pod's namespace will be used.  This allows the Kubernetes name scoping to be mirrored within StorageOS for tighter integration. Set VolumeName to any name to override the default behaviour. Set to "default" if you are not using namespaces within StorageOS. Namespaces that do not pre-exist within StorageOS will be created.
    @[::JSON::Field(key: "volumeNamespace")]
    @[::YAML::Field(key: "volumeNamespace")]
    property volume_namespace : String?
  end

  # Represents a StorageOS persistent volume resource.
  struct StorageOSVolumeSource
    include Kubernetes::Serializable

    # fsType is the filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. "ext4", "xfs", "ntfs". Implicitly inferred to be "ext4" if unspecified.
    @[::JSON::Field(key: "fsType")]
    @[::YAML::Field(key: "fsType")]
    property fs_type : String?
    # readOnly defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts.
    @[::JSON::Field(key: "readOnly")]
    @[::YAML::Field(key: "readOnly")]
    property read_only : Bool?
    # secretRef specifies the secret to use for obtaining the StorageOS API credentials.  If not specified, default values will be attempted.
    @[::JSON::Field(key: "secretRef")]
    @[::YAML::Field(key: "secretRef")]
    property secret_ref : LocalObjectReference?
    # volumeName is the human-readable name of the StorageOS volume.  Volume names are only unique within a namespace.
    @[::JSON::Field(key: "volumeName")]
    @[::YAML::Field(key: "volumeName")]
    property volume_name : String?
    # volumeNamespace specifies the scope of the volume within StorageOS.  If no namespace is specified then the Pod's namespace will be used.  This allows the Kubernetes name scoping to be mirrored within StorageOS for tighter integration. Set VolumeName to any name to override the default behaviour. Set to "default" if you are not using namespaces within StorageOS. Namespaces that do not pre-exist within StorageOS will be created.
    @[::JSON::Field(key: "volumeNamespace")]
    @[::YAML::Field(key: "volumeNamespace")]
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
    @[::JSON::Field(key: "timeAdded")]
    @[::YAML::Field(key: "timeAdded")]
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
    # Operator represents a key's relationship to the value. Valid operators are Exists, Equal, Lt, and Gt. Defaults to Equal. Exists is equivalent to wildcard for value, so that a pod can tolerate all taints of a particular category. Lt and Gt perform numeric comparisons (requires feature gate TaintTolerationComparisonOperators).
    property operator : String?
    # TolerationSeconds represents the period of time the toleration (which must be of effect NoExecute, otherwise this field is ignored) tolerates the taint. By default, it is not set, which means tolerate the taint forever (do not evict). Zero and negative values will be treated as 0 (evict immediately) by the system.
    @[::JSON::Field(key: "tolerationSeconds")]
    @[::YAML::Field(key: "tolerationSeconds")]
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
    @[::JSON::Field(key: "matchLabelExpressions")]
    @[::YAML::Field(key: "matchLabelExpressions")]
    property match_label_expressions : Array(TopologySelectorLabelRequirement)?
  end

  # TopologySpreadConstraint specifies how to spread matching pods among the given topology.
  struct TopologySpreadConstraint
    include Kubernetes::Serializable

    # LabelSelector is used to find matching pods. Pods that match this label selector are counted to determine the number of pods in their corresponding topology domain.
    @[::JSON::Field(key: "labelSelector")]
    @[::YAML::Field(key: "labelSelector")]
    property label_selector : LabelSelector?
    # MatchLabelKeys is a set of pod label keys to select the pods over which spreading will be calculated. The keys are used to lookup values from the incoming pod labels, those key-value labels are ANDed with labelSelector to select the group of existing pods over which spreading will be calculated for the incoming pod. The same key is forbidden to exist in both MatchLabelKeys and LabelSelector. MatchLabelKeys cannot be set when LabelSelector isn't set. Keys that don't exist in the incoming pod labels will be ignored. A null or empty list means only match against labelSelector.
    # This is a beta field and requires the MatchLabelKeysInPodTopologySpread feature gate to be enabled (enabled by default).
    @[::JSON::Field(key: "matchLabelKeys")]
    @[::YAML::Field(key: "matchLabelKeys")]
    property match_label_keys : Array(String)?
    # MaxSkew describes the degree to which pods may be unevenly distributed. When `whenUnsatisfiable=DoNotSchedule`, it is the maximum permitted difference between the number of matching pods in the target topology and the global minimum. The global minimum is the minimum number of matching pods in an eligible domain or zero if the number of eligible domains is less than MinDomains. For example, in a 3-zone cluster, MaxSkew is set to 1, and pods with the same labelSelector spread as 2/2/1: In this case, the global minimum is 1. | zone1 | zone2 | zone3 | |  P P  |  P P  |   P   | - if MaxSkew is 1, incoming pod can only be scheduled to zone3 to become 2/2/2; scheduling it onto zone1(zone2) would make the ActualSkew(3-1) on zone1(zone2) violate MaxSkew(1). - if MaxSkew is 2, incoming pod can be scheduled onto any zone. When `whenUnsatisfiable=ScheduleAnyway`, it is used to give higher precedence to topologies that satisfy it. It's a required field. Default value is 1 and 0 is not allowed.
    @[::JSON::Field(key: "maxSkew")]
    @[::YAML::Field(key: "maxSkew")]
    property max_skew : Int32?
    # MinDomains indicates a minimum number of eligible domains. When the number of eligible domains with matching topology keys is less than minDomains, Pod Topology Spread treats "global minimum" as 0, and then the calculation of Skew is performed. And when the number of eligible domains with matching topology keys equals or greater than minDomains, this value has no effect on scheduling. As a result, when the number of eligible domains is less than minDomains, scheduler won't schedule more than maxSkew Pods to those domains. If value is nil, the constraint behaves as if MinDomains is equal to 1. Valid values are integers greater than 0. When value is not nil, WhenUnsatisfiable must be DoNotSchedule.
    # For example, in a 3-zone cluster, MaxSkew is set to 2, MinDomains is set to 5 and pods with the same labelSelector spread as 2/2/2: | zone1 | zone2 | zone3 | |  P P  |  P P  |  P P  | The number of domains is less than 5(MinDomains), so "global minimum" is treated as 0. In this situation, new pod with the same labelSelector cannot be scheduled, because computed skew will be 3(3 - 0) if new Pod is scheduled to any of the three zones, it will violate MaxSkew.
    @[::JSON::Field(key: "minDomains")]
    @[::YAML::Field(key: "minDomains")]
    property min_domains : Int32?
    # NodeAffinityPolicy indicates how we will treat Pod's nodeAffinity/nodeSelector when calculating pod topology spread skew. Options are: - Honor: only nodes matching nodeAffinity/nodeSelector are included in the calculations. - Ignore: nodeAffinity/nodeSelector are ignored. All nodes are included in the calculations.
    # If this value is nil, the behavior is equivalent to the Honor policy.
    @[::JSON::Field(key: "nodeAffinityPolicy")]
    @[::YAML::Field(key: "nodeAffinityPolicy")]
    property node_affinity_policy : String?
    # NodeTaintsPolicy indicates how we will treat node taints when calculating pod topology spread skew. Options are: - Honor: nodes without taints, along with tainted nodes for which the incoming pod has a toleration, are included. - Ignore: node taints are ignored. All nodes are included.
    # If this value is nil, the behavior is equivalent to the Ignore policy.
    @[::JSON::Field(key: "nodeTaintsPolicy")]
    @[::YAML::Field(key: "nodeTaintsPolicy")]
    property node_taints_policy : String?
    # TopologyKey is the key of node labels. Nodes that have a label with this key and identical values are considered to be in the same topology. We consider each <key, value> as a "bucket", and try to put balanced number of pods into each bucket. We define a domain as a particular instance of a topology. Also, we define an eligible domain as a domain whose nodes meet the requirements of nodeAffinityPolicy and nodeTaintsPolicy. e.g. If TopologyKey is "kubernetes.io/hostname", each Node is a domain of that topology. And, if TopologyKey is "topology.kubernetes.io/zone", each zone is a domain of that topology. It's a required field.
    @[::JSON::Field(key: "topologyKey")]
    @[::YAML::Field(key: "topologyKey")]
    property topology_key : String?
    # WhenUnsatisfiable indicates how to deal with a pod if it doesn't satisfy the spread constraint. - DoNotSchedule (default) tells the scheduler not to schedule it. - ScheduleAnyway tells the scheduler to schedule the pod in any location,
    # but giving higher precedence to topologies that would help reduce the
    # skew.
    # A constraint is considered "Unsatisfiable" for an incoming pod if and only if every possible node assignment for that pod would violate "MaxSkew" on some topology. For example, in a 3-zone cluster, MaxSkew is set to 1, and pods with the same labelSelector spread as 3/1/1: | zone1 | zone2 | zone3 | | P P P |   P   |   P   | If WhenUnsatisfiable is set to DoNotSchedule, incoming pod can only be scheduled to zone2(zone3) to become 3/2/1(3/1/2) as ActualSkew(2-1) on zone2(zone3) satisfies MaxSkew(1). In other words, the cluster can still be imbalanced, but scheduler won't make it *more* imbalanced. It's a required field.
    @[::JSON::Field(key: "whenUnsatisfiable")]
    @[::YAML::Field(key: "whenUnsatisfiable")]
    property when_unsatisfiable : String?
  end

  # TypedLocalObjectReference contains enough information to let you locate the typed referenced object inside the same namespace.
  struct TypedLocalObjectReference
    include Kubernetes::Serializable

    # APIGroup is the group for the resource being referenced. If APIGroup is not specified, the specified Kind must be in the core API group. For any other third-party types, APIGroup is required.
    @[::JSON::Field(key: "apiGroup")]
    @[::YAML::Field(key: "apiGroup")]
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
    @[::JSON::Field(key: "apiGroup")]
    @[::YAML::Field(key: "apiGroup")]
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
    @[::JSON::Field(key: "awsElasticBlockStore")]
    @[::YAML::Field(key: "awsElasticBlockStore")]
    property aws_elastic_block_store : AWSElasticBlockStoreVolumeSource?
    # azureDisk represents an Azure Data Disk mount on the host and bind mount to the pod. Deprecated: AzureDisk is deprecated. All operations for the in-tree azureDisk type are redirected to the disk.csi.azure.com CSI driver.
    @[::JSON::Field(key: "azureDisk")]
    @[::YAML::Field(key: "azureDisk")]
    property azure_disk : AzureDiskVolumeSource?
    # azureFile represents an Azure File Service mount on the host and bind mount to the pod. Deprecated: AzureFile is deprecated. All operations for the in-tree azureFile type are redirected to the file.csi.azure.com CSI driver.
    @[::JSON::Field(key: "azureFile")]
    @[::YAML::Field(key: "azureFile")]
    property azure_file : AzureFileVolumeSource?
    # cephFS represents a Ceph FS mount on the host that shares a pod's lifetime. Deprecated: CephFS is deprecated and the in-tree cephfs type is no longer supported.
    property cephfs : CephFSVolumeSource?
    # cinder represents a cinder volume attached and mounted on kubelets host machine. Deprecated: Cinder is deprecated. All operations for the in-tree cinder type are redirected to the cinder.csi.openstack.org CSI driver. More info: https://examples.k8s.io/mysql-cinder-pd/README.md
    property cinder : CinderVolumeSource?
    # configMap represents a configMap that should populate this volume
    @[::JSON::Field(key: "configMap")]
    @[::YAML::Field(key: "configMap")]
    property config_map : ConfigMapVolumeSource?
    # csi (Container Storage Interface) represents ephemeral storage that is handled by certain external CSI drivers.
    property csi : CSIVolumeSource?
    # downwardAPI represents downward API about the pod that should populate this volume
    @[::JSON::Field(key: "downwardAPI")]
    @[::YAML::Field(key: "downwardAPI")]
    property downward_api : DownwardAPIVolumeSource?
    # emptyDir represents a temporary directory that shares a pod's lifetime. More info: https://kubernetes.io/docs/concepts/storage/volumes#emptydir
    @[::JSON::Field(key: "emptyDir")]
    @[::YAML::Field(key: "emptyDir")]
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
    @[::JSON::Field(key: "flexVolume")]
    @[::YAML::Field(key: "flexVolume")]
    property flex_volume : FlexVolumeSource?
    # flocker represents a Flocker volume attached to a kubelet's host machine. This depends on the Flocker control service being running. Deprecated: Flocker is deprecated and the in-tree flocker type is no longer supported.
    property flocker : FlockerVolumeSource?
    # gcePersistentDisk represents a GCE Disk resource that is attached to a kubelet's host machine and then exposed to the pod. Deprecated: GCEPersistentDisk is deprecated. All operations for the in-tree gcePersistentDisk type are redirected to the pd.csi.storage.gke.io CSI driver. More info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk
    @[::JSON::Field(key: "gcePersistentDisk")]
    @[::YAML::Field(key: "gcePersistentDisk")]
    property gce_persistent_disk : GCEPersistentDiskVolumeSource?
    # gitRepo represents a git repository at a particular revision. Deprecated: GitRepo is deprecated. To provision a container with a git repo, mount an EmptyDir into an InitContainer that clones the repo using git, then mount the EmptyDir into the Pod's container.
    @[::JSON::Field(key: "gitRepo")]
    @[::YAML::Field(key: "gitRepo")]
    property git_repo : GitRepoVolumeSource?
    # glusterfs represents a Glusterfs mount on the host that shares a pod's lifetime. Deprecated: Glusterfs is deprecated and the in-tree glusterfs type is no longer supported.
    property glusterfs : GlusterfsVolumeSource?
    # hostPath represents a pre-existing file or directory on the host machine that is directly exposed to the container. This is generally used for system agents or other privileged things that are allowed to see the host machine. Most containers will NOT need this. More info: https://kubernetes.io/docs/concepts/storage/volumes#hostpath
    @[::JSON::Field(key: "hostPath")]
    @[::YAML::Field(key: "hostPath")]
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
    @[::JSON::Field(key: "persistentVolumeClaim")]
    @[::YAML::Field(key: "persistentVolumeClaim")]
    property persistent_volume_claim : PersistentVolumeClaimVolumeSource?
    # photonPersistentDisk represents a PhotonController persistent disk attached and mounted on kubelets host machine. Deprecated: PhotonPersistentDisk is deprecated and the in-tree photonPersistentDisk type is no longer supported.
    @[::JSON::Field(key: "photonPersistentDisk")]
    @[::YAML::Field(key: "photonPersistentDisk")]
    property photon_persistent_disk : PhotonPersistentDiskVolumeSource?
    # portworxVolume represents a portworx volume attached and mounted on kubelets host machine. Deprecated: PortworxVolume is deprecated. All operations for the in-tree portworxVolume type are redirected to the pxd.portworx.com CSI driver.
    @[::JSON::Field(key: "portworxVolume")]
    @[::YAML::Field(key: "portworxVolume")]
    property portworx_volume : PortworxVolumeSource?
    # projected items for all in one resources secrets, configmaps, and downward API
    property projected : ProjectedVolumeSource?
    # quobyte represents a Quobyte mount on the host that shares a pod's lifetime. Deprecated: Quobyte is deprecated and the in-tree quobyte type is no longer supported.
    property quobyte : QuobyteVolumeSource?
    # rbd represents a Rados Block Device mount on the host that shares a pod's lifetime. Deprecated: RBD is deprecated and the in-tree rbd type is no longer supported.
    property rbd : RBDVolumeSource?
    # scaleIO represents a ScaleIO persistent volume attached and mounted on Kubernetes nodes. Deprecated: ScaleIO is deprecated and the in-tree scaleIO type is no longer supported.
    @[::JSON::Field(key: "scaleIO")]
    @[::YAML::Field(key: "scaleIO")]
    property scale_io : ScaleIOVolumeSource?
    # secret represents a secret that should populate this volume. More info: https://kubernetes.io/docs/concepts/storage/volumes#secret
    property secret : SecretVolumeSource?
    # storageOS represents a StorageOS volume attached and mounted on Kubernetes nodes. Deprecated: StorageOS is deprecated and the in-tree storageos type is no longer supported.
    property storageos : StorageOSVolumeSource?
    # vsphereVolume represents a vSphere volume attached and mounted on kubelets host machine. Deprecated: VsphereVolume is deprecated. All operations for the in-tree vsphereVolume type are redirected to the csi.vsphere.vmware.com CSI driver.
    @[::JSON::Field(key: "vsphereVolume")]
    @[::YAML::Field(key: "vsphereVolume")]
    property vsphere_volume : VsphereVirtualDiskVolumeSource?
  end

  # volumeDevice describes a mapping of a raw block device within a container.
  struct VolumeDevice
    include Kubernetes::Serializable

    # devicePath is the path inside of the container that the device will be mapped to.
    @[::JSON::Field(key: "devicePath")]
    @[::YAML::Field(key: "devicePath")]
    property device_path : String?
    # name must match the name of a persistentVolumeClaim in the pod
    property name : String?
  end

  # VolumeMount describes a mounting of a Volume within a container.
  struct VolumeMount
    include Kubernetes::Serializable

    # Path within the container at which the volume should be mounted.  Must not contain ':'.
    @[::JSON::Field(key: "mountPath")]
    @[::YAML::Field(key: "mountPath")]
    property mount_path : String?
    # mountPropagation determines how mounts are propagated from the host to container and the other way around. When not set, MountPropagationNone is used. This field is beta in 1.10. When RecursiveReadOnly is set to IfPossible or to Enabled, MountPropagation must be None or unspecified (which defaults to None).
    @[::JSON::Field(key: "mountPropagation")]
    @[::YAML::Field(key: "mountPropagation")]
    property mount_propagation : String?
    # This must match the Name of a Volume.
    property name : String?
    # Mounted read-only if true, read-write otherwise (false or unspecified). Defaults to false.
    @[::JSON::Field(key: "readOnly")]
    @[::YAML::Field(key: "readOnly")]
    property read_only : Bool?
    # RecursiveReadOnly specifies whether read-only mounts should be handled recursively.
    # If ReadOnly is false, this field has no meaning and must be unspecified.
    # If ReadOnly is true, and this field is set to Disabled, the mount is not made recursively read-only.  If this field is set to IfPossible, the mount is made recursively read-only, if it is supported by the container runtime.  If this field is set to Enabled, the mount is made recursively read-only if it is supported by the container runtime, otherwise the pod will not be started and an error will be generated to indicate the reason.
    # If this field is set to IfPossible or Enabled, MountPropagation must be set to None (or be unspecified, which defaults to None).
    # If this field is not specified, it is treated as an equivalent of Disabled.
    @[::JSON::Field(key: "recursiveReadOnly")]
    @[::YAML::Field(key: "recursiveReadOnly")]
    property recursive_read_only : String?
    # Path within the volume from which the container's volume should be mounted. Defaults to "" (volume's root).
    @[::JSON::Field(key: "subPath")]
    @[::YAML::Field(key: "subPath")]
    property sub_path : String?
    # Expanded path within the volume from which the container's volume should be mounted. Behaves similarly to SubPath but environment variable references $(VAR_NAME) are expanded using the container's environment. Defaults to "" (volume's root). SubPathExpr and SubPath are mutually exclusive.
    @[::JSON::Field(key: "subPathExpr")]
    @[::YAML::Field(key: "subPathExpr")]
    property sub_path_expr : String?
  end

  # VolumeMountStatus shows status of volume mounts.
  struct VolumeMountStatus
    include Kubernetes::Serializable

    # MountPath corresponds to the original VolumeMount.
    @[::JSON::Field(key: "mountPath")]
    @[::YAML::Field(key: "mountPath")]
    property mount_path : String?
    # Name corresponds to the name of the original VolumeMount.
    property name : String?
    # ReadOnly corresponds to the original VolumeMount.
    @[::JSON::Field(key: "readOnly")]
    @[::YAML::Field(key: "readOnly")]
    property read_only : Bool?
    # RecursiveReadOnly must be set to Disabled, Enabled, or unspecified (for non-readonly mounts). An IfPossible value in the original VolumeMount must be translated to Disabled or Enabled, depending on the mount result.
    @[::JSON::Field(key: "recursiveReadOnly")]
    @[::YAML::Field(key: "recursiveReadOnly")]
    property recursive_read_only : String?
    # volumeStatus represents volume-type-specific status about the mounted volume.
    @[::JSON::Field(key: "volumeStatus")]
    @[::YAML::Field(key: "volumeStatus")]
    property volume_status : VolumeStatus?
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
    @[::JSON::Field(key: "clusterTrustBundle")]
    @[::YAML::Field(key: "clusterTrustBundle")]
    property cluster_trust_bundle : ClusterTrustBundleProjection?
    # configMap information about the configMap data to project
    @[::JSON::Field(key: "configMap")]
    @[::YAML::Field(key: "configMap")]
    property config_map : ConfigMapProjection?
    # downwardAPI information about the downwardAPI data to project
    @[::JSON::Field(key: "downwardAPI")]
    @[::YAML::Field(key: "downwardAPI")]
    property downward_api : DownwardAPIProjection?
    # Projects an auto-rotating credential bundle (private key and certificate chain) that the pod can use either as a TLS client or server.
    # Kubelet generates a private key and uses it to send a PodCertificateRequest to the named signer.  Once the signer approves the request and issues a certificate chain, Kubelet writes the key and certificate chain to the pod filesystem.  The pod does not start until certificates have been issued for each podCertificate projected volume source in its spec.
    # Kubelet will begin trying to rotate the certificate at the time indicated by the signer using the PodCertificateRequest.Status.BeginRefreshAt timestamp.
    # Kubelet can write a single file, indicated by the credentialBundlePath field, or separate files, indicated by the keyPath and certificateChainPath fields.
    # The credential bundle is a single file in PEM format.  The first PEM entry is the private key (in PKCS#8 format), and the remaining PEM entries are the certificate chain issued by the signer (typically, signers will return their certificate chain in leaf-to-root order).
    # Prefer using the credential bundle format, since your application code can read it atomically.  If you use keyPath and certificateChainPath, your application must make two separate file reads. If these coincide with a certificate rotation, it is possible that the private key and leaf certificate you read may not correspond to each other.  Your application will need to check for this condition, and re-read until they are consistent.
    # The named signer controls chooses the format of the certificate it issues; consult the signer implementation's documentation to learn how to use the certificates it issues.
    @[::JSON::Field(key: "podCertificate")]
    @[::YAML::Field(key: "podCertificate")]
    property pod_certificate : PodCertificateProjection?
    # secret information about the secret data to project
    property secret : SecretProjection?
    # serviceAccountToken is information about the serviceAccountToken data to project
    @[::JSON::Field(key: "serviceAccountToken")]
    @[::YAML::Field(key: "serviceAccountToken")]
    property service_account_token : ServiceAccountTokenProjection?
  end

  # VolumeResourceRequirements describes the storage resource requirements for a volume.
  struct VolumeResourceRequirements
    include Kubernetes::Serializable

    # Limits describes the maximum amount of compute resources allowed. More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
    property limits : Hash(String, Quantity)?
    # Requests describes the minimum amount of compute resources required. If Requests is omitted for a container, it defaults to Limits if that is explicitly specified, otherwise to an implementation-defined value. Requests cannot exceed Limits. More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
    property requests : Hash(String, Quantity)?
  end

  # VolumeStatus represents the status of a mounted volume. At most one of its members must be specified.
  struct VolumeStatus
    include Kubernetes::Serializable

    # image represents an OCI object (a container image or artifact) pulled and mounted on the kubelet's host machine.
    property image : ImageVolumeStatus?
  end

  # Represents a vSphere volume resource.
  struct VsphereVirtualDiskVolumeSource
    include Kubernetes::Serializable

    # fsType is filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. "ext4", "xfs", "ntfs". Implicitly inferred to be "ext4" if unspecified.
    @[::JSON::Field(key: "fsType")]
    @[::YAML::Field(key: "fsType")]
    property fs_type : String?
    # storagePolicyID is the storage Policy Based Management (SPBM) profile ID associated with the StoragePolicyName.
    @[::JSON::Field(key: "storagePolicyID")]
    @[::YAML::Field(key: "storagePolicyID")]
    property storage_policy_id : String?
    # storagePolicyName is the storage Policy Based Management (SPBM) profile name.
    @[::JSON::Field(key: "storagePolicyName")]
    @[::YAML::Field(key: "storagePolicyName")]
    property storage_policy_name : String?
    # volumePath is the path that identifies vSphere volume vmdk
    @[::JSON::Field(key: "volumePath")]
    @[::YAML::Field(key: "volumePath")]
    property volume_path : String?
  end

  # The weights of all of the matched WeightedPodAffinityTerm fields are added per-node to find the most preferred node(s)
  struct WeightedPodAffinityTerm
    include Kubernetes::Serializable

    # Required. A pod affinity term, associated with the corresponding weight.
    @[::JSON::Field(key: "podAffinityTerm")]
    @[::YAML::Field(key: "podAffinityTerm")]
    property pod_affinity_term : PodAffinityTerm?
    # weight associated with matching the corresponding podAffinityTerm, in the range 1-100.
    property weight : Int32?
  end

  # WindowsSecurityContextOptions contain Windows-specific options and credentials.
  struct WindowsSecurityContextOptions
    include Kubernetes::Serializable

    # GMSACredentialSpec is where the GMSA admission webhook (https://github.com/kubernetes-sigs/windows-gmsa) inlines the contents of the GMSA credential spec named by the GMSACredentialSpecName field.
    @[::JSON::Field(key: "gmsaCredentialSpec")]
    @[::YAML::Field(key: "gmsaCredentialSpec")]
    property gmsa_credential_spec : String?
    # GMSACredentialSpecName is the name of the GMSA credential spec to use.
    @[::JSON::Field(key: "gmsaCredentialSpecName")]
    @[::YAML::Field(key: "gmsaCredentialSpecName")]
    property gmsa_credential_spec_name : String?
    # HostProcess determines if a container should be run as a 'Host Process' container. All of a Pod's containers must have the same effective HostProcess value (it is not allowed to have a mix of HostProcess containers and non-HostProcess containers). In addition, if HostProcess is true then HostNetwork must also be set to true.
    @[::JSON::Field(key: "hostProcess")]
    @[::YAML::Field(key: "hostProcess")]
    property host_process : Bool?
    # The UserName in Windows to run the entrypoint of the container process. Defaults to the user specified in image metadata if unspecified. May also be set in PodSecurityContext. If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence.
    @[::JSON::Field(key: "runAsUserName")]
    @[::YAML::Field(key: "runAsUserName")]
    property run_as_user_name : String?
  end

  # WorkloadReference identifies the Workload object and PodGroup membership that a Pod belongs to. The scheduler uses this information to apply workload-aware scheduling semantics.
  struct WorkloadReference
    include Kubernetes::Serializable

    # Name defines the name of the Workload object this Pod belongs to. Workload must be in the same namespace as the Pod. If it doesn't match any existing Workload, the Pod will remain unschedulable until a Workload object is created and observed by the kube-scheduler. It must be a DNS subdomain.
    property name : String?
    # PodGroup is the name of the PodGroup within the Workload that this Pod belongs to. If it doesn't match any existing PodGroup within the Workload, the Pod will remain unschedulable until the Workload object is recreated and observed by the kube-scheduler. It must be a DNS label.
    @[::JSON::Field(key: "podGroup")]
    @[::YAML::Field(key: "podGroup")]
    property pod_group : String?
    # PodGroupReplicaKey specifies the replica key of the PodGroup to which this Pod belongs. It is used to distinguish pods belonging to different replicas of the same pod group. The pod group policy is applied separately to each replica. When set, it must be a DNS label.
    @[::JSON::Field(key: "podGroupReplicaKey")]
    @[::YAML::Field(key: "podGroupReplicaKey")]
    property pod_group_replica_key : String?
  end
end
