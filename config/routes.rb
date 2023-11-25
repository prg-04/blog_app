# config/routes.rb
Rails.application.routes.draw do
 get '/sign_out_user', to: 'users#sign_out_user', as: 'sign_out_user'
devise_for :users, controllers: { registrations: 'users/registrations' }

  root 'users#index'

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create ] do
      resources :comments, only: [:new, :create]
      resources :likes, only: [:create]
    end
  end
end
