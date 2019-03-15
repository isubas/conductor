# frozen_string_literal: true

class DashboardController < ApplicationController
  before_action :authorize
  def index
    @counter = {
      roles: Role.count,
      permissions: Permission.count,
      actions: ControllerAction.count
    }
  end
end
