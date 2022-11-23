Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :suppliers, only: [ :index, :show, :new, :create ] do
    resources :orders, only: [ :index, :show, :new, :create ]
    resources :products, only: [ :new, :create ]
  end
end
