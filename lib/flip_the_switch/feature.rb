module FlipTheSwitch
  class Feature < Struct.new(:name, :enabled, :description, :subfeatures)
    def initialize(name, enabled, description = nil, subfeatures = [])
      super(name, enabled, description, subfeatures)
    end
  end
end
