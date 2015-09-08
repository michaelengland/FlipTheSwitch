require 'json'
require 'json-schema'

module FlipTheSwitch
  module Reader
    class Features
      INHERITANCE_INDICATOR = "inherits_from"

      def initialize(input, environment)
        @input = input
        @environment = environment
      end

      def features
        raise Error::InvalidFile.new(input_file) unless valid_file?
        raise Error::InvalidEnvironment.new(environment) unless file_states.has_key?(environment)
        raise Error::InvalidFile.new(input_file) unless file_states[environment].is_a?(Hash)

        parent = nil
        if file_states[environment].has_key?(INHERITANCE_INDICATOR)
          parent = file_states[environment][INHERITANCE_INDICATOR]
        end

        merged_env_hash = {}

        if parent
          file_states[parent].map { |feature_name, feature_info|
            if feature_name != INHERITANCE_INDICATOR
              merged_env_hash[feature_name] = feature_info
            end
          }
        end
        file_states[environment].map { |feature_name, feature_info|
          if feature_name != INHERITANCE_INDICATOR
            if merged_env_hash.has_key?(feature_name)
              feature_info.map { |key, value|
                  merged_env_hash[feature_name][key] = value
              }
            end
          end
        }

        merged_env_hash.map { |feature_name, feature_info|
          feature_state(feature_name, feature_info)
        }
      end

      private
      attr_reader :input, :environment

      def feature_state(feature_name, feature_info)
        raise Error::InvalidFile.new(input_file) unless feature_info.is_a?(Hash)

        feature_info_dup = feature_info.dup
        enabled = !!feature_info_dup.delete('enabled')
        description = feature_info_dup.delete('description')
        sub_features = feature_info_dup.map { |sub_feature_name, sub_feature_info|
          feature_state(sub_feature_name, sub_feature_info)
        }
        Feature.new(feature_name, enabled, description, sub_features)
      end

      def file_states

        @file_states ||=  JSON.parse(File.read(input_file))
      end

      def input_file
        if File.directory?(input)
          File.join(input, 'features.json')
        else
          input
        end
      end

      def valid_file?
        schema = {
          "type" => "object",
          "additionalProperties" => {
            "type" => "object",
            "additionalProperties" => {
                "properties" => {
                    "enabled" => {
                        "type" => "boolean"
                    },
                    "description" => {
                        "type" => "string"
                    }
                },
                "required" => [
                    "enabled"
                ]
            }
          }
        }

        JSON::Validator.validate(schema, File.read(input_file)) && file_states.is_a?(Hash)
      rescue SystemCallError => e
        raise Error::UnreadableFile.new(e)
      end
    end
  end
end
