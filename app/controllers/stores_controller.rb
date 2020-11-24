class StoresController < ApplicationController
  def index
    @stores = Store.all
  end

  def show
    @store = Store.find(params[:id])
    @orders = Order.where({ user: current_user, collected: false})
  end
end
