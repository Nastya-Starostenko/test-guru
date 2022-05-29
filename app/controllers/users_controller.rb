# frozen_string_literal: true

class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[new create]

  def new
    @user = User.new
  end

  def create
    @user = User.create(**user_params.merge(role: :user))

    if @user.save
      session[:user_id] = @user.id
      redirect_to tests_path
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :password, :password_confirmation)
  end
end
