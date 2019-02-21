class OrdersController < ApplicationController

  def index
    @orders = Order.find_by_user(current_user.id)
  end

  def show
    @order = Order.find(params[:id])
  end

  def create
    user = User.find(current_user.id)
     order = user.orders.create!
     @cart.contents.each do |item_id, order_quantity|
       item = Item.find(item_id)
       item_price = item.price
       order.order_items.create(item_id: item_id, order_quantity: order_quantity, order_price: item_price)
     end
     @cart.contents.clear
     flash[:success] = "Your order has been placed"
    redirect_to profile_path
  end

  def update
    order = Order.find(params[:id])
    order.update(status: "cancelled")
    order.items.restock
    OrderItem.where(order: order).update_all(fulfilled: false)
    flash[:success] = "Order has been cancelled"
    if current_admin?
      redirect_to admin_order_path(order)
    else
      redirect_to profile_path
    end
  end

  private
  def order_params
    params.require(:order).permit(:quantity, :created_at, :updated_at, :status)
  end
end
