require 'spec_helper'

describe FlipTheSwitch::Generator::Plist do
  subject(:plist) { FlipTheSwitch::Generator::Plist.new(output, feature_states) }
  let(:output) { 'spec/resources/Features.plist' }
  let(:feature_states) { {enabled_feature: true, disabled_feature: false} }

  after do
    File.delete(output) if File.exists?(output)
  end

  it 'writes a Features.plist file with the enabled features set' do
    subject.generate

    expect(File.exists?(output)).to be_true
  end
end
