# frozen_string_literal: true

module Auth
  module Scope
    module Store
      module Validation
        extend ActiveSupport::Concern

        included do
          before_validation :set_accessors_validations

          def set_accessors_validations
            scope_klass.filters.each do |filter|
              validates_presence_of  "#{filter}_value".to_sym unless skip_empty_for?(filter)
              validates_presence_of  "#{filter}_query_type".to_sym
              validates_inclusion_of "#{filter}_skip_empty".to_sym, in: %w[true false]
            end
          end

          def skip_empty_for?(filter)
            public_send("#{filter}_skip_empty") == 'true'
          end
        end
      end
    end
  end
end
