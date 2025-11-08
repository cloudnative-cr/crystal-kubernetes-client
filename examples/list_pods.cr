require "../src/kubernetes-client"

k8s = Kubernetes::Client.new
puts "Listing pods..."

k8s.get("/api/v1/namespaces/default/pods") do |response|
  if response.success?
    data = JSON.parse(response.body_io)
    items = data["items"].as_a
    puts "Found #{items.size} pods"
    items.each { |p| puts "  - #{p["metadata"]["name"]}" }
  end
end
