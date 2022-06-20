Rails.application.routes.draw do
  get "/dashboard", to:"posts#index"
  get 'sessions/new'
  root 'posts#index'
  get  '/signup',  to: 'users#new'
  get "profile/:name", to:"users#show", as: :profile
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

 get 'categories/:id', to: 'categories#destroy', as: :delete_category
 
   resources :users
  resources :posts 
    
  
  resources :comments do
    member do
      get :accept
      get :reject
    end
  end
  resources :stars do
    member do
      get :accept
      get :reject
    end
  end
  resources :images do
    member do 
      get :purge_image
      
    end
  end
  resources :categories
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
