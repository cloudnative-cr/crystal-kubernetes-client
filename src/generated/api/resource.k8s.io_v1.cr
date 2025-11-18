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
    # GET /apis/resource.k8s.io/v1/
    def get_resource_v1_api_resources(**params, &)
      path = "/apis/resource.k8s.io/v1/"
      get(path) { |res| yield res }
    end

    # delete collection of DeviceClass
    # DELETE /apis/resource.k8s.io/v1/deviceclasses
    def delete_resource_v1_collection_device_class(**params, &)
      path = "/apis/resource.k8s.io/v1/deviceclasses"
      delete(path) { |res| yield res }
    end

    # list or watch objects of kind DeviceClass
    # GET /apis/resource.k8s.io/v1/deviceclasses
    def list_resource_v1_device_class(**params, &)
      path = "/apis/resource.k8s.io/v1/deviceclasses"
      get(path) { |res| yield res }
    end

    # create a DeviceClass
    # POST /apis/resource.k8s.io/v1/deviceclasses
    def create_resource_v1_device_class(**params, &)
      path = "/apis/resource.k8s.io/v1/deviceclasses"
      post(path, params) { |res| yield res }
    end

    # delete a DeviceClass
    # DELETE /apis/resource.k8s.io/v1/deviceclasses/{name}
    def delete_resource_v1_device_class(**params, &)
      path = "/apis/resource.k8s.io/v1/deviceclasses/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # read the specified DeviceClass
    # GET /apis/resource.k8s.io/v1/deviceclasses/{name}
    def read_resource_v1_device_class(**params, &)
      path = "/apis/resource.k8s.io/v1/deviceclasses/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update the specified DeviceClass
    # PATCH /apis/resource.k8s.io/v1/deviceclasses/{name}
    def patch_resource_v1_device_class(**params, &)
      path = "/apis/resource.k8s.io/v1/deviceclasses/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace the specified DeviceClass
    # PUT /apis/resource.k8s.io/v1/deviceclasses/{name}
    def replace_resource_v1_device_class(**params, &)
      path = "/apis/resource.k8s.io/v1/deviceclasses/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # delete collection of ResourceClaim
    # DELETE /apis/resource.k8s.io/v1/namespaces/{namespace}/resourceclaims
    def delete_resource_v1_collection_namespaced_resource_claim(**params, &)
      path = "/apis/resource.k8s.io/v1/namespaces/{namespace}/resourceclaims"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # list or watch objects of kind ResourceClaim
    # GET /apis/resource.k8s.io/v1/namespaces/{namespace}/resourceclaims
    def list_resource_v1_namespaced_resource_claim(**params, &)
      path = "/apis/resource.k8s.io/v1/namespaces/{namespace}/resourceclaims"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # create a ResourceClaim
    # POST /apis/resource.k8s.io/v1/namespaces/{namespace}/resourceclaims
    def create_resource_v1_namespaced_resource_claim(**params, &)
      path = "/apis/resource.k8s.io/v1/namespaces/{namespace}/resourceclaims"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      post(path, params) { |res| yield res }
    end

    # delete a ResourceClaim
    # DELETE /apis/resource.k8s.io/v1/namespaces/{namespace}/resourceclaims/{name}
    def delete_resource_v1_namespaced_resource_claim(**params, &)
      path = "/apis/resource.k8s.io/v1/namespaces/{namespace}/resourceclaims/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # read the specified ResourceClaim
    # GET /apis/resource.k8s.io/v1/namespaces/{namespace}/resourceclaims/{name}
    def read_resource_v1_namespaced_resource_claim(**params, &)
      path = "/apis/resource.k8s.io/v1/namespaces/{namespace}/resourceclaims/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update the specified ResourceClaim
    # PATCH /apis/resource.k8s.io/v1/namespaces/{namespace}/resourceclaims/{name}
    def patch_resource_v1_namespaced_resource_claim(**params, &)
      path = "/apis/resource.k8s.io/v1/namespaces/{namespace}/resourceclaims/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace the specified ResourceClaim
    # PUT /apis/resource.k8s.io/v1/namespaces/{namespace}/resourceclaims/{name}
    def replace_resource_v1_namespaced_resource_claim(**params, &)
      path = "/apis/resource.k8s.io/v1/namespaces/{namespace}/resourceclaims/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # read status of the specified ResourceClaim
    # GET /apis/resource.k8s.io/v1/namespaces/{namespace}/resourceclaims/{name}/status
    def read_resource_v1_namespaced_resource_claim_status(**params, &)
      path = "/apis/resource.k8s.io/v1/namespaces/{namespace}/resourceclaims/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update status of the specified ResourceClaim
    # PATCH /apis/resource.k8s.io/v1/namespaces/{namespace}/resourceclaims/{name}/status
    def patch_resource_v1_namespaced_resource_claim_status(**params, &)
      path = "/apis/resource.k8s.io/v1/namespaces/{namespace}/resourceclaims/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace status of the specified ResourceClaim
    # PUT /apis/resource.k8s.io/v1/namespaces/{namespace}/resourceclaims/{name}/status
    def replace_resource_v1_namespaced_resource_claim_status(**params, &)
      path = "/apis/resource.k8s.io/v1/namespaces/{namespace}/resourceclaims/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # delete collection of ResourceClaimTemplate
    # DELETE /apis/resource.k8s.io/v1/namespaces/{namespace}/resourceclaimtemplates
    def delete_resource_v1_collection_namespaced_resource_claim_template(**params, &)
      path = "/apis/resource.k8s.io/v1/namespaces/{namespace}/resourceclaimtemplates"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # list or watch objects of kind ResourceClaimTemplate
    # GET /apis/resource.k8s.io/v1/namespaces/{namespace}/resourceclaimtemplates
    def list_resource_v1_namespaced_resource_claim_template(**params, &)
      path = "/apis/resource.k8s.io/v1/namespaces/{namespace}/resourceclaimtemplates"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # create a ResourceClaimTemplate
    # POST /apis/resource.k8s.io/v1/namespaces/{namespace}/resourceclaimtemplates
    def create_resource_v1_namespaced_resource_claim_template(**params, &)
      path = "/apis/resource.k8s.io/v1/namespaces/{namespace}/resourceclaimtemplates"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      post(path, params) { |res| yield res }
    end

    # delete a ResourceClaimTemplate
    # DELETE /apis/resource.k8s.io/v1/namespaces/{namespace}/resourceclaimtemplates/{name}
    def delete_resource_v1_namespaced_resource_claim_template(**params, &)
      path = "/apis/resource.k8s.io/v1/namespaces/{namespace}/resourceclaimtemplates/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # read the specified ResourceClaimTemplate
    # GET /apis/resource.k8s.io/v1/namespaces/{namespace}/resourceclaimtemplates/{name}
    def read_resource_v1_namespaced_resource_claim_template(**params, &)
      path = "/apis/resource.k8s.io/v1/namespaces/{namespace}/resourceclaimtemplates/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update the specified ResourceClaimTemplate
    # PATCH /apis/resource.k8s.io/v1/namespaces/{namespace}/resourceclaimtemplates/{name}
    def patch_resource_v1_namespaced_resource_claim_template(**params, &)
      path = "/apis/resource.k8s.io/v1/namespaces/{namespace}/resourceclaimtemplates/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace the specified ResourceClaimTemplate
    # PUT /apis/resource.k8s.io/v1/namespaces/{namespace}/resourceclaimtemplates/{name}
    def replace_resource_v1_namespaced_resource_claim_template(**params, &)
      path = "/apis/resource.k8s.io/v1/namespaces/{namespace}/resourceclaimtemplates/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # list or watch objects of kind ResourceClaim
    # GET /apis/resource.k8s.io/v1/resourceclaims
    def list_resource_v1_resource_claim_for_all_namespaces(**params, &)
      path = "/apis/resource.k8s.io/v1/resourceclaims"
      get(path) { |res| yield res }
    end

    # list or watch objects of kind ResourceClaimTemplate
    # GET /apis/resource.k8s.io/v1/resourceclaimtemplates
    def list_resource_v1_resource_claim_template_for_all_namespaces(**params, &)
      path = "/apis/resource.k8s.io/v1/resourceclaimtemplates"
      get(path) { |res| yield res }
    end

    # delete collection of ResourceSlice
    # DELETE /apis/resource.k8s.io/v1/resourceslices
    def delete_resource_v1_collection_resource_slice(**params, &)
      path = "/apis/resource.k8s.io/v1/resourceslices"
      delete(path) { |res| yield res }
    end

    # list or watch objects of kind ResourceSlice
    # GET /apis/resource.k8s.io/v1/resourceslices
    def list_resource_v1_resource_slice(**params, &)
      path = "/apis/resource.k8s.io/v1/resourceslices"
      get(path) { |res| yield res }
    end

    # create a ResourceSlice
    # POST /apis/resource.k8s.io/v1/resourceslices
    def create_resource_v1_resource_slice(**params, &)
      path = "/apis/resource.k8s.io/v1/resourceslices"
      post(path, params) { |res| yield res }
    end

    # delete a ResourceSlice
    # DELETE /apis/resource.k8s.io/v1/resourceslices/{name}
    def delete_resource_v1_resource_slice(**params, &)
      path = "/apis/resource.k8s.io/v1/resourceslices/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # read the specified ResourceSlice
    # GET /apis/resource.k8s.io/v1/resourceslices/{name}
    def read_resource_v1_resource_slice(**params, &)
      path = "/apis/resource.k8s.io/v1/resourceslices/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update the specified ResourceSlice
    # PATCH /apis/resource.k8s.io/v1/resourceslices/{name}
    def patch_resource_v1_resource_slice(**params, &)
      path = "/apis/resource.k8s.io/v1/resourceslices/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace the specified ResourceSlice
    # PUT /apis/resource.k8s.io/v1/resourceslices/{name}
    def replace_resource_v1_resource_slice(**params, &)
      path = "/apis/resource.k8s.io/v1/resourceslices/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # watch individual changes to a list of DeviceClass. deprecated: use the 'watch' parameter with a list operation instead.
    # GET /apis/resource.k8s.io/v1/watch/deviceclasses
    def watch_resource_v1_device_class_list(**params, &)
      path = "/apis/resource.k8s.io/v1/watch/deviceclasses"
      get(path) { |res| yield res }
    end

    # watch changes to an object of kind DeviceClass. deprecated: use the 'watch' parameter with a list operation instead, filtered to a single item with the 'fieldSelector' parameter.
    # GET /apis/resource.k8s.io/v1/watch/deviceclasses/{name}
    def watch_resource_v1_device_class(**params, &)
      path = "/apis/resource.k8s.io/v1/watch/deviceclasses/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # watch individual changes to a list of ResourceClaim. deprecated: use the 'watch' parameter with a list operation instead.
    # GET /apis/resource.k8s.io/v1/watch/namespaces/{namespace}/resourceclaims
    def watch_resource_v1_namespaced_resource_claim_list(**params, &)
      path = "/apis/resource.k8s.io/v1/watch/namespaces/{namespace}/resourceclaims"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # watch changes to an object of kind ResourceClaim. deprecated: use the 'watch' parameter with a list operation instead, filtered to a single item with the 'fieldSelector' parameter.
    # GET /apis/resource.k8s.io/v1/watch/namespaces/{namespace}/resourceclaims/{name}
    def watch_resource_v1_namespaced_resource_claim(**params, &)
      path = "/apis/resource.k8s.io/v1/watch/namespaces/{namespace}/resourceclaims/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # watch individual changes to a list of ResourceClaimTemplate. deprecated: use the 'watch' parameter with a list operation instead.
    # GET /apis/resource.k8s.io/v1/watch/namespaces/{namespace}/resourceclaimtemplates
    def watch_resource_v1_namespaced_resource_claim_template_list(**params, &)
      path = "/apis/resource.k8s.io/v1/watch/namespaces/{namespace}/resourceclaimtemplates"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # watch changes to an object of kind ResourceClaimTemplate. deprecated: use the 'watch' parameter with a list operation instead, filtered to a single item with the 'fieldSelector' parameter.
    # GET /apis/resource.k8s.io/v1/watch/namespaces/{namespace}/resourceclaimtemplates/{name}
    def watch_resource_v1_namespaced_resource_claim_template(**params, &)
      path = "/apis/resource.k8s.io/v1/watch/namespaces/{namespace}/resourceclaimtemplates/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # watch individual changes to a list of ResourceClaim. deprecated: use the 'watch' parameter with a list operation instead.
    # GET /apis/resource.k8s.io/v1/watch/resourceclaims
    def watch_resource_v1_resource_claim_list_for_all_namespaces(**params, &)
      path = "/apis/resource.k8s.io/v1/watch/resourceclaims"
      get(path) { |res| yield res }
    end

    # watch individual changes to a list of ResourceClaimTemplate. deprecated: use the 'watch' parameter with a list operation instead.
    # GET /apis/resource.k8s.io/v1/watch/resourceclaimtemplates
    def watch_resource_v1_resource_claim_template_list_for_all_namespaces(**params, &)
      path = "/apis/resource.k8s.io/v1/watch/resourceclaimtemplates"
      get(path) { |res| yield res }
    end

    # watch individual changes to a list of ResourceSlice. deprecated: use the 'watch' parameter with a list operation instead.
    # GET /apis/resource.k8s.io/v1/watch/resourceslices
    def watch_resource_v1_resource_slice_list(**params, &)
      path = "/apis/resource.k8s.io/v1/watch/resourceslices"
      get(path) { |res| yield res }
    end

    # watch changes to an object of kind ResourceSlice. deprecated: use the 'watch' parameter with a list operation instead, filtered to a single item with the 'fieldSelector' parameter.
    # GET /apis/resource.k8s.io/v1/watch/resourceslices/{name}
    def watch_resource_v1_resource_slice(**params, &)
      path = "/apis/resource.k8s.io/v1/watch/resourceslices/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end
  end
end
