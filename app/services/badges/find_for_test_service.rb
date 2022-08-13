# frozen_string_literal: true

module Badges
  class FindForTestService < Badges::BaseFindingService
    private

    def find_badges!
      self.badges = Badge.where("conditions ->> 'test_id' = ':test_id'", test_id: current_test.id)
    end

    def validate_rules!
      errors.push('Can\'t find badge for test') if badges.blank?
      errors.push('User already passed the test') if count_of_test_passages > 1 && badges.present?
    end

    def count_of_test_passages
      user.test_passages.where(test_id: current_test.id).select(&:success?).count
    end
  end
end
