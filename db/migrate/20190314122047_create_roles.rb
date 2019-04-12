# frozen_string_literal: true

class CreateRoles < ActiveRecord::Migration[6.0]
  def change
    create_table :roles do |t|
      t.string :name
      t.string :identifier
      t.boolean :locked, default: false

      t.timestamps
    end

    add_index :roles, :name, unique: true
    add_index :roles, :identifier, unique: true
  end
end
