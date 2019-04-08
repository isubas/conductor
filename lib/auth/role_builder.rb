# frozen_string_literal: true

module Auth
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
      end

      def actions
        permissions.each_with_object({}) do |permission, result|
          controllers = Auth::PermissionBuilder.all.fetch(permission, {})
          controllers.each do |controller, controller_actions|
            result[controller] = Set.new unless result.key?(controller)
            result[controller].merge(controller_actions)
          end
        end
      end

      def permitted?(controller, action)
        actions.fetch(controller&.to_sym, [])
               .include?(action&.to_sym)
      end
    end

    private_constant :Role
  end
end

