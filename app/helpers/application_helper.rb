# frozen_string_literal: true

module ApplicationHelper
  def appears_edit_btn_when_user_equals_current_user(user)
    if user == current_user
      link_to t('page.edit'), edit_user_path(@user)
    end
  end
end
