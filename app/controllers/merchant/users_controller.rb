class Merchant::UsersController < Merchant::BaseController

  def show
    @merchant = User.find(params[:format])
    @orders = Order.merchant_orders(@merchant)
    @items = Item.merchant_items(current_user)
    @top_states = User.top_consumer_states(current_user)
    @top_cities = User.top_consumer_cities(current_user)
    @items_sold = Item.total_sold(current_user)
    @percent_sold = Item.percentage_sold(current_user)
    @top_consumer = User.top_consumer(current_user)
    @top_spenders = User.top_spenders(current_user)
  end

end
