# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_locale

  private
  def set_locale
    if %w(ja en).include?(cookies[:locale])
      I18n.locale = cookies[:locale]
    end
  end
end
