# frozen_string_literal: true

class UsersBadge < ApplicationRecord
  belongs_to :badge
  belongs_to :user
end
