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
    # GET /apis/lifecycle.k8s.io/v1alpha1/
    def get_lifecycle_v1alpha1_api_resources(**params, &)
      path = "/apis/lifecycle.k8s.io/v1alpha1/"
      get(path) { |res| yield res }
    end

    # list or watch objects of kind EvictionRequest
    # GET /apis/lifecycle.k8s.io/v1alpha1/evictionrequests
    def list_lifecycle_v1alpha1_eviction_request_for_all_namespaces(**params, &)
      path = "/apis/lifecycle.k8s.io/v1alpha1/evictionrequests"
      get(path) { |res| yield res }
    end

    # list or watch objects of kind Eviction
    # GET /apis/lifecycle.k8s.io/v1alpha1/evictions
    def list_lifecycle_v1alpha1_eviction_for_all_namespaces(**params, &)
      path = "/apis/lifecycle.k8s.io/v1alpha1/evictions"
      get(path) { |res| yield res }
    end

    # delete collection of EvictionRequest
    # DELETE /apis/lifecycle.k8s.io/v1alpha1/namespaces/{namespace}/evictionrequests
    def delete_lifecycle_v1alpha1_collection_namespaced_eviction_request(**params, &)
      path = "/apis/lifecycle.k8s.io/v1alpha1/namespaces/{namespace}/evictionrequests"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # list or watch objects of kind EvictionRequest
    # GET /apis/lifecycle.k8s.io/v1alpha1/namespaces/{namespace}/evictionrequests
    def list_lifecycle_v1alpha1_namespaced_eviction_request(**params, &)
      path = "/apis/lifecycle.k8s.io/v1alpha1/namespaces/{namespace}/evictionrequests"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # create an EvictionRequest
    # POST /apis/lifecycle.k8s.io/v1alpha1/namespaces/{namespace}/evictionrequests
    def create_lifecycle_v1alpha1_namespaced_eviction_request(**params, &)
      path = "/apis/lifecycle.k8s.io/v1alpha1/namespaces/{namespace}/evictionrequests"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      post(path, params) { |res| yield res }
    end

    # delete an EvictionRequest
    # DELETE /apis/lifecycle.k8s.io/v1alpha1/namespaces/{namespace}/evictionrequests/{name}
    def delete_lifecycle_v1alpha1_namespaced_eviction_request(**params, &)
      path = "/apis/lifecycle.k8s.io/v1alpha1/namespaces/{namespace}/evictionrequests/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # read the specified EvictionRequest
    # GET /apis/lifecycle.k8s.io/v1alpha1/namespaces/{namespace}/evictionrequests/{name}
    def read_lifecycle_v1alpha1_namespaced_eviction_request(**params, &)
      path = "/apis/lifecycle.k8s.io/v1alpha1/namespaces/{namespace}/evictionrequests/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update the specified EvictionRequest
    # PATCH /apis/lifecycle.k8s.io/v1alpha1/namespaces/{namespace}/evictionrequests/{name}
    def patch_lifecycle_v1alpha1_namespaced_eviction_request(**params, &)
      path = "/apis/lifecycle.k8s.io/v1alpha1/namespaces/{namespace}/evictionrequests/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace the specified EvictionRequest
    # PUT /apis/lifecycle.k8s.io/v1alpha1/namespaces/{namespace}/evictionrequests/{name}
    def replace_lifecycle_v1alpha1_namespaced_eviction_request(**params, &)
      path = "/apis/lifecycle.k8s.io/v1alpha1/namespaces/{namespace}/evictionrequests/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # read status of the specified EvictionRequest
    # GET /apis/lifecycle.k8s.io/v1alpha1/namespaces/{namespace}/evictionrequests/{name}/status
    def read_lifecycle_v1alpha1_namespaced_eviction_request_status(**params, &)
      path = "/apis/lifecycle.k8s.io/v1alpha1/namespaces/{namespace}/evictionrequests/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update status of the specified EvictionRequest
    # PATCH /apis/lifecycle.k8s.io/v1alpha1/namespaces/{namespace}/evictionrequests/{name}/status
    def patch_lifecycle_v1alpha1_namespaced_eviction_request_status(**params, &)
      path = "/apis/lifecycle.k8s.io/v1alpha1/namespaces/{namespace}/evictionrequests/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace status of the specified EvictionRequest
    # PUT /apis/lifecycle.k8s.io/v1alpha1/namespaces/{namespace}/evictionrequests/{name}/status
    def replace_lifecycle_v1alpha1_namespaced_eviction_request_status(**params, &)
      path = "/apis/lifecycle.k8s.io/v1alpha1/namespaces/{namespace}/evictionrequests/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # delete collection of Eviction
    # DELETE /apis/lifecycle.k8s.io/v1alpha1/namespaces/{namespace}/evictions
    def delete_lifecycle_v1alpha1_collection_namespaced_eviction(**params, &)
      path = "/apis/lifecycle.k8s.io/v1alpha1/namespaces/{namespace}/evictions"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # list or watch objects of kind Eviction
    # GET /apis/lifecycle.k8s.io/v1alpha1/namespaces/{namespace}/evictions
    def list_lifecycle_v1alpha1_namespaced_eviction(**params, &)
      path = "/apis/lifecycle.k8s.io/v1alpha1/namespaces/{namespace}/evictions"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # create an Eviction
    # POST /apis/lifecycle.k8s.io/v1alpha1/namespaces/{namespace}/evictions
    def create_lifecycle_v1alpha1_namespaced_eviction(**params, &)
      path = "/apis/lifecycle.k8s.io/v1alpha1/namespaces/{namespace}/evictions"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      post(path, params) { |res| yield res }
    end

    # delete an Eviction
    # DELETE /apis/lifecycle.k8s.io/v1alpha1/namespaces/{namespace}/evictions/{name}
    def delete_lifecycle_v1alpha1_namespaced_eviction(**params, &)
      path = "/apis/lifecycle.k8s.io/v1alpha1/namespaces/{namespace}/evictions/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # read the specified Eviction
    # GET /apis/lifecycle.k8s.io/v1alpha1/namespaces/{namespace}/evictions/{name}
    def read_lifecycle_v1alpha1_namespaced_eviction(**params, &)
      path = "/apis/lifecycle.k8s.io/v1alpha1/namespaces/{namespace}/evictions/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update the specified Eviction
    # PATCH /apis/lifecycle.k8s.io/v1alpha1/namespaces/{namespace}/evictions/{name}
    def patch_lifecycle_v1alpha1_namespaced_eviction(**params, &)
      path = "/apis/lifecycle.k8s.io/v1alpha1/namespaces/{namespace}/evictions/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace the specified Eviction
    # PUT /apis/lifecycle.k8s.io/v1alpha1/namespaces/{namespace}/evictions/{name}
    def replace_lifecycle_v1alpha1_namespaced_eviction(**params, &)
      path = "/apis/lifecycle.k8s.io/v1alpha1/namespaces/{namespace}/evictions/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # read status of the specified Eviction
    # GET /apis/lifecycle.k8s.io/v1alpha1/namespaces/{namespace}/evictions/{name}/status
    def read_lifecycle_v1alpha1_namespaced_eviction_status(**params, &)
      path = "/apis/lifecycle.k8s.io/v1alpha1/namespaces/{namespace}/evictions/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update status of the specified Eviction
    # PATCH /apis/lifecycle.k8s.io/v1alpha1/namespaces/{namespace}/evictions/{name}/status
    def patch_lifecycle_v1alpha1_namespaced_eviction_status(**params, &)
      path = "/apis/lifecycle.k8s.io/v1alpha1/namespaces/{namespace}/evictions/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace status of the specified Eviction
    # PUT /apis/lifecycle.k8s.io/v1alpha1/namespaces/{namespace}/evictions/{name}/status
    def replace_lifecycle_v1alpha1_namespaced_eviction_status(**params, &)
      path = "/apis/lifecycle.k8s.io/v1alpha1/namespaces/{namespace}/evictions/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # watch individual changes to a list of EvictionRequest. deprecated: use the 'watch' parameter with a list operation instead.
    # GET /apis/lifecycle.k8s.io/v1alpha1/watch/evictionrequests
    def watch_lifecycle_v1alpha1_eviction_request_list_for_all_namespaces(**params, &)
      path = "/apis/lifecycle.k8s.io/v1alpha1/watch/evictionrequests"
      get(path) { |res| yield res }
    end

    # watch individual changes to a list of Eviction. deprecated: use the 'watch' parameter with a list operation instead.
    # GET /apis/lifecycle.k8s.io/v1alpha1/watch/evictions
    def watch_lifecycle_v1alpha1_eviction_list_for_all_namespaces(**params, &)
      path = "/apis/lifecycle.k8s.io/v1alpha1/watch/evictions"
      get(path) { |res| yield res }
    end

    # watch individual changes to a list of EvictionRequest. deprecated: use the 'watch' parameter with a list operation instead.
    # GET /apis/lifecycle.k8s.io/v1alpha1/watch/namespaces/{namespace}/evictionrequests
    def watch_lifecycle_v1alpha1_namespaced_eviction_request_list(**params, &)
      path = "/apis/lifecycle.k8s.io/v1alpha1/watch/namespaces/{namespace}/evictionrequests"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # watch changes to an object of kind EvictionRequest. deprecated: use the 'watch' parameter with a list operation instead, filtered to a single item with the 'fieldSelector' parameter.
    # GET /apis/lifecycle.k8s.io/v1alpha1/watch/namespaces/{namespace}/evictionrequests/{name}
    def watch_lifecycle_v1alpha1_namespaced_eviction_request(**params, &)
      path = "/apis/lifecycle.k8s.io/v1alpha1/watch/namespaces/{namespace}/evictionrequests/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # watch individual changes to a list of Eviction. deprecated: use the 'watch' parameter with a list operation instead.
    # GET /apis/lifecycle.k8s.io/v1alpha1/watch/namespaces/{namespace}/evictions
    def watch_lifecycle_v1alpha1_namespaced_eviction_list(**params, &)
      path = "/apis/lifecycle.k8s.io/v1alpha1/watch/namespaces/{namespace}/evictions"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # watch changes to an object of kind Eviction. deprecated: use the 'watch' parameter with a list operation instead, filtered to a single item with the 'fieldSelector' parameter.
    # GET /apis/lifecycle.k8s.io/v1alpha1/watch/namespaces/{namespace}/evictions/{name}
    def watch_lifecycle_v1alpha1_namespaced_eviction(**params, &)
      path = "/apis/lifecycle.k8s.io/v1alpha1/watch/namespaces/{namespace}/evictions/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end
  end
end
