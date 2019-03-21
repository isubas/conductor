# frozen_string_literal: true

require_relative 'query_builder'

module Auth
  module Scope
    module Query
      def scope(pass: false)
        return model.all if pass

        query.present? ? model.where(query) : model.none
      end

      def query
        @query ||= QueryBuilder.new(self).build
      end
    end
  end
end
