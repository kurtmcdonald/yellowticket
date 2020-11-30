class OrdersController < ApplicationController
  def create
    active_orders = Order.where(user: current_user, collected: false, status: "pending")
    item = Item.find(params[:item_id])
    order = Order.find_by(user: current_user, item: item, collected: false, status: "pending")
    if active_orders.any? && active_orders.last.item.store != item.store
      redirect_to store_path(item.store), notice: "You cannot add from two different stores."
    elsif order
      order.quantity += 1
      order.save
      redirect_to store_path(item.store, anchor: "item-#{item.id}")
    else
      Order.create(user: current_user, item: item, quantity: 1)
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
    @status = current_user.order_status
  end

  def accept
    # Change the status from pending to accepted
    # We need the instance of user that made the order
    user = User.find(params[:user_id])
    orders = user.orders.where(collected: false, status: "checkout")
    orders.each do |order|
      order.status = "accepted"
      order.save
    end
    redirect_to orders_store_path(params[:id])
  end

  def reject
    user = User.find(params[:user_id])
    orders = user.orders.where(collected: false, status: "checkout")
    orders.each do |order|
      order.status = "rejected"
      order.save!
    end
    redirect_to orders_store_path(params[:id])
  end

  def collect
    user = User.find(params[:user_id])
    orders = user.orders.where(collected: false, status: "accepted")
    orders.each do |order|
      order.status = "collected"
      order.collected = true
      order.save
    end
    redirect_to orders_store_path(params[:id])
  end

  def checkout
    orders = current_user.orders.where(collected: false, status: "pending")
    orders.each do |order|
      order.status = "checkout"
      order.save
    end
    redirect_to confirmation_store_path(params[:id])
  end


  # Add an action that gives us the user's status
  def check_status
    user = current_user
    respond_to do |format|
      format.html
      format.json { render json: { status: user.order_status } }
    end
  end
end
