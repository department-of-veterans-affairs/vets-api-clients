Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root 'session#login'

  get '/login', to: 'session#login'
  get '/callback', to: 'session#callback'
  get '/authenticate', to: 'session#authenticate'
  get '/logout', to: 'session#logout'
end
