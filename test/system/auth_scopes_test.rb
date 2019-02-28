require "application_system_test_case"

class AuthScopesTest < ApplicationSystemTestCase
  setup do
    @auth_scope = auth_scopes(:one)
  end

  test "visiting the index" do
    visit auth_scopes_url
    assert_selector "h1", text: "Auth Scopes"
  end

  test "creating a Auth scope" do
    visit auth_scopes_url
    click_on "New Auth Scope"

    fill_in "Name", with: @auth_scope.name
    fill_in "User", with: @auth_scope.user_id
    fill_in "Values", with: @auth_scope.values
    click_on "Create Auth scope"

    assert_text "Auth scope was successfully created"
    click_on "Back"
  end

  test "updating a Auth scope" do
    visit auth_scopes_url
    click_on "Edit", match: :first

    fill_in "Name", with: @auth_scope.name
    fill_in "User", with: @auth_scope.user_id
    fill_in "Values", with: @auth_scope.values
    click_on "Update Auth scope"

    assert_text "Auth scope was successfully updated"
    click_on "Back"
  end

  test "destroying a Auth scope" do
    visit auth_scopes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Auth scope was successfully destroyed"
  end
end
