# frozen_string_literal: true

class BookScope < ApplicationScope
  condition :name, collection: Book.all,
                   type: Array,
                   presence: true,
                   empty_skip: true

  # condition :foo
end
