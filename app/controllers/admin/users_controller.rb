class Admin::UsersController < Admin::BaseController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def enable
    @user = User.find(params[:format])
    @user.active = true
    flash[:success] = "This user is now active."
    redirect_to admin_users_path
  end

  def disable
    @user = User.find(params[:format])
    @user.active = false
    flash[:success] = "This user is now inactive."
    redirect_to admin_users_path
  end

end
