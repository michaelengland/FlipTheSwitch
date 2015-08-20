require 'spec_helper'

describe FlipTheSwitch::Generator::Plist do
  subject(:plist) { described_class.new(output, features) }
  let(:output) { 'tmp' }
  let(:features) { [
    FlipTheSwitch::Feature.new('enabled_feature', true, nil),
    FlipTheSwitch::Feature.new('disabled_feature', false, 'is disabled description')
  ] }
  let(:output_file) { 'tmp/Features.plist' }
  let(:actual_output_file) { File.read(output_file) }
  let(:expected_plist_file) { File.read('spec/resources/ExpectedFeatures.plist') }

  after do
    File.delete(output_file) if File.exists?(output_file)
  end

  it 'writes a Features.plist file with the enabled features set' do
    subject.generate

    expect(actual_output_file).to eql(expected_plist_file)
  end
end
