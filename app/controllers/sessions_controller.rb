class SessionsController < ApplicationController

  def new
    unless current_user.nil?
      flash[:failure] = "You are already logged in"
      if current_user.merchant?
        redirect_to merchant_dashboard_path(current_user)
      elsif current_user.admin?
        redirect_to root_path
      else
        redirect_to profile_path(current_user)
      end
    end
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "You are logged in"
      if user.merchant?
        redirect_to merchant_dashboard_path(user)
      elsif user.admin?
        redirect_to root_path
      else
        redirect_to profile_path(user)
      end
    else
      render :new
    end
  end

  def destroy
    session.clear
    flash[:success] = "You have been logged out"
    redirect_to root_path
  end

end
