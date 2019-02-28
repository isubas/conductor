# frozen_string_literal: true

module Auth
  module Scope
    module StoreAccessor
      extend ActiveSupport::Concern
      SUFFIX_FOR_STORE_ACCESSOR = '_value'

      included do
        after_initialize :set_store_accessor

        def auth_store_accessors
          _scope_klass.filter_attributes.map do |key|
            key.to_s + SUFFIX_FOR_STORE_ACCESSOR
          end
        end

        private

        def set_store_accessor
          _scope_klass.filter_attributes.each do |key|
            method = key.to_s + SUFFIX_FOR_STORE_ACCESSOR
            define_singleton_method(method) { values[key] }
            define_singleton_method("#{method}=") do |value|
              value = case value
                      when Array then value.select(&:present?)
                      else
                        value
                      end

              values[key] = value
            end
          end
        end

        def _scope_klass
          name.constantize
        end
      end
    end
  end
end
