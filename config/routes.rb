Rails.application.routes.draw do
  get "/dashboard", to:"users#index"
  get 'sessions/new'
  root 'users#index'
  get  '/signup',  to: 'users#new'
  get "profile/:name", to:"users#show", as: :profile
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
 
  resources :users
  resources :posts
  resources :comments, only: [:create,:destroy]
  resources :stars, only: [:create,:destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
