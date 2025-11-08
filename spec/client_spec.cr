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

describe Kubernetes::Client do
  describe "#initialize" do
    it "creates client with server URI and token" do
      client = Kubernetes::Client.new(
        server: URI.parse("https://kubernetes.default.svc"),
        token: "test-token"
      )
      client.server.to_s.should eq("https://kubernetes.default.svc")
    end

    it "auto-configures TLS for HTTPS connections" do
      client = Kubernetes::Client.new(
        server: URI.parse("https://kubernetes.default.svc"),
        token: "test-token"
      )
      # Should not raise - TLS auto-configured
      client.server.scheme.should eq("https")
    end

    it "accepts custom TLS context" do
      tls = OpenSSL::SSL::Context::Client.new
      client = Kubernetes::Client.new(
        server: URI.parse("https://kubernetes.default.svc"),
        token: "test-token",
        tls: tls
      )
      client.server.scheme.should eq("https")
    end

    it "works with HTTP (no TLS)" do
      client = Kubernetes::Client.new(
        server: URI.parse("http://localhost:8080"),
        token: ""
      )
      client.server.scheme.should eq("http")
    end
  end

  describe ".from_config" do
    it "raises ConfigError when context not found" do
      # Create a minimal kubeconfig
      File.write("/tmp/test-kubeconfig.yaml", <<-YAML
        apiVersion: v1
        kind: Config
        current-context: default
        contexts:
        - name: other-context
          context:
            cluster: test-cluster
            user: test-user
        clusters:
        - name: test-cluster
          cluster:
            server: https://localhost:6443
        users:
        - name: test-user
          user:
            token: test-token
        YAML
      )

      expect_raises(Kubernetes::ConfigError, /Context 'nonexistent' not found/) do
        Kubernetes::Client.from_config(
          file: "/tmp/test-kubeconfig.yaml",
          context: "nonexistent"
        )
      end
    ensure
      File.delete("/tmp/test-kubeconfig.yaml") if File.exists?("/tmp/test-kubeconfig.yaml")
    end

    it "raises ConfigError when cluster not found" do
      File.write("/tmp/test-kubeconfig.yaml", <<-YAML
        apiVersion: v1
        kind: Config
        current-context: default
        contexts:
        - name: default
          context:
            cluster: nonexistent-cluster
            user: test-user
        clusters:
        - name: test-cluster
          cluster:
            server: https://localhost:6443
        users:
        - name: test-user
          user:
            token: test-token
        YAML
      )

      expect_raises(Kubernetes::ConfigError, /Cluster 'nonexistent-cluster' not found/) do
        Kubernetes::Client.from_config(file: "/tmp/test-kubeconfig.yaml")
      end
    ensure
      File.delete("/tmp/test-kubeconfig.yaml") if File.exists?("/tmp/test-kubeconfig.yaml")
    end

    it "raises ConfigError when user not found" do
      File.write("/tmp/test-kubeconfig.yaml", <<-YAML
        apiVersion: v1
        kind: Config
        current-context: default
        contexts:
        - name: default
          context:
            cluster: test-cluster
            user: nonexistent-user
        clusters:
        - name: test-cluster
          cluster:
            server: https://localhost:6443
        users:
        - name: test-user
          user:
            token: test-token
        YAML
      )

      expect_raises(Kubernetes::ConfigError, /User 'nonexistent-user' not found/) do
        Kubernetes::Client.from_config(file: "/tmp/test-kubeconfig.yaml")
      end
    ensure
      File.delete("/tmp/test-kubeconfig.yaml") if File.exists?("/tmp/test-kubeconfig.yaml")
    end

    it "loads valid kubeconfig successfully" do
      File.write("/tmp/test-kubeconfig.yaml", <<-YAML
        apiVersion: v1
        kind: Config
        current-context: default
        contexts:
        - name: default
          context:
            cluster: test-cluster
            user: test-user
        clusters:
        - name: test-cluster
          cluster:
            server: https://localhost:6443
        users:
        - name: test-user
          user:
            token: test-token-12345
        YAML
      )

      client = Kubernetes::Client.from_config(file: "/tmp/test-kubeconfig.yaml")
      client.server.to_s.should eq("https://localhost:6443")
    ensure
      File.delete("/tmp/test-kubeconfig.yaml") if File.exists?("/tmp/test-kubeconfig.yaml")
    end
  end

  describe ".new (in-cluster detection)" do
    it "raises ConfigError when not in-cluster and no kubeconfig" do
      # Save original env
      original_host = ENV["KUBERNETES_SERVICE_HOST"]?
      original_port = ENV["KUBERNETES_SERVICE_PORT"]?

      begin
        ENV.delete("KUBERNETES_SERVICE_HOST")
        ENV.delete("KUBERNETES_SERVICE_PORT")

        # Move kubeconfig if it exists
        if File.exists?(File.expand_path("~/.kube/config"))
          File.rename(
            File.expand_path("~/.kube/config"),
            File.expand_path("~/.kube/config.backup")
          )
        end

        expect_raises(Kubernetes::ConfigError, /Cannot detect Kubernetes config/) do
          Kubernetes::Client.new
        end
      ensure
        ENV["KUBERNETES_SERVICE_HOST"] = original_host if original_host
        ENV["KUBERNETES_SERVICE_PORT"] = original_port if original_port

        # Restore kubeconfig
        if File.exists?(File.expand_path("~/.kube/config.backup"))
          File.rename(
            File.expand_path("~/.kube/config.backup"),
            File.expand_path("~/.kube/config")
          )
        end
      end
    end
  end

  describe "#close" do
    it "closes connection pool" do
      client = Kubernetes::Client.new(
        server: URI.parse("https://localhost:6443"),
        token: "test"
      )
      client.close
      # Should not raise
    end
  end
end
