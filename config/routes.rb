Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :stores, only: [:index, :show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post "/orders/:item_id", to: "orders#create", as: :create_order
  patch "/orders/clear", to: "orders#clear", as: :clear_orders
end
