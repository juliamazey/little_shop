class OrdersController < ApplicationController

  def index
    @orders = Order.find_by_user(current_user.id)
    # binding.pry
  end

private
  def order_params
    params.require(:order).permit(:quantity, :created_at, :updated_at, :status)
  end
end
