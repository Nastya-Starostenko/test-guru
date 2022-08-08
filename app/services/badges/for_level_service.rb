# frozen_string_literal: true

module Badges
  class ForLevelService < Badges::BaseAssignService
    private

    def badges
      @badges ||= begin
                    original_badges.map do |badge|
                      next unless any_conditions_true?(badge)

                      badge
                    end.compact
                  end
    end

    def original_badges
      Badge.where(level: test.level, category_id: nil)
    end

    def any_conditions_true?(badge)
      (badge.all_tests && user_complete_all_tests?) ||
        (badge.first_test && user_complete_first_test?) ||
        (badge.count_of_completed_tests == user_completed_test_count)
    end

    def user_complete_all_tests?
      user_completed_test_count == all_tests.count
    end

    def user_complete_first_test?
      user_completed_test_count == 1
    end

    def all_tests
      @all_tests = Test.where(level: test.level)
    end

    def user_completed_test_count
      @user_completed_test_count ||= user.test_passages.select(&:successful?).map(&:test_id).uniq.count
    end

    def rules_failed?
      @errors.push('Can\'t find badge for test') if badges.blank?
      badges.blank?
    end
  end
end
