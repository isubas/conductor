# frozen_string_literal: true

class CreatePermissions < ActiveRecord::Migration[6.0]
  def change
    create_table :permissions do |t|
      t.string :name
      t.string :identifier
      t.text :description
      t.boolean :locked, default: false

      t.timestamps
    end

    add_index :permissions, :name, unique: true
  end
end
