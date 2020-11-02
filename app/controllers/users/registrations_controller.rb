# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]

  def create
    if session[:github]
      User.create!(
        uid: session[:github]['uid'],
        provider: session[:github]['provider'],
        password: Devise.friendly_token[0, 20],
        email: params[:user][:email],
        name: params[:user][:name],
        postcode: params[:user][:postcode],
        address: params[:user][:address],
        introduction: params[:user][:introduction]
      )
      redirect_to root_path, notice: t('.signed_up_but_unconfirmed')
    else
      super
    end
    session.delete(:github)
  end

  protected
    def configure_sign_up_params
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :postcode, :address, :introduction])
    end

    def after_sign_in_path_for(resource)
      root_path
    end
end
