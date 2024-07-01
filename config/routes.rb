# frozen_string_literal: true

Rails.application.routes.draw do
  get 'notices/index'
  get 'bookmarks/index'
  get 'follows/index'
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }
  resources :users, only: %i[show edit update] do
    resource :follow, only: %i[index create destroy]
    resources :notices, only: %i[index update]
  end

  root 'tweets#index'
  resources :tweets, only: %i[index show create] do
    resource :like, only: %i[create destroy]
    resource :retweet, only: %i[create destroy]
    post 'reply', to: 'tweets#reply_create', as: 'reply_create'
    resource :bookmark, only: %i[indec create destroy]
  end

  resources :rooms, only: %i[index show create] do
    resources :messages, only: %i[create]
  end

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
