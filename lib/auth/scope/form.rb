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
        :hint,
        keyword_init: true
      )

      AREL_PREDICATES = {
        select: %i[in],
        text: %i[eq gt lt],
        string: %i[eq gt lt]
      }.freeze

      def form_fields
        filters.map do |attribute, option|
          {
            value: generate_field_for_value(attribute, option),
            query_type: generate_field_for_query_type(attribute, option)
          }
        end
      end

      private

      def generate_field_for_value(attribute, option)
        collection = collection_for(option)

        Field.new(
          name: attribute.to_s + StoreAccessor::Value::SUFFIX_FOR_VALUE_ACCESSOR,
          as: collection.present? ? :select : option.field_type,
          collection: collection,
          required: option.presence,
          multiple: option.multiple,
          hint: hint(option)
        )
      end

      def generate_field_for_query_type(attribute, option)
        collection = collection_for(option)

        type = collection.present? ? :select : option.field_type

        Field.new(
          name: attribute.to_s + StoreAccessor::QueryType::SUFFIX_FOR_QUERY_TYPE_ACCESSOR,
          as: :select,
          collection: AREL_PREDICATES[type],
          required: true
        )
      end

      def collection_for(option)
        if option.collection.respond_to?(:call)
          option.collection.call
        elsif option.collection.is_a?(Array)
          option.collection
        else
          []
        end
      end

      def hint(option)
        return '' unless option.skip_empty

        'Boş bırakılırsa sorguya dahil edilmez!'
      end
    end
  end
end
