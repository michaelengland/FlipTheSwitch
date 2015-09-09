require 'json'
require 'json-schema'

module FlipTheSwitch
  module Reader
    class Features
      INHERITANCE_INDICATOR = 'inherits_from'

      def initialize(input, environment)
        @input = input
        @environment = environment
      end

      def features
        raise Error::InvalidFile.new(input) unless valid_file?
        raise Error::InvalidEnvironment.new(environment) unless file_states.has_key?(environment)
        raise Error::InvalidFile.new(input) unless file_states[environment].is_a?(Hash)

        features = {}
        if inherits?
          features = merged_features
        elsif
          file_states[environment].map { |feature_name, feature_info|
            if feature_name != INHERITANCE_INDICATOR
              features[feature_name] = feature_info
            end
          }
        end

        features.map { |feature_name, feature_info|
          feature_state(feature_name, feature_info)
        }
      end

      private
      attr_reader :input, :environment

      def inherits?
        file_states[environment].has_key?(INHERITANCE_INDICATOR)
      end

      def merged_features
        merged_features_tmp = parent_features
        file_states[environment].map { |feature_name, feature_info|
          if feature_name != INHERITANCE_INDICATOR
            if merged_features_tmp.has_key?(feature_name)
              # check if needs to be overwritten
              feature_info.map { |key, value|
                merged_features_tmp[feature_name][key] = value
              }
            elsif
              merged_features_tmp[feature_name] = feature_info
            end
          end
        }
        merged_features_tmp
      end

      def parent_features
        parent = file_states[environment][INHERITANCE_INDICATOR]
        hash_for_env(parent)
      end

      def hash_for_env(env_label)
        hash = {}
        file_states[env_label].map { |feature_name, feature_info|
          if feature_name != INHERITANCE_INDICATOR
            hash[feature_name] = feature_info
          end
        }
        hash
      end

      def feature_state(feature_name, feature_info)
        raise Error::InvalidFile.new(input) unless feature_info.is_a?(Hash)

        feature_info_dup = feature_info.dup
        enabled = !!feature_info_dup.delete('enabled')
        description = feature_info_dup.delete('description')
        sub_features = feature_info_dup.map { |sub_feature_name, sub_feature_info|
          feature_state(sub_feature_name, sub_feature_info)
        }
        Feature.new(feature_name, enabled, description, sub_features)
      end

      def file_states
        @file_states ||=  JSON.parse(File.read(input))
      end

      def valid_file?
        JSON::Validator.validate(expected_schema, File.read(input)) && file_states.is_a?(Hash)
      rescue SystemCallError => e
        raise Error::UnreadableFile.new(e)
      end

      def expected_schema
         {
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
      end
    end
  end
end
