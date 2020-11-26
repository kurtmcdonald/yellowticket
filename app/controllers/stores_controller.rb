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

  def new
    @store = Store.new
  end

  def create
    @store = Store.new(stores_params)
    @store.user = current_user
    @store.save
    redirect_to store_path(@store.id)
  end

  private

  def current_orders
    @orders = Order.where({ user: current_user, collected: false})
  end

  def stores_params
    params.require(:store).permit(:name, :address, :description)
  end
end
