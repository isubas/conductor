# frozen_string_literal: true

require_relative './query_builder'

module Auth
  module Scope
    module Model
      def self.included(base)
        # base.send :include, InstanceMethods
        base.extend ClassMethods
      end

      module ClassMethods
        def auth_scope(user)
          where(
            query(user)
          )
        end

        private

        def _scope_klass
          @_scope_klass ||= "#{name}Scope".constantize
        end

        def find_values(user)
          AuthScope.find_by(name: _scope_klass.to_s, user_id: user.id).try(:values) || {}
        end

        def query(user)
          Auth::Scope::QueryBuilder.new(_scope_klass, find_values(user)).build
        end
      end
    end
  end
end
