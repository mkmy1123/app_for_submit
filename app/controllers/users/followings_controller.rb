class Users::FollowingsController < ApplicationController
  def index
    @user = User.find(params[:id])
    @users = @user.followings.page(params[:page])
  end
end
