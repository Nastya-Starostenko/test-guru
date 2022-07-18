# frozen_string_literal: true

module ApplicationHelper
  def current_year
    Time.zone.now.year
  end

  def github_url(author, repo)
    link_to "#{author}'s Github ", repo, target: '_blank', rel: 'noopener'
  end

  def language_label
    "#{I18n.t('navigation.change_to')}: #{I18n.locale == I18n.default_locale ? 'RU' : 'EN'}"
  end

  def navigation_title
    current_user.is_a?(Admin) ? I18n.t('navigation.admin_nav') : I18n.t('navigation.user_nav')
  end
end
