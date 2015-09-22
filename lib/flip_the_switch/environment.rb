module FlipTheSwitch
  class Environment < Struct.new(:name, :features, :parent_name)
    def initialize(name, features = [], parent_name = nil)
      super(name, features, parent_name)
    end

    def has_parent?
      parent_name
    end
  end
end
