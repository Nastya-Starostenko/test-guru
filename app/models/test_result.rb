# frozen_string_literal: true

class TestResult < ApplicationRecord
  belongs_to :test
  belongs_to :user
end
