require 'test_helper'

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  include Devise::Test::IntegrationHelpers

  driven_by :selenium, using: :headless_chrome

  setup do
    host! 'http://peter.lvh.me'
    sign_in users(:peter)
  end
end
