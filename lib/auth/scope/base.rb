# frozen_string_literal: true

require_relative './filter'
require_relative './form'

module Auth
  module Scope
    class Base
      extend Filter
      extend Form
    end
  end
end
