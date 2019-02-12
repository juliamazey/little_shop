class Admin::UsersController < Admin::BaseController
  def index
    @users = User.all
  end

  def show
    # binding.pry
    @user = User.find(params[:id])
  end
end
