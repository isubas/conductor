# frozen_string_literal: true

class RoleAssignment < ApplicationRecord
  belongs_to :role
  belongs_to :rolable, polymorphic: true
end
