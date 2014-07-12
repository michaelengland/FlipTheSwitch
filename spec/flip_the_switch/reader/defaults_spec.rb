require 'spec_helper'

describe FlipTheSwitch::Reader::Defaults do
  subject(:reader) { described_class.new }
  let(:defaults_file) { '.flip.yml' }

  after do
    File.delete(defaults_file) if File.exists?(defaults_file)
  end

  context 'when defaults file exists' do
    context 'when valid' do
      before do
        File.write(defaults_file, YAML.dump({
            'input' => 'input',
            'environment' => 'environment',
            'enabled' => 'enabled',
            'disabled' => 'disabled',
            'output' => 'output'
        }))
      end

      it 'returns file input default' do
        expect(subject.defaults['input']).to eql('input')
      end

      it 'returns file environment default' do
        expect(subject.defaults['environment']).to eql('environment')
      end

      it 'returns file enabled default' do
        expect(subject.defaults['enabled']).to eql('enabled')
      end

      it 'returns file disabled default' do
        expect(subject.defaults['disabled']).to eql('disabled')
      end

      it 'returns file output default' do
        expect(subject.defaults['output']).to eql('output')
      end
    end

    context 'when invalid' do
      before do
        File.write(defaults_file, 'this is not what we want')
      end

      specify do
        expect {
          subject.defaults
        }.to raise_error(FlipTheSwitch::Error::InvalidFile)
      end
    end
  end

  context 'when defaults file does NOT exist' do
    it 'returns base input default' do
      expect(subject.defaults['input']).to eql(Dir.pwd)
    end

    it 'returns base environment default' do
      expect(subject.defaults['environment']).to eql('default')
    end

    it 'returns base enabled default' do
      expect(subject.defaults['enabled']).to eql('')
    end

    it 'returns base disabled default' do
      expect(subject.defaults['disabled']).to eql('')
    end

    it 'returns base output default' do
      expect(subject.defaults['output']).to eql(Dir.pwd)
    end
  end
end
