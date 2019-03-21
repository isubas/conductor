# frozen_string_literal: true

module Auth
  module Scope
    module StoreAccessor
      module QueryType
        SUFFIX_FOR_QUERY_TYPE_ACCESSOR = '_query_type'

        def query_types_accessors
          permited_attributes_for_query_types
        end

        def permited_attributes_for_query_types
          @permited_attributes_for_query_types ||= begin
            scope_klass.filter_attributes.map { |attribute| query_type_accessor_for(attribute) }
          end
        end

        private

        def set_accessors_for_query_types
          scope_klass.filter_attributes.each do |key|
            method = query_type_accessor_for(key)

            # Getter
            define_singleton_method(method) { values[method] }

            # Setter
            define_singleton_method("#{method}=") { |value| values[method] = value }
          end
        end

        def query_type_accessor_for(key)
          key.to_s + SUFFIX_FOR_QUERY_TYPE_ACCESSOR
        end
      end
    end
  end
end
