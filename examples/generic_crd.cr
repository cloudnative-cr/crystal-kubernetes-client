require "../src/kubernetes-client"

# Example: Working with CustomResourceDefinitions using the Generic client
#
# This example demonstrates how to use the Generic client to work with
# custom resources without code generation.
#
# Usage:
#   crystal run examples/generic_crd.cr

# Define your CRD type structures

struct CronTab
  include JSON::Serializable

  property api_version : String
  property kind : String
  property metadata : Kubernetes::Metadata
  property spec : CronTabSpec
  property status : CronTabStatus?

  def initialize(@api_version, @kind, @metadata, @spec, @status = nil)
  end
end

struct CronTabSpec
  include JSON::Serializable

  @[JSON::Field(key: "cronSpec")]
  property cron_spec : String

  property image : String
  property replicas : Int32

  def initialize(@cron_spec, @image, @replicas)
  end
end

struct CronTabStatus
  include JSON::Serializable

  property active : Int32?

  @[JSON::Field(key: "lastScheduleTime")]
  property last_schedule_time : String?

  def initialize(@active = nil, @last_schedule_time = nil)
  end
end

# Main example
begin
  # Initialize Kubernetes client (auto-detects in-cluster or kubeconfig)
  k8s = Kubernetes::Client.new
  puts "Connected to Kubernetes API server: #{k8s.server}"

  # Create a Generic client for CronTab custom resources
  # This assumes you have a CRD installed with:
  #   apiVersion: stable.example.com/v1
  #   kind: CronTab
  #   plural: crontabs
  crontabs = Kubernetes::Generic(CronTab).new(k8s,
    api_group: "stable.example.com",
    version: "v1",
    resource: "crontabs"
  )

  puts "\n--- Generic Client Example for CustomResourceDefinitions ---\n"

  # Example 1: List all CronTabs in namespace
  puts "\n1. Listing all CronTabs in 'default' namespace:"
  begin
    list = crontabs.list_namespaced("default")
    puts "Found #{list.items.size} CronTab(s)"
    list.items.each do |ct|
      puts "  - #{ct.metadata.name} (cron: #{ct.spec.cron_spec})"
    end
  rescue ex : Kubernetes::ClientError
    puts "  Error listing CronTabs: #{ex.message}"
    puts "  (This is expected if the CRD is not installed)"
  end

  # Example 2: Create a new CronTab
  puts "\n2. Creating a new CronTab:"
  new_crontab = CronTab.new(
    api_version: "stable.example.com/v1",
    kind: "CronTab",
    metadata: Kubernetes::Metadata.new(
      name: "my-backup-cron",
      namespace: "default"
    ),
    spec: CronTabSpec.new(
      cron_spec: "*/5 * * * *",
      image: "backup-tool:latest",
      replicas: 1
    )
  )

  begin
    created = crontabs.create_namespaced("default", new_crontab)
    puts "  Created CronTab: #{created.metadata.name}"
  rescue ex : Kubernetes::ClientError
    if ex.message.try &.includes?("409")
      puts "  CronTab already exists (409 Conflict)"
    else
      puts "  Error creating CronTab: #{ex.message}"
    end
  end

  # Example 3: Read a specific CronTab
  puts "\n3. Reading specific CronTab:"
  begin
    crontab = crontabs.read_namespaced("default", "my-backup-cron")
    puts "  Name: #{crontab.metadata.name}"
    puts "  Cron Spec: #{crontab.spec.cron_spec}"
    puts "  Image: #{crontab.spec.image}"
    puts "  Replicas: #{crontab.spec.replicas}"
  rescue ex : Kubernetes::ClientError
    puts "  Error reading CronTab: #{ex.message}"
  end

  # Example 4: Update using server-side apply (recommended)
  puts "\n4. Updating CronTab using server-side apply:"
  begin
    updated_crontab = CronTab.new(
      api_version: "stable.example.com/v1",
      kind: "CronTab",
      metadata: Kubernetes::Metadata.new(
        name: "my-backup-cron",
        namespace: "default"
      ),
      spec: CronTabSpec.new(
        cron_spec: "*/10 * * * *", # Changed from */5 to */10
        image: "backup-tool:v2",   # Updated version
        replicas: 2                # Scaled up
      )
    )

    applied = crontabs.apply_namespaced("default", "my-backup-cron",
      updated_crontab,
      field_manager: "generic-example")
    puts "  Applied changes to CronTab"
    puts "  New cron spec: #{applied.spec.cron_spec}"
  rescue ex : Kubernetes::ClientError
    puts "  Error applying CronTab: #{ex.message}"
  end

  # Example 5: Patch using merge patch
  puts "\n5. Patching CronTab with merge patch:"
  begin
    patch = {
      "spec" => {
        "replicas" => 3,
      },
    }

    patched = crontabs.patch_namespaced("default", "my-backup-cron", patch)
    puts "  Patched replicas to: #{patched.spec.replicas}"
  rescue ex : Kubernetes::ClientError
    puts "  Error patching CronTab: #{ex.message}"
  end

  # Example 6: Watch for changes (runs for 30 seconds)
  puts "\n6. Watching CronTabs for changes (30 seconds):"
  puts "   (Try creating/modifying/deleting CronTabs in another terminal)"

  spawn do
    begin
      crontabs.watch_namespaced("default", timeout: 30.seconds) do |event|
        case event.type
        when .added?
          puts "  [ADDED] #{event.object.metadata.name}"
        when .modified?
          puts "  [MODIFIED] #{event.object.metadata.name} (replicas: #{event.object.spec.replicas})"
        when .deleted?
          puts "  [DELETED] #{event.object.metadata.name}"
        end
      end
    rescue ex
      puts "  Watch ended: #{ex.message}"
    end
  end

  sleep 31.seconds

  # Example 7: Delete the CronTab
  puts "\n7. Deleting CronTab:"
  begin
    status = crontabs.delete_namespaced("default", "my-backup-cron")
    puts "  Deleted CronTab (status: #{status.status})"
  rescue ex : Kubernetes::ClientError
    puts "  Error deleting CronTab: #{ex.message}"
  end

  puts "\n--- Example Complete ---"
  puts "\nNote: To use this example with a real CRD, you need to install the CRD first:"
  puts "  kubectl apply -f examples/crontab-crd.yaml"
  puts "\nSee https://kubernetes.io/docs/tasks/extend-kubernetes/custom-resources/custom-resource-definitions/"
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
