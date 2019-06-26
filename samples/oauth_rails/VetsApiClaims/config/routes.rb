Rails.application.routes.draw do
  root 'auth#login'

  get '/login', to: 'auth#login'
  get '/callback', to: 'auth#callback'
  get '/logout', to: 'auth#logout'

  get '/user', to: 'users#index'
  get '/claims/active_itf', to: 'claims#active_itf', as: :active_itf
  post '/claims/submit_itf', to: 'claims#submit_itf', as: :submit_itf
  resources :claims, only: [:index, :show] do
    member do
      post :update_supporting_document
    end
  end
  get '/claims_forms/526', to: 'claims#form_526'
end
