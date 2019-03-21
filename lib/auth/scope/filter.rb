# frozen_string_literal: true

module Auth
  module Scope
    module Filter
      Option = Struct.new(
        :collection,
        :presence,
        :skip_empty,
        :multiple,
        :field_type,
        keyword_init: true
      )

      def filter(attribute, **options)
        exist!(attribute)

        filters[attribute] = build_option(options)
      end

      def filters
        @filters ||= {}
      end

      def filter_attributes
        filters.keys
      end

      private

      def build_option(options)
        presence   = options.fetch(:presence, false)
        skip_empty = options.fetch(:skip_empty, false)

        Option.new(
          collection: options.fetch(:collection, []),
          multiple: options.fetch(:multiple, false),
          presence: !skip_empty || presence,
          skip_empty: skip_empty,
          field_type: options.fetch(:field_type, :string)
        )
      end

      def exist!(attribute)
        return if model.attribute_names.include?(attribute.to_s)

        raise ArgumentError, attribute
      end
    end
  end
end
