class Merchant::UsersController < Merchant::BaseController
  def index
    @users = User.all
  end

  def show
    @merchant = User.find(params[:format])
    @orders = Order.joins(:items).where(status: 0, items: {user: @merchant}).group(:id)
  end
end
