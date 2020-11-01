require "application_system_test_case"

class SecurePasswordsTest < ApplicationSystemTestCase
  setup do
    @secure_password = secure_passwords(:one)
  end

  test "visiting the index" do
    visit secure_passwords_url
    assert_selector "h1", text: "Secure Passwords"
  end

  test "creating a Secure password" do
    visit secure_passwords_url
    click_on "New Secure Password"

    fill_in "Name", with: @secure_password.name
    fill_in "Notes", with: @secure_password.notes
    fill_in "Password", with: @secure_password.password
    fill_in "Url", with: @secure_password.url
    click_on "Create Secure password"

    assert_text "Secure password was successfully created"
    click_on "Back"
  end

  test "updating a Secure password" do
    visit secure_passwords_url
    click_on "Edit", match: :first

    fill_in "Name", with: @secure_password.name
    fill_in "Notes", with: @secure_password.notes
    fill_in "Password", with: @secure_password.password
    fill_in "Url", with: @secure_password.url
    click_on "Update Secure password"

    assert_text "Secure password was successfully updated"
    click_on "Back"
  end

  test "destroying a Secure password" do
    visit secure_passwords_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Secure password was successfully destroyed"
  end
end
