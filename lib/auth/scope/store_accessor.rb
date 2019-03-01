# frozen_string_literal: true

module Auth
  module Scope
    module StoreAccessor
      extend ActiveSupport::Concern
      SUFFIX_FOR_STORE_ACCESSOR = '_value'

      included do
        after_initialize :set_store_accessor

        def auth_store_accessors
          @auth_store_accessors ||= _scope_klass.filter_attributes.map do |key|
            key.to_s + SUFFIX_FOR_STORE_ACCESSOR
          end
        end

        def permited_attributes_for_values
          @permited_attributes_for_values ||= begin
            _scope_klass.filters.each_with_object([]) do |(key, option), attributes|
              key = _store_accessor_key_for(key)
              attributes << (option.fetch(:multiple, false) ? { key => [] } : key)
            end
          end
        end

        private

        def set_store_accessor
          _scope_klass.filter_attributes.each do |key|
            method = _store_accessor_key_for(key)

            define_singleton_method(method) { values[key] }
            define_singleton_method("#{method}=") do |value|
              values[key] = value.is_a?(Array) ? value.select(&:present?) : value
            end
          end
        end

        def _store_accessor_key_for(key)
          key.to_s + SUFFIX_FOR_STORE_ACCESSOR
        end

        def _scope_klass
          name.constantize
        end
      end
    end
  end
end
