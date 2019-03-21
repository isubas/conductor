# frozen_string_literal: true

class BookScope < ApplicationScope
  filter :id, collection: -> { Book.all },
              multiple: true

  filter :desc, skip_empty: true
end
