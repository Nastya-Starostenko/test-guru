# frozen_string_literal: true

class Test < ApplicationRecord
  has_many :questions, dependent: :destroy
  has_many :test_results, dependent: :nullify
  has_many :users, through: :test_results

  belongs_to :category
  belongs_to :author, class_name: 'User', inverse_of: :authored_tests

  class << self
    def by_category(category_name)
      joins('JOIN categories ON tests.category_id = categories.id')
        .where(categories: { title: category_name })
        .order(title: :desc)
        .pluck(:title)
    end
  end
end
