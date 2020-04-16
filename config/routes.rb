Rails.application.routes.draw do

  root 'sessions#index'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/signup' => 'users#new'
  post '/signup' => 'users#create'
  delete '/logout' => 'sessions#destroy'

  get '/auth/:provider/callback' => 'sessions#omniauth'
  
  resources :reviews
  resources :products do
    resources :reviews, only: [:new, :index]
    collection do
      get :search #enables search_products_path
    end
  end
  resources :categories
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
