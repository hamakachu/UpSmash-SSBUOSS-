Rails.application.routes.draw do
  devise_for :users
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
