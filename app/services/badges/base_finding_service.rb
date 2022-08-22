# frozen_string_literal: true

module Badges
  class BaseFindingService
    class ServiceError < StandardError; end

    def initialize(current_test:, user:)
      self.current_test = current_test
      self.user = user
      self.errors = []
    end

    def call
      validate_variable!
      find_badges!
      validate_rules!
      raise ServiceError, errors.join(', ') if errors.any?

      OpenStruct.new({ success?: true , badges: badges})
    rescue StandardError
      OpenStruct.new({ success?: false, badges: badges,error: e })
    end

    private

    attr_accessor :current_test, :user, :success, :badges, :errors

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
