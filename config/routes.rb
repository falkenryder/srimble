Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :suppliers, only: [ :index, :show, :new, :create ] do
    resources :orders, only: [ :index, :show, :new, :create, :update ]
    resources :products, only: [ :new, :create ]
    get 'templates', to: "orders#supplier_templates", as: :supplier_templates
  end

  get 'templates/:id', to: "orders#single_template", as: :single_template
  get 'templates', to: "orders#all_templates", as: :all_templates

  resources :orders, only: [:index, :show, :update ]
end
