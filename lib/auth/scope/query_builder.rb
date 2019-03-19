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
        results = {
          queries: [],
          values: {}
        }

        values.each_with_index do |value, index|
          hash = to_hash(value)
          next if hash.blank?

          results[:queries] << to_query(hash, suffix: index)
          results[:values].merge!(hash.transform_keys { |key| "#{key}#{index}".to_sym })
        end
        results
      end

      private

      def to_hash(scope_value)
        klass.filter_attributes.each_with_object({}) do |filter, object|
          value = scope_value[filter.to_s]
          object[filter] = value if assignable?(filter, value)
        end
      end

      def to_query(hash, suffix: '')
        hash.each_with_object([]) do |value, object|
          key = value.first
          object << "#{key} = :#{key}#{suffix}"
        end.join(' AND ')
      end

      def assignable?(filter, value)
        return value.present? if klass.filters[filter].skip_empty

        true
      end

      def values
        @values ||= AuthScope.where(
          name: klass.to_s, user_id: instance.user.id
        ).pluck(:values)
      end
    end
  end
end
