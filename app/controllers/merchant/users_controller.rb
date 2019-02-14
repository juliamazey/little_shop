class Merchant::UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @merchant = User.find(params[:format])
  end
end
