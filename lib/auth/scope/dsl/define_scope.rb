# frozen_string_literal: true

module Auth
  module Scope
    module DSL
      module DefineScope
        def define_scope(name, &block)
          defined_scopes << name

          define_method(name) do |*args|
            current_scope.instance_exec(*args, &block)
          end
        end

        def defined_scopes
          @_defined_scopes ||= []
        end
      end
    end
  end
end
