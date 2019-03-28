# frozen_string_literal: true

module Auth
  module Scope
    module Form
      Field = Struct.new(
        :name,
        :as,
        :collection,
        :required,
        :multiple,
        keyword_init: true
      )

      def fields
        @_fields ||= begin
          filters.map do |filter, option|
            [
              generate_field_for_value(filter, option),
              generate_field_for_query_type(filter),
              generate_field_for_skip_empty(filter)
            ]
          end
        end
      end

      private

      def generate_field_for_value(filter, option)
        Field.new(
          name: "#{filter}_value",
          as: option.field_type,
          collection: option.collection,
          multiple: option.multiple
        )
      end

      def generate_field_for_query_type(filter)
        Field.new(
          name: "#{filter}_query_type",
          as: :select,
          collection: Querier::Arel::PREDICATES,
          required: true
        )
      end

      def generate_field_for_skip_empty(filter)
        Field.new(
          name: "#{filter}_skip_empty",
          collection: [true, false],
          as: :boolean
        )
      end
    end
  end
end
