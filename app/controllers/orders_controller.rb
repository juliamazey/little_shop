class OrdersController < ApplicationController

  def index
    @orders = Order.find_by_user(current_user.id)
    # binding.pry
  end
end
