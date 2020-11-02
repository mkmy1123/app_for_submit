class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update]

  def index
    @users = User.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
  end

  def update
    @user.update(user_params)
    redirect_to @user, notice: t('flash.update')
  end

  private
    def user_params
      params.require(:user).permit(
        :name, :postcode, :address, :introduction, :icon_image
      )
    end

    def set_user
      @user = User.find(params[:id])
    end
end
