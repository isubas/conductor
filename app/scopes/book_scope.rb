# frozen_string_literal: true

class BookScope < ApplicationScope
  filter :id, collection: Book.pluck(:id),
              multiple: true

  filter :name, collection: Book.pluck(:name),
                type: Array,
                presence: true,
                multiple: true,
                skip_empty: false

  filter :desc, skip_empty: true
end
