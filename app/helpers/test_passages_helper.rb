# frozen_string_literal: true

module TestPassagesHelper
  def get_result_title(test_passage)
    base_string = "The #{test_passage.test.title} test was"
    "#{base_string} #{test_passage.successful? ? 'successful completed!' : 'failed!'}"
  end
end
