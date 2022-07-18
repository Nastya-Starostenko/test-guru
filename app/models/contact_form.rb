# frozen_string_literal: true

class ContactForm < MailForm::Base
  DEFAULT_EMAIL = 'testemail@gmail.com'

  attribute :name, validate: true
  attribute :email, validate: true
  attribute :message

  def headers
    {
      subject: I18n.t('contacts_form.subject'),
      to: email_receiver,
      from: %("#{name}" <#{email}>)
    }
  end

  private

  def email_receiver
    ENV['CONTACT_EMAIL'] || Admin.first.email || DEFAULT_EMAIL
  end
end
