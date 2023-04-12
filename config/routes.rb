Rails.application.routes.draw do
  resources :users do
    resources :articles 
  end
end
