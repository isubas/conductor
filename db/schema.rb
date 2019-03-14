# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_190_315_133_148) do
  create_table 'auth_scopes', force: :cascade do |t|
    t.string 'name'
    t.integer 'user_id'
    t.text 'values'
    t.text 'preferences'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['user_id'], name: 'index_auth_scopes_on_user_id'
  end

  create_table 'authors', force: :cascade do |t|
    t.string 'first_name'
    t.string 'last_name'
    t.string 'email'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'books', force: :cascade do |t|
    t.string 'name'
    t.text 'desc'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'controller_actions', force: :cascade do |t|
    t.string 'action'
    t.string 'controller'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'permission_actions', force: :cascade do |t|
    t.integer 'controller_action_id'
    t.integer 'permission_id'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['controller_action_id'], name: 'index_permission_actions_on_controller_action_id'
    t.index ['permission_id'], name: 'index_permission_actions_on_permission_id'
  end

  create_table 'permissions', force: :cascade do |t|
    t.string 'name'
    t.string 'identifier'
    t.text 'description'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'role_assignments', force: :cascade do |t|
    t.integer 'role_id'
    t.integer 'user_id'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['role_id'], name: 'index_role_assignments_on_role_id'
    t.index ['user_id'], name: 'index_role_assignments_on_user_id'
  end

  create_table 'role_permissions', force: :cascade do |t|
    t.integer 'role_id'
    t.integer 'permission_id'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['permission_id'], name: 'index_role_permissions_on_permission_id'
    t.index ['role_id'], name: 'index_role_permissions_on_role_id'
  end

  create_table 'roles', force: :cascade do |t|
    t.string 'name'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end

  add_foreign_key 'auth_scopes', 'users'
  add_foreign_key 'permission_actions', 'controller_actions'
  add_foreign_key 'permission_actions', 'permissions'
  add_foreign_key 'role_assignments', 'roles'
  add_foreign_key 'role_assignments', 'users'
  add_foreign_key 'role_permissions', 'permissions'
  add_foreign_key 'role_permissions', 'roles'
end
