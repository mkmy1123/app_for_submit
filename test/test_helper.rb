# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: 2)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  module SignInHelper
    def sign_in_as(user)
      visit new_user_session_path
      fill_in "Eメール",	with: user.email
      fill_in "パスワード",	with: "password"
      click_button 'ログイン'
    end

    def sign_out
      visit root_path
      click_link 'ログアウト'
    end
  end

  module SelectDateHelper
    def select_time(hour, minute, options = {})
      field = options[:from]
      base_id = find(:xpath, ".//label[contains(.,'#{field}')]")[:for]
      select hour, :from => "#{base_id}_4i"
      select minute, :from => "#{base_id}_5i"
    end
  end
end
