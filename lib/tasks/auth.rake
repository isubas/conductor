# frozen_string_literal: true

namespace :auth do
  desc 'Create controller actions'
  task create_actions: :environment do
    routes = Rails.application.routes.routes.map(&:defaults).uniq
    routes.each do |route|
      next unless route.key? :controller

      ControllerAction.create(route)

      puts "#{route[:controller]}##{route[:action]} created."
    end
  end
end
