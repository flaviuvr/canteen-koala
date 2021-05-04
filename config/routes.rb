Rails.application.routes.draw do
  get 'main_page/home'
  get 'products/new'
  get 'products/show'
  get 'products/edit'
  resources :products
  root 'main_page#home'
end
