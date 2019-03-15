# frozen_string_literal: true

class ControllerAction < ApplicationRecord
  has_many :permission_actions, dependent: :destroy
  has_many :permissions, through: :permission_actions
  has_many :roles, through: :permissions

  validates :action, presence: true, uniqueness: { scope: :controller }
  validates :controller, presence: true

  def name
    controller + '#' + action
  end
end
