require "../src/kubernetes-client"

# Example: Using Query Parameters for Filtering and Pagination
#
# This example demonstrates how to use label selectors, field selectors,
# and pagination when listing resources.
#
# Usage:
#   crystal run examples/query_params.cr

begin
  # Initialize Kubernetes client
  k8s = Kubernetes::Client.new
  puts "Connected to Kubernetes API server: #{k8s.server}"

  puts "\n--- Query Parameter Examples ---\n"

  # Example 1: List pods with label selector
  puts "\n1. Listing pods with label selector 'app=nginx':"
  begin
    # Using build_list_params helper
    params = k8s.build_list_params(label_selector: "app=nginx")
    k8s.get("/api/v1/namespaces/default/pods", params) do |response|
      if response.success?
        data = JSON.parse(response.body_io)
        items = data["items"].as_a
        puts "  Found #{items.size} pods matching label 'app=nginx'"
        items.each do |pod|
          puts "    - #{pod["metadata"]["name"]}"
        end
      end
    end
  rescue ex : Kubernetes::ClientError
    puts "  Error: #{ex.message}"
  end

  # Example 2: Field selector
  puts "\n2. Listing pods with field selector 'status.phase=Running':"
  begin
    params = k8s.build_list_params(field_selector: "status.phase=Running")
    k8s.get("/api/v1/namespaces/default/pods", params) do |response|
      if response.success?
        data = JSON.parse(response.body_io)
        items = data["items"].as_a
        puts "  Found #{items.size} running pods"
        items.each do |pod|
          puts "    - #{pod["metadata"]["name"]} (#{pod["status"]["phase"]})"
        end
      end
    end
  rescue ex : Kubernetes::ClientError
    puts "  Error: #{ex.message}"
  end

  # Example 3: Pagination
  puts "\n3. Listing pods with pagination (limit=5):"
  begin
    params = k8s.build_list_params(limit: 5)
    k8s.get("/api/v1/namespaces/default/pods", params) do |response|
      if response.success?
        data = JSON.parse(response.body_io)
        items = data["items"].as_a
        metadata = data["metadata"]?

        puts "  Page 1: #{items.size} pods"
        items.each do |pod|
          puts "    - #{pod["metadata"]["name"]}"
        end

        # Check for continuation token
        if metadata && (continue_token = metadata["continue"]?)
          puts "  Continue token: #{continue_token.as_s[0..20]}..."
          puts "  (Use this token to fetch the next page)"
        else
          puts "  No more pages"
        end
      end
    end
  rescue ex : Kubernetes::ClientError
    puts "  Error: #{ex.message}"
  end

  # Example 4: Combined filters
  puts "\n4. Combining multiple query parameters:"
  begin
    params = k8s.build_list_params(
      label_selector: "app=nginx",
      field_selector: "status.phase=Running",
      limit: 10
    )
    k8s.get("/api/v1/namespaces/default/pods", params) do |response|
      if response.success?
        data = JSON.parse(response.body_io)
        items = data["items"].as_a
        puts "  Found #{items.size} running nginx pods (max 10)"
        items.each do |pod|
          puts "    - #{pod["metadata"]["name"]}"
        end
      end
    end
  rescue ex : Kubernetes::ClientError
    puts "  Error: #{ex.message}"
  end

  # Example 5: Using Generic client with query parameters
  puts "\n5. Generic client with label selector:"

  struct SimplePod
    include JSON::Serializable
    property metadata : Kubernetes::Metadata
  end

  begin
    pods = Kubernetes::Generic(SimplePod).new(k8s, "", "v1", "pods")

    # List with label selector
    list = pods.list_namespaced("default", label_selector: "app=nginx")
    puts "  Found #{list.items.size} nginx pods using Generic client"
    list.items.each do |pod|
      puts "    - #{pod.metadata.name}"
    end
  rescue ex : Kubernetes::ClientError
    puts "  Error: #{ex.message}"
  end

  # Example 6: Pagination with Generic client
  puts "\n6. Pagination using Generic client:"
  begin
    pods = Kubernetes::Generic(SimplePod).new(k8s, "", "v1", "pods")

    # Automatic pagination
    count = 0
    pods.paginate_namespaced("default", page_size: 10) do |pod|
      count += 1
      puts "  Pod #{count}: #{pod.metadata.name}"
      break if count >= 20 # Stop after 20 for demo
    end
    puts "  Iterated through #{count} pods with automatic pagination"
  rescue ex : Kubernetes::ClientError
    puts "  Error: #{ex.message}"
  end

  # Example 7: Multiple selectors
  puts "\n7. Multiple label selectors (AND logic):"
  begin
    pods = Kubernetes::Generic(SimplePod).new(k8s, "", "v1", "pods")

    # Multiple labels use comma separator
    list = pods.list_namespaced("default",
      label_selector: "app=nginx,env=production",
      field_selector: "status.phase=Running"
    )
    puts "  Found #{list.items.size} running nginx pods in production"
  rescue ex : Kubernetes::ClientError
    puts "  Error: #{ex.message}"
  end

  puts "\n--- Example Complete ---"
  puts "\nKey Points:"
  puts "  - labelSelector uses label=value syntax"
  puts "  - Multiple labels: label1=value1,label2=value2 (AND logic)"
  puts "  - fieldSelector uses field.path=value syntax"
  puts "  - Pagination uses limit and continue parameters"
  puts "  - Generic client has built-in pagination helper"
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
