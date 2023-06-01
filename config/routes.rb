Rails.application.routes.draw do
  devise_for :users
  root to: "rooms#index"
  resources :rooms do
    resources :messages
    resources :rules
    member do
      post :join
    end
  end
end
