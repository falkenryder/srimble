Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :suppliers, only: [ :index, :show, :new, :create ] do
    resources :orders, only: [ :index, :show, :new, :create, :update ]
    resources :products, only: [ :new, :create ]
    get ':templates', to: "orders#supplier_templates", as: :supplier_templates
  end

  # get 'templates', to: "orders#index", type: "template"
  # resources :templates, only: %i[index new create edit update destroy], type: "template"

  resources :templates, controller: :orders, type: "template"

  resources :orders, only: [:index, :show, :update ], type: "order"
end
