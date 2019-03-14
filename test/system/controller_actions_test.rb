# frozen_string_literal: true

require 'application_system_test_case'

class ControllerActionsTest < ApplicationSystemTestCase
  setup do
    @controller_action = controller_actions(:one)
  end

  test 'visiting the index' do
    visit controller_actions_url
    assert_selector 'h1', text: 'Controller Actions'
  end

  test 'creating a Controller action' do
    visit controller_actions_url
    click_on 'New Controller Action'

    fill_in 'Action', with: @controller_action.action
    fill_in 'Controller', with: @controller_action.controller
    click_on 'Create Controller action'

    assert_text 'Controller action was successfully created'
    click_on 'Back'
  end

  test 'updating a Controller action' do
    visit controller_actions_url
    click_on 'Edit', match: :first

    fill_in 'Action', with: @controller_action.action
    fill_in 'Controller', with: @controller_action.controller
    click_on 'Update Controller action'

    assert_text 'Controller action was successfully updated'
    click_on 'Back'
  end

  test 'destroying a Controller action' do
    visit controller_actions_url
    page.accept_confirm do
      click_on 'Destroy', match: :first
    end

    assert_text 'Controller action was successfully destroyed'
  end
end
