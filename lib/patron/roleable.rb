# frozen_string_literal: true

module Patron
  module Roleable
    extend ActiveSupport::Concern

    included do
      has_many :role_assignments, dependent: :destroy
      has_many :roles, through: :role_assignments
      has_many :permissions, through: :roles
    end

    def role?(identifier)
      roles.exists?(identifier: identifier)
    end

    def roles?(*identifiers)
      roles.where(Role.arel_table[:identifier].in_all(identifiers)).exists?
    end

    def any_roles?(*identifiers)
      roles.where(Role.arel_table[:identifier].in_any(identifiers)).exists?
    end

    def permission?(identifier)
      permissions.exists?(identifier: identifier)
    end

    def permissions?(*identifiers)
      permissions.where(Role.arel_table[:identifier].in_all(identifiers)).exists?
    end

    def any_permission?(*identifiers)
      permissions.where(Role.arel_table[:identifier].in_any(identifiers)).exists?
    end
  end
end
