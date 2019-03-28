# frozen_string_literal: true

module Auth
  module Scope
    module StoreAccessor
      module SkipEmpty
        SUFFIX_FOR_SKIP_EMPTY_ACCESSOR = '_skip_empty'

        def skip_empties_accessors
          permited_attributes_for_skip_empties
        end

        def permited_attributes_for_skip_empties
          @permited_attributes_for_skip_empties ||= begin
            scope_klass.filter_attributes.map { |attribute| skip_empty_accessor_for(attribute) }
          end
        end

        private

        def set_accessors_for_skip_empty
          scope_klass.filter_attributes.each do |key|
            method = skip_empty_accessor_for(key)

            # Getter
            define_singleton_method(method) { values[method] }

            # Setter
            define_singleton_method("#{method}=") { |value| values[method] = value }
          end
        end

        def skip_empty_accessor_for(key)
          key.to_s + SUFFIX_FOR_SKIP_EMPTY_ACCESSOR
        end
      end
    end
  end
end
