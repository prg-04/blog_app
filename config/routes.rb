# config/routes.rb
Rails.application.routes.draw do
  get 'posts/create'
  root to: "main#index"

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new ] do
      resources :comments, only: [:create]
    end
  end
end
