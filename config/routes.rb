Rails.application.routes.draw do
  get 'main_page/home'
  resources :products
  get 'products', to: 'main_page#index'
  root 'main_page#home'
end
