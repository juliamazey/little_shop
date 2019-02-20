class Admin::OrdersController < Admin::BaseController

  def index
    @orders = Order.find_by_user(params[:format])

  end

  def show
    @order = Order.find(params[:id])
  end

end
