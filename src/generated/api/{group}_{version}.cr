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
    # GET /apis/{group}/{version}
    def get_api_resources(**params, &)
      path = "/apis/{group}/{version}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # list or watch namespace scoped custom objects
    # GET /apis/{group}/{version}/{resource_plural}
    def list_custom_object_for_all_namespaces(**params, &)
      path = "/apis/{group}/{version}/{resource_plural}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # list or watch cluster scoped custom objects
    # GET /apis/{group}/{version}/{plural}
    def list_cluster_custom_object(**params, &)
      path = "/apis/{group}/{version}/{plural}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # Creates a cluster scoped Custom object
    # POST /apis/{group}/{version}/{plural}
    def create_cluster_custom_object(**params, &)
      path = "/apis/{group}/{version}/{plural}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      post(path, params) { |res| yield res }
    end

    # Delete collection of cluster scoped custom objects
    # DELETE /apis/{group}/{version}/{plural}
    def delete_collection_cluster_custom_object(**params, &)
      path = "/apis/{group}/{version}/{plural}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # list or watch namespace scoped custom objects
    # GET /apis/{group}/{version}/namespaces/{namespace}/{plural}
    def list_namespaced_custom_object(**params, &)
      path = "/apis/{group}/{version}/namespaces/{namespace}/{plural}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # Creates a namespace scoped Custom object
    # POST /apis/{group}/{version}/namespaces/{namespace}/{plural}
    def create_namespaced_custom_object(**params, &)
      path = "/apis/{group}/{version}/namespaces/{namespace}/{plural}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      post(path, params) { |res| yield res }
    end

    # Delete collection of namespace scoped custom objects
    # DELETE /apis/{group}/{version}/namespaces/{namespace}/{plural}
    def delete_collection_namespaced_custom_object(**params, &)
      path = "/apis/{group}/{version}/namespaces/{namespace}/{plural}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # Returns a cluster scoped custom object
    # GET /apis/{group}/{version}/{plural}/{name}
    def get_cluster_custom_object(**params, &)
      path = "/apis/{group}/{version}/{plural}/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # Deletes the specified cluster scoped custom object
    # DELETE /apis/{group}/{version}/{plural}/{name}
    def delete_cluster_custom_object(**params, &)
      path = "/apis/{group}/{version}/{plural}/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # patch the specified cluster scoped custom object
    # PATCH /apis/{group}/{version}/{plural}/{name}
    def patch_cluster_custom_object(**params, &)
      path = "/apis/{group}/{version}/{plural}/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace the specified cluster scoped custom object
    # PUT /apis/{group}/{version}/{plural}/{name}
    def replace_cluster_custom_object(**params, &)
      path = "/apis/{group}/{version}/{plural}/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # read status of the specified cluster scoped custom object
    # GET /apis/{group}/{version}/{plural}/{name}/status
    def get_cluster_custom_object_status(**params, &)
      path = "/apis/{group}/{version}/{plural}/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # replace status of the cluster scoped specified custom object
    # PUT /apis/{group}/{version}/{plural}/{name}/status
    def replace_cluster_custom_object_status(**params, &)
      path = "/apis/{group}/{version}/{plural}/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # partially update status of the specified cluster scoped custom object
    # PATCH /apis/{group}/{version}/{plural}/{name}/status
    def patch_cluster_custom_object_status(**params, &)
      path = "/apis/{group}/{version}/{plural}/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # read scale of the specified custom object
    # GET /apis/{group}/{version}/{plural}/{name}/scale
    def get_cluster_custom_object_scale(**params, &)
      path = "/apis/{group}/{version}/{plural}/{name}/scale"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # replace scale of the specified cluster scoped custom object
    # PUT /apis/{group}/{version}/{plural}/{name}/scale
    def replace_cluster_custom_object_scale(**params, &)
      path = "/apis/{group}/{version}/{plural}/{name}/scale"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # partially update scale of the specified cluster scoped custom object
    # PATCH /apis/{group}/{version}/{plural}/{name}/scale
    def patch_cluster_custom_object_scale(**params, &)
      path = "/apis/{group}/{version}/{plural}/{name}/scale"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # Returns a namespace scoped custom object
    # GET /apis/{group}/{version}/namespaces/{namespace}/{plural}/{name}
    def get_namespaced_custom_object(**params, &)
      path = "/apis/{group}/{version}/namespaces/{namespace}/{plural}/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # Deletes the specified namespace scoped custom object
    # DELETE /apis/{group}/{version}/namespaces/{namespace}/{plural}/{name}
    def delete_namespaced_custom_object(**params, &)
      path = "/apis/{group}/{version}/namespaces/{namespace}/{plural}/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # patch the specified namespace scoped custom object
    # PATCH /apis/{group}/{version}/namespaces/{namespace}/{plural}/{name}
    def patch_namespaced_custom_object(**params, &)
      path = "/apis/{group}/{version}/namespaces/{namespace}/{plural}/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace the specified namespace scoped custom object
    # PUT /apis/{group}/{version}/namespaces/{namespace}/{plural}/{name}
    def replace_namespaced_custom_object(**params, &)
      path = "/apis/{group}/{version}/namespaces/{namespace}/{plural}/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # read status of the specified namespace scoped custom object
    # GET /apis/{group}/{version}/namespaces/{namespace}/{plural}/{name}/status
    def get_namespaced_custom_object_status(**params, &)
      path = "/apis/{group}/{version}/namespaces/{namespace}/{plural}/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # replace status of the specified namespace scoped custom object
    # PUT /apis/{group}/{version}/namespaces/{namespace}/{plural}/{name}/status
    def replace_namespaced_custom_object_status(**params, &)
      path = "/apis/{group}/{version}/namespaces/{namespace}/{plural}/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # partially update status of the specified namespace scoped custom object
    # PATCH /apis/{group}/{version}/namespaces/{namespace}/{plural}/{name}/status
    def patch_namespaced_custom_object_status(**params, &)
      path = "/apis/{group}/{version}/namespaces/{namespace}/{plural}/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # read scale of the specified namespace scoped custom object
    # GET /apis/{group}/{version}/namespaces/{namespace}/{plural}/{name}/scale
    def get_namespaced_custom_object_scale(**params, &)
      path = "/apis/{group}/{version}/namespaces/{namespace}/{plural}/{name}/scale"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # replace scale of the specified namespace scoped custom object
    # PUT /apis/{group}/{version}/namespaces/{namespace}/{plural}/{name}/scale
    def replace_namespaced_custom_object_scale(**params, &)
      path = "/apis/{group}/{version}/namespaces/{namespace}/{plural}/{name}/scale"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # partially update scale of the specified namespace scoped custom object
    # PATCH /apis/{group}/{version}/namespaces/{namespace}/{plural}/{name}/scale
    def patch_namespaced_custom_object_scale(**params, &)
      path = "/apis/{group}/{version}/namespaces/{namespace}/{plural}/{name}/scale"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end
  end
end
