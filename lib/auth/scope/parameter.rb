# frozen_string_literal: true

module Auth
  module Scope
    class Parameter
      ATTRIBUTES = %i[
        name
        query_type
        skip_empty
        value
      ].freeze

      attr_accessor(*ATTRIBUTES)

      def initialize(args = {})
        ATTRIBUTES.each do |attribute|
          instance_variable_set("@#{attribute}", args[attribute])
        end
      end

      def to_arel_for(model)
        Querier::Arel.send(query_type, model, name, value) if assignable?
      end

      private

      def assignable?
        value.present? || skip_empty.to_i.zero?
      end
    end
  end
end
