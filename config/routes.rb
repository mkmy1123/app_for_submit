# frozen_string_literal: true

Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  concern :commentable do
    resources :comments, only: %i[create]
  end

  root 'books#index'
  resources :books, concerns: :commentable
  resources :reports, concerns: :commentable
  resources :comments, only: %i[destroy]

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  resources :user_relationships, only: %i[create destroy]
  resources :users, only: %i[show index edit update] do
    get :following, on: :member, to: 'users/followings#index'
    get :follower, on: :member, to: 'users/followers#index'
  end
end
