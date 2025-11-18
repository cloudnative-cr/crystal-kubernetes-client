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
    # GET /apis/authorization.k8s.io/v1/
    def get_authorization_v1_api_resources(**params, &)
      path = "/apis/authorization.k8s.io/v1/"
      get(path) { |res| yield res }
    end

    # create a LocalSubjectAccessReview
    # POST /apis/authorization.k8s.io/v1/namespaces/{namespace}/localsubjectaccessreviews
    def create_authorization_v1_namespaced_local_subject_access_review(**params, &)
      path = "/apis/authorization.k8s.io/v1/namespaces/{namespace}/localsubjectaccessreviews"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      post(path, params) { |res| yield res }
    end

    # create a SelfSubjectAccessReview
    # POST /apis/authorization.k8s.io/v1/selfsubjectaccessreviews
    def create_authorization_v1_self_subject_access_review(**params, &)
      path = "/apis/authorization.k8s.io/v1/selfsubjectaccessreviews"
      post(path, params) { |res| yield res }
    end

    # create a SelfSubjectRulesReview
    # POST /apis/authorization.k8s.io/v1/selfsubjectrulesreviews
    def create_authorization_v1_self_subject_rules_review(**params, &)
      path = "/apis/authorization.k8s.io/v1/selfsubjectrulesreviews"
      post(path, params) { |res| yield res }
    end

    # create a SubjectAccessReview
    # POST /apis/authorization.k8s.io/v1/subjectaccessreviews
    def create_authorization_v1_subject_access_review(**params, &)
      path = "/apis/authorization.k8s.io/v1/subjectaccessreviews"
      post(path, params) { |res| yield res }
    end
  end
end
