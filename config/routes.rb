Rails.application.routes.draw do
  root "reviews#index"
  resources :cards
  resources :reviews
end
