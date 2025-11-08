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
    # GET /apis/coordination.k8s.io/v1/
    def get_api_resources(**params, &)
      path = "/apis/coordination.k8s.io/v1/"
      get(path) { |res| yield res }
    end

    # list or watch objects of kind Lease
    # GET /apis/coordination.k8s.io/v1/leases
    def list_lease_for_all_namespaces(**params, &)
      path = "/apis/coordination.k8s.io/v1/leases"
      get(path) { |res| yield res }
    end

    # delete collection of Lease
    # DELETE /apis/coordination.k8s.io/v1/namespaces/{namespace}/leases
    def delete_collection_namespaced_lease(**params, &)
      path = "/apis/coordination.k8s.io/v1/namespaces/{namespace}/leases"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # list or watch objects of kind Lease
    # GET /apis/coordination.k8s.io/v1/namespaces/{namespace}/leases
    def list_namespaced_lease(**params, &)
      path = "/apis/coordination.k8s.io/v1/namespaces/{namespace}/leases"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # create a Lease
    # POST /apis/coordination.k8s.io/v1/namespaces/{namespace}/leases
    def create_namespaced_lease(**params, &)
      path = "/apis/coordination.k8s.io/v1/namespaces/{namespace}/leases"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      post(path, params) { |res| yield res }
    end

    # delete a Lease
    # DELETE /apis/coordination.k8s.io/v1/namespaces/{namespace}/leases/{name}
    def delete_namespaced_lease(**params, &)
      path = "/apis/coordination.k8s.io/v1/namespaces/{namespace}/leases/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # read the specified Lease
    # GET /apis/coordination.k8s.io/v1/namespaces/{namespace}/leases/{name}
    def read_namespaced_lease(**params, &)
      path = "/apis/coordination.k8s.io/v1/namespaces/{namespace}/leases/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update the specified Lease
    # PATCH /apis/coordination.k8s.io/v1/namespaces/{namespace}/leases/{name}
    def patch_namespaced_lease(**params, &)
      path = "/apis/coordination.k8s.io/v1/namespaces/{namespace}/leases/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace the specified Lease
    # PUT /apis/coordination.k8s.io/v1/namespaces/{namespace}/leases/{name}
    def replace_namespaced_lease(**params, &)
      path = "/apis/coordination.k8s.io/v1/namespaces/{namespace}/leases/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end
  end
end
