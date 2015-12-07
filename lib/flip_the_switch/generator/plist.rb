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
        all_features.inject({}) do |states, feature|
          states.merge(feature.name => feature_hash(feature))
        end
      end

      def feature_hash(feature)
        if feature.description
          {enabled: feature.enabled, description: feature.description}
        else
          {enabled: feature.enabled}
        end
      end

      def output_file
        if File.directory?(output)
          File.join(output, 'Features.plist')
        else
          output
        end
      end
    end
  end
end
