# frozen_string_literal: true

class ChangeCorrectColumnFormatOnAnswers < ActiveRecord::Migration[6.0]
  def self.up
    execute 'ALTER TABLE answers ALTER COLUMN correct DROP DEFAULT'
    change_column :answers, :correct, "boolean USING correct not in ('f', '0')"
    change_column_default :answers, :correct, false
  end

  def self.down
    execute 'ALTER TABLE answers ALTER COLUMN correct DROP DEFAULT'
    change_column :answers, :correct, "text using case when correct then 'true' else 'false' end"
    change_column_default :answers, :correct, 'false'
  end
end
