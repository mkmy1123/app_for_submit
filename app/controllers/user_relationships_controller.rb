class UserRelationshipsController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    current_user.following_relationships.find_or_create_by(followed_id: @user.id)
  end

  def destroy
    @user = User.find(params[:id])
    relationship = current_user.following_relationships.find_by(followed_id: @user.id)
    relationship.destroy
  end
end
