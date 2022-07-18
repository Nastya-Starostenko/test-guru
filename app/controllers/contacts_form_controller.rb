# frozen_string_literal: true

class ContactsFormController < ApplicationController
  before_action :create_contact_form, only: %i[create new]
  skip_before_action :authenticate_user!, only: %i[new create]

  def new; end

  def create
    @contact_form.name = permited_params[:name]
    @contact_form.email = permited_params[:email]
    @contact_form.message = permited_params[:message]
    if @contact_form.deliver
      flash.now[:success] = I18n.t('contacts_form.success')
    else
      flash.now[:error] = I18n.t('contacts_form.failed')
    end
    render :new
  end

  private

  def permited_params
    params.require(:contact_form).permit(:name, :email, :message)
  end

  def create_contact_form
    @contact_form = ContactForm.new
  end
end
