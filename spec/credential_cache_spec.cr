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

describe Kubernetes::CredentialCache do
  describe ".key_for_exec" do
    it "generates stable cache key from exec config" do
      exec = Kubernetes::Config::UserEntry::ExecConfig.from_yaml(<<-YAML
        apiVersion: client.authentication.k8s.io/v1
        command: kubectl
        args:
        - oidc-login
        - get-token
      YAML
      )

      key1 = Kubernetes::CredentialCache.key_for_exec(exec)
      key2 = Kubernetes::CredentialCache.key_for_exec(exec)

      key1.should eq(key2)
      key1.size.should eq(16) # First 16 chars of SHA256
    end

    it "generates different keys for different commands" do
      exec1 = Kubernetes::Config::UserEntry::ExecConfig.from_yaml(<<-YAML
        apiVersion: client.authentication.k8s.io/v1
        command: kubectl
        args: ["oidc-login"]
      YAML
      )

      exec2 = Kubernetes::Config::UserEntry::ExecConfig.from_yaml(<<-YAML
        apiVersion: client.authentication.k8s.io/v1
        command: kubelogin
        args: ["get-token"]
      YAML
      )

      key1 = Kubernetes::CredentialCache.key_for_exec(exec1)
      key2 = Kubernetes::CredentialCache.key_for_exec(exec2)

      key1.should_not eq(key2)
    end
  end

  describe "#get and #set" do
    it "caches and retrieves credentials" do
      cache = Kubernetes::CredentialCache.new
      auth = Kubernetes::Auth.new(token: "test-token")
      key = "test-key"

      # Initially no cache
      cache.get(key).should be_nil

      # Store credential
      cache.set(key, auth)

      # Retrieve cached credential
      cached = cache.get(key)
      cached.should_not be_nil
      cached.try(&.token).should eq("test-token")

      # Cleanup
      cache.clear_all
    end

    it "respects expiration timestamps" do
      cache = Kubernetes::CredentialCache.new
      auth = Kubernetes::Auth.new(token: "expiring-token")
      key = "expiring-key"

      # Cache with expiration in the past
      past_time = Time.utc - 1.hour
      cache.set(key, auth, past_time)

      # Should return nil (expired)
      cache.get(key).should be_nil

      # Cache with future expiration
      future_time = Time.utc + 1.hour
      cache.set(key, auth, future_time)

      # Should return cached credential
      cached = cache.get(key)
      cached.should_not be_nil
      cached.try(&.token).should eq("expiring-token")

      # Cleanup
      cache.clear_all
    end

    it "handles credentials without expiration" do
      cache = Kubernetes::CredentialCache.new
      auth = Kubernetes::Auth.new(token: "never-expires")
      key = "no-expiry-key"

      # Cache without expiration
      cache.set(key, auth, nil)

      # Should always be valid
      cached = cache.get(key)
      cached.should_not be_nil
      cached.try(&.token).should eq("never-expires")

      # Cleanup
      cache.clear_all
    end
  end

  describe "#clear_all" do
    it "clears all cached credentials" do
      cache = Kubernetes::CredentialCache.new

      # Cache multiple credentials
      cache.set("key1", Kubernetes::Auth.new(token: "token1"))
      cache.set("key2", Kubernetes::Auth.new(token: "token2"))

      # Verify they exist
      cache.get("key1").should_not be_nil
      cache.get("key2").should_not be_nil

      # Clear all
      cache.clear_all

      # Verify they're gone
      cache.get("key1").should be_nil
      cache.get("key2").should be_nil
    end
  end

  describe "CachedCredential" do
    it "serializes and deserializes correctly" do
      auth = Kubernetes::Auth.new(token: "test-token", username: "user")
      expires_at = Time.utc + 1.hour

      cached = Kubernetes::CredentialCache::CachedCredential.new(
        auth: auth,
        expires_at: expires_at
      )

      # Serialize to JSON
      json = cached.to_json

      # Deserialize
      restored = Kubernetes::CredentialCache::CachedCredential.from_json(json)

      restored.auth.token.should eq("test-token")
      restored.auth.username.should eq("user")
      # Time precision is lost in JSON serialization, check within 1 second
      if exp = restored.expires_at
        (exp - expires_at).abs.should be < 1.second
      else
        fail "expires_at should not be nil"
      end
    end

    it "checks expiration correctly" do
      auth = Kubernetes::Auth.new(token: "test")

      # Expired
      expired = Kubernetes::CredentialCache::CachedCredential.new(
        auth: auth,
        expires_at: Time.utc - 1.hour
      )
      expired.expired?.should be_true

      # Not expired
      valid = Kubernetes::CredentialCache::CachedCredential.new(
        auth: auth,
        expires_at: Time.utc + 1.hour
      )
      valid.expired?.should be_false

      # No expiration
      never = Kubernetes::CredentialCache::CachedCredential.new(
        auth: auth,
        expires_at: nil
      )
      never.expired?.should be_false
    end
  end
end
