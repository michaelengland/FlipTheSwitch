require 'yaml'

module FlipTheSwitch
  module Reader
    class Yaml
      def initialize(input)
        @input = input
      end

      def feature_states
        if valid_file?
          file_states
        else
          raise Error::InvalidFile.new
        end
      end

      private
      attr_reader :input

      def valid_file?
        file_states.is_a?(Hash) && file_states.all? { |feature, state|
          feature.is_a?(String) && !!state == state
        }
      end

      def file_states
        @file_states ||= YAML.load_file(input)
      rescue SystemCallError => e
        raise Error::UnreadableFile.new(e)
      end
    end
  end
end

