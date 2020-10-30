# frozen_string_literal: true

Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  root 'books#index'
  resources :books

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  resources :users, only: %i[show index]
end
