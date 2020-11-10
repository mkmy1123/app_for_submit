# frozen_string_literal: true

require 'application_system_test_case'

class BooksTest < ApplicationSystemTestCase
  include SignInHelper
  setup do
    @cherry_book = books(:cherry_book)
    @user = users(:mkmy1123)
    sign_in_as(@user)
  end

  test 'visiting the index' do
    visit books_url
    assert_selector 'h1', text: '本'
  end

  test 'creating a Book' do
    visit books_url
    click_on '新規作成'

    fill_in 'タイトル', with: 'ゼロからわかる Ruby 超入門'
    fill_in 'メモ', with: '超入門とっても最高〜！'
    fill_in '著者',	with: '五十嵐 邦明'
    click_on '登録する'

    assert_text '作成しました'
    assert_text 'ゼロからわかる Ruby 超入門'
    assert_text '超入門とっても最高〜！'
    assert_text '五十嵐 邦明'
  end

  test 'updating a Book' do
    visit books_url
    click_on '編集', match: :first

    fill_in 'メモ', with: 'チェリー本やっぱり最高〜！'
    click_on '更新する'

    assert_text '更新しました'
    assert_text @cherry_book.title
    assert_text 'チェリー本やっぱり最高〜！'
    assert_no_text 'チェリー本めっちゃ最高〜！'
  end

  test 'destroying a Book' do
    visit books_url
    page.accept_confirm do
      click_on '削除', match: :first
    end

    assert_text '削除しました'
    assert_no_text @cherry_book.title
  end
end
