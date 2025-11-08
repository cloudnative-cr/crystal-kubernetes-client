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
    # GET /apis/storage.k8s.io/v1alpha1/
    def get_api_resources(**params, &)
      path = "/apis/storage.k8s.io/v1alpha1/"
      get(path) { |res| yield res }
    end

    # delete collection of VolumeAttributesClass
    # DELETE /apis/storage.k8s.io/v1alpha1/volumeattributesclasses
    def delete_collection_volume_attributes_class(**params, &)
      path = "/apis/storage.k8s.io/v1alpha1/volumeattributesclasses"
      delete(path) { |res| yield res }
    end

    # list or watch objects of kind VolumeAttributesClass
    # GET /apis/storage.k8s.io/v1alpha1/volumeattributesclasses
    def list_volume_attributes_class(**params, &)
      path = "/apis/storage.k8s.io/v1alpha1/volumeattributesclasses"
      get(path) { |res| yield res }
    end

    # create a VolumeAttributesClass
    # POST /apis/storage.k8s.io/v1alpha1/volumeattributesclasses
    def create_volume_attributes_class(**params, &)
      path = "/apis/storage.k8s.io/v1alpha1/volumeattributesclasses"
      post(path, params) { |res| yield res }
    end

    # delete a VolumeAttributesClass
    # DELETE /apis/storage.k8s.io/v1alpha1/volumeattributesclasses/{name}
    def delete_volume_attributes_class(**params, &)
      path = "/apis/storage.k8s.io/v1alpha1/volumeattributesclasses/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # read the specified VolumeAttributesClass
    # GET /apis/storage.k8s.io/v1alpha1/volumeattributesclasses/{name}
    def read_volume_attributes_class(**params, &)
      path = "/apis/storage.k8s.io/v1alpha1/volumeattributesclasses/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update the specified VolumeAttributesClass
    # PATCH /apis/storage.k8s.io/v1alpha1/volumeattributesclasses/{name}
    def patch_volume_attributes_class(**params, &)
      path = "/apis/storage.k8s.io/v1alpha1/volumeattributesclasses/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace the specified VolumeAttributesClass
    # PUT /apis/storage.k8s.io/v1alpha1/volumeattributesclasses/{name}
    def replace_volume_attributes_class(**params, &)
      path = "/apis/storage.k8s.io/v1alpha1/volumeattributesclasses/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end
  end
end
