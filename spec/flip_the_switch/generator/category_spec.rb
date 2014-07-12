require 'spec_helper'

describe FlipTheSwitch::Generator::Category do
  subject(:category) { described_class.new(output, feature_states) }
  let(:output) { 'spec/resources' }
  let(:feature_states) { {'first_feature' => true, 'second_feature' => false} }
  let(:expected_header_file) { File.read('spec/resources/expected_header.h') }
  let(:expected_implementation_file) { File.read('spec/resources/expected_implementation.m') }

  after do
    delete_header_if_exists
    delete_implementation_if_exists
  end

  it 'writes a FlipTheSwitch+Features.h file with the category header' do
    subject.generate

    expect(File.read(output_name_with('h'))).to eql(expected_header_file)
  end

  it 'writes a FlipTheSwitch+Features.m file with the category implementation' do
    subject.generate

    expect(File.read(output_name_with('m'))).to eql(expected_implementation_file)
  end

  private

  def delete_header_if_exists
    delete_output_if_exists_with('h')
  end

  def delete_implementation_if_exists
    delete_output_if_exists_with('m')
  end

  def delete_output_if_exists_with(suffix)
    File.delete(output_name_with(suffix)) if File.exists?(output_name_with(suffix))
  end

  def output_name_with(suffix)
    "#{output}/FlipTheSwitch+Features.#{suffix}"
  end
end
