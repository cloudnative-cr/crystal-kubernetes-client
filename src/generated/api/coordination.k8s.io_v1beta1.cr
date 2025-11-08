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
    # GET /apis/coordination.k8s.io/v1beta1/
    def get_api_resources(**params, &)
      path = "/apis/coordination.k8s.io/v1beta1/"
      get(path) { |res| yield res }
    end

    # list or watch objects of kind LeaseCandidate
    # GET /apis/coordination.k8s.io/v1beta1/leasecandidates
    def list_lease_candidate_for_all_namespaces(**params, &)
      path = "/apis/coordination.k8s.io/v1beta1/leasecandidates"
      get(path) { |res| yield res }
    end

    # delete collection of LeaseCandidate
    # DELETE /apis/coordination.k8s.io/v1beta1/namespaces/{namespace}/leasecandidates
    def delete_collection_namespaced_lease_candidate(**params, &)
      path = "/apis/coordination.k8s.io/v1beta1/namespaces/{namespace}/leasecandidates"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # list or watch objects of kind LeaseCandidate
    # GET /apis/coordination.k8s.io/v1beta1/namespaces/{namespace}/leasecandidates
    def list_namespaced_lease_candidate(**params, &)
      path = "/apis/coordination.k8s.io/v1beta1/namespaces/{namespace}/leasecandidates"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # create a LeaseCandidate
    # POST /apis/coordination.k8s.io/v1beta1/namespaces/{namespace}/leasecandidates
    def create_namespaced_lease_candidate(**params, &)
      path = "/apis/coordination.k8s.io/v1beta1/namespaces/{namespace}/leasecandidates"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      post(path, params) { |res| yield res }
    end

    # delete a LeaseCandidate
    # DELETE /apis/coordination.k8s.io/v1beta1/namespaces/{namespace}/leasecandidates/{name}
    def delete_namespaced_lease_candidate(**params, &)
      path = "/apis/coordination.k8s.io/v1beta1/namespaces/{namespace}/leasecandidates/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # read the specified LeaseCandidate
    # GET /apis/coordination.k8s.io/v1beta1/namespaces/{namespace}/leasecandidates/{name}
    def read_namespaced_lease_candidate(**params, &)
      path = "/apis/coordination.k8s.io/v1beta1/namespaces/{namespace}/leasecandidates/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update the specified LeaseCandidate
    # PATCH /apis/coordination.k8s.io/v1beta1/namespaces/{namespace}/leasecandidates/{name}
    def patch_namespaced_lease_candidate(**params, &)
      path = "/apis/coordination.k8s.io/v1beta1/namespaces/{namespace}/leasecandidates/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace the specified LeaseCandidate
    # PUT /apis/coordination.k8s.io/v1beta1/namespaces/{namespace}/leasecandidates/{name}
    def replace_namespaced_lease_candidate(**params, &)
      path = "/apis/coordination.k8s.io/v1beta1/namespaces/{namespace}/leasecandidates/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end
  end
end
