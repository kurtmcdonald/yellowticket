class StoresController < ApplicationController
  before_action :current_orders

  def index
    @tags = Store.all.map { |store| store.tag_list }.flatten.uniq
    if params[:query].present?
      @stores = Store.search_field(params[:query])
    elsif params[:tag].present?
      @stores = Store.tagged_with(params[:tag])
    else
      @stores = Store.all
    end
  end

  def show
    @orders = Order.where(user: current_user, collected: false, status: ["pending"])
    @item = Item.new
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
    # Going to need authorisation on these actions
    @store = Store.new(stores_params)
    @store.user = current_user
    @store.save
    redirect_to store_path(@store.id)
  end

  def add_item
    # Going to need authorisation on these actions
    @item = Item.new(item_params)
    @item.store = Store.find(params[:id])
    @item.save
    redirect_back(fallback_location: :stores_path)
  end

  def update
    # Going to need authorisation on these actions
    @store = Store.find(params[:id])
    @store.update(stores_params)
    redirect_back(fallback_location: :stores_path)
  end

  def orders
    @users_with_accepted_orders = User
      .joins(orders: :item)
      .where(orders: { status: 'accepted', collected: false, items: { store: Store.find(params[:id]) } }).uniq

    @users_with_checkout_orders = User
      .joins(orders: :item)
      .where(orders: { status: 'checkout', collected: false, items: { store: Store.find(params[:id]) } }).uniq
    # @order_users = Store.find(params[:id]).orders.where(collected: false, status: ["checkout", "accepted"]).map { |order| order.user }.uniq
  end

  # def tagged
  #   if params[:tag].present?
  #     @stores = Store.tagged_with(params[:tag])
  #   else
  #     @stores = Store.all
  #   end
  # end

  private

  def current_orders
    @orders = Order.where({ user: current_user, collected: false})
  end

  def stores_params
    params.require(:store).permit(:name, :address, :description, :photo, tag_list: [])
  end

  def item_params
    params.require(:item).permit(:name, :price, :discounted_price, :photo)
  end
end
