Rails.application.routes.draw do
  namespace :api do
    resources :food_carts, only: [:index]
  end
end
