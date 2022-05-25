# frozen_string_literal: true

class TestPassage < ApplicationRecord
  belongs_to :user
  belongs_to :test
  belongs_to :current_question, class_name: 'Question', optional: true

  before_validation :before_validation_set_first_question, on: :create
  before_update :before_update_set_next_question

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

  def result_in_percent
    return unless completed?

    correct_questions / questions.count.to_f * 100
  end

  private

  def before_validation_set_first_question
    self.current_question = test.questions.first if test.present?
  end

  def before_update_set_next_question
    self.current_question = questions.find_by('id > ?', current_question.id)
  end

  def correct_answer?(answer_ids)
    current_question.answers.correct.ids.sort == answer_ids.map(&:to_i).sort
  end

  def questions
    @questions ||= test.questions.order(:id)
  end
end
