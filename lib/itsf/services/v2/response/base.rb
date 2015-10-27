module Itsf
  module Services
    module V2
      module Response
        class Base
          extend ActiveModel::Naming

          attr_reader :errors
          attr_writer :success

          def initialize
            @errors  = ActiveModel::Errors.new(self)
            @success = false
          end

          def success?
            @success
          end

          def read_attribute_for_validation(attr)
            send(attr)
          end

          def self.human_attribute_name(attr, options = {})
            attr
          end

          def self.lookup_ancestors
            [self]
          end

          private

          def errors=(errors)
            @errors = errors
          end
        end
      end
    end
  end
end