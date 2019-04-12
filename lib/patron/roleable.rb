# frozen_string_literal: true

module Patron
  module Roleable
    extend ActiveSupport::Concern

    included do
      has_many :role_assignments, as: :rolable, dependent: :destroy
      has_many :roles, through: :role_assignments
      has_many :permissions, through: :roles
    end
  end
end
