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
    # GET /apis/scheduling.k8s.io/v1/
    def get_api_resources(**params, &)
      path = "/apis/scheduling.k8s.io/v1/"
      get(path) { |res| yield res }
    end

    # delete collection of PriorityClass
    # DELETE /apis/scheduling.k8s.io/v1/priorityclasses
    def delete_collection_priority_class(**params, &)
      path = "/apis/scheduling.k8s.io/v1/priorityclasses"
      delete(path) { |res| yield res }
    end

    # list or watch objects of kind PriorityClass
    # GET /apis/scheduling.k8s.io/v1/priorityclasses
    def list_priority_class(**params, &)
      path = "/apis/scheduling.k8s.io/v1/priorityclasses"
      get(path) { |res| yield res }
    end

    # create a PriorityClass
    # POST /apis/scheduling.k8s.io/v1/priorityclasses
    def create_priority_class(**params, &)
      path = "/apis/scheduling.k8s.io/v1/priorityclasses"
      post(path, params) { |res| yield res }
    end

    # delete a PriorityClass
    # DELETE /apis/scheduling.k8s.io/v1/priorityclasses/{name}
    def delete_priority_class(**params, &)
      path = "/apis/scheduling.k8s.io/v1/priorityclasses/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # read the specified PriorityClass
    # GET /apis/scheduling.k8s.io/v1/priorityclasses/{name}
    def read_priority_class(**params, &)
      path = "/apis/scheduling.k8s.io/v1/priorityclasses/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update the specified PriorityClass
    # PATCH /apis/scheduling.k8s.io/v1/priorityclasses/{name}
    def patch_priority_class(**params, &)
      path = "/apis/scheduling.k8s.io/v1/priorityclasses/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace the specified PriorityClass
    # PUT /apis/scheduling.k8s.io/v1/priorityclasses/{name}
    def replace_priority_class(**params, &)
      path = "/apis/scheduling.k8s.io/v1/priorityclasses/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end
  end
end
