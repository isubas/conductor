# frozen_string_literal: true

module Auth
  module Scope
    module Querier
      class Builder
        include Arel

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

        attr_reader :instance, :klass

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
          @values ||= begin
            AuthScope.find_by(
              name: klass.to_s,
              user_id: instance.user.id
            ).try(:values) || []
          end
        end
      end
    end
  end
end
