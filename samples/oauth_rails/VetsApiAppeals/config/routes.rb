Rails.application.routes.draw do
  root 'pages#index'
  get '/login', to: 'pages#login'
  post '/login', to: 'pages#login'
  resources :hlrs, only: %i[create new show]
end
