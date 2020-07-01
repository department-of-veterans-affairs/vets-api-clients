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
  get '/claims/active_poa', to: 'claims#active_poa', as: :active_poa
  resources :claims, only: %i[index show] do
    member do
      post :update_supporting_document
    end
  end
  scope '/claims_forms/:form_number' do
    get '/', to: 'claims#form', as: :form
    get '/:id',  to: 'claims#form_show', as: :form_show
    post '/submit', to: 'claims#form_submit', as: :form_submit
  end
  post '/claims_forms/2122/:id/upload', to: 'claims#poa_upload', as: :poa_upload
  resources :documents do
    member do
      get :download
      get :update_status
    end
  end
end
