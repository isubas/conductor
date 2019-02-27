# frozen_string_literal: true

module Auth
  module Scope
    module Condition
      def self.included(base)
        # base.send :include, InstanceMethods
        base.extend ClassMethods
      end

      module ClassMethods
        def condition(attribute, **options)
          exist!(attribute)
          conditions[attribute] = options
        end

        def conditions
          @conditions ||= {}
        end

        def condition_attributes
          conditions.keys
        end

        private

        def model
          to_s.delete_suffix('Scope').constantize
        end

        def exist!(attribute)
          raise StandardError, 'Foo' unless model.columns_hash.key?(attribute.to_s)
        end
      end
    end
  end
end
