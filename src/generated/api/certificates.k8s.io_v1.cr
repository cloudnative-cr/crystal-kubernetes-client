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
    # GET /apis/certificates.k8s.io/v1/
    def get_api_resources(**params, &)
      path = "/apis/certificates.k8s.io/v1/"
      get(path) { |res| yield res }
    end

    # delete collection of CertificateSigningRequest
    # DELETE /apis/certificates.k8s.io/v1/certificatesigningrequests
    def delete_collection_certificate_signing_request(**params, &)
      path = "/apis/certificates.k8s.io/v1/certificatesigningrequests"
      delete(path) { |res| yield res }
    end

    # list or watch objects of kind CertificateSigningRequest
    # GET /apis/certificates.k8s.io/v1/certificatesigningrequests
    def list_certificate_signing_request(**params, &)
      path = "/apis/certificates.k8s.io/v1/certificatesigningrequests"
      get(path) { |res| yield res }
    end

    # create a CertificateSigningRequest
    # POST /apis/certificates.k8s.io/v1/certificatesigningrequests
    def create_certificate_signing_request(**params, &)
      path = "/apis/certificates.k8s.io/v1/certificatesigningrequests"
      post(path, params) { |res| yield res }
    end

    # delete a CertificateSigningRequest
    # DELETE /apis/certificates.k8s.io/v1/certificatesigningrequests/{name}
    def delete_certificate_signing_request(**params, &)
      path = "/apis/certificates.k8s.io/v1/certificatesigningrequests/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # read the specified CertificateSigningRequest
    # GET /apis/certificates.k8s.io/v1/certificatesigningrequests/{name}
    def read_certificate_signing_request(**params, &)
      path = "/apis/certificates.k8s.io/v1/certificatesigningrequests/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update the specified CertificateSigningRequest
    # PATCH /apis/certificates.k8s.io/v1/certificatesigningrequests/{name}
    def patch_certificate_signing_request(**params, &)
      path = "/apis/certificates.k8s.io/v1/certificatesigningrequests/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace the specified CertificateSigningRequest
    # PUT /apis/certificates.k8s.io/v1/certificatesigningrequests/{name}
    def replace_certificate_signing_request(**params, &)
      path = "/apis/certificates.k8s.io/v1/certificatesigningrequests/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # read approval of the specified CertificateSigningRequest
    # GET /apis/certificates.k8s.io/v1/certificatesigningrequests/{name}/approval
    def read_certificate_signing_request_approval(**params, &)
      path = "/apis/certificates.k8s.io/v1/certificatesigningrequests/{name}/approval"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update approval of the specified CertificateSigningRequest
    # PATCH /apis/certificates.k8s.io/v1/certificatesigningrequests/{name}/approval
    def patch_certificate_signing_request_approval(**params, &)
      path = "/apis/certificates.k8s.io/v1/certificatesigningrequests/{name}/approval"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace approval of the specified CertificateSigningRequest
    # PUT /apis/certificates.k8s.io/v1/certificatesigningrequests/{name}/approval
    def replace_certificate_signing_request_approval(**params, &)
      path = "/apis/certificates.k8s.io/v1/certificatesigningrequests/{name}/approval"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # read status of the specified CertificateSigningRequest
    # GET /apis/certificates.k8s.io/v1/certificatesigningrequests/{name}/status
    def read_certificate_signing_request_status(**params, &)
      path = "/apis/certificates.k8s.io/v1/certificatesigningrequests/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update status of the specified CertificateSigningRequest
    # PATCH /apis/certificates.k8s.io/v1/certificatesigningrequests/{name}/status
    def patch_certificate_signing_request_status(**params, &)
      path = "/apis/certificates.k8s.io/v1/certificatesigningrequests/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace status of the specified CertificateSigningRequest
    # PUT /apis/certificates.k8s.io/v1/certificatesigningrequests/{name}/status
    def replace_certificate_signing_request_status(**params, &)
      path = "/apis/certificates.k8s.io/v1/certificatesigningrequests/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end
  end
end
