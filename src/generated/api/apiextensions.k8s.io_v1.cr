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
    # GET /apis/apiextensions.k8s.io/v1/
    def get_apiextensions_v1_api_resources(**params, &)
      path = "/apis/apiextensions.k8s.io/v1/"
      get(path) { |res| yield res }
    end

    # delete collection of CustomResourceDefinition
    # DELETE /apis/apiextensions.k8s.io/v1/customresourcedefinitions
    def delete_apiextensions_v1_collection_custom_resource_definition(**params, &)
      path = "/apis/apiextensions.k8s.io/v1/customresourcedefinitions"
      delete(path) { |res| yield res }
    end

    # list or watch objects of kind CustomResourceDefinition
    # GET /apis/apiextensions.k8s.io/v1/customresourcedefinitions
    def list_apiextensions_v1_custom_resource_definition(**params, &)
      path = "/apis/apiextensions.k8s.io/v1/customresourcedefinitions"
      get(path) { |res| yield res }
    end

    # create a CustomResourceDefinition
    # POST /apis/apiextensions.k8s.io/v1/customresourcedefinitions
    def create_apiextensions_v1_custom_resource_definition(**params, &)
      path = "/apis/apiextensions.k8s.io/v1/customresourcedefinitions"
      post(path, params) { |res| yield res }
    end

    # delete a CustomResourceDefinition
    # DELETE /apis/apiextensions.k8s.io/v1/customresourcedefinitions/{name}
    def delete_apiextensions_v1_custom_resource_definition(**params, &)
      path = "/apis/apiextensions.k8s.io/v1/customresourcedefinitions/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # read the specified CustomResourceDefinition
    # GET /apis/apiextensions.k8s.io/v1/customresourcedefinitions/{name}
    def read_apiextensions_v1_custom_resource_definition(**params, &)
      path = "/apis/apiextensions.k8s.io/v1/customresourcedefinitions/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update the specified CustomResourceDefinition
    # PATCH /apis/apiextensions.k8s.io/v1/customresourcedefinitions/{name}
    def patch_apiextensions_v1_custom_resource_definition(**params, &)
      path = "/apis/apiextensions.k8s.io/v1/customresourcedefinitions/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace the specified CustomResourceDefinition
    # PUT /apis/apiextensions.k8s.io/v1/customresourcedefinitions/{name}
    def replace_apiextensions_v1_custom_resource_definition(**params, &)
      path = "/apis/apiextensions.k8s.io/v1/customresourcedefinitions/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # read status of the specified CustomResourceDefinition
    # GET /apis/apiextensions.k8s.io/v1/customresourcedefinitions/{name}/status
    def read_apiextensions_v1_custom_resource_definition_status(**params, &)
      path = "/apis/apiextensions.k8s.io/v1/customresourcedefinitions/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update status of the specified CustomResourceDefinition
    # PATCH /apis/apiextensions.k8s.io/v1/customresourcedefinitions/{name}/status
    def patch_apiextensions_v1_custom_resource_definition_status(**params, &)
      path = "/apis/apiextensions.k8s.io/v1/customresourcedefinitions/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace status of the specified CustomResourceDefinition
    # PUT /apis/apiextensions.k8s.io/v1/customresourcedefinitions/{name}/status
    def replace_apiextensions_v1_custom_resource_definition_status(**params, &)
      path = "/apis/apiextensions.k8s.io/v1/customresourcedefinitions/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # watch individual changes to a list of CustomResourceDefinition. deprecated: use the 'watch' parameter with a list operation instead.
    # GET /apis/apiextensions.k8s.io/v1/watch/customresourcedefinitions
    def watch_apiextensions_v1_custom_resource_definition_list(**params, &)
      path = "/apis/apiextensions.k8s.io/v1/watch/customresourcedefinitions"
      get(path) { |res| yield res }
    end

    # watch changes to an object of kind CustomResourceDefinition. deprecated: use the 'watch' parameter with a list operation instead, filtered to a single item with the 'fieldSelector' parameter.
    # GET /apis/apiextensions.k8s.io/v1/watch/customresourcedefinitions/{name}
    def watch_apiextensions_v1_custom_resource_definition(**params, &)
      path = "/apis/apiextensions.k8s.io/v1/watch/customresourcedefinitions/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end
  end
end
