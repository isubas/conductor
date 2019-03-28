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
          attr_reader :collection, :presence, :multiple

          def initialize(**args)
            @collection = args.fetch(:collection, proc { [] })
            @presence   = args.fetch(:presence, true)
            @multiple   = args.fetch(:multiple, false)
          end
        end

        private_constant :Option
      end
    end
  end
end
