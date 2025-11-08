require "../src/kubernetes-client"

# Example: Apply a Deployment using server-side apply
#
# This example demonstrates:
# - Server-side apply (create-or-update)
# - PATCH requests with apply content type
# - Field manager for multi-controller coordination

k8s = Kubernetes::Client.new

deployment = {
  apiVersion: "apps/v1",
  kind:       "Deployment",
  metadata:   {
    name:      "nginx-deployment",
    namespace: "default",
  },
  spec: {
    replicas: 3,
    selector: {
      matchLabels: {
        app: "nginx",
      },
    },
    template: {
      metadata: {
        labels: {
          app: "nginx",
        },
      },
      spec: {
        containers: [
          {
            name:  "nginx",
            image: "nginx:1.21",
            ports: [
              {containerPort: 80},
            ],
          },
        ],
      },
    },
  },
}

puts "Applying Deployment 'nginx-deployment' in default namespace..."

begin
  params = URI::Params{
    "fieldManager" => "kubernetes-crystal-client",
    "force"        => "false",
  }

  response = k8s.patch(
    "/apis/apps/v1/namespaces/default/deployments/nginx-deployment?#{params}",
    deployment,
    content_type: "application/apply-patch+yaml"
  )

  if response.success?
    data = JSON.parse(response.body)
    name = data["metadata"]["name"]
    replicas = data["spec"]["replicas"]
    puts "Deployment '#{name}' applied successfully! (replicas: #{replicas})"
  else
    puts "Error: #{response.status} - #{response.body}"
  end
rescue ex : Kubernetes::ClientError
  puts "Failed to apply Deployment: #{ex.message}"
end
