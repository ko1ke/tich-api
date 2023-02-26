Rails.application.routes.draw do
  resources :users, only: %i[create]
  put '/users/rank_up', to: 'users#rank_up'
  patch '/users/rank_up', to: 'users#rank_up'

  resources :portfolios, only: %i[index create]

  resources :news, only: %i[index]
  scope :news do
    get '/es', to: 'news#es_index'
  end
  namespace :news do
    resources :markets, only: %i[index]
    resources :companies, only: %i[index]
  end

  resources :tickers, only: %i[index]
  post '/favorites', to: 'favorites#create'
  delete '/favorites/:news_id', to: 'favorites#destroy'
  resources :chips, only: %i[create]

  # Flipper
  mount Flipper::Api.app(Flipper) => '/flipper/api' if Rails.env.development?
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
