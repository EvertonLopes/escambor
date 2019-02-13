Rails.application.routes.draw do
  namespace :site do
    get 'home/index'
  end

  root 'site/home#index'
end
