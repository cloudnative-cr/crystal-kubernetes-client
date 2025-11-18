# Kubernetes Client for Crystal

Type-safe Kubernetes client with full API coverage generated from the OpenAPI spec.

**Documentation**: https://cloudnative-cr.github.io/kubernetes-client/

## Features

- All 718 Kubernetes resource types (generated from swagger.json)
- Server-side apply pattern
- Watch loops with auto-reconnection
- Bearer tokens, client certs, exec providers (OIDC, AWS, GCP, Azure)
- Connection pooling
- Generic CRD client
- Zero-config in-cluster

## Installation

```yaml
dependencies:
  kubernetes-client:
    github: cloudnative-cr/kubernetes-client
```

## Usage

```crystal
require "kubernetes-client"

k8s = Kubernetes::Client.new

# List pods
pods = k8s.v1.pods.list_namespaced("default")
pods.items.each { |pod| puts pod.metadata.name }

# Scale deployment
k8s.v1.deployments.scale("default", "nginx", replicas: 10)

# Wait for pod
k8s.v1.pods.wait_until_ready("default", "nginx")

# Get logs
logs = k8s.v1.pods.logs("default", "nginx", tail_lines: 100)
```

### Watch

```crystal
k8s.watch("/api/v1/namespaces/default/pods") do |event|
  puts "#{event.type}: #{event.object.metadata.name}"
end
```

### Custom Resources

```crystal
struct MyCronTab
  include JSON::Serializable
  property metadata : Kubernetes::Metadata
  property spec : Spec

  struct Spec
    include JSON::Serializable
    property cron_spec : String
    property image : String
  end
end

crontabs = Kubernetes::Generic(MyCronTab).new(
  Kubernetes::Client.new,
  api_group: "stable.example.com",
  version: "v1",
  resource: "crontabs"
)

crontabs.list_namespaced("default").items.each { |ct| puts ct.metadata.name }
crontabs.watch_namespaced("default") { |event| reconcile(event.object) }
```

## Development

```bash
git clone https://github.com/cloudnative-cr/kubernetes-client
cd kubernetes-client
shards install

# Generate API bindings
make download-spec
make generate

# Run tests (78 tests, ~146ms)
crystal spec
```

## License

Apache 2.0
