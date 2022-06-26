# frozen_string_literal: true

class Gist < ApplicationRecord
  belongs_to :question
  belongs_to :author, class_name: 'User', inverse_of: :authored_gist

  validates :question, presence: true
  validates :author, presence: true
  validates :hash_id, presence: true
  validates :url, presence: true
end
