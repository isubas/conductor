# frozen_string_literal: true

module Auth
  module Scope
    module Form
      AREL_FORM_PREDICATES = {
        array: %i[in not_in],
        string: %i[
          does_not_end_match
          does_not_full_match
          does_not_start_match
          end_matches
          start_matches
          full_matches
          equal
          not_equal
          greater_than
          greater_than_to_equal
          less_than
          less_than_to_equal
        ]
      }.freeze

      Field = Struct.new(
        :name,
        :as,
        :collection,
        :required,
        :multiple,
        keyword_init: true
      )

      def fields_for_form
        @_fields_for_form ||= begin
          filters.map do |filter, option|
            [
              generate_field_for_value(filter, option),
              generate_field_for_query_type(filter, option),
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

      def generate_field_for_query_type(filter, option)
        Field.new(
          name: "#{filter}_query_type",
          as: :select,
          collection: [*AREL_FORM_PREDICATES[option.type]],
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
