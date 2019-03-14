# frozen_string_literal: true

json.extract! permission, :id, :name, :identifier, :description, :created_at, :updated_at
json.url permission_url(permission, format: :json)
