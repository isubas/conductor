# frozen_string_literal: true

class ApplicationScope < PatronScope::Base
  def initialize(user)
    @user = user
  end
end
