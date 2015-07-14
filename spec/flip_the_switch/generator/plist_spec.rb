require 'spec_helper'

describe FlipTheSwitch::Generator::Plist do
  subject(:plist) { described_class.new(output, features) }
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

  shared_examples "a plist writer" do |output, output_file|
    let(:output) { output }
    let(:output_file) { output_file }

    it "writes a #{File.basename(output_file)} file with the features set" do
      subject.generate

      expect(File.read(output_file)).to eql(expected_plist_file)
    end
  end

  context 'When the output is a directory' do
    it_behaves_like "a plist writer", 'spec/resources', 'spec/resources/Features.plist'
  end

  context 'when the output is a file' do
    it_behaves_like "a plist writer", 'spec/resources/DasPlist.plist', 'spec/resources/DasPlist.plist'
  end
end
