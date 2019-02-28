# frozen_string_literal: true

class BookScope < ApplicationScope
  filter :name, collection: Book.pluck(:name),
                type: Array,
                presence: true,
                multiple: true,
                empty_skip: true

  filter :desc
end
