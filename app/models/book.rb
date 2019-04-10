# frozen_string_literal: true

class Book < ApplicationRecord
  include Patron::Scope::Model
end
