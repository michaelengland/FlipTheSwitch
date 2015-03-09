require 'flip_the_switch/generator/base'
require 'active_support/inflector'
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
        File.delete(file) if File.exists?(file)
      end

      def header_file
        File.join(output, 'FlipTheSwitch+Features.h')
      end

      def implementation_file
        File.join(output, 'FlipTheSwitch+Features.m')
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

      def feature_names
        feature_states.keys.map(&:to_s)
      end
    end
  end
end
