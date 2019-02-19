class OrderItemsController < ApplicationController

  def update
    @order_item = OrderItem.find(params[:id])

    @item = Item.find(@order_item.item_id)

    quantity = @item.deducts_stock(@order_item.order_quantity)
    @order_item.update(fulfilled: true)
    @item.update(stock: quantity)
    redirect_to merchant_dashboard_order_path(order_items_params[:order_id])
  end

  private

   def order_items_params
     params.require(:order_item).permit(:fulfilled, :order_id)
   end

end
