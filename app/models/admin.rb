# frozen_string_literal: true

class Admin < User
  # self.inheritance_column  = 'role'

  validates :first_name, presence: true
  validates :last_name, presence: true
end
