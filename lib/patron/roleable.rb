# frozen_string_literal: true

module Patron
  module Roleable
    extend ActiveSupport::Concern

    included do
      has_many :role_assignments, dependent: :destroy
      has_many :roles,            through: :role_assignments
      has_many :permissions,      through: :roles
    end

    def roles?(*identifiers)
      roles.where(identifier: identifiers).count == identifiers.count
    end

    def any_roles?(*identifiers)
      roles.exists?(identifier: identifiers)
    end

    def permissions?(*identifiers)
      permissions.where(identifier: identifiers).count == identifiers.count
    end

    def any_permissions?(*identifiers)
      permissions.exists?(identifier: identifiers)
    end

    alias role? roles?
    alias permission? permissions?
  end
end
