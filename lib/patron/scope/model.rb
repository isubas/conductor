# frozen_string_literal: true

module Patron
  module Scope
    module Model
      extend ActiveSupport::Concern

      class_methods do
        def auth_scope(user, bypass: false)
          scope_klass.new(user).scope(bypass: bypass)
        end

        private

        def scope_klass
          @_scope_klass ||= "#{name}Scope".safe_constantize
        end
      end
    end
  end
end
