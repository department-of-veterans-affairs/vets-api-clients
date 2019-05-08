require 'test_helper'

class SessionControllerTest < ActionDispatch::IntegrationTest
  test "should get login page" do
    get login_url
    assert_response :success
    assert_template :login
  end
end
