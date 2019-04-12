# frozen_string_literal: true

Rails.application.routes.draw do
  resources :roles
  resources :permissions
  resources :controller_actions
  resources :query_stores
  root 'home#index'
  resources :books
  resources :actions

  get :dashboard, to: 'dashboard#index'
  devise_for :users
end
