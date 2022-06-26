# frozen_string_literal: true

class CreateGistTable < ActiveRecord::Migration[6.0]
  def change
    create_table :gists do |t|
      t.string :hash_id, null: false
      t.string :url, null: false
      t.belongs_to :question, null: false, foreign_key: true
      t.belongs_to :author, foreign_key: { to_table: 'users' }

      t.timestamps
    end
  end
end
