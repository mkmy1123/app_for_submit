require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  include DeviseHelper

  def setup
    @user = users(:mkmy1123)
  end

  test "should return link to edit when user equals current_user" do
    assert_dom_equal %{<a href="/users/#{@user.id}/edit">編集</a>}, appears_edit_btn_when_user_equals_current_user(@user)
  end

  test "should return postcode with alert" do
    assert_equal postcode_format_required, "郵便番号 (ハイフン必須)"
  end
end
