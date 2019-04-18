# frozen_string_literal: true

class Role < ApplicationRecord
  has_many :role_assignments, dependent: :destroy
  has_many :users, through: :role_assignments
  has_many :role_permissions, dependent: :destroy
  has_many :permissions, through: :role_permissions
end
