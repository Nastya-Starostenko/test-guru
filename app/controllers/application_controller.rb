# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def after_sign_in_path_for(resource)
    return admins_tests_path if current_user.is_a? Admin

    super
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name type])
    devise_parameter_sanitizer.permit(:edit, keys: %i[first_name last_name])
  end
end
