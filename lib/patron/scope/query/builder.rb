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
          new(instance).public_send(:build)
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
          parameters = record.parameters

          return [] if parameters.blank?

          parameters.map do |key, options|
            Query::Parameter.new(name: key, **options.symbolize_keys)
          end
        end

        def records
          @records ||= begin
            QueryStore.where_or_fetch_cache(name: klass.to_s, user_id: instance.user&.id)
          end
        end
      end
    end
  end
end
