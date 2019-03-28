# frozen_string_literal: true

module Auth
  module Scope
    class Base
      extend DSL::Filter
      extend DSL::DefineScope
      extend Form
      include Query

      attr_reader :user

      def self.model
        to_s.delete_suffix('Scope').safe_constantize
      end

      def model
        self.class.model
      end

      def current_scope
        @_current_scope ||= model
      end
    end
  end
end
