require 'thor'
require 'flip_the_switch'

module FlipTheSwitch
  class Cli < Thor
    private
    def self.defaults
      @defaults ||= Reader::Defaults.new.defaults
    end

    public
    class_option :input, type: :string, aliases: '-i', default: defaults['input'], desc: 'Filename or directory containing features.json file to read'
    class_option :environment, type: :string, aliases: '-n', default: defaults['environment'], desc: 'Name of environment to read from features.json file'

    desc 'plist', 'Auto-generates a Features.plist file for enabled/disabled features'
    method_option :output, type: :string, aliases: '-o', default: defaults['plist_output'], desc: 'Filename or directory in which Features.plist file will be created'

    def plist
      plist_generator.generate
    end

    desc 'category', 'Auto-generates .h & .m files for enabled/disabled features'
    method_option :output, type: :string, aliases: '-o', default: defaults['category_output'], desc: 'Location of the directory in which FlipTheSwitch+Features.{h,m} files will be created'

    def category
      category_generator.generate
    end

    desc 'settings', 'Auto-generates settings.bundle files for enabling/disabling features from iOS settings menu'
    method_option :output, type: :string, aliases: '-o', default: defaults['settings_output'], desc: 'Location of the directory in which FlipTheSwitch+Features.{h,m} files will be created'

    def settings
      settings_generator.generate
    end

    private

    def plist_generator
      Generator::Plist.new(output, features)
    end

    def category_generator
      Generator::Category.new(output, features)
    end

    def settings_generator
      Generator::Settings.new(output, features)
    end

    def output
      options['output']
    end

    def features
      feature_reader.features
    end

    def feature_reader
      Reader::Features.new(input, options['environment'])
    end

    def input
      if File.directory?(options['input'])
        File.join(options['input'], 'features.json')
      else
        options['input']
      end
    end
  end
end
