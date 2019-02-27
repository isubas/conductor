class CreatePermissionActions < ActiveRecord::Migration[6.0]
  def change
    create_table :permission_actions do |t|
      t.references :action, foreign_key: true
      t.references :permission, foreign_key: true

      t.timestamps
    end
  end
end
