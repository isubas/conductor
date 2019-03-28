# frozen_string_literal: true

module Auth
  module Scope
    module Query
      def scope(bypass: false)
        return model.all if bypass

        query.present? ? model.where(query) : model.none
      end

      def query
        @query ||= Querier::Builder.new(self).build
      end
    end
  end
end
