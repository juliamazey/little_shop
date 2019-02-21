class Admin::OrdersController < Admin::BaseController

  def index
    @orders = Order.find_by_user(params[:format])

  end

  def show
    if params[:id].nil?
      # binding.pry
      @order = Order.find(params[:format])
      @order_items = OrderItem.where(order_id: @order.id)
    elsif params[:format].nil?
      @order = Order.find(params[:id])
      @order_items = OrderItem.where(order_id: @order.id)
    end
  end

end
