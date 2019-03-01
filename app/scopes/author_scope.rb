# frozen_string_literal: true

class AuthorScope < ApplicationScope
  filter :first_name, type: :string,
                      presence: true,
                      skip_empty: true
  filter :last_name, type: :string,
                     presence: true,
                     skip_empty: false
  filter :email
end
