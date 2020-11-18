# frozen_string_literal: true

require 'application_system_test_case'

class ReportsTest < ApplicationSystemTestCase
  include SignInHelper
  include SelectDateHelper
  setup do
    @first_report = reports(:first_report)
    @user = users(:mkmy1123)
    sign_in_as(@user)
  end

  test 'visiting the index' do
    visit reports_url
    assert_selector 'h1', text: '日報'
  end

  test 'creating a Report' do
    visit reports_url
    click_on '新規作成'

    fill_in 'タイトル', with: '2日めの日報'
    fill_in '学習日',	with: '002020-01-01'
    fill_in '内容', with: '頑張ろう〜！'
    select_time("11", "00", from: "開始時間")
    select_time("13", "00", from: "終了時間")

    click_on '登録する'

    assert_text '作成しました'
    assert_text '2日めの日報'
    assert_text '11:00'
    assert_text '13:00'
    assert_text '頑張ろう〜！'
  end

  test 'updating a Report' do
    visit reports_url
    click_on '編集', match: :first

    fill_in 'タイトル', with: '1日めの日報'
    click_on '更新する'

    assert_text '更新しました'
    assert_no_text @first_report.title
    assert_text '1日めの日報'
  end

  test 'destroying a Report' do
    visit reports_url
    page.accept_confirm do
      click_on '削除', match: :first
    end

    assert_text '削除しました'
    assert_no_text @first_report.title
  end
end
