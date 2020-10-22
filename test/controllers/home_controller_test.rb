require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get login" do
    get home_login_url
    assert_response :success
  end

  test "should get signup" do
    get home_signup_url
    assert_response :success
  end

end
