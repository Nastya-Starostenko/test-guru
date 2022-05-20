# frozen_string_literal: true

module QuestionHelper
  def question_header(question)
    test_title = question.test.title
    question.persisted? ? "Edit <#{test_title}> Question" : "Create New <#{test_title}> Question"
  end
end
