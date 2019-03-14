# frozen_string_literal: true

class Permission < ApplicationRecord
  has_many :permission_actions, dependent: :destroy
  has_many :actions, source: :controller_action,
                     through: :permission_actions
  has_many :role_permissions, dependent: :destroy
  has_many :roles, through: :role_permissions
end
