# frozen_string_literal: true

class Answer < ApplicationRecord
  belongs_to :question

  validates :body, presence: true
  validate :validate_answers_count_in_test, on: :create

  scope :correct, -> { where(correct: true) }

  private

  def validate_answers_count_in_test
    errors.add(:answers, 'must be between 1 and 4') if question.answers.count >= 4
  end
end
