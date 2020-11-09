class UserRelationshipsController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    current_user.follow(@user)
    redirect_to @user, notice: t('flash.follow')
  end

  def destroy
    @user = User.find(params[:id])
    current_user.unfollow(@user)
    redirect_to @user, notice: t('flash.unfollow')
  end
end
