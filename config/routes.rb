Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :users, only: [:create]

      post 'login', to: 'sessions#create'

      resources :products do
        collection do
          get :list
        end
      end

    end
  end
end
