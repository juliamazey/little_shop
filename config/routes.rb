Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "welcome#index"

  resources :items
  
  resources :users, only: [:new, :index, :create, :show]

end
