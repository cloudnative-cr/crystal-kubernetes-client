require "../src/kubernetes-client"

# Example: Create a ConfigMap
#
# This example demonstrates:
# - POST requests to create resources
# - Building resource manifests
# - Error handling

k8s = Kubernetes::Client.new

configmap = {
  apiVersion: "v1",
  kind:       "ConfigMap",
  metadata:   {
    name:      "example-config",
    namespace: "default",
  },
  data: {
    "config.txt" => "Hello from Kubernetes Crystal Client!",
    "app.env"    => "production",
  },
}

puts "Creating ConfigMap 'example-config' in default namespace..."

begin
  response = k8s.post("/api/v1/namespaces/default/configmaps", configmap)

  if response.success?
    data = JSON.parse(response.body)
    name = data["metadata"]["name"]
    puts "ConfigMap '#{name}' created successfully!"
  else
    puts "Error: #{response.status} - #{response.body}"
  end
rescue ex : Kubernetes::ClientError
  puts "Failed to create ConfigMap: #{ex.message}"
end
