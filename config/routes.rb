Rails.application.routes.draw do
  resources :municipes
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "municipes#index"
end
