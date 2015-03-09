module FlipTheSwitch
  class Feature < Struct.new(:name, :enabled, :description, :sub_features, :parent)
    def initialize(name, enabled, description = nil, sub_features = [])
      super(name, enabled, description, sub_features)
      sub_features.each do |sub_feature|
        sub_feature.parent = self
      end
    end
  end
end
