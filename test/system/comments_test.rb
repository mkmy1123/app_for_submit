# frozen_string_literal: true

require 'application_system_test_case'

class CommentsTest < ApplicationSystemTestCase
  include SignInHelper
  setup do
    @user = users(:mkmy1123)
    @other_user = users(:tanaka1010)
    @cherry_book = books(:cherry_book)
    @first_report = reports(:first_report)
    sign_in_as(@user)
  end

  test 'visiting book show' do
    visit book_url(@cherry_book)
    assert_no_text 'チェリー本いいですよね〜！'
    Comment.create!(commentable: @cherry_book, user_id: @user.id, content: 'チェリー本いいですよね〜！')
    visit book_url(@cherry_book)
    assert_text 'チェリー本いいですよね〜！'
  end

  test 'visiting report show' do
    visit report_url(@first_report)
    assert_no_text '頑張ってますね〜！'
    Comment.create!(commentable: @first_report, user_id: @user.id, content: '頑張ってますね〜！')
    visit report_url(@first_report)
    assert_text '頑張ってますね〜！'
  end

  test 'creating a BookComment' do
    visit book_url(@cherry_book)
    fill_in '本文',	with: '同感です！'
    click_on '登録する'
    assert_text '同感です！'
  end

  test 'creating a ReportComment' do
    visit report_url(@first_report)
    fill_in '本文',	with: '素敵です！'
    click_on '登録する'
    assert_text '素敵です！'
  end

  test 'destroying a BookComment' do
    Comment.create!(commentable: @cherry_book, user_id: @user.id, content: 'チェリー本いいですよね〜！')
    visit book_url(@cherry_book)
    assert_text 'チェリー本いいですよね〜！'
    click_on '削除'
    assert_no_text 'チェリー本いいですよね〜！'
  end

  test 'destroying a ReportComment' do
    Comment.create!(commentable: @first_report, user_id: @user.id, content: '頑張ってますね〜！')
    visit report_url(@first_report)
    assert_text '頑張ってますね〜！'
    click_on '削除'
    assert_no_text '頑張ってますね〜！'
  end

  test 'destroying a BookComment by created user' do
    Comment.create!(commentable: @cherry_book, user_id: @user.id, content: 'チェリー本いいですよね〜！')
    sign_out
    sign_in_as(@other_user)
    visit book_url(@cherry_book)
    assert_text 'チェリー本いいですよね〜！'
    assert_no_button '削除'
  end

  test 'destroying a ReportComment by created user' do
    Comment.create!(commentable: @first_report, user_id: @user.id, content: '頑張ってますね〜！')
    sign_out
    sign_in_as(@other_user)
    visit report_url(@first_report)
    assert_text '頑張ってますね〜！'
    assert_no_button '削除'
  end
end
