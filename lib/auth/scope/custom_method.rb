# frozen_string_literal: true

module Auth
  module Scope
    module CustomMethod
      def define_scope(name, &block)
        defined_scopes[name] = block
      end

      def defined_scopes
        @_defined_scopes ||= {}
      end
    end
  end
end
