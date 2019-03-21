# frozen_string_literal: true

module Auth
  module Scope
    module StoreAccessor
      module Value
        SUFFIX_FOR_VALUE_ACCESSOR = '_value'

        def values_accessors
          scope_klass.filter_attributes.map { |attribute| value_accessor_for(attribute) }
        end

        def permited_attributes_for_values
          @permited_attributes_for_values ||= begin
            scope_klass.filters.map do |key, option|
              key = value_accessor_for(key)
              option.multiple ? { key => [] } : key
            end
          end
        end

        def set_accessors_for_values
          scope_klass.filter_attributes.each do |key|
            method = value_accessor_for(key)

            # Getter
            define_singleton_method(method) { values[key] }

            # Setter
            define_singleton_method("#{method}=") do |value|
              values[key] = value.is_a?(Array) ? value.select(&:present?) : value
            end
          end
        end

        private

        def value_accessor_for(key)
          key.to_s + SUFFIX_FOR_VALUE_ACCESSOR
        end
      end
    end
  end
end
