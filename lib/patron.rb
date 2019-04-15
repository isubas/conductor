# frozen_string_literal: true

require_relative './patron/errors'
require_relative './patron/roleable'
require_relative './patron/controller'
require_relative './patron/utils/i18n.rb'
require_relative './patron/scope'
require_relative './patron/permission_builder'
require_relative './patron/role_builder'

module Patron
  module_function

  def scopes
    return Patron::Scope::Base.descendants if Rails.env.production?

    Dir.glob(Rails.root.join('app', 'scopes', '*.rb'))
       .map { |f| File.basename(f, '.rb').classify }
  end
end
