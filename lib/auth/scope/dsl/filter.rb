# frozen_string_literal: true

module Auth
  module Scope
    module DSL
      module Filter
        def filter(attribute, **options)
          exist!(attribute)

          filters[attribute] = Option.new(options)
        end

        def filters
          @filters ||= {}
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
          SUPPORTED_FIELD_TYPES = %i[string select].freeze

          attr_reader :collection, :multiple

          def initialize(**args)
            @collection = args.fetch(:collection, proc { [] })
            @multiple   = args.fetch(:multiple, false)
            @field_type = args.fetch(:field_type, :string)
            check!
          end

          def field_type
            collection.call.present? ? :select : @field_type
          end

          private

          def check!
            return if SUPPORTED_FIELD_TYPES.include? field_type.to_sym

            raise ArgumentError, "Unsupport field type, supported field types #{SUPPORTED_FIELD_TYPES.join(',')}"
          end
        end

        private_constant :Option
      end
    end
  end
end
