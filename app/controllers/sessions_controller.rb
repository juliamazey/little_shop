class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
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
    redirect_to login_path
  end

end
