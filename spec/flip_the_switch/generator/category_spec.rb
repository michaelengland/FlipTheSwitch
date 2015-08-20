require 'spec_helper'

describe FlipTheSwitch::Generator::Category do
  subject(:category) { described_class.new(output, features) }
  let(:output) { 'tmp' }
  let(:first_feature) { FlipTheSwitch::Feature.new('first_feature', true, 'This is the first feature', [second_feature]) }
  let(:second_feature) { FlipTheSwitch::Feature.new('second_feature', false) }
  let(:features) { [first_feature] }
  let(:expected_header_file) { File.read('spec/resources/expected_header.h') }
  let(:expected_implementation_file) { File.read('spec/resources/expected_implementation.m') }

  after do
    delete_header_if_exists
    delete_implementation_if_exists
  end

  it 'writes a FTSFlipTheSwitch+Features.h file with the category header' do
    subject.generate

    expect(output_with('h')).to eql(expected_header_file)
  end

  it 'writes a FTSFlipTheSwitch+Features.m file with the category implementation' do
    subject.generate

    expect(output_with('m')).to eql(expected_implementation_file)
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

  def output_with(suffix)
    File.read(output_name_with(suffix))
  end

  def output_name_with(suffix)
    "#{output}/FTSFlipTheSwitch+Features.#{suffix}"
  end
end
