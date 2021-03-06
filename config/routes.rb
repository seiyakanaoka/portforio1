Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    password: 'users/passwords'
  }
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'homes#top'
  get '/log/hashtag/:name' => 'logs#hashtag'
  get '/log/hashtag' => 'logs#hashtag'

  resources :notifications, only: [:index]
  resources :directs, only: [:index]

  resources :ranks, only: [:index] do
    collection do
      get 'search'
    end
  end

  resources :logs do
    resources :log_comments, only: %i[create destroy]
    resource :favorites, only: %i[create destroy]
    resource :bookmarks, only: %i[create destroy]
  end
  resources :users, only: %i[show edit update] do
    member do
      get :follow, :follower
      get :my_page
      get :dive_profile
      get :unsubscribe
      get :bookmark_list
      patch :withdraw
    end
    resource :relationships, only: %i[create destroy]
  end

  resources :rooms, only: %i[index show create]
  resources :messages, only: [:create]
end
