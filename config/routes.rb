Rails.application.routes.draw do
  get 'sessions/new'
  root 'main_page#landing'
  get 'main_page/home'
  get 'main_page/landing'
  resources :products
  resources :users

  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/landing', to: 'main_page#landing'
  get '/home', to: 'main_page#home'
end
