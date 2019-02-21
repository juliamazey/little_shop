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
    if current_user
      unless current_merchant? || current_admin?
        @items = @cart.get_items
      else
        render file: "/public/404"
      end
    else
      render file: "/public/cart_login"
    end
  end

  def edit
    item = Item.find(params[:id])
    session[:cart].delete(item.id.to_s)
    redirect_to cart_path
  end

  def increase
    item = Item.find(params[:format])
    if session[:cart][item.id.to_s].to_i == item.stock
      redirect_to cart_path
    else
      increment = session[:cart][item.id.to_s].to_i + 1
      session[:cart][item.id.to_s] = increment.to_s
      redirect_to cart_path
    end
  end

  def decrease
    item = Item.find(params[:format])
    decrement = session[:cart][item.id.to_s].to_i - 1
    if decrement == 0
      session[:cart].delete(item.id.to_s)
    else
      session[:cart][item.id.to_s] = decrement.to_s
    end
    redirect_to cart_path
  end

  def destroy
    session[:cart].clear
    redirect_to cart_path
  end

private
  def cart_params
    params.require(:cart).permit(:order_quantity)
  end

end
