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

      def fields
        filters.map do |attribute, option|
          {
            value_field: generate_field_for_value(attribute, option),
            query_type_field: generate_field_for_query_type(attribute)
          }
        end
      end

      private

      def generate_field_for_value(attribute, option)
        collection = collection_for(option)

        Field.new(
          name: attribute.to_s + StoreAccessor::SUFFIX_FOR_VALUE_ACCESSOR,
          as: collection.present? ? :select : option.field_type,
          collection: collection,
          required: option.presence,
          multiple: option.multiple,
          hint: hint(option)
        )
      end

      def generate_field_for_query_type(attribute)
        Field.new(
          name: attribute.to_s + StoreAccessor::SUFFIX_FOR_QUERY_TYPE_ACCESSOR,
          as: :select,
          collection: Utils::Arel::PREDICATES,
          required: true
        )
      end

      def collection_for(option)
        case option.collection
        when Proc then option.collection.call
        when Array then option.collection
        end
      end

      def hint(option)
        return '' unless option.skip_empty

        'Boş bırakılırsa sorguya dahil edilmez!'
      end
    end
  end
end
