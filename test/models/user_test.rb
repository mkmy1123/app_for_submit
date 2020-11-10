require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:mkmy1123)
    @other_user = users(:tanaka1010)
  end

  test "should increase other_user's follower when user follow other_user" do
    assert_equal @other_user.followers.count, 0
    @user.follow(@other_user)
    assert_equal @other_user.followers.count, 1
  end

  test "should decrease other_user's follower when user unfollow other_user" do
    UserRelationship.create!(followed_id: @other_user.id, following_id: @user.id)
    assert_equal @other_user.followers.count, 1
    @user.unfollow(@other_user)
    assert_equal @other_user.followers.count, 0
  end

  test "should return true only when user follow other_user" do
    assert_equal @user.following?(@other_user), false
    UserRelationship.create!(followed_id: @other_user.id, following_id: @user.id)
    assert_equal @user.following?(@other_user), true
  end
end
