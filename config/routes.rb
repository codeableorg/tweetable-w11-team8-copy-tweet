Rails.application.routes.draw do
  get 'users/show'
  #root 'home#index'
  root 'tweets#index'
  resources :tweets do
    resources :likes
  end
  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }

end
