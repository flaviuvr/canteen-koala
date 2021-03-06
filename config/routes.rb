Rails.application.routes.draw do
  get 'sessions/new'
  root 'main_page#landing'

  resources :products, only: %i[index new show edit create update destroy] do
    post :add_to_cart, on: :member
    delete :remove_single_item_from_cart, on: :member
    delete :remove_product_from_cart, on: :member
  end

  resources :users
  get '/signup', to: 'users#new'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/home', to: 'main_page#home', as: '/home'

  resources :carts, only: :index do
    post :remove_cart_items, on: :collection
  end

  resources :account_activations, only: :edit
  resources :password_resets, only: %i[new create edit update]
end
