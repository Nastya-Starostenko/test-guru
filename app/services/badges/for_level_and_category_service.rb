# frozen_string_literal: true

module Badges
  class ForLevelAndCategoryService < Badges::ForTestService
    private

    def badges
      Badge.where(level: test.level, category_id: test.category_id)
    end
  end
end
