Rails.application.routes.draw do
  root "reviews#new"

  resources :cards
  resources :reviews
  resources :users
  resources :user_sessions

  get "login" => "user_sessions#new", :as => "login"
  get "logout" => "user_sessions#destroy", :as => "logout"
  get "signup" => "users#new", :as => "signup"

  post "oauth/callback" => "oauths#callback"
  get "oauth/callback" => "oauths#callback"
  get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider
  delete "oauth/:provider" => "oauths#destroy", :as => :delete_oauth
end
