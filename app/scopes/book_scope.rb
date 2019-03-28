# frozen_string_literal: true

class BookScope < ApplicationScope
  filter :id, collection: -> { Book.all },
              multiple: true

  filter :desc

  define_scope :programs do
    where(name: 'program')
  end

  define_scope :faculties do
    where(name: 'faculty')
  end

  define_scope :order_by_name do
    order(:name)
  end
end
