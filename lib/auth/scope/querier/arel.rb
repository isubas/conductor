# frozen_string_literal: true

module Auth
  module Scope
    module Querier
      module Arel
        PREDICATES = %w[
          in
          eq
          gt
          lt
        ].freeze

        PREDICATES.each do |predicate|
          define_method(predicate) do |key, value|
            table[key].public_send(predicate, value)
          end
        end

        def generate_arel_node(key:, value:, predicate:)
          public_send(predicate, key, value)
        end

        private

        def merge(queries, with:)
          queries.inject { |current_query, query| current_query.public_send(with.to_s, query) }
        end

        def table
          @_table ||= klass.model.arel_table
        end
      end
    end
  end
end
