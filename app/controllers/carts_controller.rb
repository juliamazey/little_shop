class CartsController < ApplicationController

  def create
    item = Item.find(params[:item_id])
    item_id_str = item.id.to_s
    @cart.add_item(item_id_str)
    session[:cart] = @cart.contents
    quantity = session[:cart][item_id_str]
    flash[:success] = "Item added to cart!"
    redirect_to items_path
  end

  def show

    @items = @cart.get_items

  end

end
