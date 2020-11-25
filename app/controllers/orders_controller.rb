class OrdersController < ApplicationController
  def create
    if Order.exists?({ user: current_user, item: Item.find(params[:item_id]), collected: false })
      order = Order.where({ user: current_user, item: Item.find(params[:item_id]), collected: false})
      order.first.quantity += 1
      order.first.save
      redirect_back(fallback_location: :stores_path)
    else
      Order.create(user: current_user, item: Item.find(params[:item_id]), quantity: 1)
      redirect_back(fallback_location: :stores_path)
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
