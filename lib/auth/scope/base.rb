# frozen_string_literal: true

module Auth
  module Scope
    class Base
      extend DSL::Filter
      extend DSL::DefineScope
      extend Form

      attr_reader :user

      def self.model
        to_s.delete_suffix('Scope').safe_constantize
      end

      def scope(bypass: false)
        return model.all if bypass

        query = Querier::Builder.new(self).run

        @_current_scope = query.present? ? model.where(query) : model.none
      end

      protected

      def model
        @_model ||= self.class.model
      end

      def current_scope
        @_current_scope ||= model
      end
    end
  end
end
