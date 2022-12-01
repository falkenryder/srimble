Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get 'results', to: 'pages#results'
  resources :suppliers, only: [ :index, :show, :new, :create ] do
    resources :orders, only: [ :index, :show, :new, :create, :update ], type: "order"
    resources :templates, only: [ :index, :new, :create, :edit, :update ], controller: :orders, type: "template"
    resources :products, only: [ :new, :create ]
  end

  # get 'templates', to: "orders#index", type: "template"
  # resources :templates, only: %i[index new create edit update destroy], type: "template"

  resources :templates, controller: :orders, type: "template"

  resources :orders, only: [:index, :new, :show, :create, :update ], type: "order"
  resources :products, only: %i[index show update]
  resources :inventories, only: [:index, :show, :update] do
    collection do
      get :sync
    end
  end
  
end
