Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :stores, only: [:index, :show, :new, :create, :update] do
    member do
      get "confirmation", to: "orders#confirmation", as: :confirmation
      post "add_item", to: "stores#add_item", as: :add_item
      get "orders", to: "stores#orders"
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post "/orders/:item_id", to: "orders#create", as: :create_order
  patch "/orders/clear", to: "orders#clear", as: :clear_orders
end
