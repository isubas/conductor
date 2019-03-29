# frozen_string_literal: true

module Auth
  module Scope
    module DSL
      module DefineScope
        def define_scope(name, &block)
          defined_scopes << name

          define_method(name) do |*args|
            current_scope.instance_exec(*args, &block)
          end
        end

        def defined_scopes
          @_defined_scopes ||= []
        end
      end

      module Filter
        def filter(attribute, **options)
          exist!(attribute)

          filters[attribute] = Option.new(options)
        end

        def filters
          @_filters ||= {}
        end

        def filter_attributes
          filters.keys
        end

        private

        def exist!(attribute)
          return if model.attribute_names.include?(attribute.to_s)

          raise ArgumentError, attribute
        end

        class Option
          SUPPORTED_TYPES = %i[string array].freeze

          attr_reader :collection,
                      :type,
                      :multiple

          def initialize(**args)
            @collection = args.fetch(:collection, proc { [] })
            @multiple   = args.fetch(:multiple, false)
            @type       = forecast_type(args)
            check!
          end

          def forecast_type(args)
            return :array if collection.call.present?

            args.fetch(:type, :string)
          end

          def field_type
            return :select if collection.call.present?

            case type
            when :string then :string
            when :array  then :select
            else              :string
            end
          end

          private

          def check!
            return if SUPPORTED_TYPES.include? type.to_sym

            raise ArgumentError, "Unsupport type, supported types #{SUPPORTED_TYPES.join(',')}"
          end
        end

        private_constant :Option
      end
    end
  end
end
