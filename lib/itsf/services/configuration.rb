require 'active_support/core_ext/module/delegation'
require 'active_support/core_ext/module/attribute_accessors'
require 'active_support/hash_with_indifferent_access'

module Itsf
  module Services
    module Configuration
      def configure
        yield self
      end

      mattr_accessor :silenced_levels do
        {
          test:        [],
          development: [],
          production:  []
        }
      end

      def silenced_levels=(silenced_levels)
        @@silenced_levels = silenced_levels.with_indifferent_access
      end
    end
  end
end
