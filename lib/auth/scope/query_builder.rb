# frozen_string_literal: true

module Auth
  module Scope
    class QueryBuilder
      attr_reader :scope_class, :values, :query

      def initialize(scope_class, values)
        @scope_class = scope_class
        @values = values
        @query = {}
      end

      def build
        mapping
      end

      private

      def mapping
        scope_class.filter_attributes.each_with_object({}) do |item, object|
          binding.pry
          object[item] = values[item.to_s]
        end
      end
    end
  end
end
