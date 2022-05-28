Rails.application.routes.draw do
  get "/dashboard", to:"posts#index"
  get 'sessions/new'
  root 'posts#index'
  get  '/signup',  to: 'users#new'
  get "profile/:name", to:"users#show", as: :profile
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  get '/logout',  to: 'sessions#destroy'
 get 'delete/:id', to: 'posts#destroy', as: :delete
 
   resources :users
  resources :posts
  resources :comments, only: [:create,:destroy]
  resources :stars, only: [:create,:destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
