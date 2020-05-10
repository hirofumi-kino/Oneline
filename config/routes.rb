Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
 root to: 'toppages#index'
 
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
 
 get 'signup', to: 'users#new'
  resources :users, only: [:index, :show, :new, :create] do
    member do
      get :followings
      get :followers
    end
  end
  
  resources :relationships, only: [:create, :destroy]
  resources :quotes, only: [:create, :destroy, :edit, :update]
   get 'book_title/:title', to: 'books#title', as: 'title'
   get 'book_author/:author', to: 'books#author', as: 'author'
end
