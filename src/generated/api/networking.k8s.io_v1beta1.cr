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
    # GET /apis/networking.k8s.io/v1beta1/
    def get_api_resources(**params, &)
      path = "/apis/networking.k8s.io/v1beta1/"
      get(path) { |res| yield res }
    end

    # delete collection of IPAddress
    # DELETE /apis/networking.k8s.io/v1beta1/ipaddresses
    def delete_collection_ip_address(**params, &)
      path = "/apis/networking.k8s.io/v1beta1/ipaddresses"
      delete(path) { |res| yield res }
    end

    # list or watch objects of kind IPAddress
    # GET /apis/networking.k8s.io/v1beta1/ipaddresses
    def list_ip_address(**params, &)
      path = "/apis/networking.k8s.io/v1beta1/ipaddresses"
      get(path) { |res| yield res }
    end

    # create an IPAddress
    # POST /apis/networking.k8s.io/v1beta1/ipaddresses
    def create_ip_address(**params, &)
      path = "/apis/networking.k8s.io/v1beta1/ipaddresses"
      post(path, params) { |res| yield res }
    end

    # delete an IPAddress
    # DELETE /apis/networking.k8s.io/v1beta1/ipaddresses/{name}
    def delete_ip_address(**params, &)
      path = "/apis/networking.k8s.io/v1beta1/ipaddresses/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # read the specified IPAddress
    # GET /apis/networking.k8s.io/v1beta1/ipaddresses/{name}
    def read_ip_address(**params, &)
      path = "/apis/networking.k8s.io/v1beta1/ipaddresses/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update the specified IPAddress
    # PATCH /apis/networking.k8s.io/v1beta1/ipaddresses/{name}
    def patch_ip_address(**params, &)
      path = "/apis/networking.k8s.io/v1beta1/ipaddresses/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace the specified IPAddress
    # PUT /apis/networking.k8s.io/v1beta1/ipaddresses/{name}
    def replace_ip_address(**params, &)
      path = "/apis/networking.k8s.io/v1beta1/ipaddresses/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # delete collection of ServiceCIDR
    # DELETE /apis/networking.k8s.io/v1beta1/servicecidrs
    def delete_collection_service_cidr(**params, &)
      path = "/apis/networking.k8s.io/v1beta1/servicecidrs"
      delete(path) { |res| yield res }
    end

    # list or watch objects of kind ServiceCIDR
    # GET /apis/networking.k8s.io/v1beta1/servicecidrs
    def list_service_cidr(**params, &)
      path = "/apis/networking.k8s.io/v1beta1/servicecidrs"
      get(path) { |res| yield res }
    end

    # create a ServiceCIDR
    # POST /apis/networking.k8s.io/v1beta1/servicecidrs
    def create_service_cidr(**params, &)
      path = "/apis/networking.k8s.io/v1beta1/servicecidrs"
      post(path, params) { |res| yield res }
    end

    # delete a ServiceCIDR
    # DELETE /apis/networking.k8s.io/v1beta1/servicecidrs/{name}
    def delete_service_cidr(**params, &)
      path = "/apis/networking.k8s.io/v1beta1/servicecidrs/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # read the specified ServiceCIDR
    # GET /apis/networking.k8s.io/v1beta1/servicecidrs/{name}
    def read_service_cidr(**params, &)
      path = "/apis/networking.k8s.io/v1beta1/servicecidrs/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update the specified ServiceCIDR
    # PATCH /apis/networking.k8s.io/v1beta1/servicecidrs/{name}
    def patch_service_cidr(**params, &)
      path = "/apis/networking.k8s.io/v1beta1/servicecidrs/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace the specified ServiceCIDR
    # PUT /apis/networking.k8s.io/v1beta1/servicecidrs/{name}
    def replace_service_cidr(**params, &)
      path = "/apis/networking.k8s.io/v1beta1/servicecidrs/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # read status of the specified ServiceCIDR
    # GET /apis/networking.k8s.io/v1beta1/servicecidrs/{name}/status
    def read_service_cidr_status(**params, &)
      path = "/apis/networking.k8s.io/v1beta1/servicecidrs/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update status of the specified ServiceCIDR
    # PATCH /apis/networking.k8s.io/v1beta1/servicecidrs/{name}/status
    def patch_service_cidr_status(**params, &)
      path = "/apis/networking.k8s.io/v1beta1/servicecidrs/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace status of the specified ServiceCIDR
    # PUT /apis/networking.k8s.io/v1beta1/servicecidrs/{name}/status
    def replace_service_cidr_status(**params, &)
      path = "/apis/networking.k8s.io/v1beta1/servicecidrs/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end
  end
end
