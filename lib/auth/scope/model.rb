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
        def auth_scope_for(*)
          where(query)
        end

        private

        def scope_klass
          @scope_klass ||= "#{name}Scope".constantize
        end

        def find_values(*)
          scope_klass.condition_attributes.map { |key, _| [key, 'Foo'] }.to_h
        end

        def query
          Auth::Scope::QueryBuilder.new(scope_klass, find_values).build
        end
      end
    end
  end
end
