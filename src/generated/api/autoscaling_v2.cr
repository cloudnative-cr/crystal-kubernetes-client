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
    # GET /apis/autoscaling/v2/
    def get_autoscaling_v2_api_resources(**params, &)
      path = "/apis/autoscaling/v2/"
      get(path) { |res| yield res }
    end

    # list or watch objects of kind HorizontalPodAutoscaler
    # GET /apis/autoscaling/v2/horizontalpodautoscalers
    def list_autoscaling_v2_horizontal_pod_autoscaler_for_all_namespaces(**params, &)
      path = "/apis/autoscaling/v2/horizontalpodautoscalers"
      get(path) { |res| yield res }
    end

    # delete collection of HorizontalPodAutoscaler
    # DELETE /apis/autoscaling/v2/namespaces/{namespace}/horizontalpodautoscalers
    def delete_autoscaling_v2_collection_namespaced_horizontal_pod_autoscaler(**params, &)
      path = "/apis/autoscaling/v2/namespaces/{namespace}/horizontalpodautoscalers"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # list or watch objects of kind HorizontalPodAutoscaler
    # GET /apis/autoscaling/v2/namespaces/{namespace}/horizontalpodautoscalers
    def list_autoscaling_v2_namespaced_horizontal_pod_autoscaler(**params, &)
      path = "/apis/autoscaling/v2/namespaces/{namespace}/horizontalpodautoscalers"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # create a HorizontalPodAutoscaler
    # POST /apis/autoscaling/v2/namespaces/{namespace}/horizontalpodautoscalers
    def create_autoscaling_v2_namespaced_horizontal_pod_autoscaler(**params, &)
      path = "/apis/autoscaling/v2/namespaces/{namespace}/horizontalpodautoscalers"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      post(path, params) { |res| yield res }
    end

    # delete a HorizontalPodAutoscaler
    # DELETE /apis/autoscaling/v2/namespaces/{namespace}/horizontalpodautoscalers/{name}
    def delete_autoscaling_v2_namespaced_horizontal_pod_autoscaler(**params, &)
      path = "/apis/autoscaling/v2/namespaces/{namespace}/horizontalpodautoscalers/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # read the specified HorizontalPodAutoscaler
    # GET /apis/autoscaling/v2/namespaces/{namespace}/horizontalpodautoscalers/{name}
    def read_autoscaling_v2_namespaced_horizontal_pod_autoscaler(**params, &)
      path = "/apis/autoscaling/v2/namespaces/{namespace}/horizontalpodautoscalers/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update the specified HorizontalPodAutoscaler
    # PATCH /apis/autoscaling/v2/namespaces/{namespace}/horizontalpodautoscalers/{name}
    def patch_autoscaling_v2_namespaced_horizontal_pod_autoscaler(**params, &)
      path = "/apis/autoscaling/v2/namespaces/{namespace}/horizontalpodautoscalers/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace the specified HorizontalPodAutoscaler
    # PUT /apis/autoscaling/v2/namespaces/{namespace}/horizontalpodautoscalers/{name}
    def replace_autoscaling_v2_namespaced_horizontal_pod_autoscaler(**params, &)
      path = "/apis/autoscaling/v2/namespaces/{namespace}/horizontalpodautoscalers/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # read status of the specified HorizontalPodAutoscaler
    # GET /apis/autoscaling/v2/namespaces/{namespace}/horizontalpodautoscalers/{name}/status
    def read_autoscaling_v2_namespaced_horizontal_pod_autoscaler_status(**params, &)
      path = "/apis/autoscaling/v2/namespaces/{namespace}/horizontalpodautoscalers/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update status of the specified HorizontalPodAutoscaler
    # PATCH /apis/autoscaling/v2/namespaces/{namespace}/horizontalpodautoscalers/{name}/status
    def patch_autoscaling_v2_namespaced_horizontal_pod_autoscaler_status(**params, &)
      path = "/apis/autoscaling/v2/namespaces/{namespace}/horizontalpodautoscalers/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace status of the specified HorizontalPodAutoscaler
    # PUT /apis/autoscaling/v2/namespaces/{namespace}/horizontalpodautoscalers/{name}/status
    def replace_autoscaling_v2_namespaced_horizontal_pod_autoscaler_status(**params, &)
      path = "/apis/autoscaling/v2/namespaces/{namespace}/horizontalpodautoscalers/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # watch individual changes to a list of HorizontalPodAutoscaler. deprecated: use the 'watch' parameter with a list operation instead.
    # GET /apis/autoscaling/v2/watch/horizontalpodautoscalers
    def watch_autoscaling_v2_horizontal_pod_autoscaler_list_for_all_namespaces(**params, &)
      path = "/apis/autoscaling/v2/watch/horizontalpodautoscalers"
      get(path) { |res| yield res }
    end

    # watch individual changes to a list of HorizontalPodAutoscaler. deprecated: use the 'watch' parameter with a list operation instead.
    # GET /apis/autoscaling/v2/watch/namespaces/{namespace}/horizontalpodautoscalers
    def watch_autoscaling_v2_namespaced_horizontal_pod_autoscaler_list(**params, &)
      path = "/apis/autoscaling/v2/watch/namespaces/{namespace}/horizontalpodautoscalers"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # watch changes to an object of kind HorizontalPodAutoscaler. deprecated: use the 'watch' parameter with a list operation instead, filtered to a single item with the 'fieldSelector' parameter.
    # GET /apis/autoscaling/v2/watch/namespaces/{namespace}/horizontalpodautoscalers/{name}
    def watch_autoscaling_v2_namespaced_horizontal_pod_autoscaler(**params, &)
      path = "/apis/autoscaling/v2/watch/namespaces/{namespace}/horizontalpodautoscalers/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end
  end
end
