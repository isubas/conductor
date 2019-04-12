# frozen_string_literal: true

class CreateRolePermissions < ActiveRecord::Migration[6.0]
  def change
    create_table :role_permissions do |t|
      t.references :role, foreign_key: true
      t.references :permission, foreign_key: true
      
      t.timestamps
    end

    add_index :role_permissions,
              %i[role_id permission_id],
              unique: true
  end
end
