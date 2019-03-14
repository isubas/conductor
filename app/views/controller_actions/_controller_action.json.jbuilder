# frozen_string_literal: true

json.extract! controller_action, :id, :action, :controller, :created_at, :updated_at
json.url controller_action_url(controller_action, format: :json)
