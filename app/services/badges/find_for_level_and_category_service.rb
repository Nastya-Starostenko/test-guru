# frozen_string_literal: true

module Badges
  class FindForLevelAndCategoryService < Badges::FindForLevelService
    private

    def original_badges
      @original_badges ||= Badge.where(
        "conditions ->> 'category_id' = ':category_id' AND (conditions ->> 'level')::Integer = :level",
        category_id: current_test.category_id, level: current_test.level
      )
    end
  end
end
