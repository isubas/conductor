Rails.application.routes.draw do
  resources :auth_scopes
  root 'books#index'
  resources :books

  devise_for :users
end
