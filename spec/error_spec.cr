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

describe Kubernetes::Error do
  it "can be raised and caught" do
    expect_raises(Kubernetes::Error, "test error") do
      raise Kubernetes::Error.new("test error")
    end
  end

  it "inherits from Exception" do
    error = Kubernetes::Error.new("test")
    error.should be_a(Exception)
  end
end

describe Kubernetes::ConfigError do
  it "can be raised and caught" do
    expect_raises(Kubernetes::ConfigError, "config error") do
      raise Kubernetes::ConfigError.new("config error")
    end
  end

  it "inherits from Kubernetes::Error" do
    error = Kubernetes::ConfigError.new("test")
    error.should be_a(Kubernetes::Error)
  end

  it "can be caught as Kubernetes::Error" do
    expect_raises(Kubernetes::Error) do
      raise Kubernetes::ConfigError.new("config error")
    end
  end
end

describe Kubernetes::ClientError do
  it "can be raised and caught" do
    expect_raises(Kubernetes::ClientError, "client error") do
      raise Kubernetes::ClientError.new("client error")
    end
  end

  it "inherits from Kubernetes::Error" do
    error = Kubernetes::ClientError.new("test")
    error.should be_a(Kubernetes::Error)
  end

  it "can be caught as Kubernetes::Error" do
    expect_raises(Kubernetes::Error) do
      raise Kubernetes::ClientError.new("client error")
    end
  end
end

describe Kubernetes::AuthenticationError do
  it "can be raised and caught" do
    expect_raises(Kubernetes::AuthenticationError, "auth error") do
      raise Kubernetes::AuthenticationError.new("auth error")
    end
  end

  it "inherits from Kubernetes::Error" do
    error = Kubernetes::AuthenticationError.new("test")
    error.should be_a(Kubernetes::Error)
  end

  it "can be caught as Kubernetes::Error" do
    expect_raises(Kubernetes::Error) do
      raise Kubernetes::AuthenticationError.new("auth error")
    end
  end

  it "has descriptive message" do
    error = Kubernetes::AuthenticationError.new("Unauthorized: invalid token")
    error.message.should eq("Unauthorized: invalid token")
  end
end
