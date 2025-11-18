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
    # GET /apis/apiregistration.k8s.io/v1/
    def get_apiregistration_v1_api_resources(**params, &)
      path = "/apis/apiregistration.k8s.io/v1/"
      get(path) { |res| yield res }
    end

    # delete collection of APIService
    # DELETE /apis/apiregistration.k8s.io/v1/apiservices
    def delete_apiregistration_v1_collection_api_service(**params, &)
      path = "/apis/apiregistration.k8s.io/v1/apiservices"
      delete(path) { |res| yield res }
    end

    # list or watch objects of kind APIService
    # GET /apis/apiregistration.k8s.io/v1/apiservices
    def list_apiregistration_v1_api_service(**params, &)
      path = "/apis/apiregistration.k8s.io/v1/apiservices"
      get(path) { |res| yield res }
    end

    # create an APIService
    # POST /apis/apiregistration.k8s.io/v1/apiservices
    def create_apiregistration_v1_api_service(**params, &)
      path = "/apis/apiregistration.k8s.io/v1/apiservices"
      post(path, params) { |res| yield res }
    end

    # delete an APIService
    # DELETE /apis/apiregistration.k8s.io/v1/apiservices/{name}
    def delete_apiregistration_v1_api_service(**params, &)
      path = "/apis/apiregistration.k8s.io/v1/apiservices/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # read the specified APIService
    # GET /apis/apiregistration.k8s.io/v1/apiservices/{name}
    def read_apiregistration_v1_api_service(**params, &)
      path = "/apis/apiregistration.k8s.io/v1/apiservices/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update the specified APIService
    # PATCH /apis/apiregistration.k8s.io/v1/apiservices/{name}
    def patch_apiregistration_v1_api_service(**params, &)
      path = "/apis/apiregistration.k8s.io/v1/apiservices/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace the specified APIService
    # PUT /apis/apiregistration.k8s.io/v1/apiservices/{name}
    def replace_apiregistration_v1_api_service(**params, &)
      path = "/apis/apiregistration.k8s.io/v1/apiservices/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # read status of the specified APIService
    # GET /apis/apiregistration.k8s.io/v1/apiservices/{name}/status
    def read_apiregistration_v1_api_service_status(**params, &)
      path = "/apis/apiregistration.k8s.io/v1/apiservices/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update status of the specified APIService
    # PATCH /apis/apiregistration.k8s.io/v1/apiservices/{name}/status
    def patch_apiregistration_v1_api_service_status(**params, &)
      path = "/apis/apiregistration.k8s.io/v1/apiservices/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace status of the specified APIService
    # PUT /apis/apiregistration.k8s.io/v1/apiservices/{name}/status
    def replace_apiregistration_v1_api_service_status(**params, &)
      path = "/apis/apiregistration.k8s.io/v1/apiservices/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # watch individual changes to a list of APIService. deprecated: use the 'watch' parameter with a list operation instead.
    # GET /apis/apiregistration.k8s.io/v1/watch/apiservices
    def watch_apiregistration_v1_api_service_list(**params, &)
      path = "/apis/apiregistration.k8s.io/v1/watch/apiservices"
      get(path) { |res| yield res }
    end

    # watch changes to an object of kind APIService. deprecated: use the 'watch' parameter with a list operation instead, filtered to a single item with the 'fieldSelector' parameter.
    # GET /apis/apiregistration.k8s.io/v1/watch/apiservices/{name}
    def watch_apiregistration_v1_api_service(**params, &)
      path = "/apis/apiregistration.k8s.io/v1/watch/apiservices/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end
  end
end
