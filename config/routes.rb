Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :tweets do
    member do
      post 'retweet'
    end
  end

  devise_for :users, controllers: {
    registrations: 'users/registrations'}
    root 'home#index'
    resources :likes
  post 'follow/:id', to: 'friends#create', as: 'follow_user'
  delete 'follow/:id', to: 'friends#destroy', as: 'unfollow_user'
end
