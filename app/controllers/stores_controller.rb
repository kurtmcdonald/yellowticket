class StoresController < ApplicationController
  before_action :current_orders

  def index
    @stores = Store.all
  end

  def show
    @store = Store.find(params[:id])
    @count = 0
    @orders.each do |order|
      @count += order.quantity
    end
  end

  private

  def current_orders
    @orders = Order.where({ user: current_user, collected: false})
  end
end
