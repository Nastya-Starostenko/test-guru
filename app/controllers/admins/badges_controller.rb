# frozen_string_literal: true

module Admins
  class BadgesController < ApplicationController
    before_action :badges, only: [:index]
    before_action :badge, only: %i[show edit update destroy]

    def index; end

    def show; end

    def new
      @badge = Badge.new
    end

    def create
      result = ::CreateBadgeService.new(**badge_params).perform

      if result.success?
        redirect_to admins_badges_path, flash: { alert: t('admin.badge.create.success') }
      else
        @badge = Badge.new(badge_params)
        flash.now[:error] = result.error.message
        render :new
      end
    end

    def edit; end

    def update
      if @badge.update(badge_params_update)
        redirect_to admins_badges_path
      else
        render :edit
      end
    end

    def destroy
      @badge.destroy

      redirect_to admins_badges_path
    end

    private

    def badges
      @badges = Badge.all
    end

    def badge
      @badge ||= Badge.find(params[:id])
    end

    def badge_params
      params.require('badge').permit(
        :all_tests, :first_test, :level, :count_of_completed_test, :category_id, :test_id, :image_url
      )
    end

    def badge_params_update
      params.require('badge').permit(:image_url)
    end
  end
end
