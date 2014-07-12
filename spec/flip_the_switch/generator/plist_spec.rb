require 'spec_helper'

describe FlipTheSwitch::Generator::Plist do
  subject(:plist) { described_class.new(output, feature_states) }
  let(:output) { 'spec/resources' }
  let(:feature_states) { {enabled_feature: true, disabled_feature: false} }
  let(:output_file) { 'spec/resources/Features.plist' }
  let(:expected_plist_file) { File.read('spec/resources/ExpectedFeatures.plist') }

  after do
    File.delete(output_file) if File.exists?(output_file)
  end

  it 'writes a Features.plist file with the enabled features set' do
    subject.generate

    expect(File.read(output_file)).to eql(expected_plist_file)
  end
end
