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
      result = ::CreateBadgeService.new(
        image_url: permit_params[:image_url], kind: permit_params[:kind], **condition_params
      ).call

      if result.success?
        redirect_to admins_badges_path, flash: { alert: t('admin.badge.create.success') }
      else
        @badge = Badge.new(image_url: permit_params[:image_url],
                           kind: permit_params[:kind],
                           conditions: condition_params)
        flash.now[:error] = result.errors.join(', ')
        render :new
      end
    end

    def edit; end

    def update
      if @badge.update(permit_params[:image_url])
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

    def condition_params
      params.require('badge').permit(
        :all_tests, :first_test, :level, :count_of_test, :category_id, :test_id
      )
    end

    def permit_params
      params.require('badge').permit(:image_url, :kind)
    end
  end
end
