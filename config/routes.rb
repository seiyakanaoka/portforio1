Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :sessions => 'users/sessions',
    :registrations => 'users/registrations',
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'homes#top'
  get 'homes/about'
  get 'homes/beginner'
  get 'users/unsubscribe'
  get 'users/withdraw'
  get 'users/dive_profile'

  resources :logs do
    resources :logcomments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  resources :users, only: [:show, :edit, :update] do
    member do
      get :follow, :follower
    end
    resource :relationships, only: [:create, :destroy]
  end

end
