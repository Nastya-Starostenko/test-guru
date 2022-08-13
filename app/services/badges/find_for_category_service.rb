# frozen_string_literal: true

module Badges
  class FindForCategoryService < Badges::FindForLevelService
    private

    def original_badges
      @original_badges ||= Badge.where(
        "conditions ->> 'category_id' = ':category_id' AND conditions ->> 'level' IS NULL",
        category_id: current_test.category_id
      )
    end
  end
end
