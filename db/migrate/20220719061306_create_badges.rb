# frozen_string_literal: true

class CreateBadges < ActiveRecord::Migration[6.0]
  def change
    create_table :badges do |t|
      t.string :name, null: false
      t.json :conditions, null: true
      t.string :image_url, null: false
      t.string :kind, null: false
      t.timestamps
    end

    add_index :badges, :name, unique: true
    add_index :badges, :image_url, unique: true
  end
end
