# frozen_string_literal: true

require 'application_system_test_case'

class UserRelationshipsTest < ApplicationSystemTestCase
  include SignInHelper
  setup do
    @user = users(:mkmy1123)
    @other_user = users(:tanaka1010)
    sign_in_as(@user)
  end

  test 'visiting the following index' do
    visit following_user_path(@user)
    assert_selector 'h1', text: 'フォロー一覧'
    assert_no_text @other_user.name
    UserRelationship.create!(following_id: @user.id, followed_id: @other_user.id)
    visit following_user_path(@user)
    assert_text @other_user.name
  end

  test 'visiting the follower index' do
    visit follower_user_path(@user)
    assert_selector 'h1', text: 'フォロワー一覧'
    assert_no_text @other_user.name
    UserRelationship.create!(following_id: @other_user.id, followed_id: @user.id)
    visit follower_user_path(@user)
    assert_text @other_user.name
  end

  test 'creating a UserRelationship' do
    visit user_path(@other_user)
    assert_text 'Followers: 0'
    click_button 'フォローする'
    assert_text 'フォローしました'
    assert_text 'Followers: 1'
  end

  test 'destroying a UserRelationship' do
    UserRelationship.create!(following_id: @user.id, followed_id: @other_user.id)
    visit user_path(@other_user)
    assert_text 'Followers: 1'
    click_button 'フォローを外す'
    assert_text 'フォローを外しました'
    assert_text 'Followers: 0'
  end
end
