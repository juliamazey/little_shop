Rails.application.routes.draw do
  root "welcome#index"

  resources :items
  resources :orders

  resources :users, only: [:new, :index, :create, :show, :edit]

  namespace :admin do
    resources :users, only: [:index]
  end

  namespace :merchant do
    resources :users, only: [:index]
  end

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

end
