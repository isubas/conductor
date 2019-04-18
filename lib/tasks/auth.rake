# frozen_string_literal: true

namespace :patron do
  desc 'Upsert permissions'
  task upsert_permissions: :environment do
    RoleManager.permissions.each do |identifier, permission|
      record = Permission.find_or_initialize_by(identifier: identifier)
      record.assign_attributes(permission.to_h)
      record.locked = true
      record.save
    end
  end

  desc 'Upsert roles'
  task upsert_roles: :environment do
    RoleManager.roles.each do |identifier, role|
      permissions        = Permission.where(identifier: role.permissions.to_a)
      record             = Role.find_or_initialize_by(identifier: identifier)
      record.locked      = true
      record.permissions = permissions
      record.name        = role.name
      record.save
    end
  end
end
