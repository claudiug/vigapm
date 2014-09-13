Rails.application.routes.draw do

  root 'welcome#index'
  get 'autocomplete', to: 'welcome#autocomplete'
  resources :tags
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :posts do
    member do
      get :users_follow
      put 'up', to: 'posts#up'
      put 'down', to: 'posts#down'
    end
    resources :comments do
      member do
        put 'up', to: 'comments#up'
        put 'down', to: 'comments#down'
      end
    end
  end

  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :relationships, only: [:create, :destroy]
  resources :subscriptions, only: [:create, :destroy]

  get 'logout', to: 'sessions#destroy', as: 'logout'

end
