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
    # GET /apis/certificates.k8s.io/v1beta1/
    def get_api_resources(**params, &)
      path = "/apis/certificates.k8s.io/v1beta1/"
      get(path) { |res| yield res }
    end

    # delete collection of ClusterTrustBundle
    # DELETE /apis/certificates.k8s.io/v1beta1/clustertrustbundles
    def delete_collection_cluster_trust_bundle(**params, &)
      path = "/apis/certificates.k8s.io/v1beta1/clustertrustbundles"
      delete(path) { |res| yield res }
    end

    # list or watch objects of kind ClusterTrustBundle
    # GET /apis/certificates.k8s.io/v1beta1/clustertrustbundles
    def list_cluster_trust_bundle(**params, &)
      path = "/apis/certificates.k8s.io/v1beta1/clustertrustbundles"
      get(path) { |res| yield res }
    end

    # create a ClusterTrustBundle
    # POST /apis/certificates.k8s.io/v1beta1/clustertrustbundles
    def create_cluster_trust_bundle(**params, &)
      path = "/apis/certificates.k8s.io/v1beta1/clustertrustbundles"
      post(path, params) { |res| yield res }
    end

    # delete a ClusterTrustBundle
    # DELETE /apis/certificates.k8s.io/v1beta1/clustertrustbundles/{name}
    def delete_cluster_trust_bundle(**params, &)
      path = "/apis/certificates.k8s.io/v1beta1/clustertrustbundles/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # read the specified ClusterTrustBundle
    # GET /apis/certificates.k8s.io/v1beta1/clustertrustbundles/{name}
    def read_cluster_trust_bundle(**params, &)
      path = "/apis/certificates.k8s.io/v1beta1/clustertrustbundles/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update the specified ClusterTrustBundle
    # PATCH /apis/certificates.k8s.io/v1beta1/clustertrustbundles/{name}
    def patch_cluster_trust_bundle(**params, &)
      path = "/apis/certificates.k8s.io/v1beta1/clustertrustbundles/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace the specified ClusterTrustBundle
    # PUT /apis/certificates.k8s.io/v1beta1/clustertrustbundles/{name}
    def replace_cluster_trust_bundle(**params, &)
      path = "/apis/certificates.k8s.io/v1beta1/clustertrustbundles/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end
  end
end
