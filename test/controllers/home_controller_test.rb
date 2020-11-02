require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
<<<<<<< HEAD
  test "should get login" do
    get home_login_url
    assert_response :success
  end

  test "should get signup" do
    get home_signup_url
=======
  test "should get index" do
    get home_index_url
>>>>>>> master
    assert_response :success
  end

end
