# frozen_string_literal: true

class User < ApplicationRecord
  has_many :test_results, dependent: :destroy
  has_many :tests, through: :test_results

  has_many :authored_tests, class_name: 'Test', foreign_key: :author_id, inverse_of: :author, dependent: :nullify

  def tests_by_level(level)
    Test.joins('JOIN test_results ON test_results.test_id = tests.id')
        .where(level: level, test_results: { user_id: id })
  end
end
