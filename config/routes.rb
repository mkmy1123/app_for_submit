# frozen_string_literal: true

Rails.application.routes.draw do
  root 'books#index'
  resources :books

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  resources :users, only: %i[show index]
end
