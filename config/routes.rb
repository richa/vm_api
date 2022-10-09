Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :users, only: [:create]


      post 'login', to: 'sessions#create'
      get 'current', to: 'sessions#current'
      delete 'logout', to: 'sessions#destroy'
      delete 'logout/all', to: 'sessions#destroy_all'

      resources :products do
        collection do
          get :list
        end
      end

      patch 'deposit', to: 'accounts#deposit'
      delete 'reset', to: 'accounts#reset'

      post 'buy', to: 'purchases#create'
    end
  end
end
