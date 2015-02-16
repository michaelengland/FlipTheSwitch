require 'flip_the_switch/generator/base'
require 'plist'

module FlipTheSwitch
  module Generator
    class Plist < Base
      def generate
        ::Plist::Emit.save_plist(feature_states, output_file)
      end

      private

      def feature_states
        features.inject({}) do |states, feature|
          states.merge(feature.name => feature.enabled)
        end
      end

      def output_file
        File.join(output, 'Features.plist')
      end
    end
  end
end
