# frozen_string_literal: true

module Auth
  module Scope
    module Validation
      extend ActiveSupport::Concern

      included do
        before_validation :set_accessors_validations

        def set_accessors_validations
          scope_klass.filters.each do |key, option|
            validates_presence_of "#{key}#{StoreAccessor::Value::SUFFIX_FOR_VALUE_ACCESSOR}".to_sym if option.presence
            validates_presence_of "#{key}#{StoreAccessor::QueryType::SUFFIX_FOR_QUERY_TYPE_ACCESSOR}".to_sym
          end
        end
      end
    end
  end
end
