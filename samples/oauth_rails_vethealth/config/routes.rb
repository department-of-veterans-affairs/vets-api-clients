Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root 'session#login'

  get '/login', to: 'session#login'
  get '/callback', to: 'session#callback'
  get '/logout', to: 'session#logout'

  get '/health_api', to: 'health_api#index'
  scope 'health_api' do
    get 'index', to: 'health_api#index'
    get 'condition', to: 'health_api#condition'
    get 'allergy_intolerance', to: 'health_api#allergy_intolerance'
  end
end
