# frozen_string_literal: true

class Book < ApplicationRecord
  include Patron::Scope::Model

  scope :programs, -> { where(name: 'Test') }
end
