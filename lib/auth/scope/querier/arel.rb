# frozen_string_literal: true

module Auth
  module Scope
    module Querier
      module Arel
        def self.define_predicate(name, **options)
          predicate = options.fetch(:equivalent, name)
          suffix    = options.fetch(:suffix, '')
          prefix    = options.fetch(:prefix, '')

          define_method(name) do |model, attribute, value|
            model.arel_table[attribute].public_send(
              predicate, sanitize_value(predicate, value, suffix, prefix)
            )
          end

          module_function(name)
        end

        define_predicate :in
        define_predicate :not_in
        define_predicate :equal,                 equivalent: :eq
        define_predicate :not_equal,             equivalent: :not_eq
        define_predicate :greater_than,          equivalent: :gt
        define_predicate :greater_than_to_equal, equivalent: :gteq
        define_predicate :less_than,             equivalent: :lt
        define_predicate :less_than_to_equal,    equivalent: :lteq
        define_predicate :start_matches,         equivalent: :matches, suffix: '%'
        define_predicate :end_matches,           equivalent: :matches, prefix: '%'
        define_predicate :full_matches,          equivalent: :matches, suffix: '%', prefix: '%'
        define_predicate :does_not_start_match,  equivalent: :does_not_match, suffix: '%'
        define_predicate :does_not_end_match,    equivalent: :does_not_match, prefix: '%'
        define_predicate :does_not_full_match,   equivalent: :does_not_match, suffix: '%', prefix: '%'

        def self.merge(queries, with:)
          queries.inject do |current_query, query|
            current_query.public_send(with.to_s, query)
          end
        end

        def self.sanitize_value(predicate, value, suffix, prefix)
          case predicate
          when :in     then value
          when /match/ then [prefix, ActiveRecord::Base.sanitize_sql_like(value), suffix].join
          else              ActiveRecord::Base.sanitize_sql(value)
          end
        end
      end
    end
  end
end
