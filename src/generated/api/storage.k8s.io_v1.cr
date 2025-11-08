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

module Kubernetes
  class Client
    # get available resources
    # GET /apis/storage.k8s.io/v1/
    def get_api_resources(**params, &)
      path = "/apis/storage.k8s.io/v1/"
      get(path) { |res| yield res }
    end

    # delete collection of CSIDriver
    # DELETE /apis/storage.k8s.io/v1/csidrivers
    def delete_collection_csi_driver(**params, &)
      path = "/apis/storage.k8s.io/v1/csidrivers"
      delete(path) { |res| yield res }
    end

    # list or watch objects of kind CSIDriver
    # GET /apis/storage.k8s.io/v1/csidrivers
    def list_csi_driver(**params, &)
      path = "/apis/storage.k8s.io/v1/csidrivers"
      get(path) { |res| yield res }
    end

    # create a CSIDriver
    # POST /apis/storage.k8s.io/v1/csidrivers
    def create_csi_driver(**params, &)
      path = "/apis/storage.k8s.io/v1/csidrivers"
      post(path, params) { |res| yield res }
    end

    # delete a CSIDriver
    # DELETE /apis/storage.k8s.io/v1/csidrivers/{name}
    def delete_csi_driver(**params, &)
      path = "/apis/storage.k8s.io/v1/csidrivers/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # read the specified CSIDriver
    # GET /apis/storage.k8s.io/v1/csidrivers/{name}
    def read_csi_driver(**params, &)
      path = "/apis/storage.k8s.io/v1/csidrivers/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update the specified CSIDriver
    # PATCH /apis/storage.k8s.io/v1/csidrivers/{name}
    def patch_csi_driver(**params, &)
      path = "/apis/storage.k8s.io/v1/csidrivers/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace the specified CSIDriver
    # PUT /apis/storage.k8s.io/v1/csidrivers/{name}
    def replace_csi_driver(**params, &)
      path = "/apis/storage.k8s.io/v1/csidrivers/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # delete collection of CSINode
    # DELETE /apis/storage.k8s.io/v1/csinodes
    def delete_collection_csi_node(**params, &)
      path = "/apis/storage.k8s.io/v1/csinodes"
      delete(path) { |res| yield res }
    end

    # list or watch objects of kind CSINode
    # GET /apis/storage.k8s.io/v1/csinodes
    def list_csi_node(**params, &)
      path = "/apis/storage.k8s.io/v1/csinodes"
      get(path) { |res| yield res }
    end

    # create a CSINode
    # POST /apis/storage.k8s.io/v1/csinodes
    def create_csi_node(**params, &)
      path = "/apis/storage.k8s.io/v1/csinodes"
      post(path, params) { |res| yield res }
    end

    # delete a CSINode
    # DELETE /apis/storage.k8s.io/v1/csinodes/{name}
    def delete_csi_node(**params, &)
      path = "/apis/storage.k8s.io/v1/csinodes/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # read the specified CSINode
    # GET /apis/storage.k8s.io/v1/csinodes/{name}
    def read_csi_node(**params, &)
      path = "/apis/storage.k8s.io/v1/csinodes/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update the specified CSINode
    # PATCH /apis/storage.k8s.io/v1/csinodes/{name}
    def patch_csi_node(**params, &)
      path = "/apis/storage.k8s.io/v1/csinodes/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace the specified CSINode
    # PUT /apis/storage.k8s.io/v1/csinodes/{name}
    def replace_csi_node(**params, &)
      path = "/apis/storage.k8s.io/v1/csinodes/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # list or watch objects of kind CSIStorageCapacity
    # GET /apis/storage.k8s.io/v1/csistoragecapacities
    def list_csi_storage_capacity_for_all_namespaces(**params, &)
      path = "/apis/storage.k8s.io/v1/csistoragecapacities"
      get(path) { |res| yield res }
    end

    # delete collection of CSIStorageCapacity
    # DELETE /apis/storage.k8s.io/v1/namespaces/{namespace}/csistoragecapacities
    def delete_collection_namespaced_csi_storage_capacity(**params, &)
      path = "/apis/storage.k8s.io/v1/namespaces/{namespace}/csistoragecapacities"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # list or watch objects of kind CSIStorageCapacity
    # GET /apis/storage.k8s.io/v1/namespaces/{namespace}/csistoragecapacities
    def list_namespaced_csi_storage_capacity(**params, &)
      path = "/apis/storage.k8s.io/v1/namespaces/{namespace}/csistoragecapacities"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # create a CSIStorageCapacity
    # POST /apis/storage.k8s.io/v1/namespaces/{namespace}/csistoragecapacities
    def create_namespaced_csi_storage_capacity(**params, &)
      path = "/apis/storage.k8s.io/v1/namespaces/{namespace}/csistoragecapacities"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      post(path, params) { |res| yield res }
    end

    # delete a CSIStorageCapacity
    # DELETE /apis/storage.k8s.io/v1/namespaces/{namespace}/csistoragecapacities/{name}
    def delete_namespaced_csi_storage_capacity(**params, &)
      path = "/apis/storage.k8s.io/v1/namespaces/{namespace}/csistoragecapacities/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # read the specified CSIStorageCapacity
    # GET /apis/storage.k8s.io/v1/namespaces/{namespace}/csistoragecapacities/{name}
    def read_namespaced_csi_storage_capacity(**params, &)
      path = "/apis/storage.k8s.io/v1/namespaces/{namespace}/csistoragecapacities/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update the specified CSIStorageCapacity
    # PATCH /apis/storage.k8s.io/v1/namespaces/{namespace}/csistoragecapacities/{name}
    def patch_namespaced_csi_storage_capacity(**params, &)
      path = "/apis/storage.k8s.io/v1/namespaces/{namespace}/csistoragecapacities/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace the specified CSIStorageCapacity
    # PUT /apis/storage.k8s.io/v1/namespaces/{namespace}/csistoragecapacities/{name}
    def replace_namespaced_csi_storage_capacity(**params, &)
      path = "/apis/storage.k8s.io/v1/namespaces/{namespace}/csistoragecapacities/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # delete collection of StorageClass
    # DELETE /apis/storage.k8s.io/v1/storageclasses
    def delete_collection_storage_class(**params, &)
      path = "/apis/storage.k8s.io/v1/storageclasses"
      delete(path) { |res| yield res }
    end

    # list or watch objects of kind StorageClass
    # GET /apis/storage.k8s.io/v1/storageclasses
    def list_storage_class(**params, &)
      path = "/apis/storage.k8s.io/v1/storageclasses"
      get(path) { |res| yield res }
    end

    # create a StorageClass
    # POST /apis/storage.k8s.io/v1/storageclasses
    def create_storage_class(**params, &)
      path = "/apis/storage.k8s.io/v1/storageclasses"
      post(path, params) { |res| yield res }
    end

    # delete a StorageClass
    # DELETE /apis/storage.k8s.io/v1/storageclasses/{name}
    def delete_storage_class(**params, &)
      path = "/apis/storage.k8s.io/v1/storageclasses/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # read the specified StorageClass
    # GET /apis/storage.k8s.io/v1/storageclasses/{name}
    def read_storage_class(**params, &)
      path = "/apis/storage.k8s.io/v1/storageclasses/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update the specified StorageClass
    # PATCH /apis/storage.k8s.io/v1/storageclasses/{name}
    def patch_storage_class(**params, &)
      path = "/apis/storage.k8s.io/v1/storageclasses/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace the specified StorageClass
    # PUT /apis/storage.k8s.io/v1/storageclasses/{name}
    def replace_storage_class(**params, &)
      path = "/apis/storage.k8s.io/v1/storageclasses/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # delete collection of VolumeAttachment
    # DELETE /apis/storage.k8s.io/v1/volumeattachments
    def delete_collection_volume_attachment(**params, &)
      path = "/apis/storage.k8s.io/v1/volumeattachments"
      delete(path) { |res| yield res }
    end

    # list or watch objects of kind VolumeAttachment
    # GET /apis/storage.k8s.io/v1/volumeattachments
    def list_volume_attachment(**params, &)
      path = "/apis/storage.k8s.io/v1/volumeattachments"
      get(path) { |res| yield res }
    end

    # create a VolumeAttachment
    # POST /apis/storage.k8s.io/v1/volumeattachments
    def create_volume_attachment(**params, &)
      path = "/apis/storage.k8s.io/v1/volumeattachments"
      post(path, params) { |res| yield res }
    end

    # delete a VolumeAttachment
    # DELETE /apis/storage.k8s.io/v1/volumeattachments/{name}
    def delete_volume_attachment(**params, &)
      path = "/apis/storage.k8s.io/v1/volumeattachments/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # read the specified VolumeAttachment
    # GET /apis/storage.k8s.io/v1/volumeattachments/{name}
    def read_volume_attachment(**params, &)
      path = "/apis/storage.k8s.io/v1/volumeattachments/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update the specified VolumeAttachment
    # PATCH /apis/storage.k8s.io/v1/volumeattachments/{name}
    def patch_volume_attachment(**params, &)
      path = "/apis/storage.k8s.io/v1/volumeattachments/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace the specified VolumeAttachment
    # PUT /apis/storage.k8s.io/v1/volumeattachments/{name}
    def replace_volume_attachment(**params, &)
      path = "/apis/storage.k8s.io/v1/volumeattachments/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # read status of the specified VolumeAttachment
    # GET /apis/storage.k8s.io/v1/volumeattachments/{name}/status
    def read_volume_attachment_status(**params, &)
      path = "/apis/storage.k8s.io/v1/volumeattachments/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update status of the specified VolumeAttachment
    # PATCH /apis/storage.k8s.io/v1/volumeattachments/{name}/status
    def patch_volume_attachment_status(**params, &)
      path = "/apis/storage.k8s.io/v1/volumeattachments/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace status of the specified VolumeAttachment
    # PUT /apis/storage.k8s.io/v1/volumeattachments/{name}/status
    def replace_volume_attachment_status(**params, &)
      path = "/apis/storage.k8s.io/v1/volumeattachments/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # delete collection of VolumeAttributesClass
    # DELETE /apis/storage.k8s.io/v1/volumeattributesclasses
    def delete_collection_volume_attributes_class(**params, &)
      path = "/apis/storage.k8s.io/v1/volumeattributesclasses"
      delete(path) { |res| yield res }
    end

    # list or watch objects of kind VolumeAttributesClass
    # GET /apis/storage.k8s.io/v1/volumeattributesclasses
    def list_volume_attributes_class(**params, &)
      path = "/apis/storage.k8s.io/v1/volumeattributesclasses"
      get(path) { |res| yield res }
    end

    # create a VolumeAttributesClass
    # POST /apis/storage.k8s.io/v1/volumeattributesclasses
    def create_volume_attributes_class(**params, &)
      path = "/apis/storage.k8s.io/v1/volumeattributesclasses"
      post(path, params) { |res| yield res }
    end

    # delete a VolumeAttributesClass
    # DELETE /apis/storage.k8s.io/v1/volumeattributesclasses/{name}
    def delete_volume_attributes_class(**params, &)
      path = "/apis/storage.k8s.io/v1/volumeattributesclasses/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # read the specified VolumeAttributesClass
    # GET /apis/storage.k8s.io/v1/volumeattributesclasses/{name}
    def read_volume_attributes_class(**params, &)
      path = "/apis/storage.k8s.io/v1/volumeattributesclasses/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update the specified VolumeAttributesClass
    # PATCH /apis/storage.k8s.io/v1/volumeattributesclasses/{name}
    def patch_volume_attributes_class(**params, &)
      path = "/apis/storage.k8s.io/v1/volumeattributesclasses/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace the specified VolumeAttributesClass
    # PUT /apis/storage.k8s.io/v1/volumeattributesclasses/{name}
    def replace_volume_attributes_class(**params, &)
      path = "/apis/storage.k8s.io/v1/volumeattributesclasses/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end
  end
end
