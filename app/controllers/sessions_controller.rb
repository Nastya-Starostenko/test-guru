# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[new create]
  before_action :set_user, only: %i[create destroy]

  def new
    redirect_to root_path if logged_in?
  end

  def create
    if @user&.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to cookies[:requested_path].presence || tests_path
    else
      flash.now[:alert] = 'Verify your Email and Password, please'
      render :new
    end
  end

  def destroy
    reset_session
    redirect_to login_path, alert: 'You successfully logout'
  end

  private

  def set_user
    @user = User.find_by(email: params[:email])
  end
end
