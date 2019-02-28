# frozen_string_literal: true

module Auth
  module Roleable
    def self.included(base)
      base.send :include, InstanceMethods
      base.extend ClassMethods
    end

    module ClassMethods
      def scope_by(*)
        puts 'Test'
      end
    end

    module InstanceMethods
      def permitted?(*)
        puts 'permitted?'
      end

      def permitted!(*)
        puts 'permitted!'
      end
    end
  end
end
