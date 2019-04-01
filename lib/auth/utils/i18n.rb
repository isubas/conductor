# frozen_string_literal: true

module Auth
  module Utils
    module I18n
      module_function

      def translate_filter(name, class_name:)
        ::I18n.translate(name, scope: [:auth, class_name])
      end

      def translate_suffix(name)
        ::I18n.translate(name, scope: %i[auth suffixes])
      end

      def translate_query_type(name)
        ::I18n.translate(name, scope: %i[auth query_types])
      end

      def translate_collection_for_query_types(query_types)
        query_types.map do |query_type|
          [translate_query_type(query_type), query_type]
        end
      end
    end
  end
end
