Rails.application.routes.draw do
  root "welcome#index"
  resources :cards
  put "review_card" => "welcome#review_card"
end
