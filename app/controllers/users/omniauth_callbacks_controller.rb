# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    auth = request.env['omniauth.auth']
    @user = User.from_omniauth(auth)

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: "GitHub") if is_navigational_format?
    elsif auth.info.email.nil?
      session[:github] = auth
      redirect_to new_user_registration_url, notice: t('flash.email_notice')
    else
      redirect_to new_user_session_url, notice: t('flash.error')
    end
  end

  def failure
    redirect_to root_path
  end
end
