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
    # GET /apis/flowcontrol.apiserver.k8s.io/v1/
    def get_api_resources(**params, &)
      path = "/apis/flowcontrol.apiserver.k8s.io/v1/"
      get(path) { |res| yield res }
    end

    # delete collection of FlowSchema
    # DELETE /apis/flowcontrol.apiserver.k8s.io/v1/flowschemas
    def delete_collection_flow_schema(**params, &)
      path = "/apis/flowcontrol.apiserver.k8s.io/v1/flowschemas"
      delete(path) { |res| yield res }
    end

    # list or watch objects of kind FlowSchema
    # GET /apis/flowcontrol.apiserver.k8s.io/v1/flowschemas
    def list_flow_schema(**params, &)
      path = "/apis/flowcontrol.apiserver.k8s.io/v1/flowschemas"
      get(path) { |res| yield res }
    end

    # create a FlowSchema
    # POST /apis/flowcontrol.apiserver.k8s.io/v1/flowschemas
    def create_flow_schema(**params, &)
      path = "/apis/flowcontrol.apiserver.k8s.io/v1/flowschemas"
      post(path, params) { |res| yield res }
    end

    # delete a FlowSchema
    # DELETE /apis/flowcontrol.apiserver.k8s.io/v1/flowschemas/{name}
    def delete_flow_schema(**params, &)
      path = "/apis/flowcontrol.apiserver.k8s.io/v1/flowschemas/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # read the specified FlowSchema
    # GET /apis/flowcontrol.apiserver.k8s.io/v1/flowschemas/{name}
    def read_flow_schema(**params, &)
      path = "/apis/flowcontrol.apiserver.k8s.io/v1/flowschemas/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update the specified FlowSchema
    # PATCH /apis/flowcontrol.apiserver.k8s.io/v1/flowschemas/{name}
    def patch_flow_schema(**params, &)
      path = "/apis/flowcontrol.apiserver.k8s.io/v1/flowschemas/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace the specified FlowSchema
    # PUT /apis/flowcontrol.apiserver.k8s.io/v1/flowschemas/{name}
    def replace_flow_schema(**params, &)
      path = "/apis/flowcontrol.apiserver.k8s.io/v1/flowschemas/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # read status of the specified FlowSchema
    # GET /apis/flowcontrol.apiserver.k8s.io/v1/flowschemas/{name}/status
    def read_flow_schema_status(**params, &)
      path = "/apis/flowcontrol.apiserver.k8s.io/v1/flowschemas/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update status of the specified FlowSchema
    # PATCH /apis/flowcontrol.apiserver.k8s.io/v1/flowschemas/{name}/status
    def patch_flow_schema_status(**params, &)
      path = "/apis/flowcontrol.apiserver.k8s.io/v1/flowschemas/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace status of the specified FlowSchema
    # PUT /apis/flowcontrol.apiserver.k8s.io/v1/flowschemas/{name}/status
    def replace_flow_schema_status(**params, &)
      path = "/apis/flowcontrol.apiserver.k8s.io/v1/flowschemas/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # delete collection of PriorityLevelConfiguration
    # DELETE /apis/flowcontrol.apiserver.k8s.io/v1/prioritylevelconfigurations
    def delete_collection_priority_level_configuration(**params, &)
      path = "/apis/flowcontrol.apiserver.k8s.io/v1/prioritylevelconfigurations"
      delete(path) { |res| yield res }
    end

    # list or watch objects of kind PriorityLevelConfiguration
    # GET /apis/flowcontrol.apiserver.k8s.io/v1/prioritylevelconfigurations
    def list_priority_level_configuration(**params, &)
      path = "/apis/flowcontrol.apiserver.k8s.io/v1/prioritylevelconfigurations"
      get(path) { |res| yield res }
    end

    # create a PriorityLevelConfiguration
    # POST /apis/flowcontrol.apiserver.k8s.io/v1/prioritylevelconfigurations
    def create_priority_level_configuration(**params, &)
      path = "/apis/flowcontrol.apiserver.k8s.io/v1/prioritylevelconfigurations"
      post(path, params) { |res| yield res }
    end

    # delete a PriorityLevelConfiguration
    # DELETE /apis/flowcontrol.apiserver.k8s.io/v1/prioritylevelconfigurations/{name}
    def delete_priority_level_configuration(**params, &)
      path = "/apis/flowcontrol.apiserver.k8s.io/v1/prioritylevelconfigurations/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # read the specified PriorityLevelConfiguration
    # GET /apis/flowcontrol.apiserver.k8s.io/v1/prioritylevelconfigurations/{name}
    def read_priority_level_configuration(**params, &)
      path = "/apis/flowcontrol.apiserver.k8s.io/v1/prioritylevelconfigurations/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update the specified PriorityLevelConfiguration
    # PATCH /apis/flowcontrol.apiserver.k8s.io/v1/prioritylevelconfigurations/{name}
    def patch_priority_level_configuration(**params, &)
      path = "/apis/flowcontrol.apiserver.k8s.io/v1/prioritylevelconfigurations/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace the specified PriorityLevelConfiguration
    # PUT /apis/flowcontrol.apiserver.k8s.io/v1/prioritylevelconfigurations/{name}
    def replace_priority_level_configuration(**params, &)
      path = "/apis/flowcontrol.apiserver.k8s.io/v1/prioritylevelconfigurations/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # read status of the specified PriorityLevelConfiguration
    # GET /apis/flowcontrol.apiserver.k8s.io/v1/prioritylevelconfigurations/{name}/status
    def read_priority_level_configuration_status(**params, &)
      path = "/apis/flowcontrol.apiserver.k8s.io/v1/prioritylevelconfigurations/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update status of the specified PriorityLevelConfiguration
    # PATCH /apis/flowcontrol.apiserver.k8s.io/v1/prioritylevelconfigurations/{name}/status
    def patch_priority_level_configuration_status(**params, &)
      path = "/apis/flowcontrol.apiserver.k8s.io/v1/prioritylevelconfigurations/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace status of the specified PriorityLevelConfiguration
    # PUT /apis/flowcontrol.apiserver.k8s.io/v1/prioritylevelconfigurations/{name}/status
    def replace_priority_level_configuration_status(**params, &)
      path = "/apis/flowcontrol.apiserver.k8s.io/v1/prioritylevelconfigurations/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end
  end
end
