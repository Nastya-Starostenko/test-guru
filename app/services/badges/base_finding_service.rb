# frozen_string_literal: true

module Badges
  class BaseFindingService
    class ServiceError < StandardError; end

    attr_reader :badges, :errors

    def initialize(current_test:, user:)
      self.current_test = current_test
      self.user = user
      self.errors = []
    end

    def call
      self.success = false

      validate_variable!
      find_badges!
      validate_rules!
      raise ServiceError, errors.join(', ') if errors.any?

      self.success = true
      self
    rescue StandardError
      self
    end

    def success?
      success
    end

    private

    attr_accessor :current_test, :user, :success
    attr_writer :badges, :errors

    def validate_variable!
      errors.push('User must be present!') if user.blank?
      errors.push('Current test must be present!') if current_test.blank?
      raise ServiceError, errors.join(', ') if errors.any?
    end

    def find_badges!
      raise NotImplementedError
    end

    def validate_rules!
      raise NotImplementedError
    end
  end
end
