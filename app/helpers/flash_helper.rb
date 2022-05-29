# frozen_string_literal: true

module FlashHelper
  def display_flash_messages
    return unless flash.any?

    messages = '<div class="flash-messages">'
    flash.each do |type, message|
      messages += "<div id='#{type}' class='flash alert'>#{message}</div>"
    end
    messages.html_safe
  end
end
