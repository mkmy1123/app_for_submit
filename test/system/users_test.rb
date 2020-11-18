# frozen_string_literal: true

require 'application_system_test_case'

class UsersTest < ApplicationSystemTestCase
  include SignInHelper
  setup do
    @user = users(:mkmy1123)
    @other_user = users(:tanaka1010)
  end

  test 'visiting the index' do
    sign_in_as(@user)
    visit users_path
    assert_selector 'h1', text: 'ユーザー'
  end

  test 'creating a User' do
    visit new_user_registration_path
    fill_in 'Eメール', with: 'suzuki@example.com'
    fill_in 'パスワード', with: 'password'
    fill_in 'パスワード（確認用）', with: 'password'
    fill_in '名前',	with: 'スズキ'
    click_button 'アカウント登録'

    user = User.last
    token = user.confirmation_token
    visit user_confirmation_path(confirmation_token: token)

    visit new_user_session_path
    fill_in 'Eメール', with: 'suzuki@example.com'
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
    assert_text 'ログインしました'
  end

  test 'updating a User' do
    sign_in_as(@user)
    visit user_path(@user)
    click_link '編集'
    fill_in '自己紹介', with: ''
    fill_in '自己紹介', with: 'こんにちは！'
    click_button '更新する'
    assert_text '更新しました'
    assert_text 'こんにちは！'
    assert_no_text @user.introduction
  end

  test 'refuse updating an other User' do
    sign_in_as(@user)
    visit edit_user_path(@other_user)
    assert_text '操作できるのはご自身のアカウントのみです'
  end
end
