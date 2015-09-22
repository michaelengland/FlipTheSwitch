require 'spec_helper'
require 'fileutils'

describe FlipTheSwitch::Generator::Settings do
  subject(:settings) { described_class.new(output, features) }
  let(:output) { 'spec/resources' }
  let(:settings_bundle) { File.join(output, 'Settings.bundle') }
  let(:features) { [
    FlipTheSwitch::Feature.new('first_feature', true, nil),
    FlipTheSwitch::Feature.new('second_feature', false, nil)
  ] }
  let(:root_output_file) { File.read(File.join(settings_bundle, 'Root.plist')) }
  let(:features_output_file) { File.read(File.join(settings_bundle, 'Features.plist')) }
  let(:features_output_file) { File.read(File.join(settings_bundle, 'Features.plist')) }
  let(:expected_features_file) { File.read('spec/resources/ExpectedSettingsFeatures.plist') }

  after do
    delete_settings_bundle_if_exists
  end

  context 'when settings already exist' do
    let(:expected_root_file) { File.read('spec/resources/ExpectedSettingsMergeExistingRoot.plist') }

    before do
      Dir.mkdir(settings_bundle)
      File.write(File.join(settings_bundle, 'Root.plist'), File.read('spec/resources/ExistingSettingsRoot.plist'))
    end

    it 'adds child page link to existing settings' do
      subject.generate

      expect(root_output_file).to eql(expected_root_file)
    end

    it 'creates a features settings page' do
      subject.generate

      expect(features_output_file).to eql(expected_features_file)
    end
  end

  context 'when settings already exist and have already got features' do
    let(:expected_root_file) { File.read('spec/resources/ExpectedSettingsMergeExistingRoot.plist') }

    before do
      Dir.mkdir(settings_bundle)
      File.write(File.join(settings_bundle, 'Root.plist'), File.read('spec/resources/ExpectedSettingsMergeExistingRoot.plist'))
      File.write(File.join(settings_bundle, 'Features.plist'), File.read('spec/resources/ExpectedFeatures.plist'))
    end

    it 'creates settings with features child page link' do
      subject.generate

      expect(root_output_file).to eql(expected_root_file)
    end

    it 'creates a features settings page' do
      subject.generate

      expect(features_output_file).to eql(expected_features_file)
    end
  end

  context 'when no settings already exist' do
    let(:expected_root_file) { File.read('spec/resources/ExpectedSettingsBaseRoot.plist') }

    it 'creates settings with features child page link' do
      subject.generate

      expect(root_output_file).to eql(expected_root_file)
    end

    it 'creates a features settings page' do
      subject.generate

      expect(features_output_file).to eql(expected_features_file)
    end
  end

  def delete_settings_bundle_if_exists
    FileUtils.rm_rf(settings_bundle) if Dir.exists?(settings_bundle)
  end
end
