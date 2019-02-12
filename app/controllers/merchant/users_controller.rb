class Merchant::UsersController < ApplicationController
  def index
    @user = User.all
  end
end
