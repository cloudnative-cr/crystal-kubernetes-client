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
  # Generic client for working with CustomResourceDefinitions and aggregated APIs
  # without code generation.
  #
  # This client provides type-safe access to any Kubernetes resource, including
  # custom resources, by using Crystal's generic type system.
  #
  # ## Example: Working with a Custom Resource
  #
  # ```
  # # Define your CRD type
  # struct MyCronTab
  #   include ::JSON::Serializable
  #   property api_version : String
  #   property kind : String
  #   property metadata : Kubernetes::Metadata
  #   property spec : MyCronTabSpec
  #   property status : MyCronTabStatus?
  # end
  #
  # struct MyCronTabSpec
  #   include ::JSON::Serializable
  #   property cron_spec : String
  #   property image : String
  #   property replicas : Int32
  # end
  #
  # struct MyCronTabStatus
  #   include ::JSON::Serializable
  #   property active : Int32?
  # end
  #
  # # Create generic client
  # k8s = Kubernetes::Client.new
  # crontabs = Kubernetes::Generic(MyCronTab).new(k8s,
  #   api_group: "stable.example.com",
  #   version: "v1",
  #   resource: "crontabs"
  # )
  #
  # # List all crontabs in namespace
  # list = crontabs.list_namespaced("default")
  # list.items.each { |ct| puts ct.metadata.name }
  #
  # # Read single crontab
  # crontab = crontabs.read_namespaced("default", "my-cron")
  #
  # # Create new crontab
  # new_crontab = MyCronTab.new
  # new_crontab.api_version = "stable.example.com/v1"
  # new_crontab.kind = "CronTab"
  # new_crontab.metadata = Kubernetes::Metadata.new("backup-cron", "default")
  # new_crontab.spec = MyCronTabSpec.new(
  #   cron_spec: "*/5 * * * *",
  #   image: "backup:latest",
  #   replicas: 1
  # )
  # crontabs.create_namespaced("default", new_crontab)
  #
  # # Update with server-side apply
  # crontabs.apply_namespaced("default", "backup-cron", new_crontab)
  #
  # # Watch for changes
  # crontabs.watch_namespaced("default") do |event|
  #   case event.type
  #   when .added?    then puts "New: #{event.object.metadata.name}"
  #   when .modified? then puts "Updated: #{event.object.metadata.name}"
  #   when .deleted?  then puts "Deleted: #{event.object.metadata.name}"
  #   end
  # end
  # ```
  #
  class Generic(T)
    def initialize(@client : Client, @api_group : String, @version : String, @resource : String)
    end

    # List all resources (cluster-scoped).
    #
    # Only use this for cluster-scoped resources like ClusterRole, PersistentVolume, etc.
    # For namespaced resources, use `list_namespaced` instead.
    #
    # Example:
    # ```
    # nodes = Kubernetes::Generic(Node).new(client, "", "v1", "nodes")
    # list = nodes.list
    #
    # # With label selector
    # list = nodes.list(label_selector: "node-role.kubernetes.io/worker=")
    #
    # # With pagination
    # list = nodes.list(limit: 100)
    # ```
    def list(label_selector : String? = nil,
             field_selector : String? = nil,
             limit : Int32? = nil,
             continue : String? = nil) : List(T)
      path = construct_path
      params = @client.build_list_params(
        label_selector: label_selector,
        field_selector: field_selector,
        limit: limit,
        continue: continue
      )
      @client.get(path, params) do |res|
        List(T).from_json(res.body_io)
      end
    end

    # List resources in a specific namespace.
    #
    # Example:
    # ```
    # pods = Kubernetes::Generic(Pod).new(client, "", "v1", "pods")
    # list = pods.list_namespaced("default")
    #
    # # With label selector
    # list = pods.list_namespaced("default", label_selector: "app=nginx")
    #
    # # With field selector and pagination
    # list = pods.list_namespaced("default",
    #   field_selector: "status.phase=Running",
    #   limit: 50
    # )
    # ```
    def list_namespaced(namespace : String,
                        label_selector : String? = nil,
                        field_selector : String? = nil,
                        limit : Int32? = nil,
                        continue : String? = nil) : List(T)
      path = construct_path(namespace)
      params = @client.build_list_params(
        label_selector: label_selector,
        field_selector: field_selector,
        limit: limit,
        continue: continue
      )
      @client.get(path, params) do |res|
        List(T).from_json(res.body_io)
      end
    end

    # Read a single cluster-scoped resource by name.
    #
    # Example:
    # ```
    # nodes = Kubernetes::Generic(Node).new(client, "", "v1", "nodes")
    # node = nodes.read("worker-1")
    # ```
    def read(name : String) : T
      path = "#{construct_path}/#{name}"
      @client.get(path) do |res|
        T.from_json(res.body_io)
      end
    end

    # Read a single namespaced resource by namespace and name.
    #
    # Example:
    # ```
    # pods = Kubernetes::Generic(Pod).new(client, "", "v1", "pods")
    # pod = pods.read_namespaced("default", "nginx-12345")
    # ```
    def read_namespaced(namespace : String, name : String) : T
      path = "#{construct_path(namespace)}/#{name}"
      @client.get(path) do |res|
        T.from_json(res.body_io)
      end
    end

    # Create a cluster-scoped resource.
    #
    # Example:
    # ```
    # namespaces = Kubernetes::Generic(Namespace).new(client, "", "v1", "namespaces")
    # ns = Namespace.new(...)
    # created = namespaces.create(ns)
    # ```
    def create(resource : T) : T
      path = construct_path
      res = @client.post(path, resource)
      T.from_json(res.body_io)
    end

    # Create a namespaced resource.
    #
    # Example:
    # ```
    # deployments = Kubernetes::Generic(Deployment).new(client, "apps", "v1", "deployments")
    # deployment = Deployment.new(...)
    # created = deployments.create_namespaced("default", deployment)
    # ```
    def create_namespaced(namespace : String, resource : T) : T
      path = construct_path(namespace)
      res = @client.post(path, resource)
      T.from_json(res.body_io)
    end

    # Update (replace) a cluster-scoped resource.
    #
    # This performs a full replacement of the resource. Use `patch` for partial updates.
    #
    # Example:
    # ```
    # namespaces = Kubernetes::Generic(Namespace).new(client, "", "v1", "namespaces")
    # ns = namespaces.read("production")
    # ns.metadata.labels["env"] = "prod"
    # updated = namespaces.update("production", ns)
    # ```
    def update(name : String, resource : T) : T
      path = "#{construct_path}/#{name}"
      res = @client.put(path, resource)
      T.from_json(res.body_io)
    end

    # Update (replace) a namespaced resource.
    #
    # This performs a full replacement of the resource. Use `patch_namespaced` for partial updates.
    #
    # Example:
    # ```
    # deployments = Kubernetes::Generic(Deployment).new(client, "apps", "v1", "deployments")
    # deployment = deployments.read_namespaced("default", "nginx")
    # deployment.spec.replicas = 5
    # updated = deployments.update_namespaced("default", "nginx", deployment)
    # ```
    def update_namespaced(namespace : String, name : String, resource : T) : T
      path = "#{construct_path(namespace)}/#{name}"
      res = @client.put(path, resource)
      T.from_json(res.body_io)
    end

    # Patch a cluster-scoped resource.
    #
    # Supports multiple patch strategies:
    # - `application/json-patch+json` - JSON Patch (RFC 6902)
    # - `application/merge-patch+json` - JSON Merge Patch (RFC 7396)
    # - `application/strategic-merge-patch+json` - Kubernetes Strategic Merge Patch
    # - `application/apply-patch+yaml` - Server-side apply (see `apply` method)
    #
    # Example:
    # ```
    # nodes = Kubernetes::Generic(Node).new(client, "", "v1", "nodes")
    #
    # # JSON Merge Patch
    # patch = {"metadata" => {"labels" => {"disk" => "ssd"}}}
    # nodes.patch("worker-1", patch)
    #
    # # Strategic Merge Patch
    # nodes.patch("worker-1", patch, content_type: "application/strategic-merge-patch+json")
    # ```
    def patch(name : String, patch : T | String | Hash,
              content_type = "application/merge-patch+json") : T
      path = "#{construct_path}/#{name}"
      res = @client.patch(path, patch, content_type: content_type)
      T.from_json(res.body_io)
    end

    # Patch a namespaced resource.
    #
    # See `patch` for details on patch strategies.
    #
    # Example:
    # ```
    # deployments = Kubernetes::Generic(Deployment).new(client, "apps", "v1", "deployments")
    #
    # # Scale deployment using merge patch
    # patch = {"spec" => {"replicas" => 10}}
    # deployments.patch_namespaced("default", "nginx", patch)
    # ```
    def patch_namespaced(namespace : String, name : String, patch : T | String | Hash,
                         content_type = "application/merge-patch+json") : T
      path = "#{construct_path(namespace)}/#{name}"
      res = @client.patch(path, patch, content_type: content_type)
      T.from_json(res.body_io)
    end

    # Server-side apply for cluster-scoped resources.
    #
    # Server-side apply is the recommended way to manage resources declaratively.
    # It performs a three-way merge based on the field manager and handles conflicts
    # automatically.
    #
    # Example:
    # ```
    # namespaces = Kubernetes::Generic(Namespace).new(client, "", "v1", "namespaces")
    # ns = Namespace.new(...)
    # namespaces.apply("production", ns, field_manager: "my-controller")
    # ```
    def apply(name : String, resource : T, field_manager = "crystal-client") : T
      params = URI::Params{"fieldManager" => field_manager}
      path = "#{construct_path}/#{name}?#{params}"
      res = @client.patch(path, resource, content_type: "application/apply-patch+yaml")
      T.from_json(res.body_io)
    end

    # Server-side apply for namespaced resources.
    #
    # This is the recommended way to create or update resources in operators.
    # It's idempotent and handles conflicts automatically.
    #
    # Example:
    # ```
    # deployments = Kubernetes::Generic(Deployment).new(client, "apps", "v1", "deployments")
    # deployment = Deployment.new(...)
    # deployments.apply_namespaced("default", "nginx", deployment, field_manager: "my-operator")
    # ```
    def apply_namespaced(namespace : String, name : String, resource : T,
                         field_manager = "crystal-client") : T
      params = URI::Params{"fieldManager" => field_manager}
      path = "#{construct_path(namespace)}/#{name}?#{params}"
      res = @client.patch(path, resource, content_type: "application/apply-patch+yaml")
      T.from_json(res.body_io)
    end

    # Delete a cluster-scoped resource.
    #
    # Returns a Status object indicating the result of the deletion.
    #
    # Example:
    # ```
    # namespaces = Kubernetes::Generic(Namespace).new(client, "", "v1", "namespaces")
    # status = namespaces.delete("old-namespace")
    # puts "Deleted: #{status.status}"
    # ```
    def delete(name : String) : Status
      path = "#{construct_path}/#{name}"
      res = @client.delete(path)
      Status.from_json(res.body_io)
    end

    # Delete a namespaced resource.
    #
    # Returns a Status object indicating the result of the deletion.
    #
    # Example:
    # ```
    # deployments = Kubernetes::Generic(Deployment).new(client, "apps", "v1", "deployments")
    # status = deployments.delete_namespaced("default", "nginx")
    # ```
    def delete_namespaced(namespace : String, name : String) : Status
      path = "#{construct_path(namespace)}/#{name}"
      res = @client.delete(path)
      Status.from_json(res.body_io)
    end

    # Watch cluster-scoped resources for changes.
    #
    # Watches return a stream of events (ADDED, MODIFIED, DELETED) as resources change.
    # The watch will automatically reconnect with exponential backoff on errors.
    #
    # Example:
    # ```
    # nodes = Kubernetes::Generic(Node).new(client, "", "v1", "nodes")
    # nodes.watch do |event|
    #   case event.type
    #   when .added?    then puts "Node added: #{event.object.metadata.name}"
    #   when .modified? then puts "Node modified: #{event.object.metadata.name}"
    #   when .deleted?  then puts "Node deleted: #{event.object.metadata.name}"
    #   end
    # end
    # ```
    def watch(resource_version = "0", timeout = 10.minutes, & : Watch(T) -> Nil)
      path = construct_path
      @client.watch(path, resource_version, timeout) do |event|
        yield event.as(Watch(T))
      end
    end

    # Watch namespaced resources for changes.
    #
    # This is the primary way to build Kubernetes operators - watch for changes to
    # your custom resources and reconcile state.
    #
    # Example:
    # ```
    # crontabs = Kubernetes::Generic(MyCronTab).new(client,
    #   "stable.example.com", "v1", "crontabs")
    #
    # # Watch loop for operator
    # crontabs.watch_namespaced("default") do |event|
    #   case event.type
    #   when .added?, .modified?
    #     reconcile(event.object)
    #   when .deleted?
    #     cleanup(event.object)
    #   end
    # end
    # ```
    def watch_namespaced(namespace : String, resource_version = "0",
                         timeout = 10.minutes, & : Watch(T) -> Nil)
      path = construct_path(namespace)
      @client.watch(path, resource_version, timeout) do |event|
        yield event.as(Watch(T))
      end
    end

    # Paginate through all resources in a namespace.
    #
    # This is a helper method that automatically handles pagination by following
    # continuation tokens. It yields each resource as it's fetched, making it
    # memory-efficient for large result sets.
    #
    # Example:
    # ```
    # pods = Kubernetes::Generic(Pod).new(client, "", "v1", "pods")
    #
    # # Iterate through all pods (100 per page)
    # pods.paginate_namespaced("default", page_size: 100) do |pod|
    #   puts pod.metadata.name
    # end
    #
    # # With label selector
    # pods.paginate_namespaced("default",
    #   label_selector: "app=nginx",
    #   page_size: 500
    # ) do |pod|
    #   process(pod)
    # end
    # ```
    def paginate_namespaced(namespace : String,
                            label_selector : String? = nil,
                            field_selector : String? = nil,
                            page_size : Int32 = 500,
                            &)
      continue_token : String? = nil

      loop do
        list = list_namespaced(
          namespace: namespace,
          label_selector: label_selector,
          field_selector: field_selector,
          limit: page_size,
          continue: continue_token
        )

        list.items.each { |item| yield item }

        # Check for continuation
        if metadata = list.metadata
          break unless metadata.continue
          continue_token = metadata.continue
        else
          break
        end
      end
    end

    # Paginate through all cluster-scoped resources.
    #
    # Example:
    # ```
    # nodes = Kubernetes::Generic(Node).new(client, "", "v1", "nodes")
    #
    # nodes.paginate(page_size: 100) do |node|
    #   puts node.metadata.name
    # end
    # ```
    def paginate(label_selector : String? = nil,
                 field_selector : String? = nil,
                 page_size : Int32 = 500,
                 &)
      continue_token : String? = nil

      loop do
        list = list(
          label_selector: label_selector,
          field_selector: field_selector,
          limit: page_size,
          continue: continue_token
        )

        list.items.each { |item| yield item }

        # Check for continuation
        if metadata = list.metadata
          break unless metadata.continue
          continue_token = metadata.continue
        else
          break
        end
      end
    end

    # Construct the API path for this resource.
    #
    # Core API (api_group = ""):
    #   /api/{version}/namespaces/{namespace}/{resource}
    #
    # Named API groups:
    #   /apis/{group}/{version}/namespaces/{namespace}/{resource}
    private def construct_path(namespace : String? = nil) : String
      # Core API uses /api/{version}
      # Named groups use /apis/{group}/{version}
      base = @api_group.empty? ? "/api" : "/apis/#{@api_group}"
      path = "#{base}/#{@version}"
      path += "/namespaces/#{namespace}" if namespace
      "#{path}/#{@resource}"
    end
  end
end
