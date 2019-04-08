# frozen_string_literal: true

module Auth
  class Permission
    class_attribute :all, instance_accessor: false,
                          default: Hash.new { |hash, name| hash[name] = {} }

    def self.permissions
      @permissions ||= Hash.new { |hash, name| hash[name] = {} }
    end

    # Example
    # permission :name_of_permission do |foo|
    #   foo.controller :controller1, actions: %i[index show]
    #   foo.controller :controller2, actions: %i[edit update]
    # end
    def self.permission(name_of_permission)
      yield Action.new(self, name_of_permission)
    end

    class Action
      attr_reader :permission, :all

      def initialize(klass, name_of_permission)
        @permission = klass.permissions[name_of_permission]
        @all        = klass.all[name_of_permission]
      end

      def controller(controller, actions:)
        tap do
          permission[controller] = actions
          all[controller]        = actions
        end
      end
    end

    private_constant :Action
  end
end