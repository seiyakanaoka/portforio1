Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions',
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'homes#top'
  get '/log/hashtag/:name' => 'logs#hashtag'
  get '/log/hashtag' => 'logs#hashtag'

  resources :ranks, only: [:index] do
    collection do
      get 'search'
    end
  end

  resources :logs do
    resources :log_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
    resource :bookmarks, only: [:create, :destroy]
  end
  resources :users, only: [:show, :edit, :update] do
    member do
      get :follow, :follower
      get :my_page
      get :dive_profile
      get :unsubscribe
      get :bookmark_list
      patch :withdraw
    end
    resource :relationships, only: [:create, :destroy]
  end

  resources :rooms, only: [:index, :show, :create]
  resources :messages, only: [:create]

end
