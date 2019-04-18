# frozen_string_literal: true

class BookPolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    permitted?
  end

  def show?
    permitted?
  end

  def create?
    permitted?
  end

  def new?
    create?
  end

  def update?
    permitted?
  end

  def edit?
    update?
  end

  def destroy?
    permitted?
  end

  private

  def permitted?
    user.permission? :book_manager
  end
end
