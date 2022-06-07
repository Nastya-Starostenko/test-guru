# frozen_string_literal: true

class AddLastNameAndRenameNameAndRoleAttributesToUsers < ActiveRecord::Migration[6.0]
  def change
    change_column_default(:users, :role, from: nil, to: 'User')
    rename_column(:users, :name, :first_name)
    rename_column(:users, :role, :type)

    add_column :users, :last_name, :string
    add_index :users, :type
  end
end
