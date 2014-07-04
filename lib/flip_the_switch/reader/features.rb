require 'yaml'

module FlipTheSwitch
  module Reader
    class Features
      def initialize(input, environment)
        @input = input
        @environment = environment
      end

      def feature_states
        if valid_file?
          environment_states
        else
          raise Error::InvalidFile.new
        end
      end

      private
      attr_reader :input, :environment

      def valid_file?
        file_states.is_a?(Hash) && file_states.all? { |environment, feature|
          environment.is_a?(String) && valid_feature_hash?(feature)
        }
      end

      def valid_feature_hash?(feature_hash)
        feature_hash.is_a?(Hash) && feature_hash.all? { |feature, state|
          feature.is_a?(String) && !!state == state
        }
      end

      def environment_states
        if file_states.has_key?(environment)
          file_states[environment]
        else
          raise Error::InvalidEnvironment
        end
      end

      def file_states
        @file_states ||= YAML.load_file(input_file)
      rescue SystemCallError => e
        raise Error::UnreadableFile.new(e)
      end

      def input_file
        File.join(input, 'features.yml')
      end
    end
  end
end
