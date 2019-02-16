# frozen_string_literal: true

Rails.application.routes.draw do
  resources :users
  resources :address
  resources :company

  root to: 'users#new'
end
