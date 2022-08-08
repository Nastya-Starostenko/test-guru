# frozen_string_literal: true

module Badges
  class BaseAssignService
    def initialize(test_passage:)
      @test_passage = test_passage
      @errors = []
    end

    def perform
      return unless @test_passage.successful?

      badges = assign_badges
      OpenStruct.new({ success?: true, badges: badges })
    rescue StandardError => e
      OpenStruct.new({ success?: false, badges: [], error: e })
    end

    private

    def assign_badges
      return [] if rules_failed?

      user.badges << badges
    end

    def rules_failed?
      raise NotImplementedError
    end

    def badges
      raise NotImplementedError
    end

    def current_test
      @current_test ||= @test_passage.test
    end

    def user
      @user ||= @test_passage.user
    end

    def count_of_test_passages
      user.test_passages.where(test_id: current_test.id).count
    end
  end
end
