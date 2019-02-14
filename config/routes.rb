Rails.application.routes.draw do
  root "welcome#index"

  resources :items
  resources :carts, only: [:create]

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  get '/cart', to: "carts#show", as: :cart
  get '/empty', to: "cart#destroy", as: :empty_cart


  get '/profile', to: 'users#show'
  get '/profile/orders', to: 'orders#index'

  namespace :merchant do
    get '/dashboard', to: "users#show", as: :dashboard
    resources :users, only: [:index]
  end


  resources :users, only: [:new, :index, :create, :show, :edit] do
      resources :orders, only: [:index, :show]
  end

  namespace :admin do
    resources :users, only: [:index, :show, :edit]
  end


  resources :orders, only: [:index]


end
