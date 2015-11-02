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
            'category_output' => 'category_output',
            'plist_output' => 'plist_output',
            'settings_output' => 'settings_output'
        }))
      end

      it 'returns file input default' do
        expect(subject.defaults['input']).to eql('input')
      end

      it 'returns file environment default' do
        expect(subject.defaults['environment']).to eql('environment')
      end

      it 'returns file category output default' do
        expect(subject.defaults['category_output']).to eql('category_output')
      end

      it 'returns file plist output default' do
        expect(subject.defaults['plist_output']).to eql('plist_output')
      end

      it 'returns file settings output default' do
        expect(subject.defaults['settings_output']).to eql('settings_output')
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

    it 'returns base category output default' do
      expect(subject.defaults['category_output']).to eql(Dir.pwd)
    end

    it 'returns base plist output default' do
      expect(subject.defaults['plist_output']).to eql(Dir.pwd)
    end

    it 'returns base settings output default' do
      expect(subject.defaults['settings_output']).to eql(Dir.pwd)
    end
  end
end
