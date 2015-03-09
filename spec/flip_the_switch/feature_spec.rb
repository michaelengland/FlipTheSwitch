require 'spec_helper'

describe FlipTheSwitch::Feature do
  subject!(:feature) { described_class.new('main_feature', true, 'hmm', [sub_feature]) }
  let!(:sub_feature) { described_class.new('sub_feature', false) }

  it 'sets the parent on any sub_features' do
    expect(sub_feature.parent).to eql(subject)
  end
end
