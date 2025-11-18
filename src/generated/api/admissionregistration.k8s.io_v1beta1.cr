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
    # GET /apis/admissionregistration.k8s.io/v1beta1/
    def get_admissionregistration_v1beta1_api_resources(**params, &)
      path = "/apis/admissionregistration.k8s.io/v1beta1/"
      get(path) { |res| yield res }
    end

    # delete collection of MutatingAdmissionPolicy
    # DELETE /apis/admissionregistration.k8s.io/v1beta1/mutatingadmissionpolicies
    def delete_admissionregistration_v1beta1_collection_mutating_admission_policy(**params, &)
      path = "/apis/admissionregistration.k8s.io/v1beta1/mutatingadmissionpolicies"
      delete(path) { |res| yield res }
    end

    # list or watch objects of kind MutatingAdmissionPolicy
    # GET /apis/admissionregistration.k8s.io/v1beta1/mutatingadmissionpolicies
    def list_admissionregistration_v1beta1_mutating_admission_policy(**params, &)
      path = "/apis/admissionregistration.k8s.io/v1beta1/mutatingadmissionpolicies"
      get(path) { |res| yield res }
    end

    # create a MutatingAdmissionPolicy
    # POST /apis/admissionregistration.k8s.io/v1beta1/mutatingadmissionpolicies
    def create_admissionregistration_v1beta1_mutating_admission_policy(**params, &)
      path = "/apis/admissionregistration.k8s.io/v1beta1/mutatingadmissionpolicies"
      post(path, params) { |res| yield res }
    end

    # delete a MutatingAdmissionPolicy
    # DELETE /apis/admissionregistration.k8s.io/v1beta1/mutatingadmissionpolicies/{name}
    def delete_admissionregistration_v1beta1_mutating_admission_policy(**params, &)
      path = "/apis/admissionregistration.k8s.io/v1beta1/mutatingadmissionpolicies/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # read the specified MutatingAdmissionPolicy
    # GET /apis/admissionregistration.k8s.io/v1beta1/mutatingadmissionpolicies/{name}
    def read_admissionregistration_v1beta1_mutating_admission_policy(**params, &)
      path = "/apis/admissionregistration.k8s.io/v1beta1/mutatingadmissionpolicies/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update the specified MutatingAdmissionPolicy
    # PATCH /apis/admissionregistration.k8s.io/v1beta1/mutatingadmissionpolicies/{name}
    def patch_admissionregistration_v1beta1_mutating_admission_policy(**params, &)
      path = "/apis/admissionregistration.k8s.io/v1beta1/mutatingadmissionpolicies/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace the specified MutatingAdmissionPolicy
    # PUT /apis/admissionregistration.k8s.io/v1beta1/mutatingadmissionpolicies/{name}
    def replace_admissionregistration_v1beta1_mutating_admission_policy(**params, &)
      path = "/apis/admissionregistration.k8s.io/v1beta1/mutatingadmissionpolicies/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # delete collection of MutatingAdmissionPolicyBinding
    # DELETE /apis/admissionregistration.k8s.io/v1beta1/mutatingadmissionpolicybindings
    def delete_admissionregistration_v1beta1_collection_mutating_admission_policy_binding(**params, &)
      path = "/apis/admissionregistration.k8s.io/v1beta1/mutatingadmissionpolicybindings"
      delete(path) { |res| yield res }
    end

    # list or watch objects of kind MutatingAdmissionPolicyBinding
    # GET /apis/admissionregistration.k8s.io/v1beta1/mutatingadmissionpolicybindings
    def list_admissionregistration_v1beta1_mutating_admission_policy_binding(**params, &)
      path = "/apis/admissionregistration.k8s.io/v1beta1/mutatingadmissionpolicybindings"
      get(path) { |res| yield res }
    end

    # create a MutatingAdmissionPolicyBinding
    # POST /apis/admissionregistration.k8s.io/v1beta1/mutatingadmissionpolicybindings
    def create_admissionregistration_v1beta1_mutating_admission_policy_binding(**params, &)
      path = "/apis/admissionregistration.k8s.io/v1beta1/mutatingadmissionpolicybindings"
      post(path, params) { |res| yield res }
    end

    # delete a MutatingAdmissionPolicyBinding
    # DELETE /apis/admissionregistration.k8s.io/v1beta1/mutatingadmissionpolicybindings/{name}
    def delete_admissionregistration_v1beta1_mutating_admission_policy_binding(**params, &)
      path = "/apis/admissionregistration.k8s.io/v1beta1/mutatingadmissionpolicybindings/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # read the specified MutatingAdmissionPolicyBinding
    # GET /apis/admissionregistration.k8s.io/v1beta1/mutatingadmissionpolicybindings/{name}
    def read_admissionregistration_v1beta1_mutating_admission_policy_binding(**params, &)
      path = "/apis/admissionregistration.k8s.io/v1beta1/mutatingadmissionpolicybindings/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update the specified MutatingAdmissionPolicyBinding
    # PATCH /apis/admissionregistration.k8s.io/v1beta1/mutatingadmissionpolicybindings/{name}
    def patch_admissionregistration_v1beta1_mutating_admission_policy_binding(**params, &)
      path = "/apis/admissionregistration.k8s.io/v1beta1/mutatingadmissionpolicybindings/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace the specified MutatingAdmissionPolicyBinding
    # PUT /apis/admissionregistration.k8s.io/v1beta1/mutatingadmissionpolicybindings/{name}
    def replace_admissionregistration_v1beta1_mutating_admission_policy_binding(**params, &)
      path = "/apis/admissionregistration.k8s.io/v1beta1/mutatingadmissionpolicybindings/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # watch individual changes to a list of MutatingAdmissionPolicy. deprecated: use the 'watch' parameter with a list operation instead.
    # GET /apis/admissionregistration.k8s.io/v1beta1/watch/mutatingadmissionpolicies
    def watch_admissionregistration_v1beta1_mutating_admission_policy_list(**params, &)
      path = "/apis/admissionregistration.k8s.io/v1beta1/watch/mutatingadmissionpolicies"
      get(path) { |res| yield res }
    end

    # watch changes to an object of kind MutatingAdmissionPolicy. deprecated: use the 'watch' parameter with a list operation instead, filtered to a single item with the 'fieldSelector' parameter.
    # GET /apis/admissionregistration.k8s.io/v1beta1/watch/mutatingadmissionpolicies/{name}
    def watch_admissionregistration_v1beta1_mutating_admission_policy(**params, &)
      path = "/apis/admissionregistration.k8s.io/v1beta1/watch/mutatingadmissionpolicies/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # watch individual changes to a list of MutatingAdmissionPolicyBinding. deprecated: use the 'watch' parameter with a list operation instead.
    # GET /apis/admissionregistration.k8s.io/v1beta1/watch/mutatingadmissionpolicybindings
    def watch_admissionregistration_v1beta1_mutating_admission_policy_binding_list(**params, &)
      path = "/apis/admissionregistration.k8s.io/v1beta1/watch/mutatingadmissionpolicybindings"
      get(path) { |res| yield res }
    end

    # watch changes to an object of kind MutatingAdmissionPolicyBinding. deprecated: use the 'watch' parameter with a list operation instead, filtered to a single item with the 'fieldSelector' parameter.
    # GET /apis/admissionregistration.k8s.io/v1beta1/watch/mutatingadmissionpolicybindings/{name}
    def watch_admissionregistration_v1beta1_mutating_admission_policy_binding(**params, &)
      path = "/apis/admissionregistration.k8s.io/v1beta1/watch/mutatingadmissionpolicybindings/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end
  end
end
