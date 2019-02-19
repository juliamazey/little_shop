class Merchant::OrdersController < Merchant::BaseController

  def show
    @order = Order.find(params[:id])
    @order_items = OrderItem.where(order_id: @order.id)
  end

end
