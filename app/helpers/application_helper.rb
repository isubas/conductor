# frozen_string_literal: true

module ApplicationHelper
  def action_bar
    tag.div class: 'shadow p-3 mb-5 bg-white rounded' do
      yield
    end
  end
end
