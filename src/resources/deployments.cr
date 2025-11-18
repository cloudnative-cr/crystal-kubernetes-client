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
  # High-level API for Deployment resources.
  #
  # Provides type-safe methods plus helpful utilities like scale and restart.
  class Deployments
    struct Deployment
      include ::JSON::Serializable

      @[::JSON::Field(key: "apiVersion")]
      property api_version : String?

      property kind : String?
      property metadata : Kubernetes::Metadata
      property spec : DeploymentSpec?
      property status : DeploymentStatus?
    end

    struct DeploymentSpec
      include ::JSON::Serializable

      property replicas : Int32?
      property selector : LabelSelector?
      property template : PodTemplateSpec?
    end

    struct LabelSelector
      include ::JSON::Serializable

      @[::JSON::Field(key: "matchLabels")]
      property match_labels : Hash(String, String)?
    end

    struct PodTemplateSpec
      include ::JSON::Serializable

      property metadata : Kubernetes::Metadata?
      property spec : Kubernetes::Resources::Pods::PodSpec?
    end

    struct DeploymentStatus
      include ::JSON::Serializable

      property replicas : Int32?

      @[::JSON::Field(key: "readyReplicas")]
      property ready_replicas : Int32?

      @[::JSON::Field(key: "availableReplicas")]
      property available_replicas : Int32?

      @[::JSON::Field(key: "updatedReplicas")]
      property updated_replicas : Int32?
    end

    def initialize(@client : Client)
      @generic = Generic(Deployment).new(@client, "apps", "v1", "deployments")
    end

    # List all deployments in a namespace.
    def list_namespaced(namespace : String,
                        label_selector : String? = nil,
                        field_selector : String? = nil,
                        limit : Int32? = nil) : List(Deployment)
      @generic.list_namespaced(
        namespace: namespace,
        label_selector: label_selector,
        field_selector: field_selector,
        limit: limit
      )
    end

    # Read a single deployment.
    def read_namespaced(namespace : String, name : String) : Deployment
      @generic.read_namespaced(namespace, name)
    end

    # Delete a deployment.
    def delete_namespaced(namespace : String, name : String) : Status
      @generic.delete_namespaced(namespace, name)
    end

    # Scale a deployment to a specific number of replicas.
    #
    # This uses a JSON merge patch to update only the replicas field.
    #
    # Example:
    # ```
    # deployment = k8s.v1.deployments.scale("default", "nginx", replicas: 10)
    # puts "Scaled to #{deployment.spec.try(&.replicas)} replicas"
    # ```
    def scale(namespace : String, name : String, replicas : Int32) : Deployment
      patch = {
        "spec" => {
          "replicas" => replicas,
        },
      }

      @generic.patch_namespaced(namespace, name, patch,
        content_type: "application/merge-patch+json")
    end

    # Restart a deployment by adding a restart annotation.
    #
    # This triggers a rollout restart by updating the pod template
    # with a restart timestamp annotation.
    #
    # Example:
    # ```
    # deployment = k8s.v1.deployments.restart("default", "nginx")
    # puts "Deployment restarted"
    # ```
    def restart(namespace : String, name : String) : Deployment
      patch = {
        "spec" => {
          "template" => {
            "metadata" => {
              "annotations" => {
                "kubectl.kubernetes.io/restartedAt" => Time.utc.to_rfc3339,
              },
            },
          },
        },
      }

      @generic.patch_namespaced(namespace, name, patch,
        content_type: "application/strategic-merge-patch+json")
    end

    # Wait for a deployment to be ready.
    #
    # A deployment is considered ready when:
    # - status.readyReplicas == spec.replicas
    # - status.updatedReplicas == spec.replicas
    #
    # Example:
    # ```
    # deployment = k8s.v1.deployments.wait_until_ready("default", "nginx")
    # puts "Deployment is ready!"
    # ```
    def wait_until_ready(namespace : String, name : String, timeout = 5.minutes) : Deployment
      deadline = Time.utc + timeout

      loop do
        deployment = read_namespaced(namespace, name)

        if spec = deployment.spec
          if status = deployment.status
            desired = spec.replicas || 0
            ready = status.ready_replicas || 0
            updated = status.updated_replicas || 0

            if ready == desired && updated == desired
              return deployment
            end
          end
        end

        raise Error.new("Timeout waiting for deployment #{name}") if Time.utc > deadline

        sleep 2.seconds
      end
    end

    # Check if a deployment is ready.
    def ready?(namespace : String, name : String) : Bool
      deployment = read_namespaced(namespace, name)

      if spec = deployment.spec
        if status = deployment.status
          desired = spec.replicas || 0
          ready = status.ready_replicas || 0
          return ready == desired
        end
      end

      false
    rescue
      false
    end

    # Get current replica count.
    def replicas(namespace : String, name : String) : Int32
      deployment = read_namespaced(namespace, name)
      deployment.spec.try(&.replicas) || 0
    end

    # Paginate through deployments.
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
      ) do |deployment|
        yield deployment
      end
    end

    # Watch deployments for changes.
    def watch_namespaced(namespace : String, resource_version = "0",
                         timeout = 10.minutes, & : Watch(Deployment) -> Nil)
      @generic.watch_namespaced(namespace, resource_version, timeout) do |event|
        yield event
      end
    end
  end
end
