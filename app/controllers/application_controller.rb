# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Auth::Controller
  before_action :authenticate_user!

  rescue_from Auth::Controller::NotAuthorizedError, with: :not_authorized

  private

  def not_authorized
    flash[:notice] = 'Bu işlemi gerçekleştiremezsiniz. Yetkiniz yok.'

    redirect_back(fallback_location: root_path)
  end
end
