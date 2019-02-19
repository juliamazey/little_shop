class ItemsController < ApplicationController

  def index
    @items = Item.select_active
  end

  def show

    @item = Item.find(params[:id])
    @orders = @item.orders
    @fulfill_time_avg = @item.average_fulfillment(@orders).to_s
    # @item_fulfillment = average_fulfillment(@orders)
        # binding.pry
  end

  def new
    @item = Item.new
  end

  def edit
    @item = Item.find(params[:id])
  end




private

  def item_params
    params.require(:item).permit(:price, :stock, :active, :description, :name)
  end

end
