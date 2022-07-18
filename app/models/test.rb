# frozen_string_literal: true

class Test < ApplicationRecord
  belongs_to :category
  belongs_to :author, class_name: 'User', inverse_of: :authored_tests

  has_many :questions, dependent: :destroy
  has_many :test_passages, dependent: :destroy
  has_many :users, through: :test_passages

  validates :title, presence: true, uniqueness: { scope: :level }
  validates :level, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  scope :by_level, ->(level) { where(level: level) }
  scope :easy, -> { by_level(0..1) }
  scope :medium, -> { by_level(2..4) }
  scope :hard, -> { by_level(5..) }
  scope :by_category, lambda { |category_name|
    joins(:category).where(categories: { title: category_name }).order(title: :desc)
  }

  class << self
    def titles_by_category(category_name)
      by_category(category_name).pluck(:title)
    end
  end
end
