# frozen_string_literal: true

require 'test_helper'

class ControllerActionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @controller_action = controller_actions(:one)
  end

  test 'should get index' do
    get controller_actions_url
    assert_response :success
  end

  test 'should get new' do
    get new_controller_action_url
    assert_response :success
  end

  test 'should create controller_action' do
    assert_difference('ControllerAction.count') do
      post controller_actions_url, params: { controller_action: { action: @controller_action.action, controller: @controller_action.controller } }
    end

    assert_redirected_to controller_action_url(ControllerAction.last)
  end

  test 'should show controller_action' do
    get controller_action_url(@controller_action)
    assert_response :success
  end

  test 'should get edit' do
    get edit_controller_action_url(@controller_action)
    assert_response :success
  end

  test 'should update controller_action' do
    patch controller_action_url(@controller_action), params: { controller_action: { action: @controller_action.action, controller: @controller_action.controller } }
    assert_redirected_to controller_action_url(@controller_action)
  end

  test 'should destroy controller_action' do
    assert_difference('ControllerAction.count', -1) do
      delete controller_action_url(@controller_action)
    end

    assert_redirected_to controller_actions_url
  end
end
