Rails.application.routes.draw do
  devise_for :users
  resources :users

  root to: "pages#toppage"

  resources :articles do
    resources :comments
    resources :likes, only: [:create, :destroy]
  end

  resources :feedbackforms

  resources :startforms

  resources :rooms do
    resources :messages
    resources :rules
    member do
      post :join
    end
  end

get '/toppage', to: 'pages#toppage'
get '/other', to: 'pages#other'

end