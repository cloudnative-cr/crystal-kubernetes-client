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

require "../src/kubernetes-client"

# This example demonstrates different authentication methods
# supported by the Kubernetes client

puts "Kubernetes Authentication Examples"
puts "=" * 50
puts

# Example 1: Bearer Token Authentication
puts "1. Bearer Token Authentication"
puts "-" * 40
token = ENV["K8S_TOKEN"]? || "your-bearer-token-here"
_client1 = Kubernetes::Client.new(
  server: URI.parse("https://kubernetes.example.com"),
  token: token
)
puts "✓ Client created with bearer token"
puts

# Example 2: Client Certificate Authentication
puts "2. Client Certificate Authentication"
puts "-" * 40
cert_file = ENV["K8S_CERT"]? || "/path/to/client.crt"
key_file = ENV["K8S_KEY"]? || "/path/to/client.key"

auth_cert = Kubernetes::Auth.new(
  client_cert_file: cert_file,
  client_key_file: key_file
)

# Note: TLS context needs to be configured with cert/key
tls_ctx = OpenSSL::SSL::Context::Client.new
# tls_ctx.certificate_chain = cert_file
# tls_ctx.private_key = key_file

_client2 = Kubernetes::Client.new(
  server: URI.parse("https://kubernetes.example.com"),
  auth: auth_cert,
  tls: tls_ctx
)
puts "✓ Client created with client certificate"
puts

# Example 3: Basic Authentication (deprecated but supported)
puts "3. Basic Authentication"
puts "-" * 40
username = ENV["K8S_USER"]? || "admin"
password = ENV["K8S_PASS"]? || "password"

auth_basic = Kubernetes::Auth.new(
  username: username,
  password: password
)

_client3 = Kubernetes::Client.new(
  server: URI.parse("https://kubernetes.example.com"),
  auth: auth_basic
)
puts "✓ Client created with basic auth"
puts

# Example 4: From Kubeconfig (automatic auth detection)
puts "4. From Kubeconfig (Auto-detected)"
puts "-" * 40
begin
  # Default kubeconfig path: ~/.kube/config
  client4 = Kubernetes::Client.from_config

  puts "✓ Client created from kubeconfig"
  puts "  Server: #{client4.server}"
  puts "  Supports: token, client-cert, exec providers, token files"
rescue ex : Kubernetes::ConfigError
  puts "✗ Could not load kubeconfig: #{ex.message}"
end
puts

# Example 5: From Kubeconfig with specific context
puts "5. From Kubeconfig with Context"
puts "-" * 40
begin
  context_name = ENV["K8S_CONTEXT"]? || "my-cluster"
  _client5 = Kubernetes::Client.from_config(context: context_name)

  puts "✓ Client created from kubeconfig context: #{context_name}"
rescue ex : Kubernetes::ConfigError
  puts "✗ Context not found: #{ex.message}"
end
puts

# Example 6: In-Cluster Configuration
puts "6. In-Cluster Configuration"
puts "-" * 40
puts "When running inside a Kubernetes pod:"
puts "  - Token from: #{Kubernetes::Client::IN_CLUSTER_TOKEN_PATH}"
puts "  - CA cert from: #{Kubernetes::Client::IN_CLUSTER_CA_CERT_PATH}"
puts "  - Namespace from: #{Kubernetes::Client::IN_CLUSTER_NAMESPACE_PATH}"
puts
puts "Usage:"
puts "  client = Kubernetes::Client.new  # Auto-detects in-cluster"
puts

# Example 7: Token from File
puts "7. Token from File"
puts "-" * 40
token_file = "/var/run/secrets/kubernetes.io/serviceaccount/token"
puts "Token files are automatically handled in kubeconfig with:"
puts <<-YAML
users:
- name: my-user
  user:
    tokenFile: #{token_file}
YAML
puts

# Example 8: Exec Provider (kubectl plugins like kubelogin)
puts "8. Exec Provider Authentication"
puts "-" * 40
puts "Exec providers run external commands to get credentials."
puts "Example kubeconfig entry:"
puts <<-YAML
users:
- name: oidc-user
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1
      command: kubectl
      args:
      - oidc-login
      - get-token
      - --oidc-issuer-url=https://issuer.example.com
      - --oidc-client-id=my-client-id
YAML
puts "The client will automatically execute the command and use the returned token."
puts

# Example 9: Authentication Priority
puts "9. Authentication Priority (from highest to lowest)"
puts "-" * 40
puts "1. Exec provider (dynamic credentials)"
puts "2. Bearer token / token file"
puts "3. Client certificate (mTLS)"
puts "4. Basic auth (username/password - deprecated)"
puts

# Example 10: Complete Kubeconfig Example
puts "10. Complete Kubeconfig Example"
puts "-" * 40
puts <<-YAML
apiVersion: v1
kind: Config
current-context: production
clusters:
- name: production
  cluster:
    server: https://api.prod.example.com
    certificate-authority-data: LS0tLS...  # Base64-encoded CA cert
    # OR
    certificate-authority: /path/to/ca.crt
    # Optional:
    insecure-skip-tls-verify: false
contexts:
- name: production
  context:
    cluster: production
    user: prod-user
users:
- name: prod-user
  user:
    # Option 1: Bearer token
    token: eyJhbGciOi...
    # Option 2: Token file
    tokenFile: /path/to/token
    # Option 3: Client certificate
    client-certificate: /path/to/client.crt
    client-key: /path/to/client.key
    # OR embedded:
    client-certificate-data: LS0tLS...
    client-key-data: LS0tLS...
    # Option 4: Exec provider
    exec:
      apiVersion: client.authentication.k8s.io/v1
      command: kubectl-oidc_login
      args: ["get-token"]
    # Option 5: Basic auth (deprecated)
    username: admin
    password: secret
YAML
puts

puts "For more information, see the Kubernetes authentication docs:"
puts "https://kubernetes.io/docs/reference/access-authn-authz/authentication/"

# Example 11: Credential Caching
puts "11. Credential Caching (Performance Optimization)"
puts "-" * 40
puts "The client automatically caches credentials to improve performance:"
puts
puts "ServiceAccount Token Caching (in-cluster):"
puts "  - Tokens are cached in memory to avoid disk I/O on every request"
puts "  - Uses inotify to detect token rotation (Kubernetes projected volumes)"
puts "  - Automatically reloads token when rotated"
puts "  - SSL error retry mechanism for seamless rotation"
puts
puts "Exec Provider Credential Caching:"
puts "  - Credentials cached in ~/.kube/cache/"
puts "  - Respects expirationTimestamp from exec provider"
puts "  - Avoids expensive OIDC flows on every client creation"
puts "  - Cache key: hash of command + args"
puts
puts "Disable credential caching:"
puts "  client = Kubernetes::Client.from_config(cache_credentials: false)"
puts
puts "Clear exec provider cache:"
puts "  cache = Kubernetes::CredentialCache.new"
puts "  cache.clear_all"
puts

puts "For more information, see the Kubernetes authentication docs:"
puts "https://kubernetes.io/docs/reference/access-authn-authz/authentication/"
