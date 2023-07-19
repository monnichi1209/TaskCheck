Rails.application.routes.draw do
  resources :tasks
  resources :users, only: [:new, :create]

  get '/login', to: 'sessions#new', as: :login
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy', as: :logout

  root to: 'tasks#index'
end
