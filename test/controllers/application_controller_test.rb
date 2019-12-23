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
end
