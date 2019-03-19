# frozen_string_literal: true

require_relative './query_builder'

module Auth
  module Scope
    module Query
      def scope
        model.where(query[:queries].join(' OR '), *query[:values])
      end

      def query
        @query ||= QueryBuilder.new(self).build
      end
    end
  end
end
