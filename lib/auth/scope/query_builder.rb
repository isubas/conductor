# frozen_string_literal: true

module Auth
  module Scope
    class QueryBuilder
      attr_reader :instance, :klass

      def initialize(instance)
        @instance = instance
        @klass    = instance.class
      end

      def build
        klass.filter_attributes.each_with_object({}) do |filter, object|
          value = values[filter.to_s]
          object[filter] = value if assignable?(filter, value)
        end
      end

      private

      def assignable?(filter, value)
        return value.present? if klass.filters[filter].skip_empty

        true
      end

      def values
        @values ||= AuthScope.find_by(
          name: klass.to_s, user_id: instance.user.id
        ).try(:values) || {}
      end
    end
  end
end
