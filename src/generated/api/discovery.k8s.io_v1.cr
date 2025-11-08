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
    # GET /apis/discovery.k8s.io/v1/
    def get_api_resources(**params, &)
      path = "/apis/discovery.k8s.io/v1/"
      get(path) { |res| yield res }
    end

    # list or watch objects of kind EndpointSlice
    # GET /apis/discovery.k8s.io/v1/endpointslices
    def list_endpoint_slice_for_all_namespaces(**params, &)
      path = "/apis/discovery.k8s.io/v1/endpointslices"
      get(path) { |res| yield res }
    end

    # delete collection of EndpointSlice
    # DELETE /apis/discovery.k8s.io/v1/namespaces/{namespace}/endpointslices
    def delete_collection_namespaced_endpoint_slice(**params, &)
      path = "/apis/discovery.k8s.io/v1/namespaces/{namespace}/endpointslices"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # list or watch objects of kind EndpointSlice
    # GET /apis/discovery.k8s.io/v1/namespaces/{namespace}/endpointslices
    def list_namespaced_endpoint_slice(**params, &)
      path = "/apis/discovery.k8s.io/v1/namespaces/{namespace}/endpointslices"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # create an EndpointSlice
    # POST /apis/discovery.k8s.io/v1/namespaces/{namespace}/endpointslices
    def create_namespaced_endpoint_slice(**params, &)
      path = "/apis/discovery.k8s.io/v1/namespaces/{namespace}/endpointslices"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      post(path, params) { |res| yield res }
    end

    # delete an EndpointSlice
    # DELETE /apis/discovery.k8s.io/v1/namespaces/{namespace}/endpointslices/{name}
    def delete_namespaced_endpoint_slice(**params, &)
      path = "/apis/discovery.k8s.io/v1/namespaces/{namespace}/endpointslices/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # read the specified EndpointSlice
    # GET /apis/discovery.k8s.io/v1/namespaces/{namespace}/endpointslices/{name}
    def read_namespaced_endpoint_slice(**params, &)
      path = "/apis/discovery.k8s.io/v1/namespaces/{namespace}/endpointslices/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update the specified EndpointSlice
    # PATCH /apis/discovery.k8s.io/v1/namespaces/{namespace}/endpointslices/{name}
    def patch_namespaced_endpoint_slice(**params, &)
      path = "/apis/discovery.k8s.io/v1/namespaces/{namespace}/endpointslices/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace the specified EndpointSlice
    # PUT /apis/discovery.k8s.io/v1/namespaces/{namespace}/endpointslices/{name}
    def replace_namespaced_endpoint_slice(**params, &)
      path = "/apis/discovery.k8s.io/v1/namespaces/{namespace}/endpointslices/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end
  end
end
