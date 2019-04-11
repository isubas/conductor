# frozen_string_literal: true

module Patron
  module Controller
    extend ActiveSupport::Concern

    class NotAuthorizedError < Patron::Error
      attr_reader :controller_action

      def initialize(options = {})
        action     = options[:action]
        controller = options[:controller].titlecase
        message    = options.fetch(:message) do
          "not allowed to #{controller}Controller##{action}"
        end

        super(message)
      end
    end

    included do
      def authorize
        return if controller_action_exist?

        raise NotAuthorizedError.new(action: action_name, controller: controller_name)
      end

      private

      def controller_action_exist?
        current_user.actions.exists?(
          action: action_name,
          controller: controller_name
        )
      end
    end
  end
end