# frozen_string_literal: true

class Question < ApplicationRecord
  before_destroy :not_the_last_question?

  belongs_to :test

  has_many :test_passages,
           class_name: 'TestPassage',
           foreign_key: :current_question_id,
           inverse_of: :current_question,
           dependent: :nullify

  has_many :answers, dependent: :destroy
  has_many :gists, dependent: :destroy

  validates :body, presence: true

  private

  def not_the_last_question?
    errors.add(:questions, 'must be at least one') if test.questions.length < 2
    throw(:abort) if errors.present?
  end
end
