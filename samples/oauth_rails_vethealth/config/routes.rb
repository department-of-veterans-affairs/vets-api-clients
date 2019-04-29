Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root 'session#login'

  get '/login', to: 'session#login'
  get '/callback', to: 'session#callback'
  get '/logout', to: 'session#logout'
  get 'session/:id', to: 'session#show', as: 'session'

  get '/health_api', to: 'health_api#index'
  scope 'health_api' do
    get 'index', to: 'health_api#index'
    get 'api_response/:api_name', to: 'health_api#api_by_param', as: 'generic'
  end
end
