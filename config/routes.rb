Rails.application.routes.draw do
  root 'welcome#index'
  get 'autocomplete', to: 'welcome#autocomplete'
  resources :users
  resources :sessions
  resources :posts do
    member do
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
    resources :profiles
  end
  get 'logout', to: 'sessions#destroy', as: 'logout'

end
