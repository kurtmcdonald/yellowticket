Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :stores, only: [:index, :show, :new, :create, :update] do
    member do
      get "confirmation", to: "orders#confirmation", as: :confirmation
      post "add_item", to: "stores#add_item", as: :add_item
      delete "destroy_item/:item_id", to: "stores#destroy_item", as: :destroy_item

      get "orders", to: "stores#orders"
      # get "tagged", to: "stores#tagged", as: :tagged
      patch "checkout", to: "orders#checkout"
      patch "orders/:user_id/accepted", to: "orders#accept", as: :accept_order
      patch "orders/:user_id/rejected", to: "orders#reject", as: :reject_order
      patch "orders/:user_id/collected", to: "orders#collect", as: :collect_order

    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  patch "edit/:item_id", to: "stores#edit_item", as: :edit_item
  post "/orders/:item_id", to: "orders#create", as: :create_order
  patch "/orders/clear", to: "orders#clear", as: :clear_orders
  get "/check-status", to: "orders#check_status"
end

# get status of user
