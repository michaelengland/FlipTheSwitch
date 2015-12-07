require 'flip_the_switch/generator/base'
require 'erb'

module FlipTheSwitch
  module Generator
    class Category < Base
      def generate
        delete_existing
        write_files
      end

      private

      def delete_existing
        delete_file(header_file)
        delete_file(implementation_file)
      end

      def write_files
        write_file(header_file, header)
        write_file(implementation_file, implementation)
      end

      def write_file(file, text)
        File.open(file, 'w') do |f|
          f.syswrite(text)
        end
      end

      def delete_file(file)
        if File.exists?(file)
          File.delete(file)
        end
      end

      def header_file
        File.join(output, 'FTSFlipTheSwitch+Features.h')
      end

      def implementation_file
        File.join(output, 'FTSFlipTheSwitch+Features.m')
      end

      def header
        render(header_template)
      end

      def implementation
        render(implementation_template)
      end

      def render(template)
        ERB.new(template, nil, '-').result(binding)
      end

      def header_template
        file_template('header.h')
      end

      def implementation_template
        file_template('implementation.m')
      end

      def file_template(name)
        File.read(File.expand_path("../#{name}.erb", __FILE__))
      end

      def lower_camelize(string)
        str = camelize(string)
        if str.empty?
          ''
        else
          str[0] = str[0].downcase
          str
        end
      end

      def camelize(string)
        string.split('_').each {|s| s.capitalize! }.join('')
      end
    end
  end
end
