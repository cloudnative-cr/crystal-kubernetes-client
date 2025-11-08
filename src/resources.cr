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
  module Resources
    # High-level type-safe API for Kubernetes resources.
    #
    # This module provides convenient, type-safe wrappers around the low-level
    # client API. Instead of using blocks and manual JSON parsing, you get
    # direct access to typed resources.
    #
    # ## Example
    #
    # ```
    # k8s = Kubernetes::Client.new
    #
    # # High-level API - no blocks, type-safe returns
    # pods = k8s.v1.pods.list_namespaced("default")
    # pods.items.each { |pod| puts pod.metadata.name }
    #
    # # Helper methods
    # ready_pod = k8s.v1.pods.wait_until_ready("default", "nginx")
    # logs = k8s.v1.pods.logs("default", "nginx")
    #
    # # Scale deployment
    # k8s.v1.deployments.scale("default", "nginx", replicas: 10)
    # ```
  end
end

require "./resources/pods"
require "./resources/deployments"
require "./resources/services"
require "./resources/config_maps"
require "./resources/secrets"
require "./resources/namespaces"
require "./resources/v1"
