# frozen_string_literal: true

Dir[Rails.root.join('app/scopes/**/*.rb')].each { |f| require f } unless Rails.configuration.eager_load
