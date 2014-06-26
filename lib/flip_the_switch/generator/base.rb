module FlipTheSwitch
  module Generator
    class Base
      def initialize(output, feature_states)
        @output = output
        @feature_states = feature_states
      end

      protected
      attr_reader :output, :feature_states
    end
  end
end
