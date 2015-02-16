require 'yaml'

module FlipTheSwitch
  module Reader
    class Features
      def initialize(input, environment)
        @input = input
        @environment = environment
      end

      def features
        raise Error::InvalidFile.new(input_file) unless file_states.is_a?(Hash)
        raise Error::InvalidEnvironment.new(environment) unless file_states.has_key?(environment)

        file_states[environment].map { |feature_name, feature_info|
          feature_state(feature_name, feature_info)
        }
      end

      private
      attr_reader :input, :environment

      def feature_state(feature_name, feature_info)
        feature_info_dup = feature_info.dup
        enabled = !!feature_info_dup.delete('enabled')
        description = feature_info_dup.delete('description')

        raise Error::InvalidFile.new(input_file) unless feature_info_dup.empty?

        Feature.new(feature_name, enabled, description)
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
