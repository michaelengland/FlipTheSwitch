require 'plist'

module FlipTheSwitch
  module Generator
    class Plist
      def initialize(output, feature_states)
        @output = output
        @feature_states = feature_states
      end

      def generate
        ::Plist::Emit.save_plist(feature_states, output)
      end

      private
      attr_reader :output, :feature_states
    end
  end
end
