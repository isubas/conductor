# frozen_string_literal: true

class Author < ApplicationRecord
  include Auth::Scope::Model
end
