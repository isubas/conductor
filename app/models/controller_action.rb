# frozen_string_literal: true

class ControllerAction < ApplicationRecord
  def name
    controller + '#' + action
  end
end
