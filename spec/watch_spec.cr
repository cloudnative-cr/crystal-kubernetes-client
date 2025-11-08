# Copyright 2025 Josephine Pfeiffer
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require "./spec_helper"

describe Kubernetes::Watch do
  describe "JSON deserialization" do
    it "deserializes ADDED events" do
      json = <<-JSON
        {
          "type": "ADDED",
          "object": {
            "apiVersion": "v1",
            "kind": "Pod",
            "metadata": {
              "name": "test-pod",
              "namespace": "default",
              "resourceVersion": "12345"
            }
          }
        }
        JSON

      # Using a simplified object for testing
      watch = Kubernetes::Watch(JSON::Any).from_json(json)
      watch.type.should eq(Kubernetes::Watch::Type::ADDED)
      watch.added?.should be_true
      watch.modified?.should be_false
      watch.deleted?.should be_false
    end

    it "deserializes MODIFIED events" do
      json = <<-JSON
        {
          "type": "MODIFIED",
          "object": {
            "apiVersion": "v1",
            "kind": "Pod",
            "metadata": {
              "name": "test-pod",
              "resourceVersion": "12346"
            }
          }
        }
        JSON

      watch = Kubernetes::Watch(JSON::Any).from_json(json)
      watch.type.should eq(Kubernetes::Watch::Type::MODIFIED)
      watch.modified?.should be_true
    end

    it "deserializes DELETED events" do
      json = <<-JSON
        {
          "type": "DELETED",
          "object": {
            "apiVersion": "v1",
            "kind": "Pod",
            "metadata": {
              "name": "test-pod",
              "resourceVersion": "12347"
            }
          }
        }
        JSON

      watch = Kubernetes::Watch(JSON::Any).from_json(json)
      watch.type.should eq(Kubernetes::Watch::Type::DELETED)
      watch.deleted?.should be_true
    end

    it "deserializes ERROR events" do
      json = <<-JSON
        {
          "type": "ERROR",
          "object": {
            "kind": "Status",
            "apiVersion": "v1",
            "status": "Failure",
            "message": "too old resource version",
            "reason": "Gone",
            "code": 410
          }
        }
        JSON

      watch = Kubernetes::Watch(JSON::Any).from_json(json)
      watch.type.should eq(Kubernetes::Watch::Type::ERROR)
    end
  end

  describe "type delegation" do
    it "delegates added? to type" do
      json = %({"type": "ADDED", "object": {}})
      watch = Kubernetes::Watch(JSON::Any).from_json(json)
      watch.added?.should eq(watch.type.added?)
    end

    it "delegates modified? to type" do
      json = %({"type": "MODIFIED", "object": {}})
      watch = Kubernetes::Watch(JSON::Any).from_json(json)
      watch.modified?.should eq(watch.type.modified?)
    end

    it "delegates deleted? to type" do
      json = %({"type": "DELETED", "object": {}})
      watch = Kubernetes::Watch(JSON::Any).from_json(json)
      watch.deleted?.should eq(watch.type.deleted?)
    end
  end
end

describe Kubernetes::Watch::Type do
  describe "enum values" do
    it "has ADDED" do
      Kubernetes::Watch::Type::ADDED.should_not be_nil
    end

    it "has MODIFIED" do
      Kubernetes::Watch::Type::MODIFIED.should_not be_nil
    end

    it "has DELETED" do
      Kubernetes::Watch::Type::DELETED.should_not be_nil
    end

    it "has ERROR" do
      Kubernetes::Watch::Type::ERROR.should_not be_nil
    end
  end
end
