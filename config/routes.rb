Rails.application.routes.draw do
  root "welcome#index"

  resources :items

  resources :users, only: [:new, :index, :create, :show]

  namespace :admin do
    resources :users, only: [:index]
  end

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
end
