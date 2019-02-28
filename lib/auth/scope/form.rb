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
        filters.map do |attribute, options|
          generete_form_field(attribute, options)
        end
      end

      private

      def generete_form_field(attribute, options)
        collection = options.fetch(:collection, [])

        Field.new(
          name: attribute.to_s + StoreAccessor::SUFFIX_FOR_STORE_ACCESSOR,
          as: collection.present? ? :select : options.fetch(:field_type, :string),
          collection: collection,
          required: options.fetch(:presence, false),
          multiple: options.fetch(:multiple, false)
        )
      end
    end
  end
end
