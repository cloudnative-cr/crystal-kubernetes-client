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
    # GET /apis/events.k8s.io/v1/
    def get_events_v1_api_resources(**params, &)
      path = "/apis/events.k8s.io/v1/"
      get(path) { |res| yield res }
    end

    # list or watch objects of kind Event
    # GET /apis/events.k8s.io/v1/events
    def list_events_v1_event_for_all_namespaces(**params, &)
      path = "/apis/events.k8s.io/v1/events"
      get(path) { |res| yield res }
    end

    # delete collection of Event
    # DELETE /apis/events.k8s.io/v1/namespaces/{namespace}/events
    def delete_events_v1_collection_namespaced_event(**params, &)
      path = "/apis/events.k8s.io/v1/namespaces/{namespace}/events"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # list or watch objects of kind Event
    # GET /apis/events.k8s.io/v1/namespaces/{namespace}/events
    def list_events_v1_namespaced_event(**params, &)
      path = "/apis/events.k8s.io/v1/namespaces/{namespace}/events"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # create an Event
    # POST /apis/events.k8s.io/v1/namespaces/{namespace}/events
    def create_events_v1_namespaced_event(**params, &)
      path = "/apis/events.k8s.io/v1/namespaces/{namespace}/events"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      post(path, params) { |res| yield res }
    end

    # delete an Event
    # DELETE /apis/events.k8s.io/v1/namespaces/{namespace}/events/{name}
    def delete_events_v1_namespaced_event(**params, &)
      path = "/apis/events.k8s.io/v1/namespaces/{namespace}/events/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # read the specified Event
    # GET /apis/events.k8s.io/v1/namespaces/{namespace}/events/{name}
    def read_events_v1_namespaced_event(**params, &)
      path = "/apis/events.k8s.io/v1/namespaces/{namespace}/events/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update the specified Event
    # PATCH /apis/events.k8s.io/v1/namespaces/{namespace}/events/{name}
    def patch_events_v1_namespaced_event(**params, &)
      path = "/apis/events.k8s.io/v1/namespaces/{namespace}/events/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace the specified Event
    # PUT /apis/events.k8s.io/v1/namespaces/{namespace}/events/{name}
    def replace_events_v1_namespaced_event(**params, &)
      path = "/apis/events.k8s.io/v1/namespaces/{namespace}/events/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # watch individual changes to a list of Event. deprecated: use the 'watch' parameter with a list operation instead.
    # GET /apis/events.k8s.io/v1/watch/events
    def watch_events_v1_event_list_for_all_namespaces(**params, &)
      path = "/apis/events.k8s.io/v1/watch/events"
      get(path) { |res| yield res }
    end

    # watch individual changes to a list of Event. deprecated: use the 'watch' parameter with a list operation instead.
    # GET /apis/events.k8s.io/v1/watch/namespaces/{namespace}/events
    def watch_events_v1_namespaced_event_list(**params, &)
      path = "/apis/events.k8s.io/v1/watch/namespaces/{namespace}/events"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # watch changes to an object of kind Event. deprecated: use the 'watch' parameter with a list operation instead, filtered to a single item with the 'fieldSelector' parameter.
    # GET /apis/events.k8s.io/v1/watch/namespaces/{namespace}/events/{name}
    def watch_events_v1_namespaced_event(**params, &)
      path = "/apis/events.k8s.io/v1/watch/namespaces/{namespace}/events/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end
  end
end
