Rails.application.routes.draw do
  namespace :backoffice do
    get 'dashboard', to: 'dashboard#index'
  end
  namespace :site do
    get 'home', to: 'home#index'
  end
  devise_for :admins
  devise_for :members
  root 'site/home#index'
end
