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
    # GET /apis/node.k8s.io/v1/
    def get_node_v1_api_resources(**params, &)
      path = "/apis/node.k8s.io/v1/"
      get(path) { |res| yield res }
    end

    # delete collection of RuntimeClass
    # DELETE /apis/node.k8s.io/v1/runtimeclasses
    def delete_node_v1_collection_runtime_class(**params, &)
      path = "/apis/node.k8s.io/v1/runtimeclasses"
      delete(path) { |res| yield res }
    end

    # list or watch objects of kind RuntimeClass
    # GET /apis/node.k8s.io/v1/runtimeclasses
    def list_node_v1_runtime_class(**params, &)
      path = "/apis/node.k8s.io/v1/runtimeclasses"
      get(path) { |res| yield res }
    end

    # create a RuntimeClass
    # POST /apis/node.k8s.io/v1/runtimeclasses
    def create_node_v1_runtime_class(**params, &)
      path = "/apis/node.k8s.io/v1/runtimeclasses"
      post(path, params) { |res| yield res }
    end

    # delete a RuntimeClass
    # DELETE /apis/node.k8s.io/v1/runtimeclasses/{name}
    def delete_node_v1_runtime_class(**params, &)
      path = "/apis/node.k8s.io/v1/runtimeclasses/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # read the specified RuntimeClass
    # GET /apis/node.k8s.io/v1/runtimeclasses/{name}
    def read_node_v1_runtime_class(**params, &)
      path = "/apis/node.k8s.io/v1/runtimeclasses/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update the specified RuntimeClass
    # PATCH /apis/node.k8s.io/v1/runtimeclasses/{name}
    def patch_node_v1_runtime_class(**params, &)
      path = "/apis/node.k8s.io/v1/runtimeclasses/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace the specified RuntimeClass
    # PUT /apis/node.k8s.io/v1/runtimeclasses/{name}
    def replace_node_v1_runtime_class(**params, &)
      path = "/apis/node.k8s.io/v1/runtimeclasses/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # watch individual changes to a list of RuntimeClass. deprecated: use the 'watch' parameter with a list operation instead.
    # GET /apis/node.k8s.io/v1/watch/runtimeclasses
    def watch_node_v1_runtime_class_list(**params, &)
      path = "/apis/node.k8s.io/v1/watch/runtimeclasses"
      get(path) { |res| yield res }
    end

    # watch changes to an object of kind RuntimeClass. deprecated: use the 'watch' parameter with a list operation instead, filtered to a single item with the 'fieldSelector' parameter.
    # GET /apis/node.k8s.io/v1/watch/runtimeclasses/{name}
    def watch_node_v1_runtime_class(**params, &)
      path = "/apis/node.k8s.io/v1/watch/runtimeclasses/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end
  end
end
