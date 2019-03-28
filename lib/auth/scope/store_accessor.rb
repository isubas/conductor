# frozen_string_literal: true

require_relative 'store_accessor/value'
require_relative 'store_accessor/query_type'

module Auth
  module Scope
    module StoreAccessor
      extend ActiveSupport::Concern

      included do
        after_initialize :set_accessors_for_values
        after_initialize :set_accessors_for_query_types

        include Value
        include QueryType

        def accessors
          [
            *query_types_accessors,
            *values_accessors
          ]
        end

        def permitted_attributes_for_store_accessors
          [
            *permited_attributes_for_values,
            *permited_attributes_for_query_types
          ]
        end

        private

        def scope_klass
          @_scope_klass ||= name.safe_constantize
        end
      end
    end
  end
end
