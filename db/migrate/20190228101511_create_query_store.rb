# frozen_string_literal: true

class CreateQueryStore < ActiveRecord::Migration[6.0]
  def change
    create_table :query_stores do |t|
      t.string :name
      t.references :user, foreign_key: true
      t.text :parameters

      t.timestamps
    end

    add_index :query_stores, %I[name user_id]
  end
end
