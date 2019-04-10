# frozen_string_literal: true

class AuthScope < ApplicationRecord
  include Patron::Scope::Store::Accessor
  include Patron::Scope::Store::Validation

  belongs_to :user

  store :values, coder: JSON

  # validates :id_value, presence: true

  def scope_klass
    name.to_s.constantize
  end
end
