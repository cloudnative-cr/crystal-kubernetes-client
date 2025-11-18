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

require "json"
require "yaml"
require "../../serialization"

module Kubernetes
  # Info contains versioning information. how we'll want to distribute that information.
  struct Info
    include Kubernetes::Serializable

    @[::JSON::Field(key: "buildDate")]
    @[::YAML::Field(key: "buildDate")]
    property build_date : String?
    property compiler : String?
    # EmulationMajor is the major version of the emulation version
    @[::JSON::Field(key: "emulationMajor")]
    @[::YAML::Field(key: "emulationMajor")]
    property emulation_major : String?
    # EmulationMinor is the minor version of the emulation version
    @[::JSON::Field(key: "emulationMinor")]
    @[::YAML::Field(key: "emulationMinor")]
    property emulation_minor : String?
    @[::JSON::Field(key: "gitCommit")]
    @[::YAML::Field(key: "gitCommit")]
    property git_commit : String?
    @[::JSON::Field(key: "gitTreeState")]
    @[::YAML::Field(key: "gitTreeState")]
    property git_tree_state : String?
    @[::JSON::Field(key: "gitVersion")]
    @[::YAML::Field(key: "gitVersion")]
    property git_version : String?
    @[::JSON::Field(key: "goVersion")]
    @[::YAML::Field(key: "goVersion")]
    property go_version : String?
    # Major is the major version of the binary version
    property major : String?
    # MinCompatibilityMajor is the major version of the minimum compatibility version
    @[::JSON::Field(key: "minCompatibilityMajor")]
    @[::YAML::Field(key: "minCompatibilityMajor")]
    property min_compatibility_major : String?
    # MinCompatibilityMinor is the minor version of the minimum compatibility version
    @[::JSON::Field(key: "minCompatibilityMinor")]
    @[::YAML::Field(key: "minCompatibilityMinor")]
    property min_compatibility_minor : String?
    # Minor is the minor version of the binary version
    property minor : String?
    property platform : String?
  end
end
