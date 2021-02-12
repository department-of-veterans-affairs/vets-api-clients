Rails.application.routes.draw do
  root 'pages#index'
  get '/hlr/new', to: 'hlr#new'
  post '/hlr/create', to: 'hlr#create'
end
