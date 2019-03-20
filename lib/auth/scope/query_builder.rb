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
        queries = values.each_with_object([]) do |value, object|
          hash = to_hash(value)
          next if hash.blank?

          object << to_query(hash)
        end

        merge(queries, with: :or)
      end

      private

      def to_query(hash)
        queries = hash.each_with_object([]) do |item, object|
          object << generate_arel_node(*item)
        end

        merge(queries, with: :and)
      end

      def assignable?(filter, value)
        return value.present? if klass.filters[filter].skip_empty

        true
      end

      def to_hash(scope_value)
        klass.filter_attributes.each_with_object({}) do |filter, object|
          value = scope_value[filter.to_s]
          object[filter] = value if assignable?(filter, value)
        end
      end

      def values
        @values ||= AuthScope.where(
          name: klass.to_s, user_id: instance.user.id
        ).pluck(:values)
      end
    end
  end
end
