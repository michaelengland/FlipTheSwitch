require 'spec_helper'

describe FlipTheSwitch::Cli do
  subject(:cli) { described_class }
  let(:yaml_reader) { double(FlipTheSwitch::Reader::Yaml, feature_states: {'something' => true}) }
  let(:plist_generator) { double(FlipTheSwitch::Generator::Plist) }
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

  context 'when plist command called' do
    let(:command) { 'plist' }

    context 'when no options given' do
      let(:options) { [] }

      before do
        FlipTheSwitch::Reader::Yaml.stub(:new).with('features.yml').and_return(yaml_reader)
        FlipTheSwitch::Generator::Plist.stub(:new).with('Features.plist', {
            'something' => true
        }).and_return(plist_generator)
      end

      it 'generates a plist using default options' do
        expect(plist_generator).to receive(:generate)
        perform
      end
    end

    context 'when options given' do
      before do
        FlipTheSwitch::Reader::Yaml.stub(:new).with('input').and_return(yaml_reader)
        FlipTheSwitch::Generator::Plist.stub(:new).with('output', {
            'something' => true,
            'en' => true,
            'abled' => true,
            'dis' => false,
            'appointing' => false
        }).and_return(plist_generator)
      end

      context 'using full name' do
        let(:options) { %w(--input=input --output=output --enabled=en abled --disabled=dis appointing) }

        it 'generates a plist using the options given' do
          expect(plist_generator).to receive(:generate)
          perform
        end
      end

      context 'using aliases' do
        let(:options) { %w(-i=input -o=output -e=en abled -d=dis appointing) }

        it 'generates a plist using the options given' do
          expect(plist_generator).to receive(:generate)
          perform
        end
      end
    end
  end
end
