require "../src/kubernetes-client"

# Example: Using the High-Level Type-Safe API
#
# This example demonstrates the high-level k8s.v1 API which provides
# type-safe access to resources without blocks or manual JSON parsing.
#
# Usage:
#   crystal run examples/high_level_api.cr

begin
  # Initialize Kubernetes client
  k8s = Kubernetes::Client.new
  puts "Connected to Kubernetes API server: #{k8s.server}"

  puts "\n--- High-Level API Examples ---\n"

  # Example 1: List pods (type-safe, no blocks)
  puts "\n1. Listing pods with high-level API:"
  begin
    pods = k8s.v1.pods.list_namespaced("default")
    puts "  Found #{pods.items.size} pods"
    pods.items.each do |pod|
      status = pod.status.try(&.phase) || "Unknown"
      puts "    - #{pod.metadata.name} (#{status})"
    end
  rescue ex : Kubernetes::ClientError
    puts "  Error: #{ex.message}"
  end

  # Example 2: List pods with label selector
  puts "\n2. Listing pods with label selector:"
  begin
    pods = k8s.v1.pods.list_namespaced("default",
      label_selector: "app=nginx")
    puts "  Found #{pods.items.size} nginx pods"
    pods.items.each do |pod|
      puts "    - #{pod.metadata.name}"
    end
  rescue ex : Kubernetes::ClientError
    puts "  Error: #{ex.message}"
  end

  # Example 3: Check if a pod is ready
  puts "\n3. Checking pod readiness:"
  begin
    pods = k8s.v1.pods.list_namespaced("default", limit: 1)
    if pod = pods.items.first?
      name = pod.metadata.name
      if k8s.v1.pods.ready?("default", name)
        puts "  Pod '#{name}' is ready"
      else
        puts "  Pod '#{name}' is not ready"
      end
    else
      puts "  No pods found"
    end
  rescue ex : Kubernetes::ClientError
    puts "  Error: #{ex.message}"
  end

  # Example 4: Get pod logs
  puts "\n4. Getting pod logs:"
  begin
    pods = k8s.v1.pods.list_namespaced("default", limit: 1)
    if pod = pods.items.first?
      name = pod.metadata.name
      logs = k8s.v1.pods.logs("default", name, tail_lines: 10)
      puts "  Last 10 lines from '#{name}':"
      logs.each_line { |line| puts "    #{line}" }
    else
      puts "  No pods found"
    end
  rescue ex : Kubernetes::ClientError
    puts "  Error: #{ex.message}"
  end

  # Example 5: List deployments
  puts "\n5. Listing deployments:"
  begin
    deployments = k8s.v1.deployments.list_namespaced("default")
    puts "  Found #{deployments.items.size} deployments"
    deployments.items.each do |deployment|
      replicas = deployment.spec.try(&.replicas) || 0
      ready = deployment.status.try(&.ready_replicas) || 0
      puts "    - #{deployment.metadata.name} (#{ready}/#{replicas} ready)"
    end
  rescue ex : Kubernetes::ClientError
    puts "  Error: #{ex.message}"
  end

  # Example 6: Scale a deployment
  puts "\n6. Scaling a deployment:"
  begin
    deployments = k8s.v1.deployments.list_namespaced("default", limit: 1)
    if deployment = deployments.items.first?
      name = deployment.metadata.name
      current = deployment.spec.try(&.replicas) || 0
      puts "  Current replicas for '#{name}': #{current}"

      # Scale to current + 1 (or back to 1 if > 3)
      new_replicas = current >= 3 ? 1 : current + 1
      puts "  Scaling to #{new_replicas} replicas..."

      scaled = k8s.v1.deployments.scale("default", name, replicas: new_replicas)
      puts "  Scaled successfully to #{scaled.spec.try(&.replicas)} replicas"
    else
      puts "  No deployments found"
    end
  rescue ex : Kubernetes::ClientError
    puts "  Error: #{ex.message}"
  end

  # Example 7: Get deployment replica count
  puts "\n7. Getting deployment replica count:"
  begin
    deployments = k8s.v1.deployments.list_namespaced("default", limit: 1)
    if deployment = deployments.items.first?
      name = deployment.metadata.name
      replicas = k8s.v1.deployments.replicas("default", name)
      puts "  Deployment '#{name}' has #{replicas} replicas"
    end
  rescue ex : Kubernetes::ClientError
    puts "  Error: #{ex.message}"
  end

  # Example 8: Check deployment readiness
  puts "\n8. Checking deployment readiness:"
  begin
    deployments = k8s.v1.deployments.list_namespaced("default", limit: 1)
    if deployment = deployments.items.first?
      name = deployment.metadata.name
      if k8s.v1.deployments.ready?("default", name)
        puts "  Deployment '#{name}' is ready"
      else
        puts "  Deployment '#{name}' is not ready"
      end
    end
  rescue ex : Kubernetes::ClientError
    puts "  Error: #{ex.message}"
  end

  # Example 9: List services
  puts "\n9. Listing services:"
  begin
    services = k8s.v1.services.list_namespaced("default")
    puts "  Found #{services.items.size} services"
    services.items.each do |service|
      type = service.spec.try(&.type) || "Unknown"
      cluster_ip = service.spec.try(&.cluster_ip) || "None"
      puts "    - #{service.metadata.name} (#{type}, #{cluster_ip})"
    end
  rescue ex : Kubernetes::ClientError
    puts "  Error: #{ex.message}"
  end

  # Example 10: List config maps
  puts "\n10. Listing config maps:"
  begin
    config_maps = k8s.v1.config_maps.list_namespaced("default")
    puts "  Found #{config_maps.items.size} config maps"
    config_maps.items.each do |cm|
      keys = cm.data.try(&.keys) || [] of String
      puts "    - #{cm.metadata.name} (#{keys.size} keys)"
    end
  rescue ex : Kubernetes::ClientError
    puts "  Error: #{ex.message}"
  end

  # Example 11: Pagination with high-level API
  puts "\n11. Pagination example:"
  begin
    count = 0
    k8s.v1.pods.paginate_namespaced("default", page_size: 10) do |p|
      count += 1
      puts "  Pod #{count}: #{p.metadata.name}"
      break if count >= 5 # Just show first 5 for demo
    end
  rescue ex : Kubernetes::ClientError
    puts "  Error: #{ex.message}"
  end

  puts "\n--- Example Complete ---"
  puts "\nKey Differences from Low-Level API:"
  puts "  - No blocks required for list/read operations"
  puts "  - Direct access to typed structs"
  puts "  - Helper methods (ready?, scale, logs, wait_until_ready)"
  puts "  - Cleaner, more readable code"
  puts "\nLow-Level API:"
  puts "  k8s.get(path) { |res| Pod.from_json(res.body_io) }"
  puts "\nHigh-Level API:"
  puts "  pod = k8s.v1.pods.read_namespaced(\"default\", \"nginx\")"
rescue ex : Kubernetes::ConfigError
  puts "Configuration error: #{ex.message}"
  puts "\nMake sure you have a valid kubeconfig or are running in-cluster."
  exit 1
rescue ex : Kubernetes::AuthenticationError
  puts "Authentication error: #{ex.message}"
  puts "\nCheck your credentials and cluster access."
  exit 1
rescue ex : Exception
  puts "Unexpected error: #{ex.message}"
  puts ex.backtrace.join("\n")
  exit 1
end
