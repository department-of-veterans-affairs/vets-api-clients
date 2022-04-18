Rails.application.routes.draw do
  root 'pages#index'
  get '/login', to: 'pages#login'
  post '/login', to: 'pages#login'
  resources :hlrs, only: %i[create new show]
  resources :nods, only: %i[create new show]
  resources :legacy_appeals, only: %i[index create]
end
