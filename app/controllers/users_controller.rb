class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    session[:user_id] = @user.id
    if User.find_by(email: user_params[:email])
      flash[:failure] = "That email is already in use"
      redirect_to new_user_path
    else
      if user_params[:password] == user_params[:password_confirmation]
        if @user.save
          redirect_to user_path(@user)
        else
          flash[:failure] = "All fields are required"
          redirect_to new_user_path
        end
      else
        flash[:failure] = "Password confirmation failed"
        redirect_to new_user_path
      end
    end
  end

  def edit
      @user = current_user
  end

  def show
    @orders = Order.find_by_user(current_user.id)
    if current_user
      # binding.pry
      unless current_merchant? || current_admin?
        @user = User.find(current_user.id)
      else
        render file: "/public/404"
      end
    else
      render file: "/public/404"
    end
  end

  def update
    @user = User.find(params[:id])
    @user.username = params[:user][:username]
    @user.address = params[:user][:address]
    @user.city = params[:user][:city]
    @user.state = params[:user][:state]
    @user.zip_code = params[:user][:zip_code]
    @user.email = params[:user][:email]
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]
    # binding.pry
    if @user.save
      flash[:success] = "User profile updated."
      redirect_to profile_path
    else
      flash[:failure] = "That email address is already in use."
      redirect_to profile_edit_path
    end
    @user = User.find(current_user[:id])
  end

  def enable
    binding.pry
  end

  def disable
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation, :address, :city, :state, :zip_code, :email)
  end
end
