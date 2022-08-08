# frozen_string_literal: true

module Badges
  class ForTestService < Badges::BaseAssignService
    private

    def badges
      @badges ||= Badge.where(test_id: @test_passage.test_id)
    end

    def rules_failed?
      @errors.push('Can\'t find badge for test') if badges.blank?
      @errors.push('User complete test not in the first time') if count_of_test_passages > 1
      @errors.present?
    end
  end
end
