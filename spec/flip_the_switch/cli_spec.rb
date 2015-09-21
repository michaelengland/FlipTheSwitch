require 'spec_helper'

describe FlipTheSwitch::Cli do
  subject(:cli) { described_class }
  let(:perform) { subject.start([command] + options, debug: true) }

  context 'when invalid command called' do
    let(:command) { 'invalid' }
    let(:options) { [] }

    it 'throws an error' do
      expect {
        perform
      }.to raise_error
    end
  end

  shared_examples_for 'generator' do
    let(:feature_reader) { double(FlipTheSwitch::Reader::Features, features: features_for_hash('something' => true)) }
    let(:generator) { double(generator_class) }

    context 'when no options given' do
      let(:options) { [] }

      before do
        FlipTheSwitch::Reader::Features.stub(:new).with(File.join(Dir.pwd, 'features.json'), 'default').and_return(feature_reader)
        generator_class.stub(:new).with(Dir.pwd, features_for_hash('something' => true)).and_return(generator)
      end

      it 'generates using default options' do
        expect(generator).to receive(:generate)
        perform
      end
    end

    context 'when options given' do
      before do
        FlipTheSwitch::Reader::Features.stub(:new).with('input', 'environment').and_return(feature_reader)
        generator_class.stub(:new).with('output', features_for_hash('something' => true)).and_return(generator)
      end

      context 'using full name' do
        let(:options) { %w(--input=input --environment=environment --output=output) }

        it 'generates using the options given' do
          expect(generator).to receive(:generate)
          perform
        end
      end

      context 'using aliases' do
        let(:options) { %w(-i=input -n=environment -o=output) }

        it 'generates using the options given' do
          expect(generator).to receive(:generate)
          perform
        end
      end
    end
  end

  def features_for_hash(hash)
    hash.map { |feature, enabled|
      FlipTheSwitch::Feature.new(feature, enabled)
    }
  end

  context 'when plist command called' do
    let(:command) { 'plist' }
    let(:generator_class) { FlipTheSwitch::Generator::Plist }

    it_behaves_like 'generator'
  end

  context 'when category command called' do
    let(:command) { 'category' }
    let(:generator_class) { FlipTheSwitch::Generator::Category }

    it_behaves_like 'generator'
  end

  context 'when settings command called' do
    let(:command) { 'settings' }
    let(:generator_class) { FlipTheSwitch::Generator::Settings }

    it_behaves_like 'generator'
  end
end
