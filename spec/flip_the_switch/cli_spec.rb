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
    let(:yaml_reader) { double(FlipTheSwitch::Reader::Yaml, feature_states: {'something' => true}) }
    let(:generator) { double(generator_class) }

    context 'when no options given' do
      let(:options) { [] }

      before do
        FlipTheSwitch::Reader::Yaml.stub(:new).with(Dir.pwd).and_return(yaml_reader)
        generator_class.stub(:new).with(Dir.pwd, 'something' => true).and_return(generator)
      end

      it 'generates using default options' do
        expect(generator).to receive(:generate)
        perform
      end
    end

    context 'when options given' do
      before do
        FlipTheSwitch::Reader::Yaml.stub(:new).with('input').and_return(yaml_reader)
        generator_class.stub(:new).with('output', {
            'something' => true,
            'en' => true,
            'abled' => true,
            'dis' => false,
            'appointing' => false
        }).and_return(generator)
      end

      context 'using full name' do
        let(:options) { %w(--input=input --output=output --enabled=en abled --disabled=dis appointing) }

        it 'generates using the options given' do
          expect(generator).to receive(:generate)
          perform
        end
      end

      context 'using aliases' do
        let(:options) { %w(-i=input -o=output -e=en abled -d=dis appointing) }

        it 'generates using the options given' do
          expect(generator).to receive(:generate)
          perform
        end
      end
    end
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
end
