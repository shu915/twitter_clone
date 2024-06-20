# frozen_string_literal: true

Rails.application.routes.draw do
  get 'bookmarks/index'
  get 'follows/index'
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }
  resources :users, only: %i[show edit update] do
    resource :follow, only: %i[index create destroy]
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # devise_scope :user do
  #   get "/" => "users/sessions#new"
  # end

  root 'tweets#index'
  resources :tweets, only: %i[index show create] do
    resource :like, only: %i[create destroy]
    resource :retweet, only: %i[create destroy]
    post 'reply', to: 'tweets#reply_create', as: 'reply_create'
    resource :bookmark, only: %i[indec create destroy]
  end

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
