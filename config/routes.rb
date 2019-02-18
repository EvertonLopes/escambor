Rails.application.routes.draw do
  namespace :backoffice do
    get 'dashboard/index'
  end
  devise_for :admins
  devise_for :members
  namespace :site do
    get 'home/index'
  end
  root 'site/home#index'
end
