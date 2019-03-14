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

      def self.model
        to_s.delete_suffix('Scope').safe_constantize
      end

      def model
        self.class.model
      end
    end
  end
end
