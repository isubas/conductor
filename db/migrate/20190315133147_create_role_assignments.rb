# frozen_string_literal: true

class CreateRoleAssignments < ActiveRecord::Migration[6.0]
  def change
    create_table :role_assignments do |t|
      t.references :role, foreign_key: true
      t.references :rolable, polymorphic: true, null: false

      t.timestamps
    end

    add_index :role_assignments,
              %i[rolable_type rolable_id role_id],
              unique: true,
              name: 'role_assignments_rolable_role'
  end
end
