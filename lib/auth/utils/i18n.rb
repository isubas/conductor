# frozen_string_literal: true

module Auth
  module Utils
    module I18n
      module_function

      def translate_filter(name, class_name:)
        translate(name, scope: [:auth, class_name])
      end

      def translate_suffix(name)
        translate(name, scope: %i[auth suffixes])
      end

      def translate_query_type(name)
        translate(name, scope: %i[auth query_types])
      end

      def translate_collection_for_boolean(collection)
        [*collection].map do |item|
          [translate(item, scope: %i[auth boolean]), item]
        end
      end

      def translate_collection_for_query_types(collection)
        [*collection].map do |item|
          [translate_query_type(item), item]
        end
      end

      def translate(name, **options)
        ::I18n.translate(name, options)
      end

      private_class_method :translate
    end
  end
end
