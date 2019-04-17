# frozen_string_literal: true

class BookScope < Patron::Scope::Base
  filter :id, collection: -> { Book.all },
              multiple: true
  filter :desc

  delegate :programs, to: :current_scope

  preview_attributes :id, :name, :desc, program: :name

  def bypass?
    user.email == 'irfan.subas@uzem.omu.edu.tr'
  end
end
