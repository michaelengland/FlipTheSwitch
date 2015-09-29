require 'spec_helper'

describe FlipTheSwitch::Environment do
  subject(:environment) { described_class.new('main_environment') }
  let(:sub_environment) { described_class.new('sub_environment', [], 'main_environment') }

  describe '#has_parent?' do
    context 'when has a parent' do
      specify {
        expect(sub_environment.has_parent?).to be_true
      }
    end

    context 'when has NO parent' do
      specify {
        expect(environment.has_parent?).to be_false
      }
    end
  end
end
