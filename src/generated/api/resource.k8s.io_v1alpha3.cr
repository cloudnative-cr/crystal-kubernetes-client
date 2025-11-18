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
    # GET /apis/resource.k8s.io/v1alpha3/
    def get_resource_v1alpha3_api_resources(**params, &)
      path = "/apis/resource.k8s.io/v1alpha3/"
      get(path) { |res| yield res }
    end

    # delete collection of DeviceTaintRule
    # DELETE /apis/resource.k8s.io/v1alpha3/devicetaintrules
    def delete_resource_v1alpha3_collection_device_taint_rule(**params, &)
      path = "/apis/resource.k8s.io/v1alpha3/devicetaintrules"
      delete(path) { |res| yield res }
    end

    # list or watch objects of kind DeviceTaintRule
    # GET /apis/resource.k8s.io/v1alpha3/devicetaintrules
    def list_resource_v1alpha3_device_taint_rule(**params, &)
      path = "/apis/resource.k8s.io/v1alpha3/devicetaintrules"
      get(path) { |res| yield res }
    end

    # create a DeviceTaintRule
    # POST /apis/resource.k8s.io/v1alpha3/devicetaintrules
    def create_resource_v1alpha3_device_taint_rule(**params, &)
      path = "/apis/resource.k8s.io/v1alpha3/devicetaintrules"
      post(path, params) { |res| yield res }
    end

    # delete a DeviceTaintRule
    # DELETE /apis/resource.k8s.io/v1alpha3/devicetaintrules/{name}
    def delete_resource_v1alpha3_device_taint_rule(**params, &)
      path = "/apis/resource.k8s.io/v1alpha3/devicetaintrules/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # read the specified DeviceTaintRule
    # GET /apis/resource.k8s.io/v1alpha3/devicetaintrules/{name}
    def read_resource_v1alpha3_device_taint_rule(**params, &)
      path = "/apis/resource.k8s.io/v1alpha3/devicetaintrules/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update the specified DeviceTaintRule
    # PATCH /apis/resource.k8s.io/v1alpha3/devicetaintrules/{name}
    def patch_resource_v1alpha3_device_taint_rule(**params, &)
      path = "/apis/resource.k8s.io/v1alpha3/devicetaintrules/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace the specified DeviceTaintRule
    # PUT /apis/resource.k8s.io/v1alpha3/devicetaintrules/{name}
    def replace_resource_v1alpha3_device_taint_rule(**params, &)
      path = "/apis/resource.k8s.io/v1alpha3/devicetaintrules/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # read status of the specified DeviceTaintRule
    # GET /apis/resource.k8s.io/v1alpha3/devicetaintrules/{name}/status
    def read_resource_v1alpha3_device_taint_rule_status(**params, &)
      path = "/apis/resource.k8s.io/v1alpha3/devicetaintrules/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update status of the specified DeviceTaintRule
    # PATCH /apis/resource.k8s.io/v1alpha3/devicetaintrules/{name}/status
    def patch_resource_v1alpha3_device_taint_rule_status(**params, &)
      path = "/apis/resource.k8s.io/v1alpha3/devicetaintrules/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace status of the specified DeviceTaintRule
    # PUT /apis/resource.k8s.io/v1alpha3/devicetaintrules/{name}/status
    def replace_resource_v1alpha3_device_taint_rule_status(**params, &)
      path = "/apis/resource.k8s.io/v1alpha3/devicetaintrules/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # watch individual changes to a list of DeviceTaintRule. deprecated: use the 'watch' parameter with a list operation instead.
    # GET /apis/resource.k8s.io/v1alpha3/watch/devicetaintrules
    def watch_resource_v1alpha3_device_taint_rule_list(**params, &)
      path = "/apis/resource.k8s.io/v1alpha3/watch/devicetaintrules"
      get(path) { |res| yield res }
    end

    # watch changes to an object of kind DeviceTaintRule. deprecated: use the 'watch' parameter with a list operation instead, filtered to a single item with the 'fieldSelector' parameter.
    # GET /apis/resource.k8s.io/v1alpha3/watch/devicetaintrules/{name}
    def watch_resource_v1alpha3_device_taint_rule(**params, &)
      path = "/apis/resource.k8s.io/v1alpha3/watch/devicetaintrules/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end
  end
end
