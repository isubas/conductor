# frozen_string_literal: true

module Patron
  module Scope
    module Query
      class Builder
        def initialize(instance)
          @instance = instance
          @klass    = instance.class
        end

        def self.call(instance)
          new(instance).send(:build)
        end

        private_class_method :new

        private

        attr_reader :instance, :klass

        def build
          queries = records.map do |record|
            parameters = build_parameters(record)
            nodes      = parameters.map { |parameter| parameter.to_arel_for(klass.model) }

            Query::Arel.merge(nodes.compact, with: :and)
          end

          Query::Arel.merge(queries.compact, with: :or)
        end

        def build_parameters(record)
          values = record.values

          return [] if values.blank?

          values.map do |name, options|
            Query::Parameter.new(name: name, **options.symbolize_keys)
          end
        end

        def records
          @records ||= begin
            AuthScope.where(name: klass.to_s, user_id: instance.current_user&.id)
          end
        end
      end
    end
  end
end
