json.extract! auth_scope, :id, :name, :user_id, :values, :created_at, :updated_at
json.url auth_scope_url(auth_scope, format: :json)
