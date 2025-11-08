# Kubernetes Client for Crystal

A comprehensive, type-safe Kubernetes client for Crystal with full API coverage generated from the official OpenAPI specification.

**Design Goals:**
- 100% Kubernetes API coverage via OpenAPI code generation
- Elegant, idiomatic Crystal API inspired by jgaskins/kubernetes
- Type-safe operations with compile-time validation
- Server-side apply pattern support
- Watch loops with automatic reconnection
- Connection pooling and resource management
- Zero-config in-cluster operation

## Features

- **Complete API Coverage**: All Kubernetes APIs generated from official swagger.json
- **Type Safety**: Full Crystal type system integration
- **Server-Side Apply**: Built-in support for the apply pattern
- **Watch Support**: Streaming watch with automatic reconnection and resource version tracking
- **Authentication**: Bearer tokens, kubeconfig, client certificates, exec providers
- **Connection Pooling**: Efficient HTTP connection reuse
- **CRD Support**: Generic custom resource operations
- **Elegant API**: Inspired by jgaskins/kubernetes, idiomatic Crystal syntax

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  kubernetes-client:
    github: cloudnative-cr/kubernetes-client
```

Run:
```bash
shards install
```

## Quick Start

### High-Level Type-Safe API (Recommended)

```crystal
require "kubernetes-client"

# Auto-detect in-cluster configuration
k8s = Kubernetes::Client.new

# List pods - type-safe, no blocks
pods = k8s.v1.pods.list_namespaced("default")
pods.items.each do |pod|
  puts "Pod: #{pod.metadata.name} - Status: #{pod.status.try(&.phase)}"
end

# Helper methods
k8s.v1.deployments.scale("default", "nginx", replicas: 10)
ready_pod = k8s.v1.pods.wait_until_ready("default", "nginx")
logs = k8s.v1.pods.logs("default", "nginx", tail_lines: 100)
```

### Watch for Changes

```crystal
require "kubernetes-client"

k8s = Kubernetes::Client.new

# Watch pods with automatic reconnection
k8s.watch("/api/v1/namespaces/default/pods") do |event|
  case event.type
  when .added?
    puts "New pod: #{event.object.metadata.name}"
  when .modified?
    puts "Updated pod: #{event.object.metadata.name}"
  when .deleted?
    puts "Deleted pod: #{event.object.metadata.name}"
  end
end
```

### Working with Custom Resources

```crystal
require "kubernetes-client"

# Define your CRD type
struct MyCronTab
  include JSON::Serializable
  property api_version : String
  property kind : String
  property metadata : Kubernetes::Metadata
  property spec : MyCronTabSpec
  property status : MyCronTabStatus?
end

struct MyCronTabSpec
  include JSON::Serializable
  property cron_spec : String
  property image : String
  property replicas : Int32
end

# Create generic client for your CRD
k8s = Kubernetes::Client.new
crontabs = Kubernetes::Generic(MyCronTab).new(k8s,
  api_group: "stable.example.com",
  version: "v1",
  resource: "crontabs"
)

# List custom resources
list = crontabs.list_namespaced("default")
list.items.each { |ct| puts ct.metadata.name }

# Create a custom resource
new_crontab = MyCronTab.new(...)
crontabs.create_namespaced("default", new_crontab)

# Watch for changes
crontabs.watch_namespaced("default") do |event|
  case event.type
  when .added?, .modified?
    reconcile(event.object)
  when .deleted?
    cleanup(event.object)
  end
end
```

## Development

### Setup

```bash
git clone https://github.com/cloudnative-cr/kubernetes-client
cd kubernetes-client
shards install
```

### Generate API Bindings

```bash
# Download latest Kubernetes OpenAPI spec
make download-spec

# Generate models and APIs
make generate
```

**Note:** API bindings are automatically updated weekly via GitHub Actions. See [CI/CD Documentation](docs/CI-CD.md) for details.

### Testing

```bash
# Run test suite (78 tests, ~146ms)
crystal spec

# Run with verbose output
crystal spec --verbose

# Run specific test file
crystal spec spec/client_spec.cr
```

**Test Coverage:**
- 78 unit tests, 100% pass rate
- Error class hierarchy
- Watch event deserialization
- Client initialization and TLS auto-config
- Kubeconfig parsing with validation
- In-cluster authentication detection
- Credential caching (in-memory and disk-based)
- Generic CRD client operations

See [docs/TEST-SUITE.md](docs/TEST-SUITE.md) for details.

### Continuous Integration

The project uses GitHub Actions for automated testing and API updates:

- **Test Suite**: Runs on every push/PR with multiple Crystal versions
- **API Updates**: Weekly automated checks for new Kubernetes API versions
- **Security**: CodeQL analysis for vulnerability detection
- **Releases**: Automated release creation on git tags

See [docs/CI-CD.md](docs/CI-CD.md) for complete CI/CD documentation.

## Contributing

1. Fork it (<https://github.com/cloudnative-cr/kubernetes-client/fork>)
2. Create your feature branch (`git checkout -b my-feature`)
3. Run tests (`crystal spec`)
4. Commit your changes (`git commit -am 'Add feature'`)
5. Push to the branch (`git push origin my-feature`)
6. Create a new Pull Request

## License

Apache License 2.0

## Credits

- Inspired by [jgaskins/kubernetes](https://github.com/jgaskins/kubernetes) for elegant API design
- Based on Kubernetes OpenAPI specification

## Contributors

- [Josephine Pfeiffer](https://github.com/pfeifferj) - creator and maintainer
