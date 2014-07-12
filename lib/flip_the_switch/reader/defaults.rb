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
            'input' => Dir.pwd,
            'environment' => 'default',
            'enabled' => '',
            'disabled' => '',
            'output' => Dir.pwd
        }
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
