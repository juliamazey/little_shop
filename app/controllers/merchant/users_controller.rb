class Merchant::UsersController < ApplicationController
  def index
    @user = User.all
  end

  def show
    @merchant = User.find(params[:format])
  end
end
