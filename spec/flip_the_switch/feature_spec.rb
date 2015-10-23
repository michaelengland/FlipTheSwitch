require 'spec_helper'

describe FlipTheSwitch::Feature do
  subject(:feature) { described_class.new('main_feature', true, 'hmm', [sub_feature]) }
  let(:sub_feature) { described_class.new('sub_feature', false, nil, [], 'main_feature') }

  describe '#has_parent?' do
    context 'when has a parent' do
      specify {
        expect(sub_feature.has_parent?).to be_true
      }
    end

    context 'when has NO parent' do
      specify {
        expect(feature.has_parent?).to be_false
      }
    end
  end
end
