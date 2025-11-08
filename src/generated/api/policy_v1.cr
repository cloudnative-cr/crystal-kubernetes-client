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
    # GET /apis/policy/v1/
    def get_api_resources(**params, &)
      path = "/apis/policy/v1/"
      get(path) { |res| yield res }
    end

    # delete collection of PodDisruptionBudget
    # DELETE /apis/policy/v1/namespaces/{namespace}/poddisruptionbudgets
    def delete_collection_namespaced_pod_disruption_budget(**params, &)
      path = "/apis/policy/v1/namespaces/{namespace}/poddisruptionbudgets"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # list or watch objects of kind PodDisruptionBudget
    # GET /apis/policy/v1/namespaces/{namespace}/poddisruptionbudgets
    def list_namespaced_pod_disruption_budget(**params, &)
      path = "/apis/policy/v1/namespaces/{namespace}/poddisruptionbudgets"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # create a PodDisruptionBudget
    # POST /apis/policy/v1/namespaces/{namespace}/poddisruptionbudgets
    def create_namespaced_pod_disruption_budget(**params, &)
      path = "/apis/policy/v1/namespaces/{namespace}/poddisruptionbudgets"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      post(path, params) { |res| yield res }
    end

    # delete a PodDisruptionBudget
    # DELETE /apis/policy/v1/namespaces/{namespace}/poddisruptionbudgets/{name}
    def delete_namespaced_pod_disruption_budget(**params, &)
      path = "/apis/policy/v1/namespaces/{namespace}/poddisruptionbudgets/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # read the specified PodDisruptionBudget
    # GET /apis/policy/v1/namespaces/{namespace}/poddisruptionbudgets/{name}
    def read_namespaced_pod_disruption_budget(**params, &)
      path = "/apis/policy/v1/namespaces/{namespace}/poddisruptionbudgets/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update the specified PodDisruptionBudget
    # PATCH /apis/policy/v1/namespaces/{namespace}/poddisruptionbudgets/{name}
    def patch_namespaced_pod_disruption_budget(**params, &)
      path = "/apis/policy/v1/namespaces/{namespace}/poddisruptionbudgets/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace the specified PodDisruptionBudget
    # PUT /apis/policy/v1/namespaces/{namespace}/poddisruptionbudgets/{name}
    def replace_namespaced_pod_disruption_budget(**params, &)
      path = "/apis/policy/v1/namespaces/{namespace}/poddisruptionbudgets/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # read status of the specified PodDisruptionBudget
    # GET /apis/policy/v1/namespaces/{namespace}/poddisruptionbudgets/{name}/status
    def read_namespaced_pod_disruption_budget_status(**params, &)
      path = "/apis/policy/v1/namespaces/{namespace}/poddisruptionbudgets/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update status of the specified PodDisruptionBudget
    # PATCH /apis/policy/v1/namespaces/{namespace}/poddisruptionbudgets/{name}/status
    def patch_namespaced_pod_disruption_budget_status(**params, &)
      path = "/apis/policy/v1/namespaces/{namespace}/poddisruptionbudgets/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace status of the specified PodDisruptionBudget
    # PUT /apis/policy/v1/namespaces/{namespace}/poddisruptionbudgets/{name}/status
    def replace_namespaced_pod_disruption_budget_status(**params, &)
      path = "/apis/policy/v1/namespaces/{namespace}/poddisruptionbudgets/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # list or watch objects of kind PodDisruptionBudget
    # GET /apis/policy/v1/poddisruptionbudgets
    def list_pod_disruption_budget_for_all_namespaces(**params, &)
      path = "/apis/policy/v1/poddisruptionbudgets"
      get(path) { |res| yield res }
    end
  end
end
