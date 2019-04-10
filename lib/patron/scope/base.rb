# frozen_string_literal: true

module Patron
  module Scope
    class Base
      extend DSL::Filter
      extend DSL::DefineScope
      extend View::Form

      attr_reader :user

      def self.model
        to_s.delete_suffix('Scope').safe_constantize
      end

      def scope(bypass: false)
        return model.all if bypass

        query = Query::Builder.call(self)

        @_current_scope = query.present? ? model.where(query) : model.none
      end

      protected

      def model
        @_model ||= self.class.model
      end

      def current_user
        @user ||= current_user
      end

      def current_scope
        @_current_scope ||= model
      end
    end
  end
end
