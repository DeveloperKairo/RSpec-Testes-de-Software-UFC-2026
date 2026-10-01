Rails.application.routes.draw do
  root "home#index"
  
  get '/cadastro', to: 'users#new'
  post '/register', to: 'users#create' # API & HTML
  
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create' # API & HTML
  delete '/logout', to: 'sessions#destroy'
  
  get '/me', to: 'users#me' # API
  get '/dashboard', to: 'dashboard#index'

  resources :projects do
    resources :tasks
  end
  get '/test_error', to: 'test_error#index'
end
