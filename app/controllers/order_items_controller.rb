class OrderItemsController < ApplicationController

  def update
    order_item = OrderItem.find(params[:id])
    item = Item.find(order_item.item_id)
    order = Order.find(order_items_params[:order_id])

    quantity = item.deducts_stock(order_item.order_quantity)
    order_item.update(fulfilled: true)
    flash[:success] = "You have fulfilled the item."

    if order.fulfilled_items?
      order.update(status: "shipped")
    end
    if current_merchant?
      redirect_to merchant_dashboard_order_path(order.id)
    else
      redirect_to admin_order_path(order.id)
    end
  end

  private

   def order_items_params
     params.require(:order_item).permit(:fulfilled, :order_id)
   end

end
