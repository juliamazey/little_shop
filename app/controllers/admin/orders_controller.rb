class Admin::OrdersController < Admin::BaseController

def show
  @orders = Order.find_by_user(params[:format])
  
end

end
