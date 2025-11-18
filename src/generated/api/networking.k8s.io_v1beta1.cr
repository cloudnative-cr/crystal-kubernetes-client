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
    def get_networking_v1beta1_api_resources(**params, &)
      path = "/apis/networking.k8s.io/v1beta1/"
      get(path) { |res| yield res }
    end

    # delete collection of IPAddress
    # DELETE /apis/networking.k8s.io/v1beta1/ipaddresses
    def delete_networking_v1beta1_collection_ip_address(**params, &)
      path = "/apis/networking.k8s.io/v1beta1/ipaddresses"
      delete(path) { |res| yield res }
    end

    # list or watch objects of kind IPAddress
    # GET /apis/networking.k8s.io/v1beta1/ipaddresses
    def list_networking_v1beta1_ip_address(**params, &)
      path = "/apis/networking.k8s.io/v1beta1/ipaddresses"
      get(path) { |res| yield res }
    end

    # create an IPAddress
    # POST /apis/networking.k8s.io/v1beta1/ipaddresses
    def create_networking_v1beta1_ip_address(**params, &)
      path = "/apis/networking.k8s.io/v1beta1/ipaddresses"
      post(path, params) { |res| yield res }
    end

    # delete an IPAddress
    # DELETE /apis/networking.k8s.io/v1beta1/ipaddresses/{name}
    def delete_networking_v1beta1_ip_address(**params, &)
      path = "/apis/networking.k8s.io/v1beta1/ipaddresses/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # read the specified IPAddress
    # GET /apis/networking.k8s.io/v1beta1/ipaddresses/{name}
    def read_networking_v1beta1_ip_address(**params, &)
      path = "/apis/networking.k8s.io/v1beta1/ipaddresses/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update the specified IPAddress
    # PATCH /apis/networking.k8s.io/v1beta1/ipaddresses/{name}
    def patch_networking_v1beta1_ip_address(**params, &)
      path = "/apis/networking.k8s.io/v1beta1/ipaddresses/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace the specified IPAddress
    # PUT /apis/networking.k8s.io/v1beta1/ipaddresses/{name}
    def replace_networking_v1beta1_ip_address(**params, &)
      path = "/apis/networking.k8s.io/v1beta1/ipaddresses/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # delete collection of ServiceCIDR
    # DELETE /apis/networking.k8s.io/v1beta1/servicecidrs
    def delete_networking_v1beta1_collection_service_cidr(**params, &)
      path = "/apis/networking.k8s.io/v1beta1/servicecidrs"
      delete(path) { |res| yield res }
    end

    # list or watch objects of kind ServiceCIDR
    # GET /apis/networking.k8s.io/v1beta1/servicecidrs
    def list_networking_v1beta1_service_cidr(**params, &)
      path = "/apis/networking.k8s.io/v1beta1/servicecidrs"
      get(path) { |res| yield res }
    end

    # create a ServiceCIDR
    # POST /apis/networking.k8s.io/v1beta1/servicecidrs
    def create_networking_v1beta1_service_cidr(**params, &)
      path = "/apis/networking.k8s.io/v1beta1/servicecidrs"
      post(path, params) { |res| yield res }
    end

    # delete a ServiceCIDR
    # DELETE /apis/networking.k8s.io/v1beta1/servicecidrs/{name}
    def delete_networking_v1beta1_service_cidr(**params, &)
      path = "/apis/networking.k8s.io/v1beta1/servicecidrs/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # read the specified ServiceCIDR
    # GET /apis/networking.k8s.io/v1beta1/servicecidrs/{name}
    def read_networking_v1beta1_service_cidr(**params, &)
      path = "/apis/networking.k8s.io/v1beta1/servicecidrs/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update the specified ServiceCIDR
    # PATCH /apis/networking.k8s.io/v1beta1/servicecidrs/{name}
    def patch_networking_v1beta1_service_cidr(**params, &)
      path = "/apis/networking.k8s.io/v1beta1/servicecidrs/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace the specified ServiceCIDR
    # PUT /apis/networking.k8s.io/v1beta1/servicecidrs/{name}
    def replace_networking_v1beta1_service_cidr(**params, &)
      path = "/apis/networking.k8s.io/v1beta1/servicecidrs/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # read status of the specified ServiceCIDR
    # GET /apis/networking.k8s.io/v1beta1/servicecidrs/{name}/status
    def read_networking_v1beta1_service_cidr_status(**params, &)
      path = "/apis/networking.k8s.io/v1beta1/servicecidrs/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update status of the specified ServiceCIDR
    # PATCH /apis/networking.k8s.io/v1beta1/servicecidrs/{name}/status
    def patch_networking_v1beta1_service_cidr_status(**params, &)
      path = "/apis/networking.k8s.io/v1beta1/servicecidrs/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace status of the specified ServiceCIDR
    # PUT /apis/networking.k8s.io/v1beta1/servicecidrs/{name}/status
    def replace_networking_v1beta1_service_cidr_status(**params, &)
      path = "/apis/networking.k8s.io/v1beta1/servicecidrs/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # watch individual changes to a list of IPAddress. deprecated: use the 'watch' parameter with a list operation instead.
    # GET /apis/networking.k8s.io/v1beta1/watch/ipaddresses
    def watch_networking_v1beta1_ip_address_list(**params, &)
      path = "/apis/networking.k8s.io/v1beta1/watch/ipaddresses"
      get(path) { |res| yield res }
    end

    # watch changes to an object of kind IPAddress. deprecated: use the 'watch' parameter with a list operation instead, filtered to a single item with the 'fieldSelector' parameter.
    # GET /apis/networking.k8s.io/v1beta1/watch/ipaddresses/{name}
    def watch_networking_v1beta1_ip_address(**params, &)
      path = "/apis/networking.k8s.io/v1beta1/watch/ipaddresses/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # watch individual changes to a list of ServiceCIDR. deprecated: use the 'watch' parameter with a list operation instead.
    # GET /apis/networking.k8s.io/v1beta1/watch/servicecidrs
    def watch_networking_v1beta1_service_cidr_list(**params, &)
      path = "/apis/networking.k8s.io/v1beta1/watch/servicecidrs"
      get(path) { |res| yield res }
    end

    # watch changes to an object of kind ServiceCIDR. deprecated: use the 'watch' parameter with a list operation instead, filtered to a single item with the 'fieldSelector' parameter.
    # GET /apis/networking.k8s.io/v1beta1/watch/servicecidrs/{name}
    def watch_networking_v1beta1_service_cidr(**params, &)
      path = "/apis/networking.k8s.io/v1beta1/watch/servicecidrs/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end
  end
end
