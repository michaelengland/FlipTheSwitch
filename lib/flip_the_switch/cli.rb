require 'thor'
require 'flip_the_switch'

module FlipTheSwitch
  class Cli < Thor
    private
    def self.defaults
      @defaults ||= Reader::Defaults.new.defaults
    end

    public
    class_option :input, type: :string, aliases: '-i', default: defaults['input'], desc: 'Location of the directory containing features.yml file to read'
    class_option :environment, type: :string, aliases: '-n', default: defaults['environment'], desc: 'Name of environment to read from in features.yml file'
    class_option :enabled, type: :string, aliases: '-e', default: defaults['enabled'], desc: 'Extra features to be set as enabled'
    class_option :disabled, type: :string, aliases: '-d', default: defaults['disabled'], desc: 'Extra features to be set as disabled'

    desc 'plist', 'Auto-generates a Features.plist file for enabled/disabled features'
    method_option :output, type: :string, aliases: '-o', default: defaults['output'], desc: 'Location of the directory in which Features.plist file will be created'
    def plist
      plist_generator.generate
    end

    desc 'category', 'Auto-generates .h & .m files for enabled/disabled features'
    method_option :output, type: :string, aliases: '-o', default: defaults['output'], desc: 'Location of the directory in which FlipTheSwitch+Features.{h,m} files will be created'
    def category
      category_generator.generate
    end

    private

    def plist_generator
      Generator::Plist.new(output, feature_states)
    end

    def category_generator
      Generator::Category.new(output, feature_states)
    end

    def output
      options['output']
    end

    def feature_states
      feature_reader.feature_states.
          merge(enabled_states).
          merge(disabled_states)
    end

    def feature_reader
      Reader::Features.new(options['input'], options['environment'])
    end

    def enabled_states
      states_for(options['enabled'].split(','), true)
    end

    def disabled_states
      states_for(options['disabled'].split(','), false)
    end

    def states_for(array, default)
      array.inject({}) do |h, feature|
        h[feature] = default
        h
      end
    end
  end
end
