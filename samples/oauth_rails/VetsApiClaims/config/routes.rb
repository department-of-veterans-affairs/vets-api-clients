# frozen_string_literal: true

Rails.application.routes.draw do
  root 'pages#index'

  get '/login', to: 'auth#login'
  get '/callback', to: 'auth#callback'
  get '/logout', to: 'auth#logout'

  get '/user', to: 'users#index'
  post '/user', to: 'users#create'
  delete '/user', to: 'users#destroy'
  get '/claims/active_itf', to: 'claims#active_itf', as: :active_itf
  get '/claims/submit_itf', to: 'claims#submit_itf', as: :submit_itf
  resources :claims, only: %i[index show] do
    member do
      post :update_supporting_document
    end
  end
  get '/claims_forms/:form_number', to: 'claims#form', as: :form
  post '/claims_forms/:form_number/submit', to: 'claims#form_submit', as: :form_submit
  resources :documents do
    member do
      get :download
      get :update_status
    end
  end
end
