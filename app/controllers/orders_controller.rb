class OrdersController < ApplicationController

  def index
    @orders = Order.find_by_user(current_user.id)
  end

  def show
    # binding.pry
  end

  def create
    user = User.find(current_user.id)
     order = user.orders.create!
     @cart.contents.each do |item_id, order_quantity|
       order.order_items.create(item_id: item_id , order_quantity: order_quantity)
     end
     @cart.contents.clear
     flash[:success] = "Your order has been placed"
    redirect_to profile_path
  end

private
  def order_params
    params.require(:order).permit(:quantity, :created_at, :updated_at, :status)
  end
end
