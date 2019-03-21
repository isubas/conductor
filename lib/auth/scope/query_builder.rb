# frozen_string_literal: true
require_relative 'utils/arel'

module Auth
  module Scope
    class QueryBuilder
      include Utils::Arel

      attr_reader :instance, :klass

      def initialize(instance)
        @instance = instance
        @klass    = instance.class
      end

      def build
        queries = values.map do |value|
          normalized_values = normalize(value)

          next if normalized_values.blank?

          normalized_values.map { |data| generate_arel_node(data) }
                           .then { |nodes| merge(nodes, with: :and) }
        end.compact

        merge(queries, with: :or)
      end

      private

      def assignable?(filter, value)
        return value.present? if klass.filters[filter].skip_empty

        true
      end

      def normalize(scope_value)
        klass.filter_attributes.map do |filter|
          value = scope_value[filter.to_s]

          next unless assignable?(filter, value)

          {
            key: filter,
            value: value,
            predicate: scope_value["#{filter}_query_type"]
          }
        end.compact
      end

      def values
        @values ||= AuthScope.where(
          name: klass.to_s, user_id: instance.user.id
        ).pluck(:values)
      end
    end
  end
end
