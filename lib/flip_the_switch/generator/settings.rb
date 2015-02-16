require 'flip_the_switch/generator/base'
require 'active_support/core_ext/hash/indifferent_access'
require 'plist'

module FlipTheSwitch
  module Generator
    class Settings < Base
      def generate
        create_settings_bundle_if_not_exists
        read_settings
        delete_existing_settings_if_exist
        write_settings
      end

      private

      def create_settings_bundle_if_not_exists
        unless Dir.exists?(settings_bundle)
          Dir.mkdir(settings_bundle)
        end
      end

      def read_settings
        current_plist
      end

      def delete_existing_settings_if_exist
        delete_root_plist_if_exists
        delete_features_plist_if_exists
      end

      def write_settings
        write_root_plist
        write_features_plist
      end

      def delete_root_plist_if_exists
        delete_file(root_plist)
      end

      def delete_features_plist_if_exists
        delete_file(features_plist)
      end

      def write_root_plist
        ::Plist::Emit.save_plist(root, root_plist)
      end

      def write_features_plist
        ::Plist::Emit.save_plist(feature_properties, features_plist)
      end

      def delete_file(file)
        File.delete(file) if File.exists?(file)
      end

      def root
        current_plist.with_indifferent_access.merge(PreferenceSpecifiers: root_preferences)
      end

      def root_preferences
        existing_root_preferences.delete_if { |root_preference|
          root_preference[:Title] == 'Features'
        } + feature_root_preferences
      end

      def existing_root_preferences
        current_plist.with_indifferent_access[:PreferenceSpecifiers] || []
      end

      def feature_root_preferences
        [
            {
                Title: 'Features',
                Type: 'PSGroupSpecifier'
            },
            {
                File: 'Features',
                Title: 'Features',
                Type: 'PSChildPaneSpecifier'
            }
        ]
      end

      def feature_properties
        {PreferenceSpecifiers: feature_toggles}
      end

      def feature_toggles
        features.map { |feature|
          {
              Type: 'PSToggleSwitchSpecifier',
              Title: feature.name,
              Key: "FTS_FEATURE_#{feature.name}",
              DefaultValue: feature.enabled
          }
        }
      end

      def current_plist
        @current_plist ||= if File.exists?(root_plist)
                             ::Plist::parse_xml(root_plist)
                           else
                             {}
                           end
      end

      def root_plist
        File.join(settings_bundle, 'Root.plist')
      end

      def features_plist
        File.join(settings_bundle, 'Features.plist')
      end

      def settings_bundle
        File.join(output, 'Settings.bundle')
      end
    end
  end
end
