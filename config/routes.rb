Rails.application.routes.draw do
  devise_for :models
  resources :posts
  resources :topics
  resources :forums
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'users#login'
  
  post '/' => 'users#login'

  get 'session/require_login'

  get 'session/logout'

  get 'dashboard/dashboard'
  
  get 'dashboard/deck'

  match "forum/home" => redirect {"/posts"}, via: [:get, :post]

  get 'home/index'

  get 'home/' => 'home#index'

  get 'users/new'

  get 'users/create'

  get 'password_resets/edit'

  post 'users/create'

  get 'users/login'

  post 'users/login'

  resources :users do
    member do
        get :confirm_email
    end
  end

  get 'preferences/profile'

  post 'preferences/profile'

  get 'preferences/password'

  post 'preferences/password'

  get 'preferences/preferences'

  post 'preferences/preferences'

  resources :password_resets

  resources :posts do

    resources :comments

    collection do
      get 'posts/new'
      get 'posts/show'
      post 'posts/new'
      delete :destroy
    end
  end

end
