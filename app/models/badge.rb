# frozen_string_literal: true

class Badge < ApplicationRecord
  has_many :users, through: :users_badges
  has_many :users_badges, dependent: :destroy
  belongs_to :category, optional: true
  belongs_to :test, optional: true

  validates :name, uniqueness: true
  validates :image_url, presence: true, uniqueness: true, format: { with: URI::DEFAULT_PARSER.make_regexp }
end
