# frozen_string_literal: true

json.extract! query_store, :id, :name, :user_id, :values, :created_at, :updated_at
json.url query_store_url(query_store, format: :json)
