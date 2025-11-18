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
  # CSIDriver captures information about a Container Storage Interface (CSI) volume driver deployed on the cluster. Kubernetes attach detach controller uses this object to determine whether attach is required. Kubelet uses this object to determine whether pod information needs to be passed on mount. CSIDriver objects are non-namespaced.
  struct CSIDriver
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
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
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
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
    @[::JSON::Field(key: "attachRequired")]
    @[::YAML::Field(key: "attachRequired")]
    property attach_required : Bool?
    # fsGroupPolicy defines if the underlying volume supports changing ownership and permission of the volume before being mounted. Refer to the specific FSGroupPolicy values for additional details.
    # This field was immutable in Kubernetes < 1.29 and now is mutable.
    # Defaults to ReadWriteOnceWithFSType, which will examine each volume to determine if Kubernetes should modify ownership and permissions of the volume. With the default policy the defined fsGroup will only be applied if a fstype is defined and the volume's access mode contains ReadWriteOnce.
    @[::JSON::Field(key: "fsGroupPolicy")]
    @[::YAML::Field(key: "fsGroupPolicy")]
    property fs_group_policy : String?
    # nodeAllocatableUpdatePeriodSeconds specifies the interval between periodic updates of the CSINode allocatable capacity for this driver. When set, both periodic updates and updates triggered by capacity-related failures are enabled. If not set, no updates occur (neither periodic nor upon detecting capacity-related failures), and the allocatable.count remains static. The minimum allowed value for this field is 10 seconds.
    # This is a beta feature and requires the MutableCSINodeAllocatableCount feature gate to be enabled.
    # This field is mutable.
    @[::JSON::Field(key: "nodeAllocatableUpdatePeriodSeconds")]
    @[::YAML::Field(key: "nodeAllocatableUpdatePeriodSeconds")]
    property node_allocatable_update_period_seconds : Int64?
    # podInfoOnMount indicates this CSI volume driver requires additional pod information (like podName, podUID, etc.) during mount operations, if set to true. If set to false, pod information will not be passed on mount. Default is false.
    # The CSI driver specifies podInfoOnMount as part of driver deployment. If true, Kubelet will pass pod information as VolumeContext in the CSI NodePublishVolume() calls. The CSI driver is responsible for parsing and validating the information passed in as VolumeContext.
    # The following VolumeContext will be passed if podInfoOnMount is set to true. This list might grow, but the prefix will be used. "csi.storage.k8s.io/pod.name": pod.Name "csi.storage.k8s.io/pod.namespace": pod.Namespace "csi.storage.k8s.io/pod.uid": string(pod.UID) "csi.storage.k8s.io/ephemeral": "true" if the volume is an ephemeral inline volume
    # defined by a CSIVolumeSource, otherwise "false"
    # "csi.storage.k8s.io/ephemeral" is a new feature in Kubernetes 1.16. It is only required for drivers which support both the "Persistent" and "Ephemeral" VolumeLifecycleMode. Other drivers can leave pod info disabled and/or ignore this field. As Kubernetes 1.15 doesn't support this field, drivers can only support one mode when deployed on such a cluster and the deployment determines which mode that is, for example via a command line parameter of the driver.
    # This field was immutable in Kubernetes < 1.29 and now is mutable.
    @[::JSON::Field(key: "podInfoOnMount")]
    @[::YAML::Field(key: "podInfoOnMount")]
    property pod_info_on_mount : Bool?
    # requiresRepublish indicates the CSI driver wants `NodePublishVolume` being periodically called to reflect any possible change in the mounted volume. This field defaults to false.
    # Note: After a successful initial NodePublishVolume call, subsequent calls to NodePublishVolume should only update the contents of the volume. New mount points will not be seen by a running container.
    @[::JSON::Field(key: "requiresRepublish")]
    @[::YAML::Field(key: "requiresRepublish")]
    property requires_republish : Bool?
    # seLinuxMount specifies if the CSI driver supports "-o context" mount option.
    # When "true", the CSI driver must ensure that all volumes provided by this CSI driver can be mounted separately with different `-o context` options. This is typical for storage backends that provide volumes as filesystems on block devices or as independent shared volumes. Kubernetes will call NodeStage / NodePublish with "-o context=xyz" mount option when mounting a ReadWriteOncePod volume used in Pod that has explicitly set SELinux context. In the future, it may be expanded to other volume AccessModes. In any case, Kubernetes will ensure that the volume is mounted only with a single SELinux context.
    # When "false", Kubernetes won't pass any special SELinux mount options to the driver. This is typical for volumes that represent subdirectories of a bigger shared filesystem.
    # Default is "false".
    @[::JSON::Field(key: "seLinuxMount")]
    @[::YAML::Field(key: "seLinuxMount")]
    property se_linux_mount : Bool?
    # serviceAccountTokenInSecrets is an opt-in for CSI drivers to indicate that service account tokens should be passed via the Secrets field in NodePublishVolumeRequest instead of the VolumeContext field. The CSI specification provides a dedicated Secrets field for sensitive information like tokens, which is the appropriate mechanism for handling credentials. This addresses security concerns where sensitive tokens were being logged as part of volume context.
    # When "true", kubelet will pass the tokens only in the Secrets field with the key "csi.storage.k8s.io/serviceAccount.tokens". The CSI driver must be updated to read tokens from the Secrets field instead of VolumeContext.
    # When "false" or not set, kubelet will pass the tokens in VolumeContext with the key "csi.storage.k8s.io/serviceAccount.tokens" (existing behavior). This maintains backward compatibility with existing CSI drivers.
    # This field can only be set when TokenRequests is configured. The API server will reject CSIDriver specs that set this field without TokenRequests.
    # Default behavior if unset is to pass tokens in the VolumeContext field.
    @[::JSON::Field(key: "serviceAccountTokenInSecrets")]
    @[::YAML::Field(key: "serviceAccountTokenInSecrets")]
    property service_account_token_in_secrets : Bool?
    # storageCapacity indicates that the CSI volume driver wants pod scheduling to consider the storage capacity that the driver deployment will report by creating CSIStorageCapacity objects with capacity information, if set to true.
    # The check can be enabled immediately when deploying a driver. In that case, provisioning new volumes with late binding will pause until the driver deployment has published some suitable CSIStorageCapacity object.
    # Alternatively, the driver can be deployed with the field unset or false and it can be flipped later when storage capacity information has been published.
    # This field was immutable in Kubernetes <= 1.22 and now is mutable.
    @[::JSON::Field(key: "storageCapacity")]
    @[::YAML::Field(key: "storageCapacity")]
    property storage_capacity : Bool?
    # tokenRequests indicates the CSI driver needs pods' service account tokens it is mounting volume for to do necessary authentication. Kubelet will pass the tokens in VolumeContext in the CSI NodePublishVolume calls. The CSI driver should parse and validate the following VolumeContext: "csi.storage.k8s.io/serviceAccount.tokens": {
    # "<audience>": {
    # "token": <token>,
    # "expirationTimestamp": <expiration timestamp in RFC3339>,
    # },
    # ...
    # }
    # Note: Audience in each TokenRequest should be different and at most one token is empty string. To receive a new token after expiry, RequiresRepublish can be used to trigger NodePublishVolume periodically.
    @[::JSON::Field(key: "tokenRequests")]
    @[::YAML::Field(key: "tokenRequests")]
    property token_requests : Array(TokenRequest)?
    # volumeLifecycleModes defines what kind of volumes this CSI volume driver supports. The default if the list is empty is "Persistent", which is the usage defined by the CSI specification and implemented in Kubernetes via the usual PV/PVC mechanism.
    # The other mode is "Ephemeral". In this mode, volumes are defined inline inside the pod spec with CSIVolumeSource and their lifecycle is tied to the lifecycle of that pod. A driver has to be aware of this because it is only going to get a NodePublishVolume call for such a volume.
    # For more information about implementing this mode, see https://kubernetes-csi.github.io/docs/ephemeral-local-volumes.html A driver can support one or more of these modes and more modes may be added in the future.
    # This field is beta. This field is immutable.
    @[::JSON::Field(key: "volumeLifecycleModes")]
    @[::YAML::Field(key: "volumeLifecycleModes")]
    property volume_lifecycle_modes : Array(String)?
  end

  # CSINode holds information about all CSI drivers installed on a node. CSI drivers do not need to create the CSINode object directly. As long as they use the node-driver-registrar sidecar container, the kubelet will automatically populate the CSINode object for the CSI driver as part of kubelet plugin registration. CSINode has the same name as a node. If the object is missing, it means either there are no CSI Drivers available on the node, or the Kubelet version is low enough that it doesn't create this object. CSINode has an OwnerReference that points to the corresponding node object.
  struct CSINode
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
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
    @[::JSON::Field(key: "nodeID")]
    @[::YAML::Field(key: "nodeID")]
    property node_id : String?
    # topologyKeys is the list of keys supported by the driver. When a driver is initialized on a cluster, it provides a set of topology keys that it understands (e.g. "company.com/zone", "company.com/region"). When a driver is initialized on a node, it provides the same topology keys along with values. Kubelet will expose these topology keys as labels on its own node object. When Kubernetes does topology aware provisioning, it can use this list to determine which labels it should retrieve from the node object and pass back to the driver. It is possible for different nodes to use different topology keys. This can be empty if driver does not support topology.
    @[::JSON::Field(key: "topologyKeys")]
    @[::YAML::Field(key: "topologyKeys")]
    property topology_keys : Array(String)?
  end

  # CSINodeList is a collection of CSINode objects.
  struct CSINodeList
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
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
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
    property api_version : String?
    # capacity is the value reported by the CSI driver in its GetCapacityResponse for a GetCapacityRequest with topology and parameters that match the previous fields.
    # The semantic is currently (CSI spec 1.2) defined as: The available capacity, in bytes, of the storage that can be used to provision volumes. If not set, that information is currently unavailable.
    property capacity : Quantity?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # maximumVolumeSize is the value reported by the CSI driver in its GetCapacityResponse for a GetCapacityRequest with topology and parameters that match the previous fields.
    # This is defined since CSI spec 1.4.0 as the largest size that may be used in a CreateVolumeRequest.capacity_range.required_bytes field to create a volume with the same parameters as those in GetCapacityRequest. The corresponding value in the Kubernetes API is ResourceRequirements.Requests in a volume claim.
    @[::JSON::Field(key: "maximumVolumeSize")]
    @[::YAML::Field(key: "maximumVolumeSize")]
    property maximum_volume_size : Quantity?
    # Standard object's metadata. The name has no particular meaning. It must be a DNS subdomain (dots allowed, 253 characters). To ensure that there are no conflicts with other CSI drivers on the cluster, the recommendation is to use csisc-<uuid>, a generated name, or a reverse-domain name which ends with the unique CSI driver name.
    # Objects are namespaced.
    # More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ObjectMeta?
    # nodeTopology defines which nodes have access to the storage for which capacity was reported. If not set, the storage is not accessible from any node in the cluster. If empty, the storage is accessible from all nodes. This field is immutable.
    @[::JSON::Field(key: "nodeTopology")]
    @[::YAML::Field(key: "nodeTopology")]
    property node_topology : LabelSelector?
    # storageClassName represents the name of the StorageClass that the reported capacity applies to. It must meet the same requirements as the name of a StorageClass object (non-empty, DNS subdomain). If that object no longer exists, the CSIStorageCapacity object is obsolete and should be removed by its creator. This field is immutable.
    @[::JSON::Field(key: "storageClassName")]
    @[::YAML::Field(key: "storageClassName")]
    property storage_class_name : String?
  end

  # CSIStorageCapacityList is a collection of CSIStorageCapacity objects.
  struct CSIStorageCapacityList
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
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
    @[::JSON::Field(key: "allowVolumeExpansion")]
    @[::YAML::Field(key: "allowVolumeExpansion")]
    property allow_volume_expansion : Bool?
    # allowedTopologies restrict the node topologies where volumes can be dynamically provisioned. Each volume plugin defines its own supported topology specifications. An empty TopologySelectorTerm list means there is no topology restriction. This field is only honored by servers that enable the VolumeScheduling feature.
    @[::JSON::Field(key: "allowedTopologies")]
    @[::YAML::Field(key: "allowedTopologies")]
    property allowed_topologies : Array(TopologySelectorTerm)?
    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ObjectMeta?
    # mountOptions controls the mountOptions for dynamically provisioned PersistentVolumes of this storage class. e.g. ["ro", "soft"]. Not validated - mount of the PVs will simply fail if one is invalid.
    @[::JSON::Field(key: "mountOptions")]
    @[::YAML::Field(key: "mountOptions")]
    property mount_options : Array(String)?
    # parameters holds the parameters for the provisioner that should create volumes of this storage class.
    property parameters : Hash(String, String)?
    # provisioner indicates the type of the provisioner.
    property provisioner : String?
    # reclaimPolicy controls the reclaimPolicy for dynamically provisioned PersistentVolumes of this storage class. Defaults to Delete.
    @[::JSON::Field(key: "reclaimPolicy")]
    @[::YAML::Field(key: "reclaimPolicy")]
    property reclaim_policy : String?
    # volumeBindingMode indicates how PersistentVolumeClaims should be provisioned and bound.  When unset, VolumeBindingImmediate is used. This field is only honored by servers that enable the VolumeScheduling feature.
    @[::JSON::Field(key: "volumeBindingMode")]
    @[::YAML::Field(key: "volumeBindingMode")]
    property volume_binding_mode : String?
  end

  # StorageClassList is a collection of storage classes.
  struct StorageClassList
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
    property api_version : String?
    # items is the list of StorageClasses
    property items : Array(StorageClass)?
    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    property kind : String?
    # Standard list metadata More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    property metadata : ListMeta?
  end

  # TokenRequest contains parameters of a service account token.
  struct TokenRequest
    include Kubernetes::Serializable

    # audience is the intended audience of the token in "TokenRequestSpec". It will default to the audiences of kube apiserver.
    property audience : String?
    # expirationSeconds is the duration of validity of the token in "TokenRequestSpec". It has the same default value of "ExpirationSeconds" in "TokenRequestSpec".
    @[::JSON::Field(key: "expirationSeconds")]
    @[::YAML::Field(key: "expirationSeconds")]
    property expiration_seconds : Int64?
  end

  # VolumeAttachment captures the intent to attach or detach the specified volume to/from the specified node.
  # VolumeAttachment objects are non-namespaced.
  struct VolumeAttachment
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
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
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
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
    @[::JSON::Field(key: "inlineVolumeSpec")]
    @[::YAML::Field(key: "inlineVolumeSpec")]
    property inline_volume_spec : PersistentVolumeSpec?
    # persistentVolumeName represents the name of the persistent volume to attach.
    @[::JSON::Field(key: "persistentVolumeName")]
    @[::YAML::Field(key: "persistentVolumeName")]
    property persistent_volume_name : String?
  end

  # VolumeAttachmentSpec is the specification of a VolumeAttachment request.
  struct VolumeAttachmentSpec
    include Kubernetes::Serializable

    # attacher indicates the name of the volume driver that MUST handle this request. This is the name returned by GetPluginName().
    property attacher : String?
    # nodeName represents the node that the volume should be attached to.
    @[::JSON::Field(key: "nodeName")]
    @[::YAML::Field(key: "nodeName")]
    property node_name : String?
    # source represents the volume that should be attached.
    property source : VolumeAttachmentSource?
  end

  # VolumeAttachmentStatus is the status of a VolumeAttachment request.
  struct VolumeAttachmentStatus
    include Kubernetes::Serializable

    # attachError represents the last error encountered during attach operation, if any. This field must only be set by the entity completing the attach operation, i.e. the external-attacher.
    @[::JSON::Field(key: "attachError")]
    @[::YAML::Field(key: "attachError")]
    property attach_error : VolumeError?
    # attached indicates the volume is successfully attached. This field must only be set by the entity completing the attach operation, i.e. the external-attacher.
    property attached : Bool?
    # attachmentMetadata is populated with any information returned by the attach operation, upon successful attach, that must be passed into subsequent WaitForAttach or Mount calls. This field must only be set by the entity completing the attach operation, i.e. the external-attacher.
    @[::JSON::Field(key: "attachmentMetadata")]
    @[::YAML::Field(key: "attachmentMetadata")]
    property attachment_metadata : Hash(String, String)?
    # detachError represents the last error encountered during detach operation, if any. This field must only be set by the entity completing the detach operation, i.e. the external-attacher.
    @[::JSON::Field(key: "detachError")]
    @[::YAML::Field(key: "detachError")]
    property detach_error : VolumeError?
  end

  # VolumeAttributesClass represents a specification of mutable volume attributes defined by the CSI driver. The class can be specified during dynamic provisioning of PersistentVolumeClaims, and changed in the PersistentVolumeClaim spec after provisioning.
  struct VolumeAttributesClass
    include Kubernetes::Serializable

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
    property api_version : String?
    # Name of the CSI driver This field is immutable.
    @[::JSON::Field(key: "driverName")]
    @[::YAML::Field(key: "driverName")]
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
    @[::JSON::Field(key: "apiVersion")]
    @[::YAML::Field(key: "apiVersion")]
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
    @[::JSON::Field(key: "errorCode")]
    @[::YAML::Field(key: "errorCode")]
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
end
