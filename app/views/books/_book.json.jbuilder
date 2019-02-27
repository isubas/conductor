json.extract! book, :id, :name, :desc, :created_at, :updated_at
json.url book_url(book, format: :json)
