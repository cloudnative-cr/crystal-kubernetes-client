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
    # GET /apis/storagemigration.k8s.io/v1alpha1/
    def get_api_resources(**params, &)
      path = "/apis/storagemigration.k8s.io/v1alpha1/"
      get(path) { |res| yield res }
    end

    # delete collection of StorageVersionMigration
    # DELETE /apis/storagemigration.k8s.io/v1alpha1/storageversionmigrations
    def delete_collection_storage_version_migration(**params, &)
      path = "/apis/storagemigration.k8s.io/v1alpha1/storageversionmigrations"
      delete(path) { |res| yield res }
    end

    # list or watch objects of kind StorageVersionMigration
    # GET /apis/storagemigration.k8s.io/v1alpha1/storageversionmigrations
    def list_storage_version_migration(**params, &)
      path = "/apis/storagemigration.k8s.io/v1alpha1/storageversionmigrations"
      get(path) { |res| yield res }
    end

    # create a StorageVersionMigration
    # POST /apis/storagemigration.k8s.io/v1alpha1/storageversionmigrations
    def create_storage_version_migration(**params, &)
      path = "/apis/storagemigration.k8s.io/v1alpha1/storageversionmigrations"
      post(path, params) { |res| yield res }
    end

    # delete a StorageVersionMigration
    # DELETE /apis/storagemigration.k8s.io/v1alpha1/storageversionmigrations/{name}
    def delete_storage_version_migration(**params, &)
      path = "/apis/storagemigration.k8s.io/v1alpha1/storageversionmigrations/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # read the specified StorageVersionMigration
    # GET /apis/storagemigration.k8s.io/v1alpha1/storageversionmigrations/{name}
    def read_storage_version_migration(**params, &)
      path = "/apis/storagemigration.k8s.io/v1alpha1/storageversionmigrations/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update the specified StorageVersionMigration
    # PATCH /apis/storagemigration.k8s.io/v1alpha1/storageversionmigrations/{name}
    def patch_storage_version_migration(**params, &)
      path = "/apis/storagemigration.k8s.io/v1alpha1/storageversionmigrations/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace the specified StorageVersionMigration
    # PUT /apis/storagemigration.k8s.io/v1alpha1/storageversionmigrations/{name}
    def replace_storage_version_migration(**params, &)
      path = "/apis/storagemigration.k8s.io/v1alpha1/storageversionmigrations/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # read status of the specified StorageVersionMigration
    # GET /apis/storagemigration.k8s.io/v1alpha1/storageversionmigrations/{name}/status
    def read_storage_version_migration_status(**params, &)
      path = "/apis/storagemigration.k8s.io/v1alpha1/storageversionmigrations/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update status of the specified StorageVersionMigration
    # PATCH /apis/storagemigration.k8s.io/v1alpha1/storageversionmigrations/{name}/status
    def patch_storage_version_migration_status(**params, &)
      path = "/apis/storagemigration.k8s.io/v1alpha1/storageversionmigrations/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace status of the specified StorageVersionMigration
    # PUT /apis/storagemigration.k8s.io/v1alpha1/storageversionmigrations/{name}/status
    def replace_storage_version_migration_status(**params, &)
      path = "/apis/storagemigration.k8s.io/v1alpha1/storageversionmigrations/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end
  end
end
