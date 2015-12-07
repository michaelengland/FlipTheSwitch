module FlipTheSwitch
  module Generator
    class Base
      def initialize(output, features)
        @output = output
        @features = features
      end

      protected
      attr_reader :output, :features

      def all_features
        features.flat_map { |feature|
          feature_and_sub_features(feature)
        }
      end

      private
      def feature_and_sub_features(feature)
        [feature] + feature.sub_features.flat_map { |sub_feature|
          feature_and_sub_features(sub_feature)
        }
      end
    end
  end
end
