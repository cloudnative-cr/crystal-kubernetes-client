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
    def get_certificates_v1beta1_api_resources(**params, &)
      path = "/apis/certificates.k8s.io/v1beta1/"
      get(path) { |res| yield res }
    end

    # delete collection of ClusterTrustBundle
    # DELETE /apis/certificates.k8s.io/v1beta1/clustertrustbundles
    def delete_certificates_v1beta1_collection_cluster_trust_bundle(**params, &)
      path = "/apis/certificates.k8s.io/v1beta1/clustertrustbundles"
      delete(path) { |res| yield res }
    end

    # list or watch objects of kind ClusterTrustBundle
    # GET /apis/certificates.k8s.io/v1beta1/clustertrustbundles
    def list_certificates_v1beta1_cluster_trust_bundle(**params, &)
      path = "/apis/certificates.k8s.io/v1beta1/clustertrustbundles"
      get(path) { |res| yield res }
    end

    # create a ClusterTrustBundle
    # POST /apis/certificates.k8s.io/v1beta1/clustertrustbundles
    def create_certificates_v1beta1_cluster_trust_bundle(**params, &)
      path = "/apis/certificates.k8s.io/v1beta1/clustertrustbundles"
      post(path, params) { |res| yield res }
    end

    # delete a ClusterTrustBundle
    # DELETE /apis/certificates.k8s.io/v1beta1/clustertrustbundles/{name}
    def delete_certificates_v1beta1_cluster_trust_bundle(**params, &)
      path = "/apis/certificates.k8s.io/v1beta1/clustertrustbundles/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # read the specified ClusterTrustBundle
    # GET /apis/certificates.k8s.io/v1beta1/clustertrustbundles/{name}
    def read_certificates_v1beta1_cluster_trust_bundle(**params, &)
      path = "/apis/certificates.k8s.io/v1beta1/clustertrustbundles/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update the specified ClusterTrustBundle
    # PATCH /apis/certificates.k8s.io/v1beta1/clustertrustbundles/{name}
    def patch_certificates_v1beta1_cluster_trust_bundle(**params, &)
      path = "/apis/certificates.k8s.io/v1beta1/clustertrustbundles/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace the specified ClusterTrustBundle
    # PUT /apis/certificates.k8s.io/v1beta1/clustertrustbundles/{name}
    def replace_certificates_v1beta1_cluster_trust_bundle(**params, &)
      path = "/apis/certificates.k8s.io/v1beta1/clustertrustbundles/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # delete collection of PodCertificateRequest
    # DELETE /apis/certificates.k8s.io/v1beta1/namespaces/{namespace}/podcertificaterequests
    def delete_certificates_v1beta1_collection_namespaced_pod_certificate_request(**params, &)
      path = "/apis/certificates.k8s.io/v1beta1/namespaces/{namespace}/podcertificaterequests"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # list or watch objects of kind PodCertificateRequest
    # GET /apis/certificates.k8s.io/v1beta1/namespaces/{namespace}/podcertificaterequests
    def list_certificates_v1beta1_namespaced_pod_certificate_request(**params, &)
      path = "/apis/certificates.k8s.io/v1beta1/namespaces/{namespace}/podcertificaterequests"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # create a PodCertificateRequest
    # POST /apis/certificates.k8s.io/v1beta1/namespaces/{namespace}/podcertificaterequests
    def create_certificates_v1beta1_namespaced_pod_certificate_request(**params, &)
      path = "/apis/certificates.k8s.io/v1beta1/namespaces/{namespace}/podcertificaterequests"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      post(path, params) { |res| yield res }
    end

    # delete a PodCertificateRequest
    # DELETE /apis/certificates.k8s.io/v1beta1/namespaces/{namespace}/podcertificaterequests/{name}
    def delete_certificates_v1beta1_namespaced_pod_certificate_request(**params, &)
      path = "/apis/certificates.k8s.io/v1beta1/namespaces/{namespace}/podcertificaterequests/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # read the specified PodCertificateRequest
    # GET /apis/certificates.k8s.io/v1beta1/namespaces/{namespace}/podcertificaterequests/{name}
    def read_certificates_v1beta1_namespaced_pod_certificate_request(**params, &)
      path = "/apis/certificates.k8s.io/v1beta1/namespaces/{namespace}/podcertificaterequests/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update the specified PodCertificateRequest
    # PATCH /apis/certificates.k8s.io/v1beta1/namespaces/{namespace}/podcertificaterequests/{name}
    def patch_certificates_v1beta1_namespaced_pod_certificate_request(**params, &)
      path = "/apis/certificates.k8s.io/v1beta1/namespaces/{namespace}/podcertificaterequests/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace the specified PodCertificateRequest
    # PUT /apis/certificates.k8s.io/v1beta1/namespaces/{namespace}/podcertificaterequests/{name}
    def replace_certificates_v1beta1_namespaced_pod_certificate_request(**params, &)
      path = "/apis/certificates.k8s.io/v1beta1/namespaces/{namespace}/podcertificaterequests/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # read status of the specified PodCertificateRequest
    # GET /apis/certificates.k8s.io/v1beta1/namespaces/{namespace}/podcertificaterequests/{name}/status
    def read_certificates_v1beta1_namespaced_pod_certificate_request_status(**params, &)
      path = "/apis/certificates.k8s.io/v1beta1/namespaces/{namespace}/podcertificaterequests/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update status of the specified PodCertificateRequest
    # PATCH /apis/certificates.k8s.io/v1beta1/namespaces/{namespace}/podcertificaterequests/{name}/status
    def patch_certificates_v1beta1_namespaced_pod_certificate_request_status(**params, &)
      path = "/apis/certificates.k8s.io/v1beta1/namespaces/{namespace}/podcertificaterequests/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace status of the specified PodCertificateRequest
    # PUT /apis/certificates.k8s.io/v1beta1/namespaces/{namespace}/podcertificaterequests/{name}/status
    def replace_certificates_v1beta1_namespaced_pod_certificate_request_status(**params, &)
      path = "/apis/certificates.k8s.io/v1beta1/namespaces/{namespace}/podcertificaterequests/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # list or watch objects of kind PodCertificateRequest
    # GET /apis/certificates.k8s.io/v1beta1/podcertificaterequests
    def list_certificates_v1beta1_pod_certificate_request_for_all_namespaces(**params, &)
      path = "/apis/certificates.k8s.io/v1beta1/podcertificaterequests"
      get(path) { |res| yield res }
    end

    # watch individual changes to a list of ClusterTrustBundle. deprecated: use the 'watch' parameter with a list operation instead.
    # GET /apis/certificates.k8s.io/v1beta1/watch/clustertrustbundles
    def watch_certificates_v1beta1_cluster_trust_bundle_list(**params, &)
      path = "/apis/certificates.k8s.io/v1beta1/watch/clustertrustbundles"
      get(path) { |res| yield res }
    end

    # watch changes to an object of kind ClusterTrustBundle. deprecated: use the 'watch' parameter with a list operation instead, filtered to a single item with the 'fieldSelector' parameter.
    # GET /apis/certificates.k8s.io/v1beta1/watch/clustertrustbundles/{name}
    def watch_certificates_v1beta1_cluster_trust_bundle(**params, &)
      path = "/apis/certificates.k8s.io/v1beta1/watch/clustertrustbundles/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # watch individual changes to a list of PodCertificateRequest. deprecated: use the 'watch' parameter with a list operation instead.
    # GET /apis/certificates.k8s.io/v1beta1/watch/namespaces/{namespace}/podcertificaterequests
    def watch_certificates_v1beta1_namespaced_pod_certificate_request_list(**params, &)
      path = "/apis/certificates.k8s.io/v1beta1/watch/namespaces/{namespace}/podcertificaterequests"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # watch changes to an object of kind PodCertificateRequest. deprecated: use the 'watch' parameter with a list operation instead, filtered to a single item with the 'fieldSelector' parameter.
    # GET /apis/certificates.k8s.io/v1beta1/watch/namespaces/{namespace}/podcertificaterequests/{name}
    def watch_certificates_v1beta1_namespaced_pod_certificate_request(**params, &)
      path = "/apis/certificates.k8s.io/v1beta1/watch/namespaces/{namespace}/podcertificaterequests/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # watch individual changes to a list of PodCertificateRequest. deprecated: use the 'watch' parameter with a list operation instead.
    # GET /apis/certificates.k8s.io/v1beta1/watch/podcertificaterequests
    def watch_certificates_v1beta1_pod_certificate_request_list_for_all_namespaces(**params, &)
      path = "/apis/certificates.k8s.io/v1beta1/watch/podcertificaterequests"
      get(path) { |res| yield res }
    end
  end
end
