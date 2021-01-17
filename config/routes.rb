Rails.application.routes.draw do
  # get 'users/show'
  # root 'home#index'
  root 'tweets#index'
  resources :tweets do
    resources :likes
  end
  resources :users, only: %i[show] do
    resources :tweets, only: %i[show]
    resources :liked_tweets, only: %i[show]
  end
  devise_for :users, controllers: { omniauth_callbacks: 'callbacks' }

  namespace 'api' do
    post '/login' => 'sessions#create'
    delete '/logout' => 'sessions#destroy'
    resources :tweets, only: %i[index show create update destroy] do
      resources :likes
    end
  end
end
