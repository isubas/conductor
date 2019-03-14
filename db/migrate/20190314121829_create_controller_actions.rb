# frozen_string_literal: true

class CreateControllerActions < ActiveRecord::Migration[6.0]
  def change
    create_table :controller_actions do |t|
      t.string :action
      t.string :controller

      t.timestamps
    end
  end
end
