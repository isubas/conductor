# frozen_string_literal: true

class CreateRoleAssignments < ActiveRecord::Migration[6.0]
  def change
    create_table :role_assignments do |t|
      t.references :role, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end

    add_index :role_assignments,
              %i[user_id role_id],
              unique: true,
              name: 'role_assignments_rolable_role'
  end
end
