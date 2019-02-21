class Admin::OrdersController < Admin::BaseController

  def index
    @orders = Order.find_by_user(params[:format])

  end

  def show
    if params[:id].nil?
      if Order.where(user_id: params[:format])
        orders = Order.where(user_id: params[:format])
        @order = orders.first
        unless @order.nil?
          @order_items = OrderItem.where(order_id: @order.id)
        end
      else
        @order = Order.find(params[:format])
        @order_items = OrderItem.where(order_id: @order.id)
      end
    elsif params[:format].nil?
      @order = Order.find(params[:id])
      @order_items = OrderItem.where(order_id: @order.id)
    end
  end

end
