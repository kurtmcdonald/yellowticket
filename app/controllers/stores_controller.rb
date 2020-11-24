class StoresController < ApplicationController
  before_action :current_orders

  def index
    @stores = Store.all
  end

  def show
    @store = Store.find(params[:id])
  end

  private

  def current_orders
    @orders = Order.where({ user: current_user, collected: false})
  end
end
