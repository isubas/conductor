# frozen_string_literal: true

class BookScope < ApplicationScope
  filter :name, collection: Book.pluck(:name),
                type: Array,
                presence: true,
                multiple: true,
                skip_empty: true

  filter :desc, skip_empty: true
end
