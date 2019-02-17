class Merchant::UsersController < Merchant::BaseController
  def index
    @users = User.all
  end

  def show
    @merchant = User.find(params[:format])
  end
end
