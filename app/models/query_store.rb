# frozen_string_literal: true

class QueryStore < ApplicationRecord
  include Patron::Scope::Store::Accessor
  include Patron::Scope::Store::Validation

  belongs_to :user

  store :parameters, coder: JSON

  after_commit :flush_cache

  def self.where_or_fetch_cache(name:, user_id:)
    # Rails.cache.fetch([name, user_id], expires_in: 5.minutes) do
    #   where(name: name, user_id: user_id).to_a
    # end
    where(name: name, user_id: user_id)
  end

  def flush_cache
    Rails.cache.delete([name, user_id])
  end

  def scope_klass
    name.to_s.constantize
  end

  def scope_for_preview
    scope_klass.new(user).scope
  end

  def scope_instance
    scope_klass.new(user)
  end
end
