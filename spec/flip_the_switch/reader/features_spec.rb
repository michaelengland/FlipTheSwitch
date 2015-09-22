require 'spec_helper'

describe FlipTheSwitch::Reader::Features do
  subject(:reader) { described_class.new(input, environment) }
  let(:environment) { 'beta' }

  context 'when input is a directory containing a valid features.yml file' do
    let(:input) { 'spec/resources/real' }

    context 'when given adirectory containing features.yml as input' do
      it 'reads the enabled/disabled states of the features for the environment' do
        expect(subject.features).to eql([
            FlipTheSwitch::Feature.new('enabled_feature', true, 'This feature is enabled', [
                FlipTheSwitch::Feature.new('sub_feature', false)
              ]),
            FlipTheSwitch::Feature.new('disabled_feature', false)
          ])
      end
    end

    context 'when given an invalid environment' do
      let(:environment) { 'invalid' }

      specify do
        expect {
          subject.features
        }.to raise_error(FlipTheSwitch::Error::InvalidEnvironment)
      end
    end
  end

  context 'when input is a valid file' do
    let(:input) { 'spec/resources/real/features.yml' }

    context 'when given adirectory containing features.yml as input' do
      it 'reads the enabled/disabled states of the features for the environment' do
        expect(subject.features).to eql([
            FlipTheSwitch::Feature.new('enabled_feature', true, 'This feature is enabled', [
                FlipTheSwitch::Feature.new('sub_feature', false)
              ]),
            FlipTheSwitch::Feature.new('disabled_feature', false)
          ])
      end
    end

    context 'when given an invalid environment' do
      let(:environment) { 'invalid' }

      specify do
        expect {
          subject.features
        }.to raise_error(FlipTheSwitch::Error::InvalidEnvironment)
      end
    end
  end

  context 'when input is an invalid file' do
    let(:input) { 'spec/resources/invalid_type/features.yml' }

    specify do
      expect {
        subject.features
      }.to raise_error(FlipTheSwitch::Error::InvalidFile)
    end
  end

  context 'when given a non-existent file' do
    let(:input) { 'spec/resources/non-existent' }

    specify do
      expect {
        subject.features
      }.to raise_error(FlipTheSwitch::Error::UnreadableFile)
    end
  end

  context 'when given an invalid file type' do
    let(:input) { 'spec/resources/invalid_type' }

    specify do
      expect {
        subject.features
      }.to raise_error(FlipTheSwitch::Error::InvalidFile)
    end
  end

  context 'when given an invalid file layout' do
    let(:input) { 'spec/resources/invalid_layout' }

    specify do
      expect {
        subject.features
      }.to raise_error(FlipTheSwitch::Error::InvalidFile)
    end
  end
end
