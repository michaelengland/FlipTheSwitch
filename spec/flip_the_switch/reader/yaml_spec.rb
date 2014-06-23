require 'spec_helper'

describe FlipTheSwitch::Reader::Yaml do
  subject(:reader) { described_class.new(input) }

  context 'when given a real file' do
    let(:input) { 'spec/resources/features.yml' }

    it 'reads the enabled/disabled states of the features' do
      expect(subject.feature_states).to eql('enabled_feature' => true, 'disabled_feature' => false)
    end
  end

  context 'when given a non-existent file' do
    let(:input) { 'spec/resources/non-existent' }

    specify do
      expect {
        subject.feature_states
      }.to raise_error(FlipTheSwitch::Error::UnreadableFile)
    end
  end

  context 'when given an invalid file type' do
    let(:input) { 'spec/resources/invalid.txt' }

    specify do
      expect {
        subject.feature_states
      }.to raise_error(FlipTheSwitch::Error::InvalidFile)
    end
  end

  context 'when given an invalid file layout' do
    let(:input) { 'spec/resources/invalid.yml' }

    specify do
      expect {
        subject.feature_states
      }.to raise_error(FlipTheSwitch::Error::InvalidFile)
    end
  end
end
