# frozen_string_literal: true

Rails.application.routes.draw do
  resources :roles
  resources :permissions, only: %i[index show]
  resources :query_stores do
    get :preview, on: :member
  end

  root 'home#index'
  resources :books

  get :dashboard, to: 'dashboard#index'
  devise_for :users
end
