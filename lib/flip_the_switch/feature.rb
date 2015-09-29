module FlipTheSwitch
  class Feature < Struct.new(:name, :enabled, :description, :sub_features, :parent_name)
    def initialize(name, enabled, description = nil, sub_features = [], parent_name = nil)
      super(name, enabled, description, sub_features, parent_name)
    end

    def has_parent?
      parent_name
    end
  end
end
