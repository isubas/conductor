# frozen_string_literal: true

module Auth
  module Scope
    module Model
      def self.included(base)
        base.extend ClassMethods
      end

      module ClassMethods
        def auth_scope(user)
          _scope_klass.new(user).scope
        end

        private

        def _scope_klass
          @_scope_klass ||= "#{name}Scope".constantize
        end
      end
    end
  end
end
