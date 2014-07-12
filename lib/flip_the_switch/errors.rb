module FlipTheSwitch
  module Error
    class Base < StandardError
    end

    class UnreadableFile < Base
    end

    class InvalidFile < Base
      def initialize(file)
        super("Invalid file - #{file}")
      end
    end

    class InvalidEnvironment < Base
      def initialize(environment)
        super("Invalid environment - #{environment}")
      end
    end
  end
end
