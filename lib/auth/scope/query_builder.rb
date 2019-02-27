# frozen_string_literal: true

module Auth
  module Scope
    class QueryBuilder
      attr_reader :values

      def initialize(scope_class, values)
        @scope_class = scope_class
        @values = values
      end

      def build
        values
      end
    end
  end
end
