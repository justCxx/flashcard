Rails.application.routes.draw do
  root "reviews#index"
  resources :cards
  put "review_card" => "reviews#review_card"
end
