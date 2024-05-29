# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }
  resources :users, only: %i[show edit update]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # devise_scope :user do
  #   get "/" => "users/sessions#new"
  # end

  root 'tweets#index'
  resources :tweets

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
