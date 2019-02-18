Rails.application.routes.draw do
  root "welcome#index"

  resources :items

  resources :carts, only: [:create, :edit]

  get '/cart', to: "carts#show", as: :cart
  get '/empty', to: "carts#destroy", as: :empty_cart
  get '/increase', to: "carts#increase", as: :increase_cart_item
  get '/decrease', to: "carts#decrease", as: :decrease_cart_item

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  get '/profile', to: 'users#show'
  get '/profile/orders', to: 'orders#index'
  get '/profile/edit', to: 'users#edit'

  namespace :merchant do
    get '/dashboard', to: "users#show", as: :dashboard
    resources :users, only: [:index]
  end


  resources :users, only: [:new, :index, :create, :update] do
      resources :orders, only: [:index, :show]
  end

  namespace :admin do
    resources :users, only: [:index, :show, :edit]
    get 'admin/user/enable', to: 'user#enable', as: :user_enable
    get 'admin/user/disable', to: 'user#disable', as: :user_disable
  end

end
