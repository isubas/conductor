# frozen_string_literal: true

module Auth
  module Scope
    module Utils
      module Arel
        PREDICATES = %i[
          in
          eq
        ].freeze

        def generate_arel_node(key, value)
          case value
          when Array then self.in(key, value)
          when String then eq(key, value)
          else
            raise 'Arel'
          end
        end

        PREDICATES.each do |predicate|
          define_method(predicate) do |key, value|
            table[key].in(value)
          end
        end

        private

        def merge(queries, with:)
          current_query = queries.delete(queries.first)

          queries.each do |query|
            current_query = current_query.send(with.to_s, query)
          end
          current_query
        end

        def table
          @table ||= klass.model.arel_table
        end
      end
    end
  end
end
