# frozen_string_literal: true

module Auth
  module PermissionBuilder
    mattr_accessor :permissions, default: {}

    def permission(name)
      yield ActionList.of(permission_of(name))
    end

    def permission_of(name)
      permissions[name] = {} unless permissions.key?(name)
      permissions[name]
    end

    class ActionList
      attr_reader :permission

      def initialize(permission)
        @permission = permission
      end

      def self.of(permission)
        new(permission)
      end

      def controller(name, actions:)
        permission[name] = actions
        self
      end
    end
  end
end
