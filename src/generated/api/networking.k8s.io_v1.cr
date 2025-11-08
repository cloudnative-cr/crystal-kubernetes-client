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
    # GET /apis/networking.k8s.io/v1/
    def get_api_resources(**params, &)
      path = "/apis/networking.k8s.io/v1/"
      get(path) { |res| yield res }
    end

    # delete collection of IngressClass
    # DELETE /apis/networking.k8s.io/v1/ingressclasses
    def delete_collection_ingress_class(**params, &)
      path = "/apis/networking.k8s.io/v1/ingressclasses"
      delete(path) { |res| yield res }
    end

    # list or watch objects of kind IngressClass
    # GET /apis/networking.k8s.io/v1/ingressclasses
    def list_ingress_class(**params, &)
      path = "/apis/networking.k8s.io/v1/ingressclasses"
      get(path) { |res| yield res }
    end

    # create an IngressClass
    # POST /apis/networking.k8s.io/v1/ingressclasses
    def create_ingress_class(**params, &)
      path = "/apis/networking.k8s.io/v1/ingressclasses"
      post(path, params) { |res| yield res }
    end

    # delete an IngressClass
    # DELETE /apis/networking.k8s.io/v1/ingressclasses/{name}
    def delete_ingress_class(**params, &)
      path = "/apis/networking.k8s.io/v1/ingressclasses/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # read the specified IngressClass
    # GET /apis/networking.k8s.io/v1/ingressclasses/{name}
    def read_ingress_class(**params, &)
      path = "/apis/networking.k8s.io/v1/ingressclasses/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update the specified IngressClass
    # PATCH /apis/networking.k8s.io/v1/ingressclasses/{name}
    def patch_ingress_class(**params, &)
      path = "/apis/networking.k8s.io/v1/ingressclasses/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace the specified IngressClass
    # PUT /apis/networking.k8s.io/v1/ingressclasses/{name}
    def replace_ingress_class(**params, &)
      path = "/apis/networking.k8s.io/v1/ingressclasses/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # list or watch objects of kind Ingress
    # GET /apis/networking.k8s.io/v1/ingresses
    def list_ingress_for_all_namespaces(**params, &)
      path = "/apis/networking.k8s.io/v1/ingresses"
      get(path) { |res| yield res }
    end

    # delete collection of IPAddress
    # DELETE /apis/networking.k8s.io/v1/ipaddresses
    def delete_collection_ip_address(**params, &)
      path = "/apis/networking.k8s.io/v1/ipaddresses"
      delete(path) { |res| yield res }
    end

    # list or watch objects of kind IPAddress
    # GET /apis/networking.k8s.io/v1/ipaddresses
    def list_ip_address(**params, &)
      path = "/apis/networking.k8s.io/v1/ipaddresses"
      get(path) { |res| yield res }
    end

    # create an IPAddress
    # POST /apis/networking.k8s.io/v1/ipaddresses
    def create_ip_address(**params, &)
      path = "/apis/networking.k8s.io/v1/ipaddresses"
      post(path, params) { |res| yield res }
    end

    # delete an IPAddress
    # DELETE /apis/networking.k8s.io/v1/ipaddresses/{name}
    def delete_ip_address(**params, &)
      path = "/apis/networking.k8s.io/v1/ipaddresses/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # read the specified IPAddress
    # GET /apis/networking.k8s.io/v1/ipaddresses/{name}
    def read_ip_address(**params, &)
      path = "/apis/networking.k8s.io/v1/ipaddresses/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update the specified IPAddress
    # PATCH /apis/networking.k8s.io/v1/ipaddresses/{name}
    def patch_ip_address(**params, &)
      path = "/apis/networking.k8s.io/v1/ipaddresses/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace the specified IPAddress
    # PUT /apis/networking.k8s.io/v1/ipaddresses/{name}
    def replace_ip_address(**params, &)
      path = "/apis/networking.k8s.io/v1/ipaddresses/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # delete collection of Ingress
    # DELETE /apis/networking.k8s.io/v1/namespaces/{namespace}/ingresses
    def delete_collection_namespaced_ingress(**params, &)
      path = "/apis/networking.k8s.io/v1/namespaces/{namespace}/ingresses"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # list or watch objects of kind Ingress
    # GET /apis/networking.k8s.io/v1/namespaces/{namespace}/ingresses
    def list_namespaced_ingress(**params, &)
      path = "/apis/networking.k8s.io/v1/namespaces/{namespace}/ingresses"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # create an Ingress
    # POST /apis/networking.k8s.io/v1/namespaces/{namespace}/ingresses
    def create_namespaced_ingress(**params, &)
      path = "/apis/networking.k8s.io/v1/namespaces/{namespace}/ingresses"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      post(path, params) { |res| yield res }
    end

    # delete an Ingress
    # DELETE /apis/networking.k8s.io/v1/namespaces/{namespace}/ingresses/{name}
    def delete_namespaced_ingress(**params, &)
      path = "/apis/networking.k8s.io/v1/namespaces/{namespace}/ingresses/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # read the specified Ingress
    # GET /apis/networking.k8s.io/v1/namespaces/{namespace}/ingresses/{name}
    def read_namespaced_ingress(**params, &)
      path = "/apis/networking.k8s.io/v1/namespaces/{namespace}/ingresses/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update the specified Ingress
    # PATCH /apis/networking.k8s.io/v1/namespaces/{namespace}/ingresses/{name}
    def patch_namespaced_ingress(**params, &)
      path = "/apis/networking.k8s.io/v1/namespaces/{namespace}/ingresses/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace the specified Ingress
    # PUT /apis/networking.k8s.io/v1/namespaces/{namespace}/ingresses/{name}
    def replace_namespaced_ingress(**params, &)
      path = "/apis/networking.k8s.io/v1/namespaces/{namespace}/ingresses/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # read status of the specified Ingress
    # GET /apis/networking.k8s.io/v1/namespaces/{namespace}/ingresses/{name}/status
    def read_namespaced_ingress_status(**params, &)
      path = "/apis/networking.k8s.io/v1/namespaces/{namespace}/ingresses/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update status of the specified Ingress
    # PATCH /apis/networking.k8s.io/v1/namespaces/{namespace}/ingresses/{name}/status
    def patch_namespaced_ingress_status(**params, &)
      path = "/apis/networking.k8s.io/v1/namespaces/{namespace}/ingresses/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace status of the specified Ingress
    # PUT /apis/networking.k8s.io/v1/namespaces/{namespace}/ingresses/{name}/status
    def replace_namespaced_ingress_status(**params, &)
      path = "/apis/networking.k8s.io/v1/namespaces/{namespace}/ingresses/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # delete collection of NetworkPolicy
    # DELETE /apis/networking.k8s.io/v1/namespaces/{namespace}/networkpolicies
    def delete_collection_namespaced_network_policy(**params, &)
      path = "/apis/networking.k8s.io/v1/namespaces/{namespace}/networkpolicies"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # list or watch objects of kind NetworkPolicy
    # GET /apis/networking.k8s.io/v1/namespaces/{namespace}/networkpolicies
    def list_namespaced_network_policy(**params, &)
      path = "/apis/networking.k8s.io/v1/namespaces/{namespace}/networkpolicies"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # create a NetworkPolicy
    # POST /apis/networking.k8s.io/v1/namespaces/{namespace}/networkpolicies
    def create_namespaced_network_policy(**params, &)
      path = "/apis/networking.k8s.io/v1/namespaces/{namespace}/networkpolicies"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      post(path, params) { |res| yield res }
    end

    # delete a NetworkPolicy
    # DELETE /apis/networking.k8s.io/v1/namespaces/{namespace}/networkpolicies/{name}
    def delete_namespaced_network_policy(**params, &)
      path = "/apis/networking.k8s.io/v1/namespaces/{namespace}/networkpolicies/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # read the specified NetworkPolicy
    # GET /apis/networking.k8s.io/v1/namespaces/{namespace}/networkpolicies/{name}
    def read_namespaced_network_policy(**params, &)
      path = "/apis/networking.k8s.io/v1/namespaces/{namespace}/networkpolicies/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update the specified NetworkPolicy
    # PATCH /apis/networking.k8s.io/v1/namespaces/{namespace}/networkpolicies/{name}
    def patch_namespaced_network_policy(**params, &)
      path = "/apis/networking.k8s.io/v1/namespaces/{namespace}/networkpolicies/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace the specified NetworkPolicy
    # PUT /apis/networking.k8s.io/v1/namespaces/{namespace}/networkpolicies/{name}
    def replace_namespaced_network_policy(**params, &)
      path = "/apis/networking.k8s.io/v1/namespaces/{namespace}/networkpolicies/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # list or watch objects of kind NetworkPolicy
    # GET /apis/networking.k8s.io/v1/networkpolicies
    def list_network_policy_for_all_namespaces(**params, &)
      path = "/apis/networking.k8s.io/v1/networkpolicies"
      get(path) { |res| yield res }
    end

    # delete collection of ServiceCIDR
    # DELETE /apis/networking.k8s.io/v1/servicecidrs
    def delete_collection_service_cidr(**params, &)
      path = "/apis/networking.k8s.io/v1/servicecidrs"
      delete(path) { |res| yield res }
    end

    # list or watch objects of kind ServiceCIDR
    # GET /apis/networking.k8s.io/v1/servicecidrs
    def list_service_cidr(**params, &)
      path = "/apis/networking.k8s.io/v1/servicecidrs"
      get(path) { |res| yield res }
    end

    # create a ServiceCIDR
    # POST /apis/networking.k8s.io/v1/servicecidrs
    def create_service_cidr(**params, &)
      path = "/apis/networking.k8s.io/v1/servicecidrs"
      post(path, params) { |res| yield res }
    end

    # delete a ServiceCIDR
    # DELETE /apis/networking.k8s.io/v1/servicecidrs/{name}
    def delete_service_cidr(**params, &)
      path = "/apis/networking.k8s.io/v1/servicecidrs/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # read the specified ServiceCIDR
    # GET /apis/networking.k8s.io/v1/servicecidrs/{name}
    def read_service_cidr(**params, &)
      path = "/apis/networking.k8s.io/v1/servicecidrs/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update the specified ServiceCIDR
    # PATCH /apis/networking.k8s.io/v1/servicecidrs/{name}
    def patch_service_cidr(**params, &)
      path = "/apis/networking.k8s.io/v1/servicecidrs/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace the specified ServiceCIDR
    # PUT /apis/networking.k8s.io/v1/servicecidrs/{name}
    def replace_service_cidr(**params, &)
      path = "/apis/networking.k8s.io/v1/servicecidrs/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # read status of the specified ServiceCIDR
    # GET /apis/networking.k8s.io/v1/servicecidrs/{name}/status
    def read_service_cidr_status(**params, &)
      path = "/apis/networking.k8s.io/v1/servicecidrs/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update status of the specified ServiceCIDR
    # PATCH /apis/networking.k8s.io/v1/servicecidrs/{name}/status
    def patch_service_cidr_status(**params, &)
      path = "/apis/networking.k8s.io/v1/servicecidrs/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace status of the specified ServiceCIDR
    # PUT /apis/networking.k8s.io/v1/servicecidrs/{name}/status
    def replace_service_cidr_status(**params, &)
      path = "/apis/networking.k8s.io/v1/servicecidrs/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end
  end
end
