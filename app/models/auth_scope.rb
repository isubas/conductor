# frozen_string_literal: true

class AuthScope < ApplicationRecord
  include Auth::Scope::StoreAccessor

  belongs_to :user

  store :values, coder: JSON

  def scope_klass
    "#{name}".constantize
  end
end
