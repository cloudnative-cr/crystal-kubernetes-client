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

require "../../serialization"

module Kubernetes
  # TokenRequest contains parameters of a service account token.
  struct TokenRequest
    include Kubernetes::Serializable

    # audience is the intended audience of the token in "TokenRequestSpec". It will default to the audiences of kube apiserver.
    property audience : String?
    # expirationSeconds is the duration of validity of the token in "TokenRequestSpec". It has the same default value of "ExpirationSeconds" in "TokenRequestSpec".
    @[JSON::Field(key: "expirationSeconds")]
    @[YAML::Field(key: "expirationSeconds")]
    property expiration_seconds : Int64?
  end
end
