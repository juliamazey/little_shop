Rails.application.routes.draw do
  root "welcome#index"

  resources :items

  resources :carts, only: [:create, :edit]

  get '/cart', to: "carts#show", as: :cart
  get '/empty', to: "carts#destroy", as: :empty_cart

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  get '/profile', to: 'users#show'
  get '/profile/orders', to: 'orders#index'
  get '/profile/edit', to: 'users#edit'

  namespace :merchant do
    get '/dashboard', to: "users#show", as: :dashboard
    get '/dashboard/users', to: "users#index", as: :dashboard_users
    get '/dashboard/items', to: "items#index", as: :dashboard_items
    get '/dashboard/item', to: "items#new", as: :dashboard_item_new
    resources :users, only: [:index]
  end


  resources :users, only: [:new, :index, :create, :update] do
      resources :orders, only: [:index, :show]
  end

  namespace :admin do
    resources :users, only: [:index, :show, :edit]
    get 'admin/user/enable', to: 'users#enable', as: :user_enable
    get 'admin/user/disable', to: 'users#disable', as: :user_disable
    get 'admin/merchants/dashboard', to: 'merchants#show', as: :merchant_dashboard
    get 'admin/merchant/downgrade', to: 'merchants#downgrade', as: :merchant_downgrade
  end
end
