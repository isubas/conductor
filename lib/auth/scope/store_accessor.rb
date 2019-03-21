# frozen_string_literal: true

module Auth
  module Scope
    module StoreAccessor
      extend ActiveSupport::Concern
      SUFFIX_FOR_VALUE_ACCESSOR = '_value'
      SUFFIX_FOR_QUERY_TYPE_ACCESSOR = '_query_type'

      included do
        after_initialize :set_store_accessor_for_values

        def auth_store_accessors_for_values
          @auth_store_accessors_for_values ||= begin
            scope_klass.filter_attributes.map do |key|
              value_accessor_for(key)
            end
          end
        end

        def permited_attributes_for_values
          @permited_attributes_for_values ||= begin
            scope_klass.filters.map do |key, option|
              key = value_accessor_for(key)
              attributes << (option.multiple ? { key => [] } : key)
            end
          end
        end

        def permited_attributes_for_query_methods
          @permited_attributes_for_query_methods ||= begin
            scope_klass.filter_attributes.map { |attribute| query_method_accessor_for(attribute) }
          end
        end

        private

        def set_store_accessor_for_values
          scope_klass.filter_attributes.each do |key|
            method = value_accessor_for(key)

            define_singleton_method(method) { values[key] }
            define_singleton_method("#{method}=") do |value|
              values[key] = value.is_a?(Array) ? value.select(&:present?) : value
            end
          end
        end

        def value_accessor_for(key)
          key.to_s + SUFFIX_FOR_VALUE_ACCESSOR
        end

        def query_method_accessor_for(key)
          key.to_s + SUFFIX_FOR_VALUE_ACCESSOR
        end

        def scope_klass
          @_scope_klass ||= name.constantize
        end
      end
    end
  end
end
