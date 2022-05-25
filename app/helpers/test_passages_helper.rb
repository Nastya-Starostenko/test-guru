# frozen_string_literal: true

module TestPassagesHelper
  def get_title(test_passage)
    base_string = "The #{test_passage.test.title} test was "
    "#{base_string}#{result_in_word(test_passage)} completed!"
  end

  def get_title_class(test_passage)
    "#{result_in_word(test_passage)}_title"
  end

  private

  def result_in_word(test_passage)
    test_passage.result_in_percent >= 85 ? 'successful' : 'failed'
  end
end
