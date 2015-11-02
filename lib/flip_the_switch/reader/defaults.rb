require 'yaml'

module FlipTheSwitch
  module Reader
    class Defaults
      def defaults
        if valid_file?
          base_defaults.merge(file_defaults)
        else
          raise Error::InvalidFile.new(defaults_file_name)
        end
      end

      private

      def valid_file?
        file_defaults.is_a?(Hash)
      end

      def base_defaults
        {
          'input' => Dir.pwd,
          'environment' => 'default',
          'enabled' => '',
          'disabled' => '',
          'category_output' => Dir.pwd,
          'plist_output' => Dir.pwd,
          'settings_output' => Dir.pwd
        }
      end

      def file_defaults
        @file_defaults ||= if File.exists?(defaults_file_name)
          YAML.load(File.read(defaults_file_name))
        else
          {}
        end
      end

      def defaults_file_name
        '.flip.yml'
      end
    end
  end
end
