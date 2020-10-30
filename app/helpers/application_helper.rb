# frozen_string_literal: true

module ApplicationHelper
  def profile_title(user)
    if user == current_user
      t('words.my') + t('activerecord.pages.profile')
    else
      t('activerecord.pages.profile')
    end
  end
end
