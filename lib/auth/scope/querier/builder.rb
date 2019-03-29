# frozen_string_literal: true

module Auth
  module Scope
    module Querier
      class Builder
        def initialize(instance)
          @instance = instance
          @klass    = instance.class
        end

        def build
          queries = records.map do |record|
            parameters = build_parameters(record)
            nodes      = parameters.map { |parameter| parameter.to_arel_for(@klass.model) }

            Querier::Arel.merge(nodes.compact, with: :and)
          end

          Querier::Arel.merge(queries.compact, with: :or)
        end

        private

        attr_reader :instance, :klass

        def build_parameters(record)
          values = record.values

          return [] if values.blank?

          values.map do |name, options|
            Parameter.new(name: name, **options.symbolize_keys)
          end
        end

        def records
          @records ||= begin
            AuthScope.where(name: klass.to_s, user_id: instance.user.id)
          end
        end
      end
    end
  end
end
