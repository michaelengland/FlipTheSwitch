require 'plist'

module FlipTheSwitch
  module Generator
    class Plist < Base
      def generate
        ::Plist::Emit.save_plist(feature_states, output)
      end
    end
  end
end
