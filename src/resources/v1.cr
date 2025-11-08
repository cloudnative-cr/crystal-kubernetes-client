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
  # Facade for v1 API resources.
  #
  # This class provides convenient access to all core and apps/v1 resources
  # through a single, type-safe interface.
  #
  # ## Example
  #
  # ```
  # k8s = Kubernetes::Client.new
  #
  # # Access resources through the v1 API
  # pods = k8s.v1.pods.list_namespaced("default")
  # k8s.v1.deployments.scale("default", "nginx", replicas: 10)
  # logs = k8s.v1.pods.logs("default", "nginx")
  # ```
  class V1
    getter pods : Pods
    getter deployments : Deployments
    getter services : Services
    getter config_maps : ConfigMaps
    getter secrets : Secrets
    getter namespaces : Namespaces

    def initialize(@client : Client)
      @pods = Pods.new(@client)
      @deployments = Deployments.new(@client)
      @services = Services.new(@client)
      @config_maps = ConfigMaps.new(@client)
      @secrets = Secrets.new(@client)
      @namespaces = Namespaces.new(@client)
    end
  end
end
