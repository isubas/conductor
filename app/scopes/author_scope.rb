# frozen_string_literal: true

class AuthorScope < ApplicationScope
  condition :first_name, type: :string,
                         presence: true,
                         empty_skip: true
  condition :last_name, type: :string,
                        presence: true,
                        skip_empty: true
  condition :email
end
