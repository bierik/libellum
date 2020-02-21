require 'test_helper'

class ApplicationControllerTest < ActionDispatch::IntegrationTest
  test 'checks for organization' do
    host! 'does-not-exist.example.com'
    assert_raises(ActiveRecord::RecordNotFound) do
      get root_path
    end

    # There's an organization with the handle "peter".
    host! 'peter.example.com'
    get root_path
    assert_response :found
  end

  test 'user who is not in the target organization should be logged out' do
    host! 'peter.example.com'
    # The user jack is not in the organization peter
    sign_in(users(:jack))

    get root_path
    assert_redirected_to new_user_session_path
  end
end
