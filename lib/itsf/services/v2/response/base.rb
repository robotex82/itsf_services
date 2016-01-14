module Itsf
  module Services
    module V2
      module Response
        class Base
          extend ActiveModel::Naming

          attr_reader :errors
          attr_reader :messages
          attr_writer :success

          def initialize
            @messages = []
            @errors = ActiveModel::Errors.new(self)
          end

          def success?
            @errors.blank?
          end

          def failed?
            !success?
          end

          def read_attribute_for_validation(attr)
            send(attr)
          end

          def self.human_attribute_name(attr, _options = {})
            attr
          end

          def self.lookup_ancestors
            [self]
          end

          private

          attr_writer :errors
          attr_writer :messages
        end
      end
    end
  end
end
