class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.find_by(email: params[:email])
    binding.pry
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      # binding.pry
      redirect_to user_path(user)
    else
      render :new
    end
  end
end
