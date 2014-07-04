module FlipTheSwitch
  module Reader
    class Settings
      def defaults
        if valid_file?
          base_defaults.merge(file_defaults)
        else
          raise Error::InvalidFile
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
            'output' => Dir.pwd
        }
      end

      def file_defaults
        @file_defaults ||= YAML.load_file(settings_file)
      rescue SystemCallError
        {}
      end

      def settings_file
        '.flip.yml'
      end
    end
  end
end
