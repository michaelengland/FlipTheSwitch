module FlipTheSwitch
  module Error
    class Base < StandardError
    end

    class UnreadableFile < Base
    end

    class InvalidFile < Base
    end
  end
end
