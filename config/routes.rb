Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :sessions => 'users/sessions',
    :registrations => 'users/registrations',
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'homes#top'
  get 'homes/about'
  get 'homes/beginner'
  get 'ranks/ranking'

  resources :logs do
    resources :log_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  resources :users, only: [:show, :edit, :update] do
    member do
      get :follow, :follower
      get :my_page
      get :dive_profile
      get :unsubscribe
      get :withdraw
    end
    resource :relationships, only: [:create, :destroy]
  end

  resources :rooms, only: [:show, :create]
  resources :messages, only: [:create]

end
