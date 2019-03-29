# frozen_string_literal: true

class AuthorScope < ApplicationScope
  filter :first_name
  filter :last_name
  filter :email
end
