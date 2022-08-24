# frozen_string_literal: true

class AddTimeForTests < ActiveRecord::Migration[6.0]
  def change
    add_column :tests, :time, :integer, null: false, default: 15, comment: 'Time for passing test'
  end
end
