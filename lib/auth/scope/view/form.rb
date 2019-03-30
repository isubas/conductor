# frozen_string_literal: true

module Auth
  module Scope
    module View
      module Form
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
            collection: arel_predicates_for(option.type),
            required: true
          )
        end

        def generate_field_for_skip_empty(filter)
          Field.new(
            name: "#{filter}_skip_empty",
            collection: %w[true false],
            as: :select
          )
        end

        def arel_predicates_for(type)
          case type
          when :array  then %i[in not_in]
          when :string then Query::Arel.predicates.to_a - %i[in not_in]
          else              []
          end
        end
      end
    end
  end
end
