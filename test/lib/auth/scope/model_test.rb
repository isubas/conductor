
require 'test_helper'

module Auth
  module Scope
    class ModelTest < ActiveSupport::TestCase
      class DummyModel < ActiveRecord::Base
        include PatronScope::Model
      end

      test 'respond_to auth_scope method' do
        assert DummyModel.respond_to? :auth_scope
      end
    end
  end
end