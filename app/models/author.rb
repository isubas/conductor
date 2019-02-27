class Author < ApplicationRecord
  include Auth::Scope::Model
end
