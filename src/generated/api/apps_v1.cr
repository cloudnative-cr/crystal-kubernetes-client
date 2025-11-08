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
    # GET /apis/apps/v1/
    def get_api_resources(**params, &)
      path = "/apis/apps/v1/"
      get(path) { |res| yield res }
    end

    # list or watch objects of kind ControllerRevision
    # GET /apis/apps/v1/controllerrevisions
    def list_controller_revision_for_all_namespaces(**params, &)
      path = "/apis/apps/v1/controllerrevisions"
      get(path) { |res| yield res }
    end

    # list or watch objects of kind DaemonSet
    # GET /apis/apps/v1/daemonsets
    def list_daemon_set_for_all_namespaces(**params, &)
      path = "/apis/apps/v1/daemonsets"
      get(path) { |res| yield res }
    end

    # list or watch objects of kind Deployment
    # GET /apis/apps/v1/deployments
    def list_deployment_for_all_namespaces(**params, &)
      path = "/apis/apps/v1/deployments"
      get(path) { |res| yield res }
    end

    # delete collection of ControllerRevision
    # DELETE /apis/apps/v1/namespaces/{namespace}/controllerrevisions
    def delete_collection_namespaced_controller_revision(**params, &)
      path = "/apis/apps/v1/namespaces/{namespace}/controllerrevisions"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # list or watch objects of kind ControllerRevision
    # GET /apis/apps/v1/namespaces/{namespace}/controllerrevisions
    def list_namespaced_controller_revision(**params, &)
      path = "/apis/apps/v1/namespaces/{namespace}/controllerrevisions"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # create a ControllerRevision
    # POST /apis/apps/v1/namespaces/{namespace}/controllerrevisions
    def create_namespaced_controller_revision(**params, &)
      path = "/apis/apps/v1/namespaces/{namespace}/controllerrevisions"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      post(path, params) { |res| yield res }
    end

    # delete a ControllerRevision
    # DELETE /apis/apps/v1/namespaces/{namespace}/controllerrevisions/{name}
    def delete_namespaced_controller_revision(**params, &)
      path = "/apis/apps/v1/namespaces/{namespace}/controllerrevisions/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # read the specified ControllerRevision
    # GET /apis/apps/v1/namespaces/{namespace}/controllerrevisions/{name}
    def read_namespaced_controller_revision(**params, &)
      path = "/apis/apps/v1/namespaces/{namespace}/controllerrevisions/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update the specified ControllerRevision
    # PATCH /apis/apps/v1/namespaces/{namespace}/controllerrevisions/{name}
    def patch_namespaced_controller_revision(**params, &)
      path = "/apis/apps/v1/namespaces/{namespace}/controllerrevisions/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace the specified ControllerRevision
    # PUT /apis/apps/v1/namespaces/{namespace}/controllerrevisions/{name}
    def replace_namespaced_controller_revision(**params, &)
      path = "/apis/apps/v1/namespaces/{namespace}/controllerrevisions/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # delete collection of DaemonSet
    # DELETE /apis/apps/v1/namespaces/{namespace}/daemonsets
    def delete_collection_namespaced_daemon_set(**params, &)
      path = "/apis/apps/v1/namespaces/{namespace}/daemonsets"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # list or watch objects of kind DaemonSet
    # GET /apis/apps/v1/namespaces/{namespace}/daemonsets
    def list_namespaced_daemon_set(**params, &)
      path = "/apis/apps/v1/namespaces/{namespace}/daemonsets"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # create a DaemonSet
    # POST /apis/apps/v1/namespaces/{namespace}/daemonsets
    def create_namespaced_daemon_set(**params, &)
      path = "/apis/apps/v1/namespaces/{namespace}/daemonsets"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      post(path, params) { |res| yield res }
    end

    # delete a DaemonSet
    # DELETE /apis/apps/v1/namespaces/{namespace}/daemonsets/{name}
    def delete_namespaced_daemon_set(**params, &)
      path = "/apis/apps/v1/namespaces/{namespace}/daemonsets/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # read the specified DaemonSet
    # GET /apis/apps/v1/namespaces/{namespace}/daemonsets/{name}
    def read_namespaced_daemon_set(**params, &)
      path = "/apis/apps/v1/namespaces/{namespace}/daemonsets/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update the specified DaemonSet
    # PATCH /apis/apps/v1/namespaces/{namespace}/daemonsets/{name}
    def patch_namespaced_daemon_set(**params, &)
      path = "/apis/apps/v1/namespaces/{namespace}/daemonsets/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace the specified DaemonSet
    # PUT /apis/apps/v1/namespaces/{namespace}/daemonsets/{name}
    def replace_namespaced_daemon_set(**params, &)
      path = "/apis/apps/v1/namespaces/{namespace}/daemonsets/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # read status of the specified DaemonSet
    # GET /apis/apps/v1/namespaces/{namespace}/daemonsets/{name}/status
    def read_namespaced_daemon_set_status(**params, &)
      path = "/apis/apps/v1/namespaces/{namespace}/daemonsets/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update status of the specified DaemonSet
    # PATCH /apis/apps/v1/namespaces/{namespace}/daemonsets/{name}/status
    def patch_namespaced_daemon_set_status(**params, &)
      path = "/apis/apps/v1/namespaces/{namespace}/daemonsets/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace status of the specified DaemonSet
    # PUT /apis/apps/v1/namespaces/{namespace}/daemonsets/{name}/status
    def replace_namespaced_daemon_set_status(**params, &)
      path = "/apis/apps/v1/namespaces/{namespace}/daemonsets/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # delete collection of Deployment
    # DELETE /apis/apps/v1/namespaces/{namespace}/deployments
    def delete_collection_namespaced_deployment(**params, &)
      path = "/apis/apps/v1/namespaces/{namespace}/deployments"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # list or watch objects of kind Deployment
    # GET /apis/apps/v1/namespaces/{namespace}/deployments
    def list_namespaced_deployment(**params, &)
      path = "/apis/apps/v1/namespaces/{namespace}/deployments"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # create a Deployment
    # POST /apis/apps/v1/namespaces/{namespace}/deployments
    def create_namespaced_deployment(**params, &)
      path = "/apis/apps/v1/namespaces/{namespace}/deployments"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      post(path, params) { |res| yield res }
    end

    # delete a Deployment
    # DELETE /apis/apps/v1/namespaces/{namespace}/deployments/{name}
    def delete_namespaced_deployment(**params, &)
      path = "/apis/apps/v1/namespaces/{namespace}/deployments/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # read the specified Deployment
    # GET /apis/apps/v1/namespaces/{namespace}/deployments/{name}
    def read_namespaced_deployment(**params, &)
      path = "/apis/apps/v1/namespaces/{namespace}/deployments/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update the specified Deployment
    # PATCH /apis/apps/v1/namespaces/{namespace}/deployments/{name}
    def patch_namespaced_deployment(**params, &)
      path = "/apis/apps/v1/namespaces/{namespace}/deployments/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace the specified Deployment
    # PUT /apis/apps/v1/namespaces/{namespace}/deployments/{name}
    def replace_namespaced_deployment(**params, &)
      path = "/apis/apps/v1/namespaces/{namespace}/deployments/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # read scale of the specified Deployment
    # GET /apis/apps/v1/namespaces/{namespace}/deployments/{name}/scale
    def read_namespaced_deployment_scale(**params, &)
      path = "/apis/apps/v1/namespaces/{namespace}/deployments/{name}/scale"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update scale of the specified Deployment
    # PATCH /apis/apps/v1/namespaces/{namespace}/deployments/{name}/scale
    def patch_namespaced_deployment_scale(**params, &)
      path = "/apis/apps/v1/namespaces/{namespace}/deployments/{name}/scale"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace scale of the specified Deployment
    # PUT /apis/apps/v1/namespaces/{namespace}/deployments/{name}/scale
    def replace_namespaced_deployment_scale(**params, &)
      path = "/apis/apps/v1/namespaces/{namespace}/deployments/{name}/scale"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # read status of the specified Deployment
    # GET /apis/apps/v1/namespaces/{namespace}/deployments/{name}/status
    def read_namespaced_deployment_status(**params, &)
      path = "/apis/apps/v1/namespaces/{namespace}/deployments/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update status of the specified Deployment
    # PATCH /apis/apps/v1/namespaces/{namespace}/deployments/{name}/status
    def patch_namespaced_deployment_status(**params, &)
      path = "/apis/apps/v1/namespaces/{namespace}/deployments/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace status of the specified Deployment
    # PUT /apis/apps/v1/namespaces/{namespace}/deployments/{name}/status
    def replace_namespaced_deployment_status(**params, &)
      path = "/apis/apps/v1/namespaces/{namespace}/deployments/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # delete collection of ReplicaSet
    # DELETE /apis/apps/v1/namespaces/{namespace}/replicasets
    def delete_collection_namespaced_replica_set(**params, &)
      path = "/apis/apps/v1/namespaces/{namespace}/replicasets"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # list or watch objects of kind ReplicaSet
    # GET /apis/apps/v1/namespaces/{namespace}/replicasets
    def list_namespaced_replica_set(**params, &)
      path = "/apis/apps/v1/namespaces/{namespace}/replicasets"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # create a ReplicaSet
    # POST /apis/apps/v1/namespaces/{namespace}/replicasets
    def create_namespaced_replica_set(**params, &)
      path = "/apis/apps/v1/namespaces/{namespace}/replicasets"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      post(path, params) { |res| yield res }
    end

    # delete a ReplicaSet
    # DELETE /apis/apps/v1/namespaces/{namespace}/replicasets/{name}
    def delete_namespaced_replica_set(**params, &)
      path = "/apis/apps/v1/namespaces/{namespace}/replicasets/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # read the specified ReplicaSet
    # GET /apis/apps/v1/namespaces/{namespace}/replicasets/{name}
    def read_namespaced_replica_set(**params, &)
      path = "/apis/apps/v1/namespaces/{namespace}/replicasets/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update the specified ReplicaSet
    # PATCH /apis/apps/v1/namespaces/{namespace}/replicasets/{name}
    def patch_namespaced_replica_set(**params, &)
      path = "/apis/apps/v1/namespaces/{namespace}/replicasets/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace the specified ReplicaSet
    # PUT /apis/apps/v1/namespaces/{namespace}/replicasets/{name}
    def replace_namespaced_replica_set(**params, &)
      path = "/apis/apps/v1/namespaces/{namespace}/replicasets/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # read scale of the specified ReplicaSet
    # GET /apis/apps/v1/namespaces/{namespace}/replicasets/{name}/scale
    def read_namespaced_replica_set_scale(**params, &)
      path = "/apis/apps/v1/namespaces/{namespace}/replicasets/{name}/scale"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update scale of the specified ReplicaSet
    # PATCH /apis/apps/v1/namespaces/{namespace}/replicasets/{name}/scale
    def patch_namespaced_replica_set_scale(**params, &)
      path = "/apis/apps/v1/namespaces/{namespace}/replicasets/{name}/scale"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace scale of the specified ReplicaSet
    # PUT /apis/apps/v1/namespaces/{namespace}/replicasets/{name}/scale
    def replace_namespaced_replica_set_scale(**params, &)
      path = "/apis/apps/v1/namespaces/{namespace}/replicasets/{name}/scale"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # read status of the specified ReplicaSet
    # GET /apis/apps/v1/namespaces/{namespace}/replicasets/{name}/status
    def read_namespaced_replica_set_status(**params, &)
      path = "/apis/apps/v1/namespaces/{namespace}/replicasets/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update status of the specified ReplicaSet
    # PATCH /apis/apps/v1/namespaces/{namespace}/replicasets/{name}/status
    def patch_namespaced_replica_set_status(**params, &)
      path = "/apis/apps/v1/namespaces/{namespace}/replicasets/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace status of the specified ReplicaSet
    # PUT /apis/apps/v1/namespaces/{namespace}/replicasets/{name}/status
    def replace_namespaced_replica_set_status(**params, &)
      path = "/apis/apps/v1/namespaces/{namespace}/replicasets/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # delete collection of StatefulSet
    # DELETE /apis/apps/v1/namespaces/{namespace}/statefulsets
    def delete_collection_namespaced_stateful_set(**params, &)
      path = "/apis/apps/v1/namespaces/{namespace}/statefulsets"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # list or watch objects of kind StatefulSet
    # GET /apis/apps/v1/namespaces/{namespace}/statefulsets
    def list_namespaced_stateful_set(**params, &)
      path = "/apis/apps/v1/namespaces/{namespace}/statefulsets"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # create a StatefulSet
    # POST /apis/apps/v1/namespaces/{namespace}/statefulsets
    def create_namespaced_stateful_set(**params, &)
      path = "/apis/apps/v1/namespaces/{namespace}/statefulsets"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      post(path, params) { |res| yield res }
    end

    # delete a StatefulSet
    # DELETE /apis/apps/v1/namespaces/{namespace}/statefulsets/{name}
    def delete_namespaced_stateful_set(**params, &)
      path = "/apis/apps/v1/namespaces/{namespace}/statefulsets/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # read the specified StatefulSet
    # GET /apis/apps/v1/namespaces/{namespace}/statefulsets/{name}
    def read_namespaced_stateful_set(**params, &)
      path = "/apis/apps/v1/namespaces/{namespace}/statefulsets/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update the specified StatefulSet
    # PATCH /apis/apps/v1/namespaces/{namespace}/statefulsets/{name}
    def patch_namespaced_stateful_set(**params, &)
      path = "/apis/apps/v1/namespaces/{namespace}/statefulsets/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace the specified StatefulSet
    # PUT /apis/apps/v1/namespaces/{namespace}/statefulsets/{name}
    def replace_namespaced_stateful_set(**params, &)
      path = "/apis/apps/v1/namespaces/{namespace}/statefulsets/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # read scale of the specified StatefulSet
    # GET /apis/apps/v1/namespaces/{namespace}/statefulsets/{name}/scale
    def read_namespaced_stateful_set_scale(**params, &)
      path = "/apis/apps/v1/namespaces/{namespace}/statefulsets/{name}/scale"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update scale of the specified StatefulSet
    # PATCH /apis/apps/v1/namespaces/{namespace}/statefulsets/{name}/scale
    def patch_namespaced_stateful_set_scale(**params, &)
      path = "/apis/apps/v1/namespaces/{namespace}/statefulsets/{name}/scale"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace scale of the specified StatefulSet
    # PUT /apis/apps/v1/namespaces/{namespace}/statefulsets/{name}/scale
    def replace_namespaced_stateful_set_scale(**params, &)
      path = "/apis/apps/v1/namespaces/{namespace}/statefulsets/{name}/scale"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # read status of the specified StatefulSet
    # GET /apis/apps/v1/namespaces/{namespace}/statefulsets/{name}/status
    def read_namespaced_stateful_set_status(**params, &)
      path = "/apis/apps/v1/namespaces/{namespace}/statefulsets/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update status of the specified StatefulSet
    # PATCH /apis/apps/v1/namespaces/{namespace}/statefulsets/{name}/status
    def patch_namespaced_stateful_set_status(**params, &)
      path = "/apis/apps/v1/namespaces/{namespace}/statefulsets/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace status of the specified StatefulSet
    # PUT /apis/apps/v1/namespaces/{namespace}/statefulsets/{name}/status
    def replace_namespaced_stateful_set_status(**params, &)
      path = "/apis/apps/v1/namespaces/{namespace}/statefulsets/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # list or watch objects of kind ReplicaSet
    # GET /apis/apps/v1/replicasets
    def list_replica_set_for_all_namespaces(**params, &)
      path = "/apis/apps/v1/replicasets"
      get(path) { |res| yield res }
    end

    # list or watch objects of kind StatefulSet
    # GET /apis/apps/v1/statefulsets
    def list_stateful_set_for_all_namespaces(**params, &)
      path = "/apis/apps/v1/statefulsets"
      get(path) { |res| yield res }
    end
  end
end
