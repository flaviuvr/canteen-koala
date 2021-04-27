Rails.application.routes.draw do
  get 'main_page/home'
  root 'main_page#home'
end
