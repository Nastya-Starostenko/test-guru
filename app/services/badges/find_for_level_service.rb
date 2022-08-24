# frozen_string_literal: true

module Badges
  class FindForLevelService < Badges::BaseFindingService
    private

    def find_badges!
      for_all_completed_test!
      first_completed_test!
      for_count_of_test!
    end

    def original_badges
      @original_badges ||= Badge.where(
        "conditions ->> 'category_id' is NULL AND (conditions ->> 'level')::Integer = :level",
        level: current_test.level
      )
    end

    def for_all_completed_test!
      return unless user_complete_all_tests?

      self.badges = original_badges.where("(conditions ->> 'all_tests')::Boolean")
    end

    def first_completed_test!
      return unless user_complete_first_test?

      badges << original_badges.where("(conditions ->> 'first_test')::Boolean")
    end

    def for_count_of_test!
      badges << original_badges.where("(conditions ->> 'count_of_test')::Integer = :count",
                                      count: user_completed_test_count)
    end

    def user_complete_all_tests?
      user_completed_test_count == Test.where(level: current_test.level).count
    end

    def user_complete_first_test?
      user_completed_test_count == 1
    end

    def user_completed_test_count
      @user_completed_test_count ||= Test.where(level: current_test.level,
                                                id: user.test_passages.select(&:successful?).map(&:test_id))
                                         .count
    end

    def validate_rules!
      errors.push('Can\'t find badge for condition') if badges.blank?
    end
  end
end
