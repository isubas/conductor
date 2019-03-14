# frozen_string_literal: true

class CreatePermissionActions < ActiveRecord::Migration[6.0]
  def change
    create_table :permission_actions do |t|
      t.references :controller_action, foreign_key: true
      t.references :permission, foreign_key: true

      t.timestamps
    end
  end
end
