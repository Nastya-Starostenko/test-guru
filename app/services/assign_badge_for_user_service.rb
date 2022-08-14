# frozen_string_literal: true

class AssignBadgeForUserService
  class ServiceError < StandardError; end

  attr_reader :errors

  def initialize(test_passage:)
    @test_passage = test_passage
    @user = test_passage.user
    @errors = []
    @success = false
  end

  def call
    validate_variable!

    user.badges << badges
    raise ServiceError, errors.join(', ') if errors.any?

    self.success = true
  rescue StandardError
    self
  end

  def success?
    success
  end

  private

  attr_accessor :test_passage, :user, :success
  attr_writer :errors

  def validate_variable!
    errors.push('Test passage must be present!') if test_passage.blank?
    errors.push('Test must be successful!') unless test_passage&.successful?
    raise ServiceError, errors.join(', ') if errors.any?
  end

  def badges
    Badge.kinds.keys.map do |name|
      "Badges::FindFor#{name.to_s.camelize}Service".constantize.new(input).call&.badges
    end.flatten.compact
  end

  def input
    @input ||= { current_test: @test_passage.test, user: user }
  end
end
