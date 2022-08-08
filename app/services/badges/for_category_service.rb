# frozen_string_literal: true

module Badges
  class ForCategoryService < Badges::ForTestService
    private

    def badges
      @badges ||= Badge.where(category_id: current_test.category_id, level: nil)
    end

    def rules_failed?
      @errors.push('Can\'t find badge for category') if badges.blank?
      @errors.present?
    end
  end
end
