# frozen_string_literal: true

require_relative './condition'

module Auth
  module Scope
    class Base
      include Condition
    end
  end
end
