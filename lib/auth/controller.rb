# frozen_string_literal: true

module Auth
  module Controller
    extend ActiveSupport::Concern

    class NotAuthorizedError < Auth::Error
      attr_reader :controller_action

      def initialize(options = {})
        action     = options[:action]
        controller = options[:controller].titlecase

        message = options.fetch(:message) { "not allowed to #{controller}Controller##{action}" }

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
