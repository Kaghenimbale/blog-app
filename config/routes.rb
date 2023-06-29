Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "users#index"

  delete '/sign_out', to: 'sessions#destroy', as: :custom_destroy_user_session

  resources :users, only: %i[index show] do
    resources :posts, only: %i[index show   new create destroy] do
      resources :comments, only: %i[new create destroy]
      resources :likes, only: %i[create]
    end
  end

  resources :comments, only: [:destroy]
end
