Rails.application.routes.draw do
  root to: 'visitors#index'
  devise_for :users
  resources :users
  resources :presentations do
    member do
      get :present
    end
    resources :placeholders
  end
  resources :placeholders do
    collection do
      get :news_rss
    end
  end
end
