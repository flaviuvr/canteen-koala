Rails.application.routes.draw do
  get 'main_page/home'
  resources :products
  root 'main_page#home'
end
