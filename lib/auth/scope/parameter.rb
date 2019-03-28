# frozen_string_literal: true

module Auth
  module Scope
    class Parameter
      include ActiveModel::Validations

      ATTRIBUTES = %i[
        index
        name
        query_type
        value
      ].freeze

      attr_accessor(*ATTRIBUTES)

      validates :index,      numericality: { greater_than_or_equal_to: 0 }
      validates :name,       presence: true
      validates :query_type, inclusion: { in: %w[in eq gt] }
      validates :value,      presence: true

      def initialize(args = {})
        ATTRIBUTES.each do |attribute|
          instance_variable_set("@#{attribute}", args[attribute])
        end
      end

      def to_hash
        {
          index => {
            name: name,
            query_type: query_type,
            value: value
          }
        }
      end

      alias to_h to_hash
    end
  end
end
