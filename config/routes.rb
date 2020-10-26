# frozen_string_literal: true

Rails.application.routes.draw do
  root 'locale#new'
  post 'locale' => 'locale#create'
  resources :books
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
