class Merchant::UsersController < Merchant::BaseController

  def show
    @merchant = User.find(params[:format])
    @orders = Order.merchant_orders(@merchant)
    @items = Item.merchant_items(current_user)
    @users = User.top_consumers(current_user)
    @items_sold = OrderItem.items_sold
    @percent_sold = Item.percent_sold
  end

end
