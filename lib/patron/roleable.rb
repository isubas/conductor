# frozen_string_literal: true

module Patron
  module Roleable
    extend ActiveSupport::Concern

    included do
      has_many :role_assignments, dependent: :destroy
      has_many :roles, through: :role_assignments
      has_many :permissions, through: :roles
      has_many :actions, through: :permissions
    end
  end
end
