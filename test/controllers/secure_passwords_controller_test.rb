require 'test_helper'

class SecurePasswordsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @secure_password = secure_passwords(:one)
  end

  test "should get index" do
    get secure_passwords_url
    assert_response :success
  end

  test "should get new" do
    get new_secure_password_url
    assert_response :success
  end

  test "should create secure_password" do
    assert_difference('SecurePassword.count') do
      post secure_passwords_url, params: { secure_password: { name: @secure_password.name, notes: @secure_password.notes, password: @secure_password.password, url: @secure_password.url } }
    end

    assert_redirected_to secure_password_url(SecurePassword.last)
  end

  test "should show secure_password" do
    get secure_password_url(@secure_password)
    assert_response :success
  end

  test "should get edit" do
    get edit_secure_password_url(@secure_password)
    assert_response :success
  end

  test "should update secure_password" do
    patch secure_password_url(@secure_password), params: { secure_password: { name: @secure_password.name, notes: @secure_password.notes, password: @secure_password.password, url: @secure_password.url } }
    assert_redirected_to secure_password_url(@secure_password)
  end

  test "should destroy secure_password" do
    assert_difference('SecurePassword.count', -1) do
      delete secure_password_url(@secure_password)
    end

    assert_redirected_to secure_passwords_url
  end
end
