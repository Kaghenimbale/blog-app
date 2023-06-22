Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "users#index"

  get '/posts/index', to: 'posts#index'
  get '/posts/show', to: 'posts#show'

  resources :users, only: %i[index show] do
    resources :posts, only: %i[index show]
  end
end
