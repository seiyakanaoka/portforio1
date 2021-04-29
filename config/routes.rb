Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :registrations => 'users/registraitons',
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'homes#top'
  get 'homes/about'
  get 'homes/beginner'
  get 'users/my_page'
  get 'users/unsubscribe'
  get 'users/withdraw'
  get 'users/dive_profile'

  resourses :logs do
    resourses :logcomments, only: [:create, :destroy]
    resourse :favorites, only: [:create, :destroy]
  end
  resourses :users, only: [:show, :edit, update] do
    member do
      get :follow, :follower
    end
    resourse :relationships, only: [:create, :destroy]
  end

end
