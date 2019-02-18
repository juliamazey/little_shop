class Merchant::UsersController < Merchant::BaseController

  def show
    @merchant = User.find(params[:format])
    @orders = Order.merchant_orders(@merchant)
  end


end
