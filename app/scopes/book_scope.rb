# frozen_string_literal: true

class BookScope < ApplicationScope
  filter :id, collection: -> { Book.all },
              multiple: true

  filter :desc, skip_empty: true

  define_scope :foo do |a, b|
    puts 'foo'
  end

  define_scope :bar do |a, b|
    puts 'bar'
  end
end
