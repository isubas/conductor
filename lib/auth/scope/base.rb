# frozen_string_literal: true

require_relative './filter'
require_relative './form'
require_relative './query'
require_relative './custom_method'

module Auth
  module Scope
    class Base
      extend Filter
      extend Form
      extend CustomMethod
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
