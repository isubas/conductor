# frozen_string_literal: true

require 'test_helper'

class AuthScopesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @auth_scope = auth_scopes(:one)
  end

  test 'should get index' do
    get auth_scopes_url
    assert_response :success
  end

  test 'should get new' do
    get new_auth_scope_url
    assert_response :success
  end

  test 'should create auth_scope' do
    assert_difference('AuthScope.count') do
      post auth_scopes_url, params: { auth_scope: { name: @auth_scope.name, user_id: @auth_scope.user_id, values: @auth_scope.values } }
    end

    assert_redirected_to auth_scope_url(AuthScope.last)
  end

  test 'should show auth_scope' do
    get auth_scope_url(@auth_scope)
    assert_response :success
  end

  test 'should get edit' do
    get edit_auth_scope_url(@auth_scope)
    assert_response :success
  end

  test 'should update auth_scope' do
    patch auth_scope_url(@auth_scope), params: { auth_scope: { name: @auth_scope.name, user_id: @auth_scope.user_id, values: @auth_scope.values } }
    assert_redirected_to auth_scope_url(@auth_scope)
  end

  test 'should destroy auth_scope' do
    assert_difference('AuthScope.count', -1) do
      delete auth_scope_url(@auth_scope)
    end

    assert_redirected_to auth_scopes_url
  end
end
