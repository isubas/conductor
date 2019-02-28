# frozen_string_literal: true

module Auth
  module Scope
    module Filter
      def filter(attribute, **options)
        exist!(attribute)
        filters[attribute] = options
      end

      def filters
        @filters ||= {}
      end

      def filter_attributes
        filters.keys
      end

      private

      def model
        to_s.delete_suffix('Scope').constantize
      end

      def exist!(attribute)
        raise StandardError, attribute unless model.columns_hash.key?(attribute.to_s)
      end
    end
  end
end
