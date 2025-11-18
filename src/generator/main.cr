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
require "file_utils"

# OpenAPI/Swagger code generator for Kubernetes API
module Generator
  class Main
    def initialize(@swagger_file : String, @output_dir : String)
      @swagger = JSON.parse(File.read(@swagger_file))
      @definitions = @swagger["definitions"].as_h
      @paths = @swagger["paths"].as_h
      @generated_types = Set(String).new
    end

    def run
      puts "Generating Kubernetes client from #{@swagger_file}..."
      puts "Found #{@definitions.size} definitions"
      puts "Found #{@paths.size} API paths"

      # Create output directories
      FileUtils.mkdir_p("#{@output_dir}/models")
      FileUtils.mkdir_p("#{@output_dir}/api")

      # Generate models
      generate_models

      # Generate API methods
      generate_apis

      puts "Generation complete!"
    end

    private def generate_models
      puts "\nGenerating models..."

      # Group definitions by group/version
      grouped = group_definitions(@definitions)

      grouped.each do |group_version, defs|
        next if defs.empty?

        file_name = group_version.gsub(".", "_")
        file_path = "#{@output_dir}/models/#{file_name}.cr"

        File.open(file_path, "w") do |f|
          f.puts copyright_header
          f.puts
          f.puts %{require "json"}
          f.puts %{require "yaml"}
          f.puts %{require "../../serialization"}
          f.puts
          f.puts "module Kubernetes"

          defs.each do |name, definition|
            generate_model(f, name, definition)
          end

          f.puts "end"
        end

        puts "  Generated #{file_path} (#{defs.size} types)"
      end
    end

    private def group_definitions(definitions)
      grouped = Hash(String, Hash(String, JSON::Any)).new { |h, k| h[k] = {} of String => JSON::Any }

      definitions.each do |name, definition|
        # Extract group/version from name (e.g., "v1.Pod" -> "v1", "apps.v1.Deployment" -> "apps_v1")
        parts = name.split(".")
        if parts.size >= 2
          # Last part is the type name, everything before is group/version
          group_version = parts[0..-2].join(".")
          grouped[group_version][name] = definition
        else
          grouped["core"][name] = definition
        end
      end

      grouped
    end

    private def generate_model(io, name, definition)
      description = definition["description"]?.try(&.as_s) || ""
      properties = definition["properties"]?.try(&.as_h) || {} of String => JSON::Any
      type = definition["type"]?.try(&.as_s) || "object"

      # Extract simple type name (last part after dots)
      simple_name = name.split(".").last

      # Detect if this type is recursive (references itself)
      is_recursive = recursive_type?(simple_name, properties)

      io.puts
      # Properly handle multi-line descriptions for types
      unless description.empty?
        description.each_line do |line|
          cleaned = line.strip
          io.puts "  # #{cleaned}" if cleaned.size > 0
        end
      end

      # Use class for recursive types, struct for non-recursive
      if is_recursive
        io.puts "  class #{simple_name}"
      else
        io.puts "  struct #{simple_name}"
      end
      io.puts "    include Kubernetes::Serializable"

      # Only add blank line and properties if there are properties
      if properties.any?
        io.puts
        properties.each do |prop_name, prop_def|
          generate_property(io, prop_name, prop_def.as_h)
        end
      end

      io.puts "  end"
    end

    # Check if a type references itself (directly or in arrays/hashes)
    private def recursive_type?(type_name : String, properties : Hash(String, JSON::Any)) : Bool
      properties.each do |_, prop_def|
        prop_hash = prop_def.as_h

        # Check direct reference
        if ref = prop_hash["$ref"]?.try(&.as_s)
          ref_type = ref.split("/").last.split(".").last
          return true if ref_type == type_name
        end

        # Check array items
        if items = prop_hash["items"]?.try(&.as_h)
          if ref = items["$ref"]?.try(&.as_s)
            ref_type = ref.split("/").last.split(".").last
            return true if ref_type == type_name
          end
        end

        # Check additionalProperties (for Hash types)
        if additional = prop_hash["additionalProperties"]?.try(&.as_h)
          if ref = additional["$ref"]?.try(&.as_s)
            ref_type = ref.split("/").last.split(".").last
            return true if ref_type == type_name
          end
        end
      end

      false
    end

    private def generate_property(io, name, definition)
      description = definition["description"]?.try(&.as_s)
      crystal_type = swagger_type_to_crystal(definition)
      crystal_name = snake_case(name)

      # Properly handle multi-line descriptions
      if description && !description.empty?
        description.each_line do |line|
          cleaned = line.strip
          io.puts "    # #{cleaned}" if cleaned.size > 0
        end
      end

      # Handle special fields that need custom JSON keys
      if crystal_name != name
        io.puts "    @[::JSON::Field(key: \"#{name}\")]"
        io.puts "    @[::YAML::Field(key: \"#{name}\")]"
      end

      # Make optional unless required
      is_required = definition["required"]?.try(&.as_bool) || false

      if is_required
        io.puts "    property #{crystal_name} : #{crystal_type}"
      else
        io.puts "    property #{crystal_name} : #{crystal_type}?"
      end
    end

    private def convert_string_type(format : String?) : String
      case format
      when "date-time"
        "Time"
      when "int-or-string"
        "String | Int32"
      else
        "String"
      end
    end

    private def convert_integer_type(format : String?) : String
      case format
      when "int64"
        "Int64"
      else
        "Int32"
      end
    end

    private def convert_array_type(definition) : String
      items = definition["items"]?
      if items
        item_type = swagger_type_to_crystal(items.as_h)
        "Array(#{item_type})"
      else
        "Array(JSON::Any)"
      end
    end

    private def convert_object_type(definition) : String
      additional_props = definition["additionalProperties"]?
      if additional_props && additional_props.as_h?
        value_type = swagger_type_to_crystal(additional_props.as_h)
        "Hash(String, #{value_type})"
      else
        "Hash(String, JSON::Any)"
      end
    end

    private def swagger_type_to_crystal(definition) : String
      ref = definition["$ref"]?
      if ref
        # Reference to another type
        ref_name = ref.as_s.split("/").last
        simple_name = ref_name.split(".").last
        return simple_name
      end

      type = definition["type"]?.try(&.as_s)
      format = definition["format"]?.try(&.as_s)

      case type
      when "string"
        convert_string_type(format)
      when "integer"
        convert_integer_type(format)
      when "number"
        "Float64"
      when "boolean"
        "Bool"
      when "array"
        convert_array_type(definition)
      when "object"
        convert_object_type(definition)
      else
        "JSON::Any"
      end
    end

    private def snake_case(str : String) : String
      # Handle special prefixes like $ which aren't valid Crystal identifiers
      str = str.sub(/^\$/, "ref_")

      str
        .gsub(/([A-Z]+)([A-Z][a-z])/, "\\1_\\2")
        .gsub(/([a-z\d])([A-Z])/, "\\1_\\2")
        .gsub("-", "_")
        .downcase
    end

    private def generate_apis
      puts "\nGenerating API clients..."

      # Group paths by API group/version
      api_groups = group_api_paths(@paths)

      api_groups.each do |group_version, paths|
        file_name = group_version.gsub("/", "_").gsub("-", "_")
        file_path = "#{@output_dir}/api/#{file_name}.cr"

        File.open(file_path, "w") do |f|
          f.puts copyright_header
          f.puts
          f.puts "module Kubernetes"
          f.puts "  class Client"

          paths.each do |path, operations|
            generate_api_methods(f, path, operations.as_h)
          end

          f.puts "  end"
          f.puts "end"
        end

        puts "  Generated #{file_path}"
      end
    end

    private def group_api_paths(paths)
      grouped = Hash(String, Hash(String, JSON::Any)).new { |h, k| h[k] = {} of String => JSON::Any }

      paths.each do |path, operations|
        # Extract API group from path (e.g., "/api/v1", "/apis/apps/v1")
        if path.starts_with?("/api/v")
          group_version = "core_" + path.split("/")[2]
        elsif path.starts_with?("/apis/")
          parts = path.split("/")
          group_version = parts[2..3].join("_") if parts.size >= 4
        else
          group_version = "other"
        end

        grouped[group_version || "other"][path] = operations if group_version
      end

      grouped
    end

    private def generate_api_methods(io, path, operations)
      operations.each do |method, operation|
        next unless ["get", "post", "put", "patch", "delete"].includes?(method)

        op_def = operation.as_h
        operation_id = op_def["operationId"]?.try(&.as_s)
        next unless operation_id

        description = op_def["description"]?.try(&.as_s) || ""

        io.puts
        io.puts "    # #{description}" unless description.empty?
        io.puts "    # #{method.upcase} #{path}"

        # Generate method signature
        method_name = snake_case(operation_id)
        io.puts "    def #{method_name}(**params)"
        io.puts "      path = \"#{path}\""

        # Handle path parameters
        if path.includes?("{")
          io.puts "      params.each { |k, v| path = path.gsub(\"{#{"\#{k}"}}\", v.to_s) }"
        end

        # Make HTTP request
        case method
        when "get"
          io.puts "      get(path) { |res| yield res }"
        when "post", "put", "patch"
          io.puts "      #{method}(path, params) { |res| yield res }"
        when "delete"
          io.puts "      delete(path) { |res| yield res }"
        end

        io.puts "    end"
      end
    end

    private def copyright_header
      <<-HEADER
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
      HEADER
    end
  end
end

# Run generator
if ARGV.size < 2
  puts "Usage: crystal run src/generator/main.cr -- <swagger.json> <output_dir>"
  exit 1
end

generator = Generator::Main.new(ARGV[0], ARGV[1])
generator.run
