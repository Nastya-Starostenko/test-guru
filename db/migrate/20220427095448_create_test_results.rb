# frozen_string_literal: true

class CreateTestResults < ActiveRecord::Migration[6.0]
  def change
    create_table :test_results do |t|
      t.string :status, null: false, default: 'In progress'
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :test, null: false, foreign_key: true

      t.timestamps
    end
  end
end
