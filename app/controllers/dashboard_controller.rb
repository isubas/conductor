# frozen_string_literal: true

class DashboardController < ApplicationController
  def index
    @counter = {
      roles: Role.count,
      permissions: Permission.count
    }
  end
end
