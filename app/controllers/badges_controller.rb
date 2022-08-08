# frozen_string_literal: true

class BadgesController < ApplicationController
  before_action :badges, only: [:index]

  def index; end

  private

  def badges
    @badges = current_user.badges
  end
end
