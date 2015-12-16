require 'forwardable'

module Itsf
  module Services
    module V2
      module Service
        class Base
          include ActiveModel::Validations
          extend Forwardable

          def_delegator :@instrumenter, :instrument
          attr_accessor :instrumenter
          attr_reader :response

          def self.i18n_scope
            'activerecord'
          end

          def self.call(attributes = {}, *args)
            new(attributes, *args).send(:do_work)
          end

          def initialize(attributes = {}, *args)
            options = args.extract_options!
            options.reverse_merge!(instrumenter: ActiveSupport::Notifications)

            @errors = ActiveModel::Errors.new(self)

            initialize_instrumenter(options[:instrumenter])
            instrument('initialize.export_to_sap.payment.dzb') do
              initialize_attributes if respond_to?(:initialize_attributes)
              send_attributes(attributes)
              initialize_response
            end
          end

          private

          def send_attributes(attributes)
            attributes.each do |name, value|
              send("#{name}=", value)
            end
          end

          def initialize_instrumenter(instrumenter)
            @instrumenter = instrumenter
          end

          def initialize_response
            if self.class.const_defined?('Response')
              @response = "#{self.class}::Response".constantize.new
            else
              @response = Services::V2::Response::Base.new
            end
          end

          def respond
            response
          end

          def response
            set_errors_on_response
            @response
          end

          def say(message, options = {})
            options.reverse_merge!(indent: 0)
            indent = options.delete(:indent)
            puts "[#{self.class.name}]: #{'  ' * indent}#{message}"
            true
          end

          def add_error_and_say(attribute, message, options = {})
            errors.add(attribute, message)
            say(message, options)
          end

          def set_errors_on_response
            @response.send(:'errors=', @errors)
          end
        end
      end
    end
  end
end
