# frozen_string_literal: true

class TestPassage < ApplicationRecord
  SUCCESS_RATIO = 85

  belongs_to :user
  belongs_to :test
  belongs_to :current_question, class_name: 'Question', optional: true

  before_validation :set_current_question

  def set_current_question
    self.current_question = next_question
  end

  def accept!(answer_ids)
    self.correct_questions += 1 if correct_answer?(answer_ids)
    save!
  end

  def completed?
    current_question.nil?
  end

  def question_number
    questions.ids.index(current_question.id) + 1
  end

  def successful?
    return false if result_in_percent.nil?

    result_in_percent >= SUCCESS_RATIO
  end

  def result_in_percent
    return unless completed?

    (correct_questions / questions.count.to_f * 100).round
  end

  private

  def next_question
    self.current_question = persisted? ? questions.find_by('id > ?', current_question.id) : questions.first
  end

  def correct_answer?(answer_ids)
    return false if answer_ids.blank?

    current_question.answers.correct.ids.sort == answer_ids.map(&:to_i).sort
  end

  def questions
    @questions ||= test.questions.order(:id)
  end
end
