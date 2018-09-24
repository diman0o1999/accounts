Rails.application.routes.draw do

  resources :categories
  post '/rate' => 'rater#create', :as => 'rate'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users

  get 'persons/profile'
  # get 'article/index'
  resources :reports
  post 'check_nickname', to: 'static#check_nickname'

  get 'persons/profile', as: 'user_root'
  resources :users do
    get 'favorites', on: :member
  end

  resources :articles do
    put 'add_to_favorites',      on: :member
    put 'delete_from_favorites', on: :member
    resources :comments
    resources :ratings, only: [ :new, :create ]
  end
  root 'articles#index'
end
