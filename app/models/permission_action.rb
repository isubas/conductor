class PermissionAction < ApplicationRecord
  belongs_to :action
  belongs_to :permission
end
