# frozen_string_literal: true

namespace :auth do
  desc 'Upsert permissions'
  task upsert_permissions: :environment do
  end

  desc 'Upsert roles'
  task create_roles: :environment do
  end
end
