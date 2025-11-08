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
    # GET /api/v1/
    def get_api_resources(**params, &)
      path = "/api/v1/"
      get(path) { |res| yield res }
    end

    # list objects of kind ComponentStatus
    # GET /api/v1/componentstatuses
    def list_component_status(**params, &)
      path = "/api/v1/componentstatuses"
      get(path) { |res| yield res }
    end

    # read the specified ComponentStatus
    # GET /api/v1/componentstatuses/{name}
    def read_component_status(**params, &)
      path = "/api/v1/componentstatuses/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # list or watch objects of kind ConfigMap
    # GET /api/v1/configmaps
    def list_config_map_for_all_namespaces(**params, &)
      path = "/api/v1/configmaps"
      get(path) { |res| yield res }
    end

    # list or watch objects of kind Endpoints
    # GET /api/v1/endpoints
    def list_endpoints_for_all_namespaces(**params, &)
      path = "/api/v1/endpoints"
      get(path) { |res| yield res }
    end

    # list or watch objects of kind Event
    # GET /api/v1/events
    def list_event_for_all_namespaces(**params, &)
      path = "/api/v1/events"
      get(path) { |res| yield res }
    end

    # list or watch objects of kind LimitRange
    # GET /api/v1/limitranges
    def list_limit_range_for_all_namespaces(**params, &)
      path = "/api/v1/limitranges"
      get(path) { |res| yield res }
    end

    # list or watch objects of kind Namespace
    # GET /api/v1/namespaces
    def list_namespace(**params, &)
      path = "/api/v1/namespaces"
      get(path) { |res| yield res }
    end

    # create a Namespace
    # POST /api/v1/namespaces
    def create_namespace(**params, &)
      path = "/api/v1/namespaces"
      post(path, params) { |res| yield res }
    end

    # create a Binding
    # POST /api/v1/namespaces/{namespace}/bindings
    def create_namespaced_binding(**params, &)
      path = "/api/v1/namespaces/{namespace}/bindings"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      post(path, params) { |res| yield res }
    end

    # delete collection of ConfigMap
    # DELETE /api/v1/namespaces/{namespace}/configmaps
    def delete_collection_namespaced_config_map(**params, &)
      path = "/api/v1/namespaces/{namespace}/configmaps"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # list or watch objects of kind ConfigMap
    # GET /api/v1/namespaces/{namespace}/configmaps
    def list_namespaced_config_map(**params, &)
      path = "/api/v1/namespaces/{namespace}/configmaps"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # create a ConfigMap
    # POST /api/v1/namespaces/{namespace}/configmaps
    def create_namespaced_config_map(**params, &)
      path = "/api/v1/namespaces/{namespace}/configmaps"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      post(path, params) { |res| yield res }
    end

    # delete a ConfigMap
    # DELETE /api/v1/namespaces/{namespace}/configmaps/{name}
    def delete_namespaced_config_map(**params, &)
      path = "/api/v1/namespaces/{namespace}/configmaps/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # read the specified ConfigMap
    # GET /api/v1/namespaces/{namespace}/configmaps/{name}
    def read_namespaced_config_map(**params, &)
      path = "/api/v1/namespaces/{namespace}/configmaps/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update the specified ConfigMap
    # PATCH /api/v1/namespaces/{namespace}/configmaps/{name}
    def patch_namespaced_config_map(**params, &)
      path = "/api/v1/namespaces/{namespace}/configmaps/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace the specified ConfigMap
    # PUT /api/v1/namespaces/{namespace}/configmaps/{name}
    def replace_namespaced_config_map(**params, &)
      path = "/api/v1/namespaces/{namespace}/configmaps/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # delete collection of Endpoints
    # DELETE /api/v1/namespaces/{namespace}/endpoints
    def delete_collection_namespaced_endpoints(**params, &)
      path = "/api/v1/namespaces/{namespace}/endpoints"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # list or watch objects of kind Endpoints
    # GET /api/v1/namespaces/{namespace}/endpoints
    def list_namespaced_endpoints(**params, &)
      path = "/api/v1/namespaces/{namespace}/endpoints"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # create Endpoints
    # POST /api/v1/namespaces/{namespace}/endpoints
    def create_namespaced_endpoints(**params, &)
      path = "/api/v1/namespaces/{namespace}/endpoints"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      post(path, params) { |res| yield res }
    end

    # delete Endpoints
    # DELETE /api/v1/namespaces/{namespace}/endpoints/{name}
    def delete_namespaced_endpoints(**params, &)
      path = "/api/v1/namespaces/{namespace}/endpoints/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # read the specified Endpoints
    # GET /api/v1/namespaces/{namespace}/endpoints/{name}
    def read_namespaced_endpoints(**params, &)
      path = "/api/v1/namespaces/{namespace}/endpoints/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update the specified Endpoints
    # PATCH /api/v1/namespaces/{namespace}/endpoints/{name}
    def patch_namespaced_endpoints(**params, &)
      path = "/api/v1/namespaces/{namespace}/endpoints/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace the specified Endpoints
    # PUT /api/v1/namespaces/{namespace}/endpoints/{name}
    def replace_namespaced_endpoints(**params, &)
      path = "/api/v1/namespaces/{namespace}/endpoints/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # delete collection of Event
    # DELETE /api/v1/namespaces/{namespace}/events
    def delete_collection_namespaced_event(**params, &)
      path = "/api/v1/namespaces/{namespace}/events"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # list or watch objects of kind Event
    # GET /api/v1/namespaces/{namespace}/events
    def list_namespaced_event(**params, &)
      path = "/api/v1/namespaces/{namespace}/events"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # create an Event
    # POST /api/v1/namespaces/{namespace}/events
    def create_namespaced_event(**params, &)
      path = "/api/v1/namespaces/{namespace}/events"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      post(path, params) { |res| yield res }
    end

    # delete an Event
    # DELETE /api/v1/namespaces/{namespace}/events/{name}
    def delete_namespaced_event(**params, &)
      path = "/api/v1/namespaces/{namespace}/events/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # read the specified Event
    # GET /api/v1/namespaces/{namespace}/events/{name}
    def read_namespaced_event(**params, &)
      path = "/api/v1/namespaces/{namespace}/events/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update the specified Event
    # PATCH /api/v1/namespaces/{namespace}/events/{name}
    def patch_namespaced_event(**params, &)
      path = "/api/v1/namespaces/{namespace}/events/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace the specified Event
    # PUT /api/v1/namespaces/{namespace}/events/{name}
    def replace_namespaced_event(**params, &)
      path = "/api/v1/namespaces/{namespace}/events/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # delete collection of LimitRange
    # DELETE /api/v1/namespaces/{namespace}/limitranges
    def delete_collection_namespaced_limit_range(**params, &)
      path = "/api/v1/namespaces/{namespace}/limitranges"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # list or watch objects of kind LimitRange
    # GET /api/v1/namespaces/{namespace}/limitranges
    def list_namespaced_limit_range(**params, &)
      path = "/api/v1/namespaces/{namespace}/limitranges"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # create a LimitRange
    # POST /api/v1/namespaces/{namespace}/limitranges
    def create_namespaced_limit_range(**params, &)
      path = "/api/v1/namespaces/{namespace}/limitranges"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      post(path, params) { |res| yield res }
    end

    # delete a LimitRange
    # DELETE /api/v1/namespaces/{namespace}/limitranges/{name}
    def delete_namespaced_limit_range(**params, &)
      path = "/api/v1/namespaces/{namespace}/limitranges/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # read the specified LimitRange
    # GET /api/v1/namespaces/{namespace}/limitranges/{name}
    def read_namespaced_limit_range(**params, &)
      path = "/api/v1/namespaces/{namespace}/limitranges/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update the specified LimitRange
    # PATCH /api/v1/namespaces/{namespace}/limitranges/{name}
    def patch_namespaced_limit_range(**params, &)
      path = "/api/v1/namespaces/{namespace}/limitranges/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace the specified LimitRange
    # PUT /api/v1/namespaces/{namespace}/limitranges/{name}
    def replace_namespaced_limit_range(**params, &)
      path = "/api/v1/namespaces/{namespace}/limitranges/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # delete collection of PersistentVolumeClaim
    # DELETE /api/v1/namespaces/{namespace}/persistentvolumeclaims
    def delete_collection_namespaced_persistent_volume_claim(**params, &)
      path = "/api/v1/namespaces/{namespace}/persistentvolumeclaims"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # list or watch objects of kind PersistentVolumeClaim
    # GET /api/v1/namespaces/{namespace}/persistentvolumeclaims
    def list_namespaced_persistent_volume_claim(**params, &)
      path = "/api/v1/namespaces/{namespace}/persistentvolumeclaims"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # create a PersistentVolumeClaim
    # POST /api/v1/namespaces/{namespace}/persistentvolumeclaims
    def create_namespaced_persistent_volume_claim(**params, &)
      path = "/api/v1/namespaces/{namespace}/persistentvolumeclaims"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      post(path, params) { |res| yield res }
    end

    # delete a PersistentVolumeClaim
    # DELETE /api/v1/namespaces/{namespace}/persistentvolumeclaims/{name}
    def delete_namespaced_persistent_volume_claim(**params, &)
      path = "/api/v1/namespaces/{namespace}/persistentvolumeclaims/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # read the specified PersistentVolumeClaim
    # GET /api/v1/namespaces/{namespace}/persistentvolumeclaims/{name}
    def read_namespaced_persistent_volume_claim(**params, &)
      path = "/api/v1/namespaces/{namespace}/persistentvolumeclaims/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update the specified PersistentVolumeClaim
    # PATCH /api/v1/namespaces/{namespace}/persistentvolumeclaims/{name}
    def patch_namespaced_persistent_volume_claim(**params, &)
      path = "/api/v1/namespaces/{namespace}/persistentvolumeclaims/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace the specified PersistentVolumeClaim
    # PUT /api/v1/namespaces/{namespace}/persistentvolumeclaims/{name}
    def replace_namespaced_persistent_volume_claim(**params, &)
      path = "/api/v1/namespaces/{namespace}/persistentvolumeclaims/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # read status of the specified PersistentVolumeClaim
    # GET /api/v1/namespaces/{namespace}/persistentvolumeclaims/{name}/status
    def read_namespaced_persistent_volume_claim_status(**params, &)
      path = "/api/v1/namespaces/{namespace}/persistentvolumeclaims/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update status of the specified PersistentVolumeClaim
    # PATCH /api/v1/namespaces/{namespace}/persistentvolumeclaims/{name}/status
    def patch_namespaced_persistent_volume_claim_status(**params, &)
      path = "/api/v1/namespaces/{namespace}/persistentvolumeclaims/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace status of the specified PersistentVolumeClaim
    # PUT /api/v1/namespaces/{namespace}/persistentvolumeclaims/{name}/status
    def replace_namespaced_persistent_volume_claim_status(**params, &)
      path = "/api/v1/namespaces/{namespace}/persistentvolumeclaims/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # delete collection of Pod
    # DELETE /api/v1/namespaces/{namespace}/pods
    def delete_collection_namespaced_pod(**params, &)
      path = "/api/v1/namespaces/{namespace}/pods"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # list or watch objects of kind Pod
    # GET /api/v1/namespaces/{namespace}/pods
    def list_namespaced_pod(**params, &)
      path = "/api/v1/namespaces/{namespace}/pods"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # create a Pod
    # POST /api/v1/namespaces/{namespace}/pods
    def create_namespaced_pod(**params, &)
      path = "/api/v1/namespaces/{namespace}/pods"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      post(path, params) { |res| yield res }
    end

    # delete a Pod
    # DELETE /api/v1/namespaces/{namespace}/pods/{name}
    def delete_namespaced_pod(**params, &)
      path = "/api/v1/namespaces/{namespace}/pods/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # read the specified Pod
    # GET /api/v1/namespaces/{namespace}/pods/{name}
    def read_namespaced_pod(**params, &)
      path = "/api/v1/namespaces/{namespace}/pods/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update the specified Pod
    # PATCH /api/v1/namespaces/{namespace}/pods/{name}
    def patch_namespaced_pod(**params, &)
      path = "/api/v1/namespaces/{namespace}/pods/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace the specified Pod
    # PUT /api/v1/namespaces/{namespace}/pods/{name}
    def replace_namespaced_pod(**params, &)
      path = "/api/v1/namespaces/{namespace}/pods/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # connect GET requests to attach of Pod
    # GET /api/v1/namespaces/{namespace}/pods/{name}/attach
    def connect_get_namespaced_pod_attach(**params, &)
      path = "/api/v1/namespaces/{namespace}/pods/{name}/attach"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # connect POST requests to attach of Pod
    # POST /api/v1/namespaces/{namespace}/pods/{name}/attach
    def connect_post_namespaced_pod_attach(**params, &)
      path = "/api/v1/namespaces/{namespace}/pods/{name}/attach"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      post(path, params) { |res| yield res }
    end

    # create binding of a Pod
    # POST /api/v1/namespaces/{namespace}/pods/{name}/binding
    def create_namespaced_pod_binding(**params, &)
      path = "/api/v1/namespaces/{namespace}/pods/{name}/binding"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      post(path, params) { |res| yield res }
    end

    # read ephemeralcontainers of the specified Pod
    # GET /api/v1/namespaces/{namespace}/pods/{name}/ephemeralcontainers
    def read_namespaced_pod_ephemeralcontainers(**params, &)
      path = "/api/v1/namespaces/{namespace}/pods/{name}/ephemeralcontainers"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update ephemeralcontainers of the specified Pod
    # PATCH /api/v1/namespaces/{namespace}/pods/{name}/ephemeralcontainers
    def patch_namespaced_pod_ephemeralcontainers(**params, &)
      path = "/api/v1/namespaces/{namespace}/pods/{name}/ephemeralcontainers"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace ephemeralcontainers of the specified Pod
    # PUT /api/v1/namespaces/{namespace}/pods/{name}/ephemeralcontainers
    def replace_namespaced_pod_ephemeralcontainers(**params, &)
      path = "/api/v1/namespaces/{namespace}/pods/{name}/ephemeralcontainers"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # create eviction of a Pod
    # POST /api/v1/namespaces/{namespace}/pods/{name}/eviction
    def create_namespaced_pod_eviction(**params, &)
      path = "/api/v1/namespaces/{namespace}/pods/{name}/eviction"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      post(path, params) { |res| yield res }
    end

    # connect GET requests to exec of Pod
    # GET /api/v1/namespaces/{namespace}/pods/{name}/exec
    def connect_get_namespaced_pod_exec(**params, &)
      path = "/api/v1/namespaces/{namespace}/pods/{name}/exec"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # connect POST requests to exec of Pod
    # POST /api/v1/namespaces/{namespace}/pods/{name}/exec
    def connect_post_namespaced_pod_exec(**params, &)
      path = "/api/v1/namespaces/{namespace}/pods/{name}/exec"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      post(path, params) { |res| yield res }
    end

    # read log of the specified Pod
    # GET /api/v1/namespaces/{namespace}/pods/{name}/log
    def read_namespaced_pod_log(**params, &)
      path = "/api/v1/namespaces/{namespace}/pods/{name}/log"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # connect GET requests to portforward of Pod
    # GET /api/v1/namespaces/{namespace}/pods/{name}/portforward
    def connect_get_namespaced_pod_portforward(**params, &)
      path = "/api/v1/namespaces/{namespace}/pods/{name}/portforward"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # connect POST requests to portforward of Pod
    # POST /api/v1/namespaces/{namespace}/pods/{name}/portforward
    def connect_post_namespaced_pod_portforward(**params, &)
      path = "/api/v1/namespaces/{namespace}/pods/{name}/portforward"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      post(path, params) { |res| yield res }
    end

    # connect DELETE requests to proxy of Pod
    # DELETE /api/v1/namespaces/{namespace}/pods/{name}/proxy
    def connect_delete_namespaced_pod_proxy(**params, &)
      path = "/api/v1/namespaces/{namespace}/pods/{name}/proxy"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # connect GET requests to proxy of Pod
    # GET /api/v1/namespaces/{namespace}/pods/{name}/proxy
    def connect_get_namespaced_pod_proxy(**params, &)
      path = "/api/v1/namespaces/{namespace}/pods/{name}/proxy"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # connect PATCH requests to proxy of Pod
    # PATCH /api/v1/namespaces/{namespace}/pods/{name}/proxy
    def connect_patch_namespaced_pod_proxy(**params, &)
      path = "/api/v1/namespaces/{namespace}/pods/{name}/proxy"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # connect POST requests to proxy of Pod
    # POST /api/v1/namespaces/{namespace}/pods/{name}/proxy
    def connect_post_namespaced_pod_proxy(**params, &)
      path = "/api/v1/namespaces/{namespace}/pods/{name}/proxy"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      post(path, params) { |res| yield res }
    end

    # connect PUT requests to proxy of Pod
    # PUT /api/v1/namespaces/{namespace}/pods/{name}/proxy
    def connect_put_namespaced_pod_proxy(**params, &)
      path = "/api/v1/namespaces/{namespace}/pods/{name}/proxy"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # connect DELETE requests to proxy of Pod
    # DELETE /api/v1/namespaces/{namespace}/pods/{name}/proxy/{path}
    def connect_delete_namespaced_pod_proxy_with_path(**params, &)
      path = "/api/v1/namespaces/{namespace}/pods/{name}/proxy/{path}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # connect GET requests to proxy of Pod
    # GET /api/v1/namespaces/{namespace}/pods/{name}/proxy/{path}
    def connect_get_namespaced_pod_proxy_with_path(**params, &)
      path = "/api/v1/namespaces/{namespace}/pods/{name}/proxy/{path}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # connect PATCH requests to proxy of Pod
    # PATCH /api/v1/namespaces/{namespace}/pods/{name}/proxy/{path}
    def connect_patch_namespaced_pod_proxy_with_path(**params, &)
      path = "/api/v1/namespaces/{namespace}/pods/{name}/proxy/{path}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # connect POST requests to proxy of Pod
    # POST /api/v1/namespaces/{namespace}/pods/{name}/proxy/{path}
    def connect_post_namespaced_pod_proxy_with_path(**params, &)
      path = "/api/v1/namespaces/{namespace}/pods/{name}/proxy/{path}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      post(path, params) { |res| yield res }
    end

    # connect PUT requests to proxy of Pod
    # PUT /api/v1/namespaces/{namespace}/pods/{name}/proxy/{path}
    def connect_put_namespaced_pod_proxy_with_path(**params, &)
      path = "/api/v1/namespaces/{namespace}/pods/{name}/proxy/{path}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # read resize of the specified Pod
    # GET /api/v1/namespaces/{namespace}/pods/{name}/resize
    def read_namespaced_pod_resize(**params, &)
      path = "/api/v1/namespaces/{namespace}/pods/{name}/resize"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update resize of the specified Pod
    # PATCH /api/v1/namespaces/{namespace}/pods/{name}/resize
    def patch_namespaced_pod_resize(**params, &)
      path = "/api/v1/namespaces/{namespace}/pods/{name}/resize"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace resize of the specified Pod
    # PUT /api/v1/namespaces/{namespace}/pods/{name}/resize
    def replace_namespaced_pod_resize(**params, &)
      path = "/api/v1/namespaces/{namespace}/pods/{name}/resize"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # read status of the specified Pod
    # GET /api/v1/namespaces/{namespace}/pods/{name}/status
    def read_namespaced_pod_status(**params, &)
      path = "/api/v1/namespaces/{namespace}/pods/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update status of the specified Pod
    # PATCH /api/v1/namespaces/{namespace}/pods/{name}/status
    def patch_namespaced_pod_status(**params, &)
      path = "/api/v1/namespaces/{namespace}/pods/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace status of the specified Pod
    # PUT /api/v1/namespaces/{namespace}/pods/{name}/status
    def replace_namespaced_pod_status(**params, &)
      path = "/api/v1/namespaces/{namespace}/pods/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # delete collection of PodTemplate
    # DELETE /api/v1/namespaces/{namespace}/podtemplates
    def delete_collection_namespaced_pod_template(**params, &)
      path = "/api/v1/namespaces/{namespace}/podtemplates"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # list or watch objects of kind PodTemplate
    # GET /api/v1/namespaces/{namespace}/podtemplates
    def list_namespaced_pod_template(**params, &)
      path = "/api/v1/namespaces/{namespace}/podtemplates"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # create a PodTemplate
    # POST /api/v1/namespaces/{namespace}/podtemplates
    def create_namespaced_pod_template(**params, &)
      path = "/api/v1/namespaces/{namespace}/podtemplates"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      post(path, params) { |res| yield res }
    end

    # delete a PodTemplate
    # DELETE /api/v1/namespaces/{namespace}/podtemplates/{name}
    def delete_namespaced_pod_template(**params, &)
      path = "/api/v1/namespaces/{namespace}/podtemplates/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # read the specified PodTemplate
    # GET /api/v1/namespaces/{namespace}/podtemplates/{name}
    def read_namespaced_pod_template(**params, &)
      path = "/api/v1/namespaces/{namespace}/podtemplates/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update the specified PodTemplate
    # PATCH /api/v1/namespaces/{namespace}/podtemplates/{name}
    def patch_namespaced_pod_template(**params, &)
      path = "/api/v1/namespaces/{namespace}/podtemplates/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace the specified PodTemplate
    # PUT /api/v1/namespaces/{namespace}/podtemplates/{name}
    def replace_namespaced_pod_template(**params, &)
      path = "/api/v1/namespaces/{namespace}/podtemplates/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # delete collection of ReplicationController
    # DELETE /api/v1/namespaces/{namespace}/replicationcontrollers
    def delete_collection_namespaced_replication_controller(**params, &)
      path = "/api/v1/namespaces/{namespace}/replicationcontrollers"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # list or watch objects of kind ReplicationController
    # GET /api/v1/namespaces/{namespace}/replicationcontrollers
    def list_namespaced_replication_controller(**params, &)
      path = "/api/v1/namespaces/{namespace}/replicationcontrollers"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # create a ReplicationController
    # POST /api/v1/namespaces/{namespace}/replicationcontrollers
    def create_namespaced_replication_controller(**params, &)
      path = "/api/v1/namespaces/{namespace}/replicationcontrollers"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      post(path, params) { |res| yield res }
    end

    # delete a ReplicationController
    # DELETE /api/v1/namespaces/{namespace}/replicationcontrollers/{name}
    def delete_namespaced_replication_controller(**params, &)
      path = "/api/v1/namespaces/{namespace}/replicationcontrollers/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # read the specified ReplicationController
    # GET /api/v1/namespaces/{namespace}/replicationcontrollers/{name}
    def read_namespaced_replication_controller(**params, &)
      path = "/api/v1/namespaces/{namespace}/replicationcontrollers/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update the specified ReplicationController
    # PATCH /api/v1/namespaces/{namespace}/replicationcontrollers/{name}
    def patch_namespaced_replication_controller(**params, &)
      path = "/api/v1/namespaces/{namespace}/replicationcontrollers/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace the specified ReplicationController
    # PUT /api/v1/namespaces/{namespace}/replicationcontrollers/{name}
    def replace_namespaced_replication_controller(**params, &)
      path = "/api/v1/namespaces/{namespace}/replicationcontrollers/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # read scale of the specified ReplicationController
    # GET /api/v1/namespaces/{namespace}/replicationcontrollers/{name}/scale
    def read_namespaced_replication_controller_scale(**params, &)
      path = "/api/v1/namespaces/{namespace}/replicationcontrollers/{name}/scale"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update scale of the specified ReplicationController
    # PATCH /api/v1/namespaces/{namespace}/replicationcontrollers/{name}/scale
    def patch_namespaced_replication_controller_scale(**params, &)
      path = "/api/v1/namespaces/{namespace}/replicationcontrollers/{name}/scale"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace scale of the specified ReplicationController
    # PUT /api/v1/namespaces/{namespace}/replicationcontrollers/{name}/scale
    def replace_namespaced_replication_controller_scale(**params, &)
      path = "/api/v1/namespaces/{namespace}/replicationcontrollers/{name}/scale"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # read status of the specified ReplicationController
    # GET /api/v1/namespaces/{namespace}/replicationcontrollers/{name}/status
    def read_namespaced_replication_controller_status(**params, &)
      path = "/api/v1/namespaces/{namespace}/replicationcontrollers/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update status of the specified ReplicationController
    # PATCH /api/v1/namespaces/{namespace}/replicationcontrollers/{name}/status
    def patch_namespaced_replication_controller_status(**params, &)
      path = "/api/v1/namespaces/{namespace}/replicationcontrollers/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace status of the specified ReplicationController
    # PUT /api/v1/namespaces/{namespace}/replicationcontrollers/{name}/status
    def replace_namespaced_replication_controller_status(**params, &)
      path = "/api/v1/namespaces/{namespace}/replicationcontrollers/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # delete collection of ResourceQuota
    # DELETE /api/v1/namespaces/{namespace}/resourcequotas
    def delete_collection_namespaced_resource_quota(**params, &)
      path = "/api/v1/namespaces/{namespace}/resourcequotas"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # list or watch objects of kind ResourceQuota
    # GET /api/v1/namespaces/{namespace}/resourcequotas
    def list_namespaced_resource_quota(**params, &)
      path = "/api/v1/namespaces/{namespace}/resourcequotas"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # create a ResourceQuota
    # POST /api/v1/namespaces/{namespace}/resourcequotas
    def create_namespaced_resource_quota(**params, &)
      path = "/api/v1/namespaces/{namespace}/resourcequotas"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      post(path, params) { |res| yield res }
    end

    # delete a ResourceQuota
    # DELETE /api/v1/namespaces/{namespace}/resourcequotas/{name}
    def delete_namespaced_resource_quota(**params, &)
      path = "/api/v1/namespaces/{namespace}/resourcequotas/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # read the specified ResourceQuota
    # GET /api/v1/namespaces/{namespace}/resourcequotas/{name}
    def read_namespaced_resource_quota(**params, &)
      path = "/api/v1/namespaces/{namespace}/resourcequotas/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update the specified ResourceQuota
    # PATCH /api/v1/namespaces/{namespace}/resourcequotas/{name}
    def patch_namespaced_resource_quota(**params, &)
      path = "/api/v1/namespaces/{namespace}/resourcequotas/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace the specified ResourceQuota
    # PUT /api/v1/namespaces/{namespace}/resourcequotas/{name}
    def replace_namespaced_resource_quota(**params, &)
      path = "/api/v1/namespaces/{namespace}/resourcequotas/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # read status of the specified ResourceQuota
    # GET /api/v1/namespaces/{namespace}/resourcequotas/{name}/status
    def read_namespaced_resource_quota_status(**params, &)
      path = "/api/v1/namespaces/{namespace}/resourcequotas/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update status of the specified ResourceQuota
    # PATCH /api/v1/namespaces/{namespace}/resourcequotas/{name}/status
    def patch_namespaced_resource_quota_status(**params, &)
      path = "/api/v1/namespaces/{namespace}/resourcequotas/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace status of the specified ResourceQuota
    # PUT /api/v1/namespaces/{namespace}/resourcequotas/{name}/status
    def replace_namespaced_resource_quota_status(**params, &)
      path = "/api/v1/namespaces/{namespace}/resourcequotas/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # delete collection of Secret
    # DELETE /api/v1/namespaces/{namespace}/secrets
    def delete_collection_namespaced_secret(**params, &)
      path = "/api/v1/namespaces/{namespace}/secrets"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # list or watch objects of kind Secret
    # GET /api/v1/namespaces/{namespace}/secrets
    def list_namespaced_secret(**params, &)
      path = "/api/v1/namespaces/{namespace}/secrets"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # create a Secret
    # POST /api/v1/namespaces/{namespace}/secrets
    def create_namespaced_secret(**params, &)
      path = "/api/v1/namespaces/{namespace}/secrets"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      post(path, params) { |res| yield res }
    end

    # delete a Secret
    # DELETE /api/v1/namespaces/{namespace}/secrets/{name}
    def delete_namespaced_secret(**params, &)
      path = "/api/v1/namespaces/{namespace}/secrets/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # read the specified Secret
    # GET /api/v1/namespaces/{namespace}/secrets/{name}
    def read_namespaced_secret(**params, &)
      path = "/api/v1/namespaces/{namespace}/secrets/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update the specified Secret
    # PATCH /api/v1/namespaces/{namespace}/secrets/{name}
    def patch_namespaced_secret(**params, &)
      path = "/api/v1/namespaces/{namespace}/secrets/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace the specified Secret
    # PUT /api/v1/namespaces/{namespace}/secrets/{name}
    def replace_namespaced_secret(**params, &)
      path = "/api/v1/namespaces/{namespace}/secrets/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # delete collection of ServiceAccount
    # DELETE /api/v1/namespaces/{namespace}/serviceaccounts
    def delete_collection_namespaced_service_account(**params, &)
      path = "/api/v1/namespaces/{namespace}/serviceaccounts"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # list or watch objects of kind ServiceAccount
    # GET /api/v1/namespaces/{namespace}/serviceaccounts
    def list_namespaced_service_account(**params, &)
      path = "/api/v1/namespaces/{namespace}/serviceaccounts"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # create a ServiceAccount
    # POST /api/v1/namespaces/{namespace}/serviceaccounts
    def create_namespaced_service_account(**params, &)
      path = "/api/v1/namespaces/{namespace}/serviceaccounts"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      post(path, params) { |res| yield res }
    end

    # delete a ServiceAccount
    # DELETE /api/v1/namespaces/{namespace}/serviceaccounts/{name}
    def delete_namespaced_service_account(**params, &)
      path = "/api/v1/namespaces/{namespace}/serviceaccounts/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # read the specified ServiceAccount
    # GET /api/v1/namespaces/{namespace}/serviceaccounts/{name}
    def read_namespaced_service_account(**params, &)
      path = "/api/v1/namespaces/{namespace}/serviceaccounts/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update the specified ServiceAccount
    # PATCH /api/v1/namespaces/{namespace}/serviceaccounts/{name}
    def patch_namespaced_service_account(**params, &)
      path = "/api/v1/namespaces/{namespace}/serviceaccounts/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace the specified ServiceAccount
    # PUT /api/v1/namespaces/{namespace}/serviceaccounts/{name}
    def replace_namespaced_service_account(**params, &)
      path = "/api/v1/namespaces/{namespace}/serviceaccounts/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # create token of a ServiceAccount
    # POST /api/v1/namespaces/{namespace}/serviceaccounts/{name}/token
    def create_namespaced_service_account_token(**params, &)
      path = "/api/v1/namespaces/{namespace}/serviceaccounts/{name}/token"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      post(path, params) { |res| yield res }
    end

    # delete collection of Service
    # DELETE /api/v1/namespaces/{namespace}/services
    def delete_collection_namespaced_service(**params, &)
      path = "/api/v1/namespaces/{namespace}/services"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # list or watch objects of kind Service
    # GET /api/v1/namespaces/{namespace}/services
    def list_namespaced_service(**params, &)
      path = "/api/v1/namespaces/{namespace}/services"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # create a Service
    # POST /api/v1/namespaces/{namespace}/services
    def create_namespaced_service(**params, &)
      path = "/api/v1/namespaces/{namespace}/services"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      post(path, params) { |res| yield res }
    end

    # delete a Service
    # DELETE /api/v1/namespaces/{namespace}/services/{name}
    def delete_namespaced_service(**params, &)
      path = "/api/v1/namespaces/{namespace}/services/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # read the specified Service
    # GET /api/v1/namespaces/{namespace}/services/{name}
    def read_namespaced_service(**params, &)
      path = "/api/v1/namespaces/{namespace}/services/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update the specified Service
    # PATCH /api/v1/namespaces/{namespace}/services/{name}
    def patch_namespaced_service(**params, &)
      path = "/api/v1/namespaces/{namespace}/services/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace the specified Service
    # PUT /api/v1/namespaces/{namespace}/services/{name}
    def replace_namespaced_service(**params, &)
      path = "/api/v1/namespaces/{namespace}/services/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # connect DELETE requests to proxy of Service
    # DELETE /api/v1/namespaces/{namespace}/services/{name}/proxy
    def connect_delete_namespaced_service_proxy(**params, &)
      path = "/api/v1/namespaces/{namespace}/services/{name}/proxy"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # connect GET requests to proxy of Service
    # GET /api/v1/namespaces/{namespace}/services/{name}/proxy
    def connect_get_namespaced_service_proxy(**params, &)
      path = "/api/v1/namespaces/{namespace}/services/{name}/proxy"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # connect PATCH requests to proxy of Service
    # PATCH /api/v1/namespaces/{namespace}/services/{name}/proxy
    def connect_patch_namespaced_service_proxy(**params, &)
      path = "/api/v1/namespaces/{namespace}/services/{name}/proxy"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # connect POST requests to proxy of Service
    # POST /api/v1/namespaces/{namespace}/services/{name}/proxy
    def connect_post_namespaced_service_proxy(**params, &)
      path = "/api/v1/namespaces/{namespace}/services/{name}/proxy"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      post(path, params) { |res| yield res }
    end

    # connect PUT requests to proxy of Service
    # PUT /api/v1/namespaces/{namespace}/services/{name}/proxy
    def connect_put_namespaced_service_proxy(**params, &)
      path = "/api/v1/namespaces/{namespace}/services/{name}/proxy"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # connect DELETE requests to proxy of Service
    # DELETE /api/v1/namespaces/{namespace}/services/{name}/proxy/{path}
    def connect_delete_namespaced_service_proxy_with_path(**params, &)
      path = "/api/v1/namespaces/{namespace}/services/{name}/proxy/{path}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # connect GET requests to proxy of Service
    # GET /api/v1/namespaces/{namespace}/services/{name}/proxy/{path}
    def connect_get_namespaced_service_proxy_with_path(**params, &)
      path = "/api/v1/namespaces/{namespace}/services/{name}/proxy/{path}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # connect PATCH requests to proxy of Service
    # PATCH /api/v1/namespaces/{namespace}/services/{name}/proxy/{path}
    def connect_patch_namespaced_service_proxy_with_path(**params, &)
      path = "/api/v1/namespaces/{namespace}/services/{name}/proxy/{path}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # connect POST requests to proxy of Service
    # POST /api/v1/namespaces/{namespace}/services/{name}/proxy/{path}
    def connect_post_namespaced_service_proxy_with_path(**params, &)
      path = "/api/v1/namespaces/{namespace}/services/{name}/proxy/{path}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      post(path, params) { |res| yield res }
    end

    # connect PUT requests to proxy of Service
    # PUT /api/v1/namespaces/{namespace}/services/{name}/proxy/{path}
    def connect_put_namespaced_service_proxy_with_path(**params, &)
      path = "/api/v1/namespaces/{namespace}/services/{name}/proxy/{path}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # read status of the specified Service
    # GET /api/v1/namespaces/{namespace}/services/{name}/status
    def read_namespaced_service_status(**params, &)
      path = "/api/v1/namespaces/{namespace}/services/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update status of the specified Service
    # PATCH /api/v1/namespaces/{namespace}/services/{name}/status
    def patch_namespaced_service_status(**params, &)
      path = "/api/v1/namespaces/{namespace}/services/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace status of the specified Service
    # PUT /api/v1/namespaces/{namespace}/services/{name}/status
    def replace_namespaced_service_status(**params, &)
      path = "/api/v1/namespaces/{namespace}/services/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # delete a Namespace
    # DELETE /api/v1/namespaces/{name}
    def delete_namespace(**params, &)
      path = "/api/v1/namespaces/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # read the specified Namespace
    # GET /api/v1/namespaces/{name}
    def read_namespace(**params, &)
      path = "/api/v1/namespaces/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update the specified Namespace
    # PATCH /api/v1/namespaces/{name}
    def patch_namespace(**params, &)
      path = "/api/v1/namespaces/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace the specified Namespace
    # PUT /api/v1/namespaces/{name}
    def replace_namespace(**params, &)
      path = "/api/v1/namespaces/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # replace finalize of the specified Namespace
    # PUT /api/v1/namespaces/{name}/finalize
    def replace_namespace_finalize(**params, &)
      path = "/api/v1/namespaces/{name}/finalize"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # read status of the specified Namespace
    # GET /api/v1/namespaces/{name}/status
    def read_namespace_status(**params, &)
      path = "/api/v1/namespaces/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update status of the specified Namespace
    # PATCH /api/v1/namespaces/{name}/status
    def patch_namespace_status(**params, &)
      path = "/api/v1/namespaces/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace status of the specified Namespace
    # PUT /api/v1/namespaces/{name}/status
    def replace_namespace_status(**params, &)
      path = "/api/v1/namespaces/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # delete collection of Node
    # DELETE /api/v1/nodes
    def delete_collection_node(**params, &)
      path = "/api/v1/nodes"
      delete(path) { |res| yield res }
    end

    # list or watch objects of kind Node
    # GET /api/v1/nodes
    def list_node(**params, &)
      path = "/api/v1/nodes"
      get(path) { |res| yield res }
    end

    # create a Node
    # POST /api/v1/nodes
    def create_node(**params, &)
      path = "/api/v1/nodes"
      post(path, params) { |res| yield res }
    end

    # delete a Node
    # DELETE /api/v1/nodes/{name}
    def delete_node(**params, &)
      path = "/api/v1/nodes/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # read the specified Node
    # GET /api/v1/nodes/{name}
    def read_node(**params, &)
      path = "/api/v1/nodes/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update the specified Node
    # PATCH /api/v1/nodes/{name}
    def patch_node(**params, &)
      path = "/api/v1/nodes/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace the specified Node
    # PUT /api/v1/nodes/{name}
    def replace_node(**params, &)
      path = "/api/v1/nodes/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # connect DELETE requests to proxy of Node
    # DELETE /api/v1/nodes/{name}/proxy
    def connect_delete_node_proxy(**params, &)
      path = "/api/v1/nodes/{name}/proxy"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # connect GET requests to proxy of Node
    # GET /api/v1/nodes/{name}/proxy
    def connect_get_node_proxy(**params, &)
      path = "/api/v1/nodes/{name}/proxy"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # connect PATCH requests to proxy of Node
    # PATCH /api/v1/nodes/{name}/proxy
    def connect_patch_node_proxy(**params, &)
      path = "/api/v1/nodes/{name}/proxy"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # connect POST requests to proxy of Node
    # POST /api/v1/nodes/{name}/proxy
    def connect_post_node_proxy(**params, &)
      path = "/api/v1/nodes/{name}/proxy"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      post(path, params) { |res| yield res }
    end

    # connect PUT requests to proxy of Node
    # PUT /api/v1/nodes/{name}/proxy
    def connect_put_node_proxy(**params, &)
      path = "/api/v1/nodes/{name}/proxy"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # connect DELETE requests to proxy of Node
    # DELETE /api/v1/nodes/{name}/proxy/{path}
    def connect_delete_node_proxy_with_path(**params, &)
      path = "/api/v1/nodes/{name}/proxy/{path}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # connect GET requests to proxy of Node
    # GET /api/v1/nodes/{name}/proxy/{path}
    def connect_get_node_proxy_with_path(**params, &)
      path = "/api/v1/nodes/{name}/proxy/{path}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # connect PATCH requests to proxy of Node
    # PATCH /api/v1/nodes/{name}/proxy/{path}
    def connect_patch_node_proxy_with_path(**params, &)
      path = "/api/v1/nodes/{name}/proxy/{path}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # connect POST requests to proxy of Node
    # POST /api/v1/nodes/{name}/proxy/{path}
    def connect_post_node_proxy_with_path(**params, &)
      path = "/api/v1/nodes/{name}/proxy/{path}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      post(path, params) { |res| yield res }
    end

    # connect PUT requests to proxy of Node
    # PUT /api/v1/nodes/{name}/proxy/{path}
    def connect_put_node_proxy_with_path(**params, &)
      path = "/api/v1/nodes/{name}/proxy/{path}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # read status of the specified Node
    # GET /api/v1/nodes/{name}/status
    def read_node_status(**params, &)
      path = "/api/v1/nodes/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update status of the specified Node
    # PATCH /api/v1/nodes/{name}/status
    def patch_node_status(**params, &)
      path = "/api/v1/nodes/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace status of the specified Node
    # PUT /api/v1/nodes/{name}/status
    def replace_node_status(**params, &)
      path = "/api/v1/nodes/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # list or watch objects of kind PersistentVolumeClaim
    # GET /api/v1/persistentvolumeclaims
    def list_persistent_volume_claim_for_all_namespaces(**params, &)
      path = "/api/v1/persistentvolumeclaims"
      get(path) { |res| yield res }
    end

    # delete collection of PersistentVolume
    # DELETE /api/v1/persistentvolumes
    def delete_collection_persistent_volume(**params, &)
      path = "/api/v1/persistentvolumes"
      delete(path) { |res| yield res }
    end

    # list or watch objects of kind PersistentVolume
    # GET /api/v1/persistentvolumes
    def list_persistent_volume(**params, &)
      path = "/api/v1/persistentvolumes"
      get(path) { |res| yield res }
    end

    # create a PersistentVolume
    # POST /api/v1/persistentvolumes
    def create_persistent_volume(**params, &)
      path = "/api/v1/persistentvolumes"
      post(path, params) { |res| yield res }
    end

    # delete a PersistentVolume
    # DELETE /api/v1/persistentvolumes/{name}
    def delete_persistent_volume(**params, &)
      path = "/api/v1/persistentvolumes/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # read the specified PersistentVolume
    # GET /api/v1/persistentvolumes/{name}
    def read_persistent_volume(**params, &)
      path = "/api/v1/persistentvolumes/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update the specified PersistentVolume
    # PATCH /api/v1/persistentvolumes/{name}
    def patch_persistent_volume(**params, &)
      path = "/api/v1/persistentvolumes/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace the specified PersistentVolume
    # PUT /api/v1/persistentvolumes/{name}
    def replace_persistent_volume(**params, &)
      path = "/api/v1/persistentvolumes/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # read status of the specified PersistentVolume
    # GET /api/v1/persistentvolumes/{name}/status
    def read_persistent_volume_status(**params, &)
      path = "/api/v1/persistentvolumes/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update status of the specified PersistentVolume
    # PATCH /api/v1/persistentvolumes/{name}/status
    def patch_persistent_volume_status(**params, &)
      path = "/api/v1/persistentvolumes/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace status of the specified PersistentVolume
    # PUT /api/v1/persistentvolumes/{name}/status
    def replace_persistent_volume_status(**params, &)
      path = "/api/v1/persistentvolumes/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # list or watch objects of kind Pod
    # GET /api/v1/pods
    def list_pod_for_all_namespaces(**params, &)
      path = "/api/v1/pods"
      get(path) { |res| yield res }
    end

    # list or watch objects of kind PodTemplate
    # GET /api/v1/podtemplates
    def list_pod_template_for_all_namespaces(**params, &)
      path = "/api/v1/podtemplates"
      get(path) { |res| yield res }
    end

    # list or watch objects of kind ReplicationController
    # GET /api/v1/replicationcontrollers
    def list_replication_controller_for_all_namespaces(**params, &)
      path = "/api/v1/replicationcontrollers"
      get(path) { |res| yield res }
    end

    # list or watch objects of kind ResourceQuota
    # GET /api/v1/resourcequotas
    def list_resource_quota_for_all_namespaces(**params, &)
      path = "/api/v1/resourcequotas"
      get(path) { |res| yield res }
    end

    # list or watch objects of kind Secret
    # GET /api/v1/secrets
    def list_secret_for_all_namespaces(**params, &)
      path = "/api/v1/secrets"
      get(path) { |res| yield res }
    end

    # list or watch objects of kind ServiceAccount
    # GET /api/v1/serviceaccounts
    def list_service_account_for_all_namespaces(**params, &)
      path = "/api/v1/serviceaccounts"
      get(path) { |res| yield res }
    end

    # list or watch objects of kind Service
    # GET /api/v1/services
    def list_service_for_all_namespaces(**params, &)
      path = "/api/v1/services"
      get(path) { |res| yield res }
    end
  end
end
