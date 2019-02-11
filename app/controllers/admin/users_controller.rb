class Admin::UsersController < Admin::BaseController
  def index
    @user = User.all
  end
end
