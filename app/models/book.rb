# frozen_string_literal: true

class Book < ApplicationRecord
  include Auth::Scope::Model
end
