# frozen_string_literal: true

module Auth
  module Scope
    module Model
      def self.included(base)
        base.extend ClassMethods
      end

      module ClassMethods
        def auth_scope(user, pass: false)
          scope_klass.new(user).scope(pass: pass)
        end

        private

        def scope_klass
          @_scope_klass ||= "#{name}Scope".safe_constantize
        end
      end
    end
  end
end
