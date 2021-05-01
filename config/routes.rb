Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :sessions => 'users/sessions',
    :registrations => 'users/registrations',
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'homes#top'
  get 'homes/about'
  get 'homes/beginner'

  resources :logs do
    resources :logcomments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  resources :users, only: [:show, :edit, :update] do
    member do
      get :follow, :follower
      get :dive_profile
      get :unsubscribe
      get :withdraw
    end
    resource :relationships, only: [:create, :destroy]
  end

end
