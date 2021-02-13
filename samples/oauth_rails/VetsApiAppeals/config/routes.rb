Rails.application.routes.draw do
  root 'pages#index'
  get '/hlr/new', to: 'hlr#new'
  get '/hlr/show/:id', to: 'hlr#show'
  post '/hlr/create', to: 'hlr#create'
end
