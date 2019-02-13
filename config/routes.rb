Rails.application.routes.draw do
  root "welcome#index"

  resources :items
  resources :carts, only: [:create, :show]

  resources :users, only: [:new, :index, :create, :show, :edit] do
      resources :orders, only: [:index, :show]
  end

  namespace :admin do
    resources :users, only: [:index, :show, :edit]
  end

  namespace :merchant do
    resources :users, only: [:index]
  end

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

end
