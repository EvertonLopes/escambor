# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :site do
    get 'home', to: 'home#index'
  end
  namespace :backoffice do
    resources :categories, except: %i[show destroy]
    resources :admins, except: %i[show destroy]
    get 'dashboard', to: 'dashboard#index'
  end

  devise_for :admins, skip: [:registrations]
  devise_for :members

  root 'site/home#index'
  get 'backoffice', to: 'backoffice/dashboard#index'
end
