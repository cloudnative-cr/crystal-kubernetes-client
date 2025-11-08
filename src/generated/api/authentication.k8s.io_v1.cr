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
    # GET /apis/authentication.k8s.io/v1/
    def get_api_resources(**params, &)
      path = "/apis/authentication.k8s.io/v1/"
      get(path) { |res| yield res }
    end

    # create a SelfSubjectReview
    # POST /apis/authentication.k8s.io/v1/selfsubjectreviews
    def create_self_subject_review(**params, &)
      path = "/apis/authentication.k8s.io/v1/selfsubjectreviews"
      post(path, params) { |res| yield res }
    end

    # create a TokenReview
    # POST /apis/authentication.k8s.io/v1/tokenreviews
    def create_token_review(**params, &)
      path = "/apis/authentication.k8s.io/v1/tokenreviews"
      post(path, params) { |res| yield res }
    end
  end
end
