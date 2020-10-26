class LocaleController < ApplicationController
  def new
  end

  def create
    if %w(ja en).include?(params[:locale])
      cookies[:locale] = params[:locale]
      redirect_to books_path
    end
  end
end
