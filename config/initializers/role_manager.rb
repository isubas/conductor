# frozen_string_literal: true

class RoleManager
  extend Patron::PermissionBuilder
  extend Patron::RoleBuilder

  permission :book_manager,
             name: 'Kitap Yönetimi',
             description: 'BookController#(index-show-edit-update-destroy)'

  role :admin, name: 'Admin', permissions: %i[book_manager]
  role :foo,   name: 'Foo',   permissions: %i[book_manager]
  role :bar,   name: 'Bar',   permissions: %i[book_manager]
end
