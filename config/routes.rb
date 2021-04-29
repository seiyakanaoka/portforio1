Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :registrations => 'users/registraitons',
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

root 'homes#top'
get 'homes/about'
end
