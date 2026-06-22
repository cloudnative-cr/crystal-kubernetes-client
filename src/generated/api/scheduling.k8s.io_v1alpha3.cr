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
    # GET /apis/scheduling.k8s.io/v1alpha3/
    def get_scheduling_v1alpha3_api_resources(**params, &)
      path = "/apis/scheduling.k8s.io/v1alpha3/"
      get(path) { |res| yield res }
    end

    # delete collection of PodGroup
    # DELETE /apis/scheduling.k8s.io/v1alpha3/namespaces/{namespace}/podgroups
    def delete_scheduling_v1alpha3_collection_namespaced_pod_group(**params, &)
      path = "/apis/scheduling.k8s.io/v1alpha3/namespaces/{namespace}/podgroups"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # list or watch objects of kind PodGroup
    # GET /apis/scheduling.k8s.io/v1alpha3/namespaces/{namespace}/podgroups
    def list_scheduling_v1alpha3_namespaced_pod_group(**params, &)
      path = "/apis/scheduling.k8s.io/v1alpha3/namespaces/{namespace}/podgroups"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # create a PodGroup
    # POST /apis/scheduling.k8s.io/v1alpha3/namespaces/{namespace}/podgroups
    def create_scheduling_v1alpha3_namespaced_pod_group(**params, &)
      path = "/apis/scheduling.k8s.io/v1alpha3/namespaces/{namespace}/podgroups"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      post(path, params) { |res| yield res }
    end

    # delete a PodGroup
    # DELETE /apis/scheduling.k8s.io/v1alpha3/namespaces/{namespace}/podgroups/{name}
    def delete_scheduling_v1alpha3_namespaced_pod_group(**params, &)
      path = "/apis/scheduling.k8s.io/v1alpha3/namespaces/{namespace}/podgroups/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # read the specified PodGroup
    # GET /apis/scheduling.k8s.io/v1alpha3/namespaces/{namespace}/podgroups/{name}
    def read_scheduling_v1alpha3_namespaced_pod_group(**params, &)
      path = "/apis/scheduling.k8s.io/v1alpha3/namespaces/{namespace}/podgroups/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update the specified PodGroup
    # PATCH /apis/scheduling.k8s.io/v1alpha3/namespaces/{namespace}/podgroups/{name}
    def patch_scheduling_v1alpha3_namespaced_pod_group(**params, &)
      path = "/apis/scheduling.k8s.io/v1alpha3/namespaces/{namespace}/podgroups/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace the specified PodGroup
    # PUT /apis/scheduling.k8s.io/v1alpha3/namespaces/{namespace}/podgroups/{name}
    def replace_scheduling_v1alpha3_namespaced_pod_group(**params, &)
      path = "/apis/scheduling.k8s.io/v1alpha3/namespaces/{namespace}/podgroups/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # read status of the specified PodGroup
    # GET /apis/scheduling.k8s.io/v1alpha3/namespaces/{namespace}/podgroups/{name}/status
    def read_scheduling_v1alpha3_namespaced_pod_group_status(**params, &)
      path = "/apis/scheduling.k8s.io/v1alpha3/namespaces/{namespace}/podgroups/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update status of the specified PodGroup
    # PATCH /apis/scheduling.k8s.io/v1alpha3/namespaces/{namespace}/podgroups/{name}/status
    def patch_scheduling_v1alpha3_namespaced_pod_group_status(**params, &)
      path = "/apis/scheduling.k8s.io/v1alpha3/namespaces/{namespace}/podgroups/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace status of the specified PodGroup
    # PUT /apis/scheduling.k8s.io/v1alpha3/namespaces/{namespace}/podgroups/{name}/status
    def replace_scheduling_v1alpha3_namespaced_pod_group_status(**params, &)
      path = "/apis/scheduling.k8s.io/v1alpha3/namespaces/{namespace}/podgroups/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # delete collection of Workload
    # DELETE /apis/scheduling.k8s.io/v1alpha3/namespaces/{namespace}/workloads
    def delete_scheduling_v1alpha3_collection_namespaced_workload(**params, &)
      path = "/apis/scheduling.k8s.io/v1alpha3/namespaces/{namespace}/workloads"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # list or watch objects of kind Workload
    # GET /apis/scheduling.k8s.io/v1alpha3/namespaces/{namespace}/workloads
    def list_scheduling_v1alpha3_namespaced_workload(**params, &)
      path = "/apis/scheduling.k8s.io/v1alpha3/namespaces/{namespace}/workloads"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # create a Workload
    # POST /apis/scheduling.k8s.io/v1alpha3/namespaces/{namespace}/workloads
    def create_scheduling_v1alpha3_namespaced_workload(**params, &)
      path = "/apis/scheduling.k8s.io/v1alpha3/namespaces/{namespace}/workloads"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      post(path, params) { |res| yield res }
    end

    # delete a Workload
    # DELETE /apis/scheduling.k8s.io/v1alpha3/namespaces/{namespace}/workloads/{name}
    def delete_scheduling_v1alpha3_namespaced_workload(**params, &)
      path = "/apis/scheduling.k8s.io/v1alpha3/namespaces/{namespace}/workloads/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # read the specified Workload
    # GET /apis/scheduling.k8s.io/v1alpha3/namespaces/{namespace}/workloads/{name}
    def read_scheduling_v1alpha3_namespaced_workload(**params, &)
      path = "/apis/scheduling.k8s.io/v1alpha3/namespaces/{namespace}/workloads/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update the specified Workload
    # PATCH /apis/scheduling.k8s.io/v1alpha3/namespaces/{namespace}/workloads/{name}
    def patch_scheduling_v1alpha3_namespaced_workload(**params, &)
      path = "/apis/scheduling.k8s.io/v1alpha3/namespaces/{namespace}/workloads/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace the specified Workload
    # PUT /apis/scheduling.k8s.io/v1alpha3/namespaces/{namespace}/workloads/{name}
    def replace_scheduling_v1alpha3_namespaced_workload(**params, &)
      path = "/apis/scheduling.k8s.io/v1alpha3/namespaces/{namespace}/workloads/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # list or watch objects of kind PodGroup
    # GET /apis/scheduling.k8s.io/v1alpha3/podgroups
    def list_scheduling_v1alpha3_pod_group_for_all_namespaces(**params, &)
      path = "/apis/scheduling.k8s.io/v1alpha3/podgroups"
      get(path) { |res| yield res }
    end

    # watch individual changes to a list of PodGroup. deprecated: use the 'watch' parameter with a list operation instead.
    # GET /apis/scheduling.k8s.io/v1alpha3/watch/namespaces/{namespace}/podgroups
    def watch_scheduling_v1alpha3_namespaced_pod_group_list(**params, &)
      path = "/apis/scheduling.k8s.io/v1alpha3/watch/namespaces/{namespace}/podgroups"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # watch changes to an object of kind PodGroup. deprecated: use the 'watch' parameter with a list operation instead, filtered to a single item with the 'fieldSelector' parameter.
    # GET /apis/scheduling.k8s.io/v1alpha3/watch/namespaces/{namespace}/podgroups/{name}
    def watch_scheduling_v1alpha3_namespaced_pod_group(**params, &)
      path = "/apis/scheduling.k8s.io/v1alpha3/watch/namespaces/{namespace}/podgroups/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # watch individual changes to a list of Workload. deprecated: use the 'watch' parameter with a list operation instead.
    # GET /apis/scheduling.k8s.io/v1alpha3/watch/namespaces/{namespace}/workloads
    def watch_scheduling_v1alpha3_namespaced_workload_list(**params, &)
      path = "/apis/scheduling.k8s.io/v1alpha3/watch/namespaces/{namespace}/workloads"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # watch changes to an object of kind Workload. deprecated: use the 'watch' parameter with a list operation instead, filtered to a single item with the 'fieldSelector' parameter.
    # GET /apis/scheduling.k8s.io/v1alpha3/watch/namespaces/{namespace}/workloads/{name}
    def watch_scheduling_v1alpha3_namespaced_workload(**params, &)
      path = "/apis/scheduling.k8s.io/v1alpha3/watch/namespaces/{namespace}/workloads/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # watch individual changes to a list of PodGroup. deprecated: use the 'watch' parameter with a list operation instead.
    # GET /apis/scheduling.k8s.io/v1alpha3/watch/podgroups
    def watch_scheduling_v1alpha3_pod_group_list_for_all_namespaces(**params, &)
      path = "/apis/scheduling.k8s.io/v1alpha3/watch/podgroups"
      get(path) { |res| yield res }
    end

    # watch individual changes to a list of Workload. deprecated: use the 'watch' parameter with a list operation instead.
    # GET /apis/scheduling.k8s.io/v1alpha3/watch/workloads
    def watch_scheduling_v1alpha3_workload_list_for_all_namespaces(**params, &)
      path = "/apis/scheduling.k8s.io/v1alpha3/watch/workloads"
      get(path) { |res| yield res }
    end

    # list or watch objects of kind Workload
    # GET /apis/scheduling.k8s.io/v1alpha3/workloads
    def list_scheduling_v1alpha3_workload_for_all_namespaces(**params, &)
      path = "/apis/scheduling.k8s.io/v1alpha3/workloads"
      get(path) { |res| yield res }
    end
  end
end
