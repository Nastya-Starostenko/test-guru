# frozen_string_literal: true

class Badge < ApplicationRecord
  has_many :users, through: :users_badges
  has_many :users_badges, dependent: :destroy

  validates :name, uniqueness: true
  validates :image_url, presence: true, uniqueness: true, format: { with: URI::DEFAULT_PARSER.make_regexp }

  enum kind: {
    test: 'Test',
    category: 'Category',
    level: 'Level',
    level_and_category: 'Level And Category'
  }
end
