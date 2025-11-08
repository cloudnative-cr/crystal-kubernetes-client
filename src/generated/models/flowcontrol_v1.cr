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
  # Subject matches the originator of a request, as identified by the request authentication system. There are three ways of matching an originator; by user, group, or service account.
  struct Subject
    include Kubernetes::Serializable

    # `group` matches based on user group name.
    property group : GroupSubject?
    # `kind` indicates which one of the other fields is non-empty. Required
    property kind : String?
    # `serviceAccount` matches ServiceAccounts.
    @[JSON::Field(key: "serviceAccount")]
    @[YAML::Field(key: "serviceAccount")]
    property service_account : ServiceAccountSubject?
    # `user` matches based on username.
    property user : UserSubject?
  end
end
