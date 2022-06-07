# frozen_string_literal: true

module Registrations
  class RegistrationsController < Devise::RegistrationsController
    def create
      super
      set_flash_message! :notice,
                         :signed_up_custom,
                         users_first_name: @user.first_name,
                         users_last_name: @user.last_name
    end
  end
end
