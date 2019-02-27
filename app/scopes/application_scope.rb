# frozen_string_literal: true

class ApplicationScope < Auth::Scope::Base
  def initialize(user)
    @user = user
  end
end
