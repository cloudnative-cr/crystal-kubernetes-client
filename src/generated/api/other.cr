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
    # get service account issuer OpenID configuration, also known as the 'OIDC discovery doc'
    # GET /.well-known/openid-configuration/
    def get_service_account_issuer_open_id_configuration(**params, &)
      path = "/.well-known/openid-configuration/"
      get(path) { |res| yield res }
    end

    # get available API versions
    # GET /api/
    def get_core_api_versions(**params, &)
      path = "/api/"
      get(path) { |res| yield res }
    end

    # GET /logs/
    def log_file_list_handler(**params, &)
      path = "/logs/"
      get(path) { |res| yield res }
    end

    # GET /logs/{logpath}
    def log_file_handler(**params, &)
      path = "/logs/{logpath}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # get service account issuer OpenID JSON Web Key Set (contains public token verification keys)
    # GET /openid/v1/jwks/
    def get_service_account_issuer_open_id_keyset(**params, &)
      path = "/openid/v1/jwks/"
      get(path) { |res| yield res }
    end

    # get the version information for this server
    # GET /version/
    def get_code_version(**params, &)
      path = "/version/"
      get(path) { |res| yield res }
    end
  end
end
