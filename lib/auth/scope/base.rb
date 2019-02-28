# frozen_string_literal: true

require_relative './filter'
require_relative './form'
require_relative './query'

module Auth
  module Scope
    class Base
      extend Filter
      extend Form
      include Query

      attr_reader :user

      protected

      def model
        self.class.to_s.delete_suffix('Scope').constantize
      end
    end
  end
end
