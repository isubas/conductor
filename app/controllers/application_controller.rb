# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit

  before_action :authenticate_user!
  rescue_from Pundit::NotAuthorizedError, with: :not_authorized

  private

  def not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore

    flash[:notice] = t "#{policy_name}.#{exception.query}", scope: 'pundit', default: :default

    redirect_back(fallback_location: root_path)
  end
end
