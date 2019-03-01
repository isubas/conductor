Rails.application.routes.draw do
  resources :auth_scopes
  root 'books#index'
  resources :books
  resources :actions

  devise_for :users
end
