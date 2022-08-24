# frozen_string_literal: true

module Admins
  class BadgesController < ApplicationController
    before_action :badge, only: %i[show edit update destroy]

    def index
      @badges = Badge.all
    end

    def show; end

    def new
      @badge = Badge.new
    end

    def create
      result = ::CreateBadgeService.new(
        image_url: permit_params[:image_url], kind: permit_params[:kind], **condition_params
      ).call

      if result.success?
        redirect_to admins_badges_path, flash: { notice: t('admin.badge.create.success') }
      else
        @badge = result.badge
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

    def badge
      @badge ||= Badge.find(params[:id])
    end

    def condition_params
      params.require('badge').permit(Badges::ConditionalStruct.attributes_name)
    end

    def permit_params
      params.require('badge').permit(:image_url, :kind)
    end
  end
end
