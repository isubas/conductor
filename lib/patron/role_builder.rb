# frozen_string_literal: true

module Patron
  class RoleBuilder
    def self.roles
      @roles ||= {}
    end

    def self.role(name, permissions:)
      roles[name] = Role.new(name, permissions)
    end

    class Role
      attr_reader :name, :permissions

      def initialize(name, permissions)
        @name        = name
        @permissions = permissions
        check!
      end

      def actions
        permissions.each_with_object({}) do |permission, result|
          controllers_of_permissions = Patron::PermissionBuilder.find(permission)

          controllers_of_permissions.each do |controller, actions_of_controller|
            result[controller] = Set.new unless result.key?(controller)
            result[controller].merge(actions_of_controller)
          end
        end
      end

      def permitted?(controller, action)
        actions.fetch(controller&.to_sym, [])
               .include?(action&.to_sym)
      end

      private

      def check!
        permissions.each do |permission|
          Patron::PermissionBuilder.exist!(permission)
        end
      end
    end

    private_constant :Role
  end
end
