Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  namespace :api do
    namespace :v1 do
      get "/news", to: "news#news"
      get "/:fecha1/:fecha2", to: "news#ranged"
      post "/create", to: "news#create"
    end
  end

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
