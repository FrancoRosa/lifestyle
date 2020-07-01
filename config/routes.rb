Rails.application.routes.draw do
  root to: "articles#index"
  resources :articles
  resources :categories
  resources :votes
  resources :users
  get "/sign_up", to: "users#new"
  get "/sign_in", to: "users#sign_in"
  post "/sign_in", to: "users#create_session"
  get "/sign_out", to: "users#sign_out"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
