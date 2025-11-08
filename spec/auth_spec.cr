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

describe Kubernetes::Auth do
  describe ".from_user" do
    it "builds auth from bearer token" do
      user = Kubernetes::Config::UserEntry::User.from_yaml(<<-YAML
        token: "test-token-12345"
      YAML
      )

      auth = Kubernetes::Auth.from_user(user)
      auth.token.should eq("test-token-12345")
      auth.username.should be_nil
      auth.client_cert_file.should be_nil
    end

    it "builds auth from token file" do
      # Create temporary token file
      token_file = File.tempfile("k8s-token-test", ".txt")
      File.write(token_file.path, "file-token-67890\n")

      user = Kubernetes::Config::UserEntry::User.from_yaml(<<-YAML
        tokenFile: #{token_file.path}
      YAML
      )

      auth = Kubernetes::Auth.from_user(user)
      auth.token.should eq("file-token-67890")
    end

    it "builds auth from client certificate files" do
      # Create temporary cert and key files
      cert_file = File.tempfile("k8s-cert-test", ".pem")
      key_file = File.tempfile("k8s-key-test", ".pem")

      # Minimal PEM format (not a real cert, just for testing structure)
      File.write(cert_file.path, "-----BEGIN CERTIFICATE-----\ntest\n-----END CERTIFICATE-----")
      File.write(key_file.path, "-----BEGIN PRIVATE KEY-----\ntest\n-----END PRIVATE KEY-----")

      user = Kubernetes::Config::UserEntry::User.from_yaml(<<-YAML
        client-certificate: #{cert_file.path}
        client-key: #{key_file.path}
      YAML
      )

      auth = Kubernetes::Auth.from_user(user)
      auth.token.should be_nil
      auth.client_cert_file.should eq(File.expand_path(cert_file.path))
      auth.client_key_file.should eq(File.expand_path(key_file.path))
    end

    it "builds auth from embedded client certificate data" do
      cert_data = Base64.strict_encode("-----BEGIN CERTIFICATE-----\ntest\n-----END CERTIFICATE-----")
      key_data = Base64.strict_encode("-----BEGIN PRIVATE KEY-----\ntest\n-----END PRIVATE KEY-----")

      user = Kubernetes::Config::UserEntry::User.from_yaml(<<-YAML
        client-certificate-data: #{cert_data}
        client-key-data: #{key_data}
      YAML
      )

      auth = Kubernetes::Auth.from_user(user)
      auth.token.should be_nil
      auth.client_cert_file.should_not be_nil
      auth.client_key_file.should_not be_nil

      # Verify temp files contain correct data
      if cert_file = auth.client_cert_file
        File.read(cert_file).should eq("-----BEGIN CERTIFICATE-----\ntest\n-----END CERTIFICATE-----")
      end
    end

    it "builds auth from basic auth" do
      user = Kubernetes::Config::UserEntry::User.from_yaml(<<-YAML
        username: admin
        password: secret123
      YAML
      )

      auth = Kubernetes::Auth.from_user(user)
      auth.username.should eq("admin")
      auth.password.should eq("secret123")
      auth.token.should be_nil
    end

    it "returns empty auth when no credentials provided" do
      user = Kubernetes::Config::UserEntry::User.from_yaml("{}")
      auth = Kubernetes::Auth.from_user(user)

      auth.token.should be_nil
      auth.username.should be_nil
      auth.client_cert_file.should be_nil
    end
  end

  describe "#apply_headers" do
    it "applies bearer token to headers" do
      auth = Kubernetes::Auth.new(token: "my-token")
      headers = HTTP::Headers.new

      auth.apply_headers(headers)
      headers["Authorization"].should eq("Bearer my-token")
    end

    it "applies basic auth to headers" do
      auth = Kubernetes::Auth.new(username: "user", password: "pass")
      headers = HTTP::Headers.new

      auth.apply_headers(headers)
      expected = "Basic #{Base64.strict_encode("user:pass")}"
      headers["Authorization"].should eq(expected)
    end

    it "does not set headers when no auth provided" do
      auth = Kubernetes::Auth.new
      headers = HTTP::Headers.new

      auth.apply_headers(headers)
      headers.has_key?("Authorization").should be_false
    end
  end
end
