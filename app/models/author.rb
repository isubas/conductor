# frozen_string_literal: true

class Author < ApplicationRecord
  include Patron::Scope::Model
end
