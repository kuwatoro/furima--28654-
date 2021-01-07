Rails.application.routes.draw do
  devise_for :users
  root "items#index"
  resources :items do
    resources :order_residences, only: [:index, :create]
  end
end
