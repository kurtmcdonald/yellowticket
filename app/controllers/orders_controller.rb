class OrdersController < ApplicationController
  def create
    item = Item.find(params[:item_id])
    if Order.exists?({ user: current_user, item: item, collected: false })
      order = Order.where({ user: current_user, item: item, collected: false})
      order.first.quantity += 1
      order.first.save
      redirect_back(fallback_location: :stores_path)
    else
      Order.create(user: current_user, item: Item.find(params[:item_id]), quantity: 1)
      # redirect_back(fallback_location: :stores_path)
      redirect_to store_path(item.store, anchor: "item-#{item.id}")
    end
  end

  def clear
    Order.all.each do |order|
      order.collected = true
      order.save
    end
    redirect_back(fallback_location: :stores_path)
  end
end
