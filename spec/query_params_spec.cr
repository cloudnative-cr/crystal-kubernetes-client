require "./spec_helper"

describe Kubernetes::Client do
  describe "#build_list_params" do
    it "builds empty params when no options provided" do
      client = Kubernetes::Client.new(server: URI.parse("https://localhost:6443"))
      params = client.build_list_params

      params.to_s.should eq("")
    end

    it "builds params with label selector" do
      client = Kubernetes::Client.new(server: URI.parse("https://localhost:6443"))
      params = client.build_list_params(label_selector: "app=nginx")

      params.to_s.should eq("labelSelector=app%3Dnginx")
    end

    it "builds params with field selector" do
      client = Kubernetes::Client.new(server: URI.parse("https://localhost:6443"))
      params = client.build_list_params(field_selector: "status.phase=Running")

      params.to_s.should eq("fieldSelector=status.phase%3DRunning")
    end

    it "builds params with limit" do
      client = Kubernetes::Client.new(server: URI.parse("https://localhost:6443"))
      params = client.build_list_params(limit: 100)

      params.to_s.should eq("limit=100")
    end

    it "builds params with continue token" do
      client = Kubernetes::Client.new(server: URI.parse("https://localhost:6443"))
      params = client.build_list_params(continue: "abc123")

      params.to_s.should eq("continue=abc123")
    end

    it "builds params with resource version" do
      client = Kubernetes::Client.new(server: URI.parse("https://localhost:6443"))
      params = client.build_list_params(resource_version: "12345")

      params.to_s.should eq("resourceVersion=12345")
    end

    it "builds params with timeout seconds" do
      client = Kubernetes::Client.new(server: URI.parse("https://localhost:6443"))
      params = client.build_list_params(timeout_seconds: 30)

      params.to_s.should eq("timeoutSeconds=30")
    end

    it "builds params with watch flag" do
      client = Kubernetes::Client.new(server: URI.parse("https://localhost:6443"))
      params = client.build_list_params(watch: true)

      params.to_s.should eq("watch=true")
    end

    it "builds params with multiple options" do
      client = Kubernetes::Client.new(server: URI.parse("https://localhost:6443"))
      params = client.build_list_params(
        label_selector: "app=nginx,env=prod",
        field_selector: "status.phase=Running",
        limit: 50
      )

      # Order may vary, just check all are present
      params_string = params.to_s
      params_string.should contain("labelSelector=app%3Dnginx%2Cenv%3Dprod")
      params_string.should contain("fieldSelector=status.phase%3DRunning")
      params_string.should contain("limit=50")
    end

    it "omits nil parameters" do
      client = Kubernetes::Client.new(server: URI.parse("https://localhost:6443"))
      params = client.build_list_params(
        label_selector: "app=nginx",
        field_selector: nil,
        limit: nil
      )

      params.to_s.should eq("labelSelector=app%3Dnginx")
    end
  end
end

describe Kubernetes::ListMetadata do
  it "parses list metadata with continue token" do
    json = %({
      "resourceVersion": "12345",
      "continue": "next-token",
      "remainingItemCount": 100
    })

    metadata = Kubernetes::ListMetadata.from_json(json)
    metadata.resource_version.should eq("12345")
    metadata.continue.should eq("next-token")
    metadata.remaining_item_count.should eq(100)
  end

  it "handles missing continue token" do
    json = %({
      "resourceVersion": "12345"
    })

    metadata = Kubernetes::ListMetadata.from_json(json)
    metadata.resource_version.should eq("12345")
    metadata.continue.should be_nil
    metadata.remaining_item_count.should be_nil
  end
end

struct TestListItem
  include JSON::Serializable
  property metadata : Kubernetes::Metadata?
end

describe Kubernetes::List do
  it "includes metadata with continue token" do
    json = %({
      "apiVersion": "v1",
      "kind": "PodList",
      "metadata": {
        "resourceVersion": "12345",
        "continue": "next-page"
      },
      "items": []
    })

    list = Kubernetes::List(TestListItem).from_json(json)
    list.metadata.should_not be_nil
    if metadata = list.metadata
      metadata.resource_version.should eq("12345")
      metadata.continue.should eq("next-page")
    end
  end
end
