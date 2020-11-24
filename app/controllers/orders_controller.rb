class OrdersController < ApplicationController
  def create
    Order.create(user: current_user, item: Item.find(params[:item_id]))
    redirect_back(fallback_location: :stores_path)
  end

  def clear
    Order.all.each do |order|
      order.collected = true
      order.save
    end
    redirect_back(fallback_location: :stores_path)
  end
end
