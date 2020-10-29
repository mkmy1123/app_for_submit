# frozen_string_literal: true

module ApplicationHelper
  def appears_edit_btn_when_user_equals_current_user(user)
    if user == current_user
      link_to t('page.edit'), edit_user_path(@user)
    end
  end

  def postcode_format_required
    "#{User.human_attribute_name(:postcode)} #{t('page.postcode_alert')}"
  end

  def convert_feeling_to_emoji(report)
    if report.normal?
      "🙂"
    elsif report.bad?
      "😢"
    elsif report.good?
      "😄"
    end
  end
end
