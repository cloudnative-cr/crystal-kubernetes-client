require "../src/kubernetes-client"

struct SimplePod
  include JSON::Serializable
  property metadata : Metadata

  struct Metadata
    include JSON::Serializable
    property name : String
    @[JSON::Field(key: "resourceVersion")]
    property resource_version : String
  end
end

k8s = Kubernetes::Client.new
puts "Watching pods (Ctrl+C to stop)..."

k8s.watch("/api/v1/namespaces/default/pods") do |event|
  event = event.as(Kubernetes::Watch(SimplePod))
  puts "[#{event.type}] #{event.object.metadata.name}"
end
