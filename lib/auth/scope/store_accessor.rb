# frozen_string_literal: true

require_relative 'store_accessor/value'
require_relative 'store_accessor/query_type'
require_relative 'store_accessor/skip_empty'

module Auth
  module Scope
    module StoreAccessor
      extend ActiveSupport::Concern

      included do
        after_initialize :set_accessors_for_values
        after_initialize :set_accessors_for_query_types
        after_initialize :set_accessors_for_skip_empty

        include Value
        include QueryType
        include SkipEmpty

        def accessors
          [
            *query_types_accessors,
            *values_accessors,
            *skip_empties_accessors
          ]
        end

        def permitted_attributes_for_store_accessors
          [
            *permited_attributes_for_values,
            *permited_attributes_for_query_types,
            *permited_attributes_for_skip_empties
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
