# frozen_string_literal: true

class AssignBadgeForUserService
  def initialize(test_passage:)
    @test_passage = test_passage
  end

  def perform
    return unless @test_passage.successful?

    find_badges
    OpenStruct.new({ success?: true })
  rescue Octokit::Error, InvalidInput, ActiveRecord::RecordInvalid => e
    OpenStruct.new({ success?: false, error: e })
  end

  private

  def find_badges
    Badges::ForTestService.new(test_passage: @test_passage).perform
    Badges::ForCategoryService.new(test_passage: @test_passage).perform
    Badges::ForLevelService.new(test_passage: @test_passage).perform
    Badges::ForLevelAndCategoryService.new(test_passage: @test_passage).perform
  end
end
