module FlipTheSwitch
  module Generator
    class Base
      def initialize(output, features)
        @output = output
        @features = features
      end

      protected
      attr_reader :output, :features
    end
  end
end
