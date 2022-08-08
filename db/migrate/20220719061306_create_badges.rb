# frozen_string_literal: true

class CreateBadges < ActiveRecord::Migration[6.0]
  def change
    create_table :badges do |t|
      t.string :name, null: false
      t.string :level, null: true
      t.string :count_of_completed_test, null: true
      t.boolean :all_tests, default: false
      t.boolean :first_test, default: false
      t.string :image_url, null: false
      t.references :category, foreign_key: true
      t.references :test, foreign_key: true

      t.timestamps
    end

    add_index :badges, :name, unique: true
    add_index :badges, :image_url, unique: true
  end
end
