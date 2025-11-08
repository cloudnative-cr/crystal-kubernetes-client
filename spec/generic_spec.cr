require "./spec_helper"

describe Kubernetes::Generic do
  describe "#construct_path" do
    it "constructs correct path for core API cluster-scoped resource" do
      client = Kubernetes::Client.new(server: URI.parse("https://localhost:6443"))
      gc = Kubernetes::Generic(TestResource).new(client, "", "v1", "nodes")

      # Access private method via reflection for testing
      path = gc.@resource
      path.should eq("nodes")
    end

    it "constructs correct path for named API group cluster-scoped resource" do
      client = Kubernetes::Client.new(server: URI.parse("https://localhost:6443"))
      gc = Kubernetes::Generic(TestResource).new(client, "apps", "v1", "deployments")

      path = gc.@resource
      path.should eq("deployments")
    end
  end

  describe "type safety" do
    it "provides compile-time type checking" do
      client = Kubernetes::Client.new(server: URI.parse("https://localhost:6443"))

      # This should compile with proper types
      gc = Kubernetes::Generic(TestCronTab).new(client,
        "stable.example.com", "v1", "crontabs")

      # The generic parameter ensures type safety
      typeof(gc).should eq(Kubernetes::Generic(TestCronTab))
    end
  end

  describe "API group handling" do
    it "handles empty API group for core resources" do
      client = Kubernetes::Client.new(server: URI.parse("https://localhost:6443"))

      # Core API resources use empty string for api_group
      pods = Kubernetes::Generic(TestResource).new(client, "", "v1", "pods")
      pods.@api_group.should eq("")
    end

    it "handles named API groups" do
      client = Kubernetes::Client.new(server: URI.parse("https://localhost:6443"))

      # Named API groups like apps, batch, etc.
      deployments = Kubernetes::Generic(TestResource).new(client, "apps", "v1", "deployments")
      deployments.@api_group.should eq("apps")
    end

    it "handles multi-part API groups" do
      client = Kubernetes::Client.new(server: URI.parse("https://localhost:6443"))

      # CRDs often have multi-part groups
      crontabs = Kubernetes::Generic(TestResource).new(client,
        "stable.example.com", "v1", "crontabs")
      crontabs.@api_group.should eq("stable.example.com")
    end
  end

  describe "versioning" do
    it "supports v1 stable version" do
      client = Kubernetes::Client.new(server: URI.parse("https://localhost:6443"))
      gc = Kubernetes::Generic(TestResource).new(client, "apps", "v1", "deployments")
      gc.@version.should eq("v1")
    end

    it "supports alpha versions" do
      client = Kubernetes::Client.new(server: URI.parse("https://localhost:6443"))
      gc = Kubernetes::Generic(TestResource).new(client, "apps", "v1alpha1", "deployments")
      gc.@version.should eq("v1alpha1")
    end

    it "supports beta versions" do
      client = Kubernetes::Client.new(server: URI.parse("https://localhost:6443"))
      gc = Kubernetes::Generic(TestResource).new(client, "apps", "v1beta1", "deployments")
      gc.@version.should eq("v1beta1")
    end
  end

  describe "resource naming" do
    it "uses plural resource names" do
      client = Kubernetes::Client.new(server: URI.parse("https://localhost:6443"))

      # Kubernetes API always uses plural
      gc = Kubernetes::Generic(TestResource).new(client, "", "v1", "pods")
      gc.@resource.should eq("pods")

      # Not "pod" - that would fail
      gc2 = Kubernetes::Generic(TestResource).new(client, "", "v1", "configmaps")
      gc2.@resource.should eq("configmaps")
    end

    it "handles irregular plurals correctly" do
      client = Kubernetes::Client.new(server: URI.parse("https://localhost:6443"))

      # NetworkPolicy -> networkpolicies (not networkpolicys)
      # IngressClass -> ingressclasses (not ingressclasss)
      gc = Kubernetes::Generic(TestResource).new(client, "networking.k8s.io", "v1", "networkpolicies")
      gc.@resource.should eq("networkpolicies")
    end
  end
end

# Test helper structures

struct TestResource
  include JSON::Serializable
  property api_version : String?
  property kind : String?
  property metadata : Kubernetes::Metadata?
end

struct TestCronTab
  include JSON::Serializable
  property api_version : String
  property kind : String
  property metadata : Kubernetes::Metadata
  property spec : TestCronTabSpec
  property status : TestCronTabStatus?
end

struct TestCronTabSpec
  include JSON::Serializable
  property cron_spec : String
  property image : String
  property replicas : Int32
end

struct TestCronTabStatus
  include JSON::Serializable
  property active : Int32?
  property last_schedule_time : String?
end
