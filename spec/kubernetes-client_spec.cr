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

require "./spec_helper"

describe Kubernetes do
  it "has version constant" do
    Kubernetes::VERSION.should be_a(String)
  end

  it "defines core classes" do
    Kubernetes::Client.should_not be_nil
    Kubernetes::Watch.should_not be_nil
  end

  it "defines error classes" do
    Kubernetes::Error.should_not be_nil
    Kubernetes::ConfigError.should_not be_nil
    Kubernetes::ClientError.should_not be_nil
    Kubernetes::AuthenticationError.should_not be_nil
  end

  it "defines in-cluster constants" do
    Kubernetes::Client::IN_CLUSTER_TOKEN_PATH.should eq("/var/run/secrets/kubernetes.io/serviceaccount/token")
    Kubernetes::Client::IN_CLUSTER_CA_CERT_PATH.should eq("/var/run/secrets/kubernetes.io/serviceaccount/ca.crt")
    Kubernetes::Client::IN_CLUSTER_NAMESPACE_PATH.should eq("/var/run/secrets/kubernetes.io/serviceaccount/namespace")
  end
end
