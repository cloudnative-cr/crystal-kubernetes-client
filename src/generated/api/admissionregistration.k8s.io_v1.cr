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
    # GET /apis/admissionregistration.k8s.io/v1/
    def get_admissionregistration_v1_api_resources(**params, &)
      path = "/apis/admissionregistration.k8s.io/v1/"
      get(path) { |res| yield res }
    end

    # delete collection of MutatingWebhookConfiguration
    # DELETE /apis/admissionregistration.k8s.io/v1/mutatingwebhookconfigurations
    def delete_admissionregistration_v1_collection_mutating_webhook_configuration(**params, &)
      path = "/apis/admissionregistration.k8s.io/v1/mutatingwebhookconfigurations"
      delete(path) { |res| yield res }
    end

    # list or watch objects of kind MutatingWebhookConfiguration
    # GET /apis/admissionregistration.k8s.io/v1/mutatingwebhookconfigurations
    def list_admissionregistration_v1_mutating_webhook_configuration(**params, &)
      path = "/apis/admissionregistration.k8s.io/v1/mutatingwebhookconfigurations"
      get(path) { |res| yield res }
    end

    # create a MutatingWebhookConfiguration
    # POST /apis/admissionregistration.k8s.io/v1/mutatingwebhookconfigurations
    def create_admissionregistration_v1_mutating_webhook_configuration(**params, &)
      path = "/apis/admissionregistration.k8s.io/v1/mutatingwebhookconfigurations"
      post(path, params) { |res| yield res }
    end

    # delete a MutatingWebhookConfiguration
    # DELETE /apis/admissionregistration.k8s.io/v1/mutatingwebhookconfigurations/{name}
    def delete_admissionregistration_v1_mutating_webhook_configuration(**params, &)
      path = "/apis/admissionregistration.k8s.io/v1/mutatingwebhookconfigurations/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # read the specified MutatingWebhookConfiguration
    # GET /apis/admissionregistration.k8s.io/v1/mutatingwebhookconfigurations/{name}
    def read_admissionregistration_v1_mutating_webhook_configuration(**params, &)
      path = "/apis/admissionregistration.k8s.io/v1/mutatingwebhookconfigurations/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update the specified MutatingWebhookConfiguration
    # PATCH /apis/admissionregistration.k8s.io/v1/mutatingwebhookconfigurations/{name}
    def patch_admissionregistration_v1_mutating_webhook_configuration(**params, &)
      path = "/apis/admissionregistration.k8s.io/v1/mutatingwebhookconfigurations/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace the specified MutatingWebhookConfiguration
    # PUT /apis/admissionregistration.k8s.io/v1/mutatingwebhookconfigurations/{name}
    def replace_admissionregistration_v1_mutating_webhook_configuration(**params, &)
      path = "/apis/admissionregistration.k8s.io/v1/mutatingwebhookconfigurations/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # delete collection of ValidatingAdmissionPolicy
    # DELETE /apis/admissionregistration.k8s.io/v1/validatingadmissionpolicies
    def delete_admissionregistration_v1_collection_validating_admission_policy(**params, &)
      path = "/apis/admissionregistration.k8s.io/v1/validatingadmissionpolicies"
      delete(path) { |res| yield res }
    end

    # list or watch objects of kind ValidatingAdmissionPolicy
    # GET /apis/admissionregistration.k8s.io/v1/validatingadmissionpolicies
    def list_admissionregistration_v1_validating_admission_policy(**params, &)
      path = "/apis/admissionregistration.k8s.io/v1/validatingadmissionpolicies"
      get(path) { |res| yield res }
    end

    # create a ValidatingAdmissionPolicy
    # POST /apis/admissionregistration.k8s.io/v1/validatingadmissionpolicies
    def create_admissionregistration_v1_validating_admission_policy(**params, &)
      path = "/apis/admissionregistration.k8s.io/v1/validatingadmissionpolicies"
      post(path, params) { |res| yield res }
    end

    # delete a ValidatingAdmissionPolicy
    # DELETE /apis/admissionregistration.k8s.io/v1/validatingadmissionpolicies/{name}
    def delete_admissionregistration_v1_validating_admission_policy(**params, &)
      path = "/apis/admissionregistration.k8s.io/v1/validatingadmissionpolicies/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # read the specified ValidatingAdmissionPolicy
    # GET /apis/admissionregistration.k8s.io/v1/validatingadmissionpolicies/{name}
    def read_admissionregistration_v1_validating_admission_policy(**params, &)
      path = "/apis/admissionregistration.k8s.io/v1/validatingadmissionpolicies/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update the specified ValidatingAdmissionPolicy
    # PATCH /apis/admissionregistration.k8s.io/v1/validatingadmissionpolicies/{name}
    def patch_admissionregistration_v1_validating_admission_policy(**params, &)
      path = "/apis/admissionregistration.k8s.io/v1/validatingadmissionpolicies/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace the specified ValidatingAdmissionPolicy
    # PUT /apis/admissionregistration.k8s.io/v1/validatingadmissionpolicies/{name}
    def replace_admissionregistration_v1_validating_admission_policy(**params, &)
      path = "/apis/admissionregistration.k8s.io/v1/validatingadmissionpolicies/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # read status of the specified ValidatingAdmissionPolicy
    # GET /apis/admissionregistration.k8s.io/v1/validatingadmissionpolicies/{name}/status
    def read_admissionregistration_v1_validating_admission_policy_status(**params, &)
      path = "/apis/admissionregistration.k8s.io/v1/validatingadmissionpolicies/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update status of the specified ValidatingAdmissionPolicy
    # PATCH /apis/admissionregistration.k8s.io/v1/validatingadmissionpolicies/{name}/status
    def patch_admissionregistration_v1_validating_admission_policy_status(**params, &)
      path = "/apis/admissionregistration.k8s.io/v1/validatingadmissionpolicies/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace status of the specified ValidatingAdmissionPolicy
    # PUT /apis/admissionregistration.k8s.io/v1/validatingadmissionpolicies/{name}/status
    def replace_admissionregistration_v1_validating_admission_policy_status(**params, &)
      path = "/apis/admissionregistration.k8s.io/v1/validatingadmissionpolicies/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # delete collection of ValidatingAdmissionPolicyBinding
    # DELETE /apis/admissionregistration.k8s.io/v1/validatingadmissionpolicybindings
    def delete_admissionregistration_v1_collection_validating_admission_policy_binding(**params, &)
      path = "/apis/admissionregistration.k8s.io/v1/validatingadmissionpolicybindings"
      delete(path) { |res| yield res }
    end

    # list or watch objects of kind ValidatingAdmissionPolicyBinding
    # GET /apis/admissionregistration.k8s.io/v1/validatingadmissionpolicybindings
    def list_admissionregistration_v1_validating_admission_policy_binding(**params, &)
      path = "/apis/admissionregistration.k8s.io/v1/validatingadmissionpolicybindings"
      get(path) { |res| yield res }
    end

    # create a ValidatingAdmissionPolicyBinding
    # POST /apis/admissionregistration.k8s.io/v1/validatingadmissionpolicybindings
    def create_admissionregistration_v1_validating_admission_policy_binding(**params, &)
      path = "/apis/admissionregistration.k8s.io/v1/validatingadmissionpolicybindings"
      post(path, params) { |res| yield res }
    end

    # delete a ValidatingAdmissionPolicyBinding
    # DELETE /apis/admissionregistration.k8s.io/v1/validatingadmissionpolicybindings/{name}
    def delete_admissionregistration_v1_validating_admission_policy_binding(**params, &)
      path = "/apis/admissionregistration.k8s.io/v1/validatingadmissionpolicybindings/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # read the specified ValidatingAdmissionPolicyBinding
    # GET /apis/admissionregistration.k8s.io/v1/validatingadmissionpolicybindings/{name}
    def read_admissionregistration_v1_validating_admission_policy_binding(**params, &)
      path = "/apis/admissionregistration.k8s.io/v1/validatingadmissionpolicybindings/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update the specified ValidatingAdmissionPolicyBinding
    # PATCH /apis/admissionregistration.k8s.io/v1/validatingadmissionpolicybindings/{name}
    def patch_admissionregistration_v1_validating_admission_policy_binding(**params, &)
      path = "/apis/admissionregistration.k8s.io/v1/validatingadmissionpolicybindings/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace the specified ValidatingAdmissionPolicyBinding
    # PUT /apis/admissionregistration.k8s.io/v1/validatingadmissionpolicybindings/{name}
    def replace_admissionregistration_v1_validating_admission_policy_binding(**params, &)
      path = "/apis/admissionregistration.k8s.io/v1/validatingadmissionpolicybindings/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # delete collection of ValidatingWebhookConfiguration
    # DELETE /apis/admissionregistration.k8s.io/v1/validatingwebhookconfigurations
    def delete_admissionregistration_v1_collection_validating_webhook_configuration(**params, &)
      path = "/apis/admissionregistration.k8s.io/v1/validatingwebhookconfigurations"
      delete(path) { |res| yield res }
    end

    # list or watch objects of kind ValidatingWebhookConfiguration
    # GET /apis/admissionregistration.k8s.io/v1/validatingwebhookconfigurations
    def list_admissionregistration_v1_validating_webhook_configuration(**params, &)
      path = "/apis/admissionregistration.k8s.io/v1/validatingwebhookconfigurations"
      get(path) { |res| yield res }
    end

    # create a ValidatingWebhookConfiguration
    # POST /apis/admissionregistration.k8s.io/v1/validatingwebhookconfigurations
    def create_admissionregistration_v1_validating_webhook_configuration(**params, &)
      path = "/apis/admissionregistration.k8s.io/v1/validatingwebhookconfigurations"
      post(path, params) { |res| yield res }
    end

    # delete a ValidatingWebhookConfiguration
    # DELETE /apis/admissionregistration.k8s.io/v1/validatingwebhookconfigurations/{name}
    def delete_admissionregistration_v1_validating_webhook_configuration(**params, &)
      path = "/apis/admissionregistration.k8s.io/v1/validatingwebhookconfigurations/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # read the specified ValidatingWebhookConfiguration
    # GET /apis/admissionregistration.k8s.io/v1/validatingwebhookconfigurations/{name}
    def read_admissionregistration_v1_validating_webhook_configuration(**params, &)
      path = "/apis/admissionregistration.k8s.io/v1/validatingwebhookconfigurations/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update the specified ValidatingWebhookConfiguration
    # PATCH /apis/admissionregistration.k8s.io/v1/validatingwebhookconfigurations/{name}
    def patch_admissionregistration_v1_validating_webhook_configuration(**params, &)
      path = "/apis/admissionregistration.k8s.io/v1/validatingwebhookconfigurations/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace the specified ValidatingWebhookConfiguration
    # PUT /apis/admissionregistration.k8s.io/v1/validatingwebhookconfigurations/{name}
    def replace_admissionregistration_v1_validating_webhook_configuration(**params, &)
      path = "/apis/admissionregistration.k8s.io/v1/validatingwebhookconfigurations/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # watch individual changes to a list of MutatingWebhookConfiguration. deprecated: use the 'watch' parameter with a list operation instead.
    # GET /apis/admissionregistration.k8s.io/v1/watch/mutatingwebhookconfigurations
    def watch_admissionregistration_v1_mutating_webhook_configuration_list(**params, &)
      path = "/apis/admissionregistration.k8s.io/v1/watch/mutatingwebhookconfigurations"
      get(path) { |res| yield res }
    end

    # watch changes to an object of kind MutatingWebhookConfiguration. deprecated: use the 'watch' parameter with a list operation instead, filtered to a single item with the 'fieldSelector' parameter.
    # GET /apis/admissionregistration.k8s.io/v1/watch/mutatingwebhookconfigurations/{name}
    def watch_admissionregistration_v1_mutating_webhook_configuration(**params, &)
      path = "/apis/admissionregistration.k8s.io/v1/watch/mutatingwebhookconfigurations/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # watch individual changes to a list of ValidatingAdmissionPolicy. deprecated: use the 'watch' parameter with a list operation instead.
    # GET /apis/admissionregistration.k8s.io/v1/watch/validatingadmissionpolicies
    def watch_admissionregistration_v1_validating_admission_policy_list(**params, &)
      path = "/apis/admissionregistration.k8s.io/v1/watch/validatingadmissionpolicies"
      get(path) { |res| yield res }
    end

    # watch changes to an object of kind ValidatingAdmissionPolicy. deprecated: use the 'watch' parameter with a list operation instead, filtered to a single item with the 'fieldSelector' parameter.
    # GET /apis/admissionregistration.k8s.io/v1/watch/validatingadmissionpolicies/{name}
    def watch_admissionregistration_v1_validating_admission_policy(**params, &)
      path = "/apis/admissionregistration.k8s.io/v1/watch/validatingadmissionpolicies/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # watch individual changes to a list of ValidatingAdmissionPolicyBinding. deprecated: use the 'watch' parameter with a list operation instead.
    # GET /apis/admissionregistration.k8s.io/v1/watch/validatingadmissionpolicybindings
    def watch_admissionregistration_v1_validating_admission_policy_binding_list(**params, &)
      path = "/apis/admissionregistration.k8s.io/v1/watch/validatingadmissionpolicybindings"
      get(path) { |res| yield res }
    end

    # watch changes to an object of kind ValidatingAdmissionPolicyBinding. deprecated: use the 'watch' parameter with a list operation instead, filtered to a single item with the 'fieldSelector' parameter.
    # GET /apis/admissionregistration.k8s.io/v1/watch/validatingadmissionpolicybindings/{name}
    def watch_admissionregistration_v1_validating_admission_policy_binding(**params, &)
      path = "/apis/admissionregistration.k8s.io/v1/watch/validatingadmissionpolicybindings/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # watch individual changes to a list of ValidatingWebhookConfiguration. deprecated: use the 'watch' parameter with a list operation instead.
    # GET /apis/admissionregistration.k8s.io/v1/watch/validatingwebhookconfigurations
    def watch_admissionregistration_v1_validating_webhook_configuration_list(**params, &)
      path = "/apis/admissionregistration.k8s.io/v1/watch/validatingwebhookconfigurations"
      get(path) { |res| yield res }
    end

    # watch changes to an object of kind ValidatingWebhookConfiguration. deprecated: use the 'watch' parameter with a list operation instead, filtered to a single item with the 'fieldSelector' parameter.
    # GET /apis/admissionregistration.k8s.io/v1/watch/validatingwebhookconfigurations/{name}
    def watch_admissionregistration_v1_validating_webhook_configuration(**params, &)
      path = "/apis/admissionregistration.k8s.io/v1/watch/validatingwebhookconfigurations/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end
  end
end
