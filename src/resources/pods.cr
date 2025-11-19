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

module Kubernetes::Resources
  # High-level API for Pod resources.
  #
  # Provides type-safe methods for working with Pods without blocks,
  # plus helpful utility methods like waiting for readiness and fetching logs.
  class Pods
    struct Pod
      include ::JSON::Serializable

      @[::JSON::Field(key: "apiVersion")]
      property api_version : String?

      property kind : String?
      property metadata : Kubernetes::Metadata
      property spec : PodSpec?
      property status : PodStatus?
    end

    struct PodSpec
      include ::JSON::Serializable

      property containers : Array(Container)?
      property node_name : String?

      @[::JSON::Field(key: "restartPolicy")]
      property restart_policy : String?

      @[::JSON::Field(key: "serviceAccountName")]
      property service_account_name : String?
    end

    struct Container
      include ::JSON::Serializable

      property name : String
      property image : String
      property command : Array(String)?
      property args : Array(String)?
    end

    struct PodStatus
      include ::JSON::Serializable

      property phase : String?

      @[::JSON::Field(key: "podIP")]
      property pod_ip : String?

      @[::JSON::Field(key: "containerStatuses")]
      property container_statuses : Array(ContainerStatus)?
    end

    struct ContainerStatus
      include ::JSON::Serializable

      property name : String
      property? ready : Bool
      property state : ContainerState?
    end

    struct ContainerState
      include ::JSON::Serializable

      property running : ContainerStateRunning?
      property waiting : ContainerStateWaiting?
      property terminated : ContainerStateTerminated?
    end

    struct ContainerStateRunning
      include ::JSON::Serializable

      @[::JSON::Field(key: "startedAt")]
      property started_at : String?
    end

    struct ContainerStateWaiting
      include ::JSON::Serializable

      property reason : String?
      property message : String?
    end

    struct ContainerStateTerminated
      include ::JSON::Serializable

      @[::JSON::Field(key: "exitCode")]
      property exit_code : Int32?

      property reason : String?
      property message : String?
    end

    def initialize(@client : Client)
      @generic = Generic(Pod).new(@client, "", "v1", "pods")
    end

    # List all pods in a namespace.
    #
    # Example:
    # ```
    # pods = k8s.v1.pods.list_namespaced("default")
    # pods.items.each { |pod| puts pod.metadata.name }
    # ```
    def list_namespaced(namespace : String,
                        label_selector : String? = nil,
                        field_selector : String? = nil,
                        limit : Int32? = nil) : List(Pod)
      @generic.list_namespaced(
        namespace: namespace,
        label_selector: label_selector,
        field_selector: field_selector,
        limit: limit
      )
    end

    # Read a single pod.
    #
    # Example:
    # ```
    # pod = k8s.v1.pods.read_namespaced("default", "nginx-12345")
    # puts pod.status.try(&.phase)
    # ```
    def read_namespaced(namespace : String, name : String) : Pod
      @generic.read_namespaced(namespace, name)
    end

    # Delete a pod.
    #
    # Example:
    # ```
    # status = k8s.v1.pods.delete_namespaced("default", "nginx-12345")
    # ```
    def delete_namespaced(namespace : String, name : String) : Status
      @generic.delete_namespaced(namespace, name)
    end

    # Wait for a pod to be ready.
    #
    # This method polls the pod status until all containers are ready
    # or the timeout is reached.
    #
    # Example:
    # ```
    # pod = k8s.v1.pods.wait_until_ready("default", "nginx", timeout: 5.minutes)
    # puts "Pod is ready!"
    # ```
    def wait_until_ready(namespace : String, name : String, timeout = 5.minutes) : Pod
      deadline = ::Time.utc + timeout

      loop do
        pod = read_namespaced(namespace, name)

        # Check if all containers are ready
        if status = pod.status
          if container_statuses = status.container_statuses
            if container_statuses.all?(&.ready)
              return pod
            end
          end
        end

        raise Error.new("Timeout waiting for pod #{name} to be ready") if ::Time.utc > deadline

        sleep 1.second
      end
    end

    # Wait for a pod to reach Running phase.
    #
    # Example:
    # ```
    # pod = k8s.v1.pods.wait_until_running("default", "nginx")
    # ```
    def wait_until_running(namespace : String, name : String, timeout = 5.minutes) : Pod
      deadline = ::Time.utc + timeout

      loop do
        pod = read_namespaced(namespace, name)

        if pod.status.try(&.phase) == "Running"
          return pod
        end

        raise Error.new("Timeout waiting for pod #{name} to be running") if ::Time.utc > deadline

        sleep 1.second
      end
    end

    # Get logs from a pod.
    #
    # Example:
    # ```
    # logs = k8s.v1.pods.logs("default", "nginx")
    # puts logs
    #
    # # Get logs from specific container
    # logs = k8s.v1.pods.logs("default", "nginx", container: "app")
    # ```
    def logs(namespace : String, name : String, container : String? = nil,
             follow : Bool = false, tail_lines : Int32? = nil) : String
      path = "/api/v1/namespaces/#{namespace}/pods/#{name}/log"

      params = {} of String => String
      params["container"] = container if container
      params["follow"] = "true" if follow
      params["tailLines"] = tail_lines.to_s if tail_lines

      params_string = params.empty? ? nil : URI::Params.encode(params)

      @client.get(path, params_string) do |res|
        res.body_io.gets_to_end
      end
    end

    # Execute a command in a pod (requires WebSocket support - planned for v1.0.0).
    #
    # Example:
    # ```
    # output = k8s.v1.pods.exec("default", "nginx", ["ls", "-la"])
    # ```
    def exec(namespace : String, name : String, command : Array(String),
             container : String? = nil) : String
      raise Error.new("exec() requires WebSocket support (planned for v1.0.0)")
    end

    # Check if a pod is ready.
    #
    # Example:
    # ```
    # if k8s.v1.pods.ready?("default", "nginx")
    #   puts "Pod is ready"
    # end
    # ```
    def ready?(namespace : String, name : String) : Bool
      pod = read_namespaced(namespace, name)

      if status = pod.status
        if container_statuses = status.container_statuses
          return container_statuses.all?(&.ready)
        end
      end

      false
    rescue
      false
    end

    # Check if a pod is running.
    #
    # Example:
    # ```
    # if k8s.v1.pods.running?("default", "nginx")
    #   puts "Pod is running"
    # end
    # ```
    def running?(namespace : String, name : String) : Bool
      pod = read_namespaced(namespace, name)
      pod.status.try(&.phase) == "Running"
    rescue
      false
    end

    # Paginate through all pods in a namespace.
    #
    # Example:
    # ```
    # k8s.v1.pods.paginate_namespaced("default", page_size: 100) do |pod|
    #   puts pod.metadata.name
    # end
    # ```
    def paginate_namespaced(namespace : String,
                            label_selector : String? = nil,
                            field_selector : String? = nil,
                            page_size : Int32 = 500,
                            &)
      @generic.paginate_namespaced(
        namespace: namespace,
        label_selector: label_selector,
        field_selector: field_selector,
        page_size: page_size
      ) do |pod|
        yield pod
      end
    end

    # Watch pods for changes.
    #
    # Example:
    # ```
    # k8s.v1.pods.watch_namespaced("default") do |event|
    #   case event.type
    #   when .added? then puts "New pod: #{event.object.metadata.name}"
    #   end
    # end
    # ```
    def watch_namespaced(namespace : String, resource_version = "0",
                         timeout = 10.minutes, & : Watch(Pod) -> Nil)
      @generic.watch_namespaced(namespace, resource_version, timeout) do |event|
        yield event
      end
    end
  end
end
