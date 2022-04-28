# frozen_string_literal: true

class User < ApplicationRecord
  def tests_by_level(level)
    Test.joins('JOIN test_results ON test_results.test_id = tests.id')
        .where(level: level, test_results: { user_id: id })
  end
end
