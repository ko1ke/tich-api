Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  resources :users, only: %i[create]
  resources :portfolios, only: %i[index create]
  resources :news, only: %i[index]
  resources :tickers, only: %i[index]
  # get '/news/:symbol', to: 'news#index', as: 'news'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
