# frozen_string_literal: true

class CreateAnswers < ActiveRecord::Migration[6.0]
  def change
    create_table :answers do |t|
      t.string :body, null: false
      t.string :correct, null: false, default: false
      t.belongs_to :question, null: false, foreign_key: true

      t.timestamps
    end
  end
end
