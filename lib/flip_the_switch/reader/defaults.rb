require 'active_support/core_ext/hash/indifferent_access'

module FlipTheSwitch
  module Reader
    class Defaults
      def defaults
        if valid_file?
          base_defaults.merge(file_defaults)
        else
          raise Error::InvalidFile.new(defaults_file)
        end
      end

      private

      def valid_file?
        file_defaults.is_a?(Hash)
      end

      def base_defaults
        {
            input: Dir.pwd,
            environment: 'default',
            enabled: '',
            disabled: '',
            category_output: Dir.pwd,
            plist_output: Dir.pwd,
            settings_output: Dir.pwd
        }.with_indifferent_access
      end

      def file_defaults
        @file_defaults ||= YAML.load_file(defaults_file)
      rescue SystemCallError
        {}
      end

      def defaults_file
        '.flip.yml'
      end
    end
  end
end
