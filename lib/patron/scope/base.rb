# frozen_string_literal: true

module Patron
  module Scope
    class Base
      extend DSL::Filter
      extend View::Form

      def self.model
        to_s.delete_suffix('Scope').safe_constantize
      end

      attr_reader :user

      def initialize(user, current_scope: nil)
        @user          = user
        @current_scope = current_scope
      end

      def scope(bypass: false)
        return model.all if bypass

        query = Query::Builder.call(self)

        query.present? ? current_scope.where(query) : model.none
      end

      protected

      def model
        @_model ||= self.class.model
      end

      def current_scope
        @current_scope || model
      end
    end
  end
end
