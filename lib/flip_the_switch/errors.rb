module FlipTheSwitch
  module Error
    class Base < StandardError
    end

    class UnreadableFile < Base
    end

    class InvalidFile < Base
    end

    class InvalidEnvironment < Base
    end
  end
end
