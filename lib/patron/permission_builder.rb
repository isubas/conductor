# frozen_string_literal: true

module Patron
  class PermissionBuilder
    class_attribute :all, instance_accessor: false,
                          default: Hash.new { |hash, name| hash[name] = {} }

    class << self
      def permissions
        @permissions ||= Hash.new { |hash, name| hash[name] = {} }
      end

      # Example
      # permission :name_of_permission do |foo|
      #   foo.controller :controller1, actions: %i[index show]
      #   foo.controller :controller2, actions: %i[edit update]
      # end
      def permission(name_of_permission)
        yield Action.new(self, name_of_permission)
      end

      def find(*names)
        names.inject({}) { |hash, name| hash.merge(all.fetch(name.to_sym, {})) }
      end

      def exist?(name)
        all.key?(name.to_sym)
      end

      def exist!(name)
        exist?(name) || raise("Not found permission #{name}")
      end
    end

    class Action
      attr_reader :permission, :all

      def initialize(klass, name_of_permission)
        @permission = klass.permissions[name_of_permission]
        @all        = klass.all[name_of_permission]
      end

      def controller(controller, actions:)
        actions = actions.compact.map(&:to_sym)

        raise ArgumentError, 'actions cannot be empty' if actions.blank?

        tap do
          permission[controller] = Set.new(actions)
          all[controller]        = Set.new(actions)
        end
      end
    end

    private_constant :Action
  end
end
