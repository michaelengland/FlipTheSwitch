require 'spec_helper'

describe FlipTheSwitch::Reader::Features do
  subject(:reader) { described_class.new(input, environment) }
  let(:environment) { 'defaults' }
  let(:input) { 'spec/resources/real/features.json' }

  context 'when given an valid environment' do
    context 'when reading a standard environment' do
      it 'reads the enabled/disabled states of the features for the environment' do
        expect(subject.features).to eql([
              FlipTheSwitch::Feature.new('enabled_feature', true, 'This feature is enabled', [
                  FlipTheSwitch::Feature.new('sub_feature', false, nil, [
                      FlipTheSwitch::Feature.new('sub_sub_feature', false, nil, [], 'sub_feature')
                    ], 'enabled_feature')
                ]),
              FlipTheSwitch::Feature.new('disabled_feature', false, 'This feature is disabled')
            ])
      end
    end


    context 'when reading an inherited environment' do
      let(:environment) { 'alpha' }

      it 'reads the enabled/disabled states of the features for the environment' do
        expect(subject.features).to eql([
              FlipTheSwitch::Feature.new('enabled_feature', false, 'This feature is enabled', [
                  FlipTheSwitch::Feature.new('sub_feature', false, nil, [
                      FlipTheSwitch::Feature.new('sub_sub_feature', false, nil, [], 'sub_feature')
                    ], 'enabled_feature')
                ]),
              FlipTheSwitch::Feature.new('disabled_feature', false, 'This feature is disabled')
            ])
      end
    end

    context 'when reading an double inherited environment' do
      let(:environment) { 'beta' }

      it 'reads the enabled/disabled states of the features for the environment' do
        expect(subject.features).to eql([
              FlipTheSwitch::Feature.new('enabled_feature', true, 'This feature is enabled', [
                  FlipTheSwitch::Feature.new('sub_feature', false, nil, [
                      FlipTheSwitch::Feature.new('sub_sub_feature', false, nil, [], 'sub_feature')
                    ], 'enabled_feature')
                ]),
              FlipTheSwitch::Feature.new('disabled_feature', false, 'This feature is disabled')
            ])
      end
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

  context 'when given an invalid environment' do
    let(:environment) { 'invalid' }

    specify do
      expect {
        subject.features
      }.to raise_error(FlipTheSwitch::Error::InvalidEnvironment)
    end
  end

  context 'when input is an invalid file' do
    let(:input) { 'spec/resources/invalid_type/features.json' }

    specify do
      expect {
        subject.features
      }.to raise_error(FlipTheSwitch::Error::InvalidFile)
    end
  end

  context 'when given a non-existent file' do
    let(:input) { 'spec/resources/non-existent/features.json' }

    specify do
      expect {
        subject.features
      }.to raise_error(FlipTheSwitch::Error::UnreadableFile)
    end
  end

  context 'when given an invalid file type' do
    let(:input) { 'spec/resources/invalid_type/features.json' }

    specify do
      expect {
        subject.features
      }.to raise_error(FlipTheSwitch::Error::InvalidFile)
    end
  end

  context 'when given an invalid file layout' do
    let(:input) { 'spec/resources/invalid_layout/features.json' }

    specify do
      expect {
        subject.features
      }.to raise_error(FlipTheSwitch::Error::InvalidFile)
    end
  end
end
