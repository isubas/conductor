# frozen_string_literal: true

class CreatePermissions < ActiveRecord::Migration[6.0]
  def change
    create_table :permissions do |t|
      t.string :name
      t.string :identifier
      t.text :description

      t.timestamps
    end
  end
end
