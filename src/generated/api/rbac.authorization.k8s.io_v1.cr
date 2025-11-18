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
    # GET /apis/rbac.authorization.k8s.io/v1/
    def get_rbac_authorization_v1_api_resources(**params, &)
      path = "/apis/rbac.authorization.k8s.io/v1/"
      get(path) { |res| yield res }
    end

    # delete collection of ClusterRoleBinding
    # DELETE /apis/rbac.authorization.k8s.io/v1/clusterrolebindings
    def delete_rbac_authorization_v1_collection_cluster_role_binding(**params, &)
      path = "/apis/rbac.authorization.k8s.io/v1/clusterrolebindings"
      delete(path) { |res| yield res }
    end

    # list or watch objects of kind ClusterRoleBinding
    # GET /apis/rbac.authorization.k8s.io/v1/clusterrolebindings
    def list_rbac_authorization_v1_cluster_role_binding(**params, &)
      path = "/apis/rbac.authorization.k8s.io/v1/clusterrolebindings"
      get(path) { |res| yield res }
    end

    # create a ClusterRoleBinding
    # POST /apis/rbac.authorization.k8s.io/v1/clusterrolebindings
    def create_rbac_authorization_v1_cluster_role_binding(**params, &)
      path = "/apis/rbac.authorization.k8s.io/v1/clusterrolebindings"
      post(path, params) { |res| yield res }
    end

    # delete a ClusterRoleBinding
    # DELETE /apis/rbac.authorization.k8s.io/v1/clusterrolebindings/{name}
    def delete_rbac_authorization_v1_cluster_role_binding(**params, &)
      path = "/apis/rbac.authorization.k8s.io/v1/clusterrolebindings/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # read the specified ClusterRoleBinding
    # GET /apis/rbac.authorization.k8s.io/v1/clusterrolebindings/{name}
    def read_rbac_authorization_v1_cluster_role_binding(**params, &)
      path = "/apis/rbac.authorization.k8s.io/v1/clusterrolebindings/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update the specified ClusterRoleBinding
    # PATCH /apis/rbac.authorization.k8s.io/v1/clusterrolebindings/{name}
    def patch_rbac_authorization_v1_cluster_role_binding(**params, &)
      path = "/apis/rbac.authorization.k8s.io/v1/clusterrolebindings/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace the specified ClusterRoleBinding
    # PUT /apis/rbac.authorization.k8s.io/v1/clusterrolebindings/{name}
    def replace_rbac_authorization_v1_cluster_role_binding(**params, &)
      path = "/apis/rbac.authorization.k8s.io/v1/clusterrolebindings/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # delete collection of ClusterRole
    # DELETE /apis/rbac.authorization.k8s.io/v1/clusterroles
    def delete_rbac_authorization_v1_collection_cluster_role(**params, &)
      path = "/apis/rbac.authorization.k8s.io/v1/clusterroles"
      delete(path) { |res| yield res }
    end

    # list or watch objects of kind ClusterRole
    # GET /apis/rbac.authorization.k8s.io/v1/clusterroles
    def list_rbac_authorization_v1_cluster_role(**params, &)
      path = "/apis/rbac.authorization.k8s.io/v1/clusterroles"
      get(path) { |res| yield res }
    end

    # create a ClusterRole
    # POST /apis/rbac.authorization.k8s.io/v1/clusterroles
    def create_rbac_authorization_v1_cluster_role(**params, &)
      path = "/apis/rbac.authorization.k8s.io/v1/clusterroles"
      post(path, params) { |res| yield res }
    end

    # delete a ClusterRole
    # DELETE /apis/rbac.authorization.k8s.io/v1/clusterroles/{name}
    def delete_rbac_authorization_v1_cluster_role(**params, &)
      path = "/apis/rbac.authorization.k8s.io/v1/clusterroles/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # read the specified ClusterRole
    # GET /apis/rbac.authorization.k8s.io/v1/clusterroles/{name}
    def read_rbac_authorization_v1_cluster_role(**params, &)
      path = "/apis/rbac.authorization.k8s.io/v1/clusterroles/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update the specified ClusterRole
    # PATCH /apis/rbac.authorization.k8s.io/v1/clusterroles/{name}
    def patch_rbac_authorization_v1_cluster_role(**params, &)
      path = "/apis/rbac.authorization.k8s.io/v1/clusterroles/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace the specified ClusterRole
    # PUT /apis/rbac.authorization.k8s.io/v1/clusterroles/{name}
    def replace_rbac_authorization_v1_cluster_role(**params, &)
      path = "/apis/rbac.authorization.k8s.io/v1/clusterroles/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # delete collection of RoleBinding
    # DELETE /apis/rbac.authorization.k8s.io/v1/namespaces/{namespace}/rolebindings
    def delete_rbac_authorization_v1_collection_namespaced_role_binding(**params, &)
      path = "/apis/rbac.authorization.k8s.io/v1/namespaces/{namespace}/rolebindings"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # list or watch objects of kind RoleBinding
    # GET /apis/rbac.authorization.k8s.io/v1/namespaces/{namespace}/rolebindings
    def list_rbac_authorization_v1_namespaced_role_binding(**params, &)
      path = "/apis/rbac.authorization.k8s.io/v1/namespaces/{namespace}/rolebindings"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # create a RoleBinding
    # POST /apis/rbac.authorization.k8s.io/v1/namespaces/{namespace}/rolebindings
    def create_rbac_authorization_v1_namespaced_role_binding(**params, &)
      path = "/apis/rbac.authorization.k8s.io/v1/namespaces/{namespace}/rolebindings"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      post(path, params) { |res| yield res }
    end

    # delete a RoleBinding
    # DELETE /apis/rbac.authorization.k8s.io/v1/namespaces/{namespace}/rolebindings/{name}
    def delete_rbac_authorization_v1_namespaced_role_binding(**params, &)
      path = "/apis/rbac.authorization.k8s.io/v1/namespaces/{namespace}/rolebindings/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # read the specified RoleBinding
    # GET /apis/rbac.authorization.k8s.io/v1/namespaces/{namespace}/rolebindings/{name}
    def read_rbac_authorization_v1_namespaced_role_binding(**params, &)
      path = "/apis/rbac.authorization.k8s.io/v1/namespaces/{namespace}/rolebindings/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update the specified RoleBinding
    # PATCH /apis/rbac.authorization.k8s.io/v1/namespaces/{namespace}/rolebindings/{name}
    def patch_rbac_authorization_v1_namespaced_role_binding(**params, &)
      path = "/apis/rbac.authorization.k8s.io/v1/namespaces/{namespace}/rolebindings/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace the specified RoleBinding
    # PUT /apis/rbac.authorization.k8s.io/v1/namespaces/{namespace}/rolebindings/{name}
    def replace_rbac_authorization_v1_namespaced_role_binding(**params, &)
      path = "/apis/rbac.authorization.k8s.io/v1/namespaces/{namespace}/rolebindings/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # delete collection of Role
    # DELETE /apis/rbac.authorization.k8s.io/v1/namespaces/{namespace}/roles
    def delete_rbac_authorization_v1_collection_namespaced_role(**params, &)
      path = "/apis/rbac.authorization.k8s.io/v1/namespaces/{namespace}/roles"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # list or watch objects of kind Role
    # GET /apis/rbac.authorization.k8s.io/v1/namespaces/{namespace}/roles
    def list_rbac_authorization_v1_namespaced_role(**params, &)
      path = "/apis/rbac.authorization.k8s.io/v1/namespaces/{namespace}/roles"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # create a Role
    # POST /apis/rbac.authorization.k8s.io/v1/namespaces/{namespace}/roles
    def create_rbac_authorization_v1_namespaced_role(**params, &)
      path = "/apis/rbac.authorization.k8s.io/v1/namespaces/{namespace}/roles"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      post(path, params) { |res| yield res }
    end

    # delete a Role
    # DELETE /apis/rbac.authorization.k8s.io/v1/namespaces/{namespace}/roles/{name}
    def delete_rbac_authorization_v1_namespaced_role(**params, &)
      path = "/apis/rbac.authorization.k8s.io/v1/namespaces/{namespace}/roles/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # read the specified Role
    # GET /apis/rbac.authorization.k8s.io/v1/namespaces/{namespace}/roles/{name}
    def read_rbac_authorization_v1_namespaced_role(**params, &)
      path = "/apis/rbac.authorization.k8s.io/v1/namespaces/{namespace}/roles/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update the specified Role
    # PATCH /apis/rbac.authorization.k8s.io/v1/namespaces/{namespace}/roles/{name}
    def patch_rbac_authorization_v1_namespaced_role(**params, &)
      path = "/apis/rbac.authorization.k8s.io/v1/namespaces/{namespace}/roles/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace the specified Role
    # PUT /apis/rbac.authorization.k8s.io/v1/namespaces/{namespace}/roles/{name}
    def replace_rbac_authorization_v1_namespaced_role(**params, &)
      path = "/apis/rbac.authorization.k8s.io/v1/namespaces/{namespace}/roles/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # list or watch objects of kind RoleBinding
    # GET /apis/rbac.authorization.k8s.io/v1/rolebindings
    def list_rbac_authorization_v1_role_binding_for_all_namespaces(**params, &)
      path = "/apis/rbac.authorization.k8s.io/v1/rolebindings"
      get(path) { |res| yield res }
    end

    # list or watch objects of kind Role
    # GET /apis/rbac.authorization.k8s.io/v1/roles
    def list_rbac_authorization_v1_role_for_all_namespaces(**params, &)
      path = "/apis/rbac.authorization.k8s.io/v1/roles"
      get(path) { |res| yield res }
    end

    # watch individual changes to a list of ClusterRoleBinding. deprecated: use the 'watch' parameter with a list operation instead.
    # GET /apis/rbac.authorization.k8s.io/v1/watch/clusterrolebindings
    def watch_rbac_authorization_v1_cluster_role_binding_list(**params, &)
      path = "/apis/rbac.authorization.k8s.io/v1/watch/clusterrolebindings"
      get(path) { |res| yield res }
    end

    # watch changes to an object of kind ClusterRoleBinding. deprecated: use the 'watch' parameter with a list operation instead, filtered to a single item with the 'fieldSelector' parameter.
    # GET /apis/rbac.authorization.k8s.io/v1/watch/clusterrolebindings/{name}
    def watch_rbac_authorization_v1_cluster_role_binding(**params, &)
      path = "/apis/rbac.authorization.k8s.io/v1/watch/clusterrolebindings/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # watch individual changes to a list of ClusterRole. deprecated: use the 'watch' parameter with a list operation instead.
    # GET /apis/rbac.authorization.k8s.io/v1/watch/clusterroles
    def watch_rbac_authorization_v1_cluster_role_list(**params, &)
      path = "/apis/rbac.authorization.k8s.io/v1/watch/clusterroles"
      get(path) { |res| yield res }
    end

    # watch changes to an object of kind ClusterRole. deprecated: use the 'watch' parameter with a list operation instead, filtered to a single item with the 'fieldSelector' parameter.
    # GET /apis/rbac.authorization.k8s.io/v1/watch/clusterroles/{name}
    def watch_rbac_authorization_v1_cluster_role(**params, &)
      path = "/apis/rbac.authorization.k8s.io/v1/watch/clusterroles/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # watch individual changes to a list of RoleBinding. deprecated: use the 'watch' parameter with a list operation instead.
    # GET /apis/rbac.authorization.k8s.io/v1/watch/namespaces/{namespace}/rolebindings
    def watch_rbac_authorization_v1_namespaced_role_binding_list(**params, &)
      path = "/apis/rbac.authorization.k8s.io/v1/watch/namespaces/{namespace}/rolebindings"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # watch changes to an object of kind RoleBinding. deprecated: use the 'watch' parameter with a list operation instead, filtered to a single item with the 'fieldSelector' parameter.
    # GET /apis/rbac.authorization.k8s.io/v1/watch/namespaces/{namespace}/rolebindings/{name}
    def watch_rbac_authorization_v1_namespaced_role_binding(**params, &)
      path = "/apis/rbac.authorization.k8s.io/v1/watch/namespaces/{namespace}/rolebindings/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # watch individual changes to a list of Role. deprecated: use the 'watch' parameter with a list operation instead.
    # GET /apis/rbac.authorization.k8s.io/v1/watch/namespaces/{namespace}/roles
    def watch_rbac_authorization_v1_namespaced_role_list(**params, &)
      path = "/apis/rbac.authorization.k8s.io/v1/watch/namespaces/{namespace}/roles"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # watch changes to an object of kind Role. deprecated: use the 'watch' parameter with a list operation instead, filtered to a single item with the 'fieldSelector' parameter.
    # GET /apis/rbac.authorization.k8s.io/v1/watch/namespaces/{namespace}/roles/{name}
    def watch_rbac_authorization_v1_namespaced_role(**params, &)
      path = "/apis/rbac.authorization.k8s.io/v1/watch/namespaces/{namespace}/roles/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # watch individual changes to a list of RoleBinding. deprecated: use the 'watch' parameter with a list operation instead.
    # GET /apis/rbac.authorization.k8s.io/v1/watch/rolebindings
    def watch_rbac_authorization_v1_role_binding_list_for_all_namespaces(**params, &)
      path = "/apis/rbac.authorization.k8s.io/v1/watch/rolebindings"
      get(path) { |res| yield res }
    end

    # watch individual changes to a list of Role. deprecated: use the 'watch' parameter with a list operation instead.
    # GET /apis/rbac.authorization.k8s.io/v1/watch/roles
    def watch_rbac_authorization_v1_role_list_for_all_namespaces(**params, &)
      path = "/apis/rbac.authorization.k8s.io/v1/watch/roles"
      get(path) { |res| yield res }
    end
  end
end
