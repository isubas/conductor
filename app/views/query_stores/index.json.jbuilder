# frozen_string_literal: true

json.array! @query_stores, partial: 'query_stores/query_store', as: :query_store
