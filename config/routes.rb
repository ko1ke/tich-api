Rails.application.routes.draw do
  resources :users, only: %i[create]
  resources :portfolios, only: %i[index create]
  resources :news, only: %i[index]
  namespace :news do
    resources :markets, only: %i[index]
    resources :companies, only: %i[index]
  end
  resources :tickers, only: %i[index]
  post '/favorites', to: 'favorites#create'
  delete '/favorites/:news_id', to: 'favorites#destroy'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
