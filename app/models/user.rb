# frozen_string_literal: true

class User < ApplicationRecord
  has_many :test_results, dependent: :destroy
  has_many :tests, through: :test_results
  has_many :authored_tests, class_name: 'Test', foreign_key: :author_id, inverse_of: :author, dependent: :nullify

  validates :email, presence: true
  validates :name, presence: true

  def tests_by_level(level)
    tests.where(level: level)
  end
end
