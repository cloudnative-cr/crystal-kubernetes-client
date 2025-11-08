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
    # GET /apis/internal.apiserver.k8s.io/v1alpha1/
    def get_api_resources(**params, &)
      path = "/apis/internal.apiserver.k8s.io/v1alpha1/"
      get(path) { |res| yield res }
    end

    # delete collection of StorageVersion
    # DELETE /apis/internal.apiserver.k8s.io/v1alpha1/storageversions
    def delete_collection_storage_version(**params, &)
      path = "/apis/internal.apiserver.k8s.io/v1alpha1/storageversions"
      delete(path) { |res| yield res }
    end

    # list or watch objects of kind StorageVersion
    # GET /apis/internal.apiserver.k8s.io/v1alpha1/storageversions
    def list_storage_version(**params, &)
      path = "/apis/internal.apiserver.k8s.io/v1alpha1/storageversions"
      get(path) { |res| yield res }
    end

    # create a StorageVersion
    # POST /apis/internal.apiserver.k8s.io/v1alpha1/storageversions
    def create_storage_version(**params, &)
      path = "/apis/internal.apiserver.k8s.io/v1alpha1/storageversions"
      post(path, params) { |res| yield res }
    end

    # delete a StorageVersion
    # DELETE /apis/internal.apiserver.k8s.io/v1alpha1/storageversions/{name}
    def delete_storage_version(**params, &)
      path = "/apis/internal.apiserver.k8s.io/v1alpha1/storageversions/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # read the specified StorageVersion
    # GET /apis/internal.apiserver.k8s.io/v1alpha1/storageversions/{name}
    def read_storage_version(**params, &)
      path = "/apis/internal.apiserver.k8s.io/v1alpha1/storageversions/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update the specified StorageVersion
    # PATCH /apis/internal.apiserver.k8s.io/v1alpha1/storageversions/{name}
    def patch_storage_version(**params, &)
      path = "/apis/internal.apiserver.k8s.io/v1alpha1/storageversions/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace the specified StorageVersion
    # PUT /apis/internal.apiserver.k8s.io/v1alpha1/storageversions/{name}
    def replace_storage_version(**params, &)
      path = "/apis/internal.apiserver.k8s.io/v1alpha1/storageversions/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # read status of the specified StorageVersion
    # GET /apis/internal.apiserver.k8s.io/v1alpha1/storageversions/{name}/status
    def read_storage_version_status(**params, &)
      path = "/apis/internal.apiserver.k8s.io/v1alpha1/storageversions/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update status of the specified StorageVersion
    # PATCH /apis/internal.apiserver.k8s.io/v1alpha1/storageversions/{name}/status
    def patch_storage_version_status(**params, &)
      path = "/apis/internal.apiserver.k8s.io/v1alpha1/storageversions/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace status of the specified StorageVersion
    # PUT /apis/internal.apiserver.k8s.io/v1alpha1/storageversions/{name}/status
    def replace_storage_version_status(**params, &)
      path = "/apis/internal.apiserver.k8s.io/v1alpha1/storageversions/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end
  end
end
