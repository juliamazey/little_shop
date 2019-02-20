Rails.application.routes.draw do
  root "welcome#index"

  resources :items

  resources :carts, only: [:create, :edit]

  resources :order_items, only: [:update]

  resources :orders, only: [:update]

  get '/cart', to: "carts#show", as: :cart
  get '/empty', to: "carts#destroy", as: :empty_cart
  get '/increase', to: "carts#increase", as: :increase_cart_item
  get '/decrease', to: "carts#decrease", as: :decrease_cart_item
  get '/checkout', to: "orders#create", as: :checkout

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  get '/profile', to: 'users#show'
  get '/profile/edit', to: 'users#edit'
  # get '/profile/orders', to: 'orders#index'
  get '/merchants', to: 'users#index', as: :merchants

  namespace :merchant do
    resources :items, only: [:edit, :create, :show]
    get '/dashboard', to: "users#show", as: :dashboard
    get '/dashboard/orders/:id', to: "orders#show", as: :dashboard_order
    get '/dashboard/users', to: "users#index", as: :dashboard_users
    get '/dashboard/items', to: "items#index", as: :dashboard_items
    get '/dashboard/items/delete', to: "items#destroy", as: :destroy_item
    get '/dashboard/items/edit', to: "items#edit", as: :edit_item
    get '/dashboard/items/new', to: "items#new", as: :dashboard_item_new
    resources :users, only: [:index]
  end

  resources :users, only: [:new, :index, :create, :update] do
    resources :orders, only: [:show, :create]
    get '/profile/orders', to: 'orders#index'
  end

  namespace :admin do
    resources :users, only: [:index, :show, :edit]
    get '/user/orders', to: 'orders#index'
    get '/user/enable', to: 'users#enable', as: :user_enable
    get '/user/disable', to: 'users#disable', as: :user_disable
    get '/merchants/dashboard', to: 'merchants#show', as: :merchant_dashboard
    get '/merchant/downgrade', to: 'merchants#downgrade', as: :merchant_downgrade
    resources :orders, only: [:show]
    resources :merchants, only: [:show, :index]
  end


end
