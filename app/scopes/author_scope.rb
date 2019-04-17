# frozen_string_literal: true

class AuthorScope < Patron::Scope::Base
  filter :first_name
  filter :last_name
  filter :email, field_type: :datetime
end
