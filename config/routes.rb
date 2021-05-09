Rails.application.routes.draw do
  root 'main_page#landing'
  get 'main_page/home'
  get 'main_page/landing'
  resources :products
  resources :users

  get '/signup', to: 'users#new'
  get '/landing', to: 'main_page#landing'
  get '/home', to: 'main_page#home'
end
