class Merchant::OrdersController < Merchant::BaseController

  def show
    @order = Order.find(params[:id])
  end

end
