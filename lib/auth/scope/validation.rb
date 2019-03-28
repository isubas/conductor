# frozen_string_literal: true

module Auth
  module Scope
    module Validation
      extend ActiveSupport::Concern

      included do
        before_validation :set_accessors_validations

        def set_accessors_validations
          scope_klass.filters.each do |filter, _|
            validates_presence_of "#{filter}_value".to_sym if public_send("#{filter}_skip_empty").to_i.zero?
            validates_presence_of "#{filter}_query_type".to_sym
          end
        end
      end
    end
  end
end
