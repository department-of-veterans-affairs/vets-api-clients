Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'auth_controller#login'
  
  get '/callback', to: 'auth_controller#callback'

end
