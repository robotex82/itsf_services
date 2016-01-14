module Itsf
  module Services
    module V2
      module Message
        class Base
          attr_accessor :service_class, :message, :level, :indent

          def initialize(attributes = {})
            send_attributes(attributes)
          end

          def to_s(format = :default)
            case format
            when :html
            when :default
              "[#{service_class.name} | #{level}]: #{'  ' * indent}#{message}"
            end
          end

          private

          def send_attributes(attributes)
            attributes.each do |name, value|
              send("#{name}=", value)
            end
          end
        end
      end
    end
  end
end
