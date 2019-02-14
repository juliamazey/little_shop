Rails.application.routes.draw do
  root "welcome#index"

  resources :items
  resources :carts, only: [:create]

  get '/cart', to: "carts#show", as: :cart
  get '/empty', to: "cart#destroy", as: :empty_cart

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
