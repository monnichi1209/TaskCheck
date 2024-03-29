Rails.application.routes.draw do
  namespace :admin do
    resources :users
  end

  resources :tasks
  resources :users, only: [:new, :create, :show]

  get '/login', to: 'sessions#new', as: :login
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy', as: :logout

  root to: 'tasks#index'
end
