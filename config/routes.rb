Rails.application.routes.draw do
  root "reviews#new"

  resources :decks do
    resources :cards
    member do
      put "set_default"
    end
  end

  get "new_card" => "cards#new"
  post "new_card" => "cards#create"

  resources :reviews, only: [:new, :create]
  resources :user_sessions, path: :login, only: [:create]

  # Registration and authentication
  get "login" => "user_sessions#new"
  get "logout" => "user_sessions#destroy"
  get "signup" => "registration#new"
  post "signup" => "registration#create"

  # OAuth authorization
  get "oauth/callback" => "oauths#callback"
  post "oauth/callback" => "oauths#callback"
  get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider
  delete "oauth/:provider" => "oauths#destroy", :as => :delete_oauth

  # User profile
  get "profile" => "user_profile#show"
  get "profile/edit" => "user_profile#edit", :as => :edit_profile
  patch "profile" => "user_profile#update"
  delete "profile" => "user_profile#destroy"
end
