# frozen_string_literal: true

json.array! @auth_scopes, partial: 'auth_scopes/auth_scope', as: :auth_scope
