Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  resources :users, only: %i[create]
  resources :portfolios, only: %i[index create]
  namespace :news do
    resources :markets, only: %i[index]
    resources :companies, only: %i[index]
  end
  resources :tickers, only: %i[index]
  # get '/news/:symbol', to: 'news#index', as: 'news'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
