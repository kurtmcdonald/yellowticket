class OrdersController < ApplicationController
  def create
    active_orders = Order.where(user: current_user, collected: false, status: "pending")
    item = Item.find(params[:item_id])
    if active_orders.any? && active_orders.last.item.store != item.store
      redirect_to store_path(item.store), notice: "You cannot add from two different stores."
    elsif Order.exists?({ user: current_user, item: item, collected: false })
      order = Order.where({ user: current_user, item: item, collected: false})
      order.first.quantity += 1
      order.first.save
      redirect_to store_path(item.store, anchor: "item-#{item.id}")
    else
      Order.create(user: current_user, item: Item.find(params[:item_id]), quantity: 1)
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

  def confirmation
    @store = Store.find(params[:id])
    @markers = [{ lat: @store.latitude, lng: @store.longitude}]
    orders = Order.where(user: current_user, collected: false)
    if orders.any?
      @status = orders.first.status
    else
      @status = "collected"
    end
  end

  def accept
    # Change the status from pending to accepted
    # We need the instance of user that made the order
    user = User.find(params[:user_id])
    orders = user.orders.where(collected: false)
    orders.each do |order|
      order.status = "accepted"
      order.save
    end
    redirect_to orders_store_path(params[:id])
  end

  def reject
    user = User.find(params[:user_id])
    orders = user.orders.where(collected: false)
    orders.each do |order|
      order.status = "rejected"
      order.save
    end
    redirect_to orders_store_path(params[:id])
  end

  def confirm_rejection
    orders = current_user.orders.where(collected: false, status: "rejected")
    orders.each do |order|
      order.collected = true
      order.save
    end
    redirect_to stores_path
  end

  def collect
    user = User.find(params[:user_id])
    orders = user.orders.where(collected: false)
    orders.each do |order|
      order.status = "collected"
      order.collected = true
      order.save
    end
    redirect_to orders_store_path(params[:id])
  end

  def checkout
    orders = current_user.orders.where(collected: false)
    orders.each do |order|
      order.status = "checkout"
      order.save
    end
    redirect_to confirmation_store_path(params[:id])
  end
end
