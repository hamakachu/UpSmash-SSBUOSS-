Rails.application.routes.draw do
  devise_for :users
  resources :users
  resources :articles
  resources :feedbackforms
  root to: "startforms#toppage"
  resources :startforms do
    member do
      get :toppage
    end
  end
  resources :rooms do
    resources :messages
    resources :rules
    member do
      post :join
    end
  end
end
