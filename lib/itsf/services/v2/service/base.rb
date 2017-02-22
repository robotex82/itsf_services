require 'forwardable'

module Itsf
  module Services
    module V2
      module Service
        class Base
          include ActiveModel::Validations
          extend Forwardable

          include ActiveModel::Conversion
          def persisted?; false end

          def_delegator :@instrumenter, :instrument
          attr_accessor :instrumenter
          attr_reader :response
          attr_reader :_messages

          def self.i18n_scope
            'activerecord'
          end

          def self.call(attributes = {}, *args)
            new(attributes, *args).send(:do_work)
          end

          def initialize(attributes = {}, *args)
            options = args.extract_options!
            options.reverse_merge!(instrumenter: ActiveSupport::Notifications)

            @_messages = []
            @errors = ActiveModel::Errors.new(self)

            initialize_instrumenter(options[:instrumenter])
            instrument('initialize.base.service.v2.services.itsf') do
              initialize_attributes if respond_to?(:initialize_attributes, true)
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
            set_messages_on_response
            set_errors_on_response
            @response
          end

          def say(message, options = {})
            options.reverse_merge!(indent: 0, level: :info)
            indent = options.delete(:indent)
            level = options.delete(:level)
            formatted_message = "[#{self.class.name}]: #{'  ' * indent}#{message}"
            puts formatted_message unless Itsf::Services.silenced_levels[Rails.env].include?(level)
            @_messages << Services::V2::Message::Base.new(service_class: self.class, message: message, level: level, indent: indent)
            true
          end

          def info(message, options = {})
            options.reverse_merge!(level: :info)
            say(message, options)
          end

          def warn(message, options = {})
            options.reverse_merge!(level: :warning)
            say(message, options)
          end

          def error(message, options = {})
            options.reverse_merge!(level: :error, attribute: :base)
            errors.add(options[:attribute], message)
            say(message, options)
          end

          def add_error_and_say(attribute, message, options = {})
            errors.add(attribute, message)
            say(message, options)
          end

          def set_errors_on_response
            @response.send(:'errors=', @errors)
          end

          def set_messages_on_response
            @response.send(:'messages=', @_messages)
          end
        end
      end
    end
  end
end
