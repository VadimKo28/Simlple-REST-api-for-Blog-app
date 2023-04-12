Rails.application.routes.draw do
  get 'articles/index'
  resources :users
end
