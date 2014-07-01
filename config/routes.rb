PostitTemplate::Application.routes.draw do
  root to: 'posts#index'
  
  get '/register', to: 'users#new'
  get '/login', to: 'sessions#new', as: :sessions_new
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  #get '/posts', to: 'posts#index'
  #get '/posts/:id', to: 'posts#show'
  #get '/posts/new', to: 'posts#new'
  #post '/posts', to: 'posts#create'
  #get '/posts/:id/edit', to: 'posts#edit'
  #patch '/posts/:id', to: 'posts#update'
  
  resources :posts do
    resources :comments, only: [:create]
  end

  resources :categories, only: [:new, :create, :show]
  resources :users, only: [:create, :show, :edit, :update]
end
