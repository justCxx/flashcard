Rails.application.routes.draw do
  root "reviews#new"

  resources :cards
  resources :reviews
  resources :users
  resources :user_sessions

  get "login" => "user_sessions#new", :as => "login"
  get "logout" => "user_sessions#destroy", :as => "logout"
  get "signup" => "users#new", :as => "signup"
end
