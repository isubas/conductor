# frozen_string_literal: true

Rails.application.routes.draw do
  resources :roles
  resources :permissions
  resources :controller_actions
  resources :auth_scopes
  root 'books#index'
  resources :books
  resources :actions

  get :dashboard, to: 'dashboard#index'
  devise_for :users
end
