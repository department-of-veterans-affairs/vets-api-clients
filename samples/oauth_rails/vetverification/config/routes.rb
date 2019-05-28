Rails.application.routes.draw do
  root 'auth#login'

  get '/login', to: 'auth#login'
  get '/callback', to: 'auth#callback'
  get '/logout', to: 'auth#logout'

  get '/verify', to: 'verification#show'
  get '/user', to: 'users#index'
  resources :claims, only: [:index, :show]
  get '/claims_forms/526', to: 'claims#form_526'
end
