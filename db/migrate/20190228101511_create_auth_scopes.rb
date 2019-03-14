# frozen_string_literal: true

class CreateAuthScopes < ActiveRecord::Migration[6.0]
  def change
    create_table :auth_scopes do |t|
      t.string :name
      t.references :user, foreign_key: true
      t.text :values
      t.text :preferences

      t.timestamps
    end
  end
end
