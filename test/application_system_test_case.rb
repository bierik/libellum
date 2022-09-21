require 'test_helper'

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  include Devise::Test::IntegrationHelpers

  driven_by :selenium, using: :chrome

  setup do
    Capybara.app_host = 'http://peter.lvh.me'
    sign_in users(:peter)
  end
end
