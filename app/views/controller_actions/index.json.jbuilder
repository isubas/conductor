# frozen_string_literal: true

json.array! @controller_actions, partial: 'controller_actions/controller_action', as: :controller_action
