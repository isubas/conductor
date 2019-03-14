# frozen_string_literal: true

class PermissionAction < ApplicationRecord
  belongs_to :controller_action
  belongs_to :permission
end
