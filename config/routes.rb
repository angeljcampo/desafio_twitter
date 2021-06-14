Rails.application.routes.draw do
  resources :tweets do
    member do
      post 'retweet'
    end
  end
  devise_for :users, controllers: {
        registrations: 'users/registrations'}
  root 'home#index'
  resources :likes
end
