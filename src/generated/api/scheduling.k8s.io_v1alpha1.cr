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
    # GET /apis/scheduling.k8s.io/v1alpha1/
    def get_scheduling_v1alpha1_api_resources(**params, &)
      path = "/apis/scheduling.k8s.io/v1alpha1/"
      get(path) { |res| yield res }
    end

    # delete collection of Workload
    # DELETE /apis/scheduling.k8s.io/v1alpha1/namespaces/{namespace}/workloads
    def delete_scheduling_v1alpha1_collection_namespaced_workload(**params, &)
      path = "/apis/scheduling.k8s.io/v1alpha1/namespaces/{namespace}/workloads"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # list or watch objects of kind Workload
    # GET /apis/scheduling.k8s.io/v1alpha1/namespaces/{namespace}/workloads
    def list_scheduling_v1alpha1_namespaced_workload(**params, &)
      path = "/apis/scheduling.k8s.io/v1alpha1/namespaces/{namespace}/workloads"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # create a Workload
    # POST /apis/scheduling.k8s.io/v1alpha1/namespaces/{namespace}/workloads
    def create_scheduling_v1alpha1_namespaced_workload(**params, &)
      path = "/apis/scheduling.k8s.io/v1alpha1/namespaces/{namespace}/workloads"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      post(path, params) { |res| yield res }
    end

    # delete a Workload
    # DELETE /apis/scheduling.k8s.io/v1alpha1/namespaces/{namespace}/workloads/{name}
    def delete_scheduling_v1alpha1_namespaced_workload(**params, &)
      path = "/apis/scheduling.k8s.io/v1alpha1/namespaces/{namespace}/workloads/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # read the specified Workload
    # GET /apis/scheduling.k8s.io/v1alpha1/namespaces/{namespace}/workloads/{name}
    def read_scheduling_v1alpha1_namespaced_workload(**params, &)
      path = "/apis/scheduling.k8s.io/v1alpha1/namespaces/{namespace}/workloads/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update the specified Workload
    # PATCH /apis/scheduling.k8s.io/v1alpha1/namespaces/{namespace}/workloads/{name}
    def patch_scheduling_v1alpha1_namespaced_workload(**params, &)
      path = "/apis/scheduling.k8s.io/v1alpha1/namespaces/{namespace}/workloads/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace the specified Workload
    # PUT /apis/scheduling.k8s.io/v1alpha1/namespaces/{namespace}/workloads/{name}
    def replace_scheduling_v1alpha1_namespaced_workload(**params, &)
      path = "/apis/scheduling.k8s.io/v1alpha1/namespaces/{namespace}/workloads/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # watch individual changes to a list of Workload. deprecated: use the 'watch' parameter with a list operation instead.
    # GET /apis/scheduling.k8s.io/v1alpha1/watch/namespaces/{namespace}/workloads
    def watch_scheduling_v1alpha1_namespaced_workload_list(**params, &)
      path = "/apis/scheduling.k8s.io/v1alpha1/watch/namespaces/{namespace}/workloads"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # watch changes to an object of kind Workload. deprecated: use the 'watch' parameter with a list operation instead, filtered to a single item with the 'fieldSelector' parameter.
    # GET /apis/scheduling.k8s.io/v1alpha1/watch/namespaces/{namespace}/workloads/{name}
    def watch_scheduling_v1alpha1_namespaced_workload(**params, &)
      path = "/apis/scheduling.k8s.io/v1alpha1/watch/namespaces/{namespace}/workloads/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # watch individual changes to a list of Workload. deprecated: use the 'watch' parameter with a list operation instead.
    # GET /apis/scheduling.k8s.io/v1alpha1/watch/workloads
    def watch_scheduling_v1alpha1_workload_list_for_all_namespaces(**params, &)
      path = "/apis/scheduling.k8s.io/v1alpha1/watch/workloads"
      get(path) { |res| yield res }
    end

    # list or watch objects of kind Workload
    # GET /apis/scheduling.k8s.io/v1alpha1/workloads
    def list_scheduling_v1alpha1_workload_for_all_namespaces(**params, &)
      path = "/apis/scheduling.k8s.io/v1alpha1/workloads"
      get(path) { |res| yield res }
    end
  end
end
