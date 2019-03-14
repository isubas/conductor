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
          generate_form_field(attribute, option)
        end
      end

      private

      def generate_form_field(attribute, option)
        collection = collection_for(option)

        Field.new(
          name: attribute_name_prepare(attribute),
          as: collection.present? ? :select : option.field_type,
          collection: collection,
          required: option.presence,
          multiple: option.multiple,
          hint: hint(option)
        )
      end

      def collection_for(option)
        case option.collection
        when Proc then option.collection.call
        when Array then option.collection
        end
      end

      def attribute_name_prepare(attribute)
        attribute.to_s + StoreAccessor::SUFFIX_FOR_STORE_ACCESSOR
      end

      def hint(option)
        return '' unless option.skip_empty

        'Boş bırakılırsa sorguya dahil edilmez!'
      end
    end
  end
end
